open Lwt.Infix

module Db =
  (val Caqti_lwt.connect
         (Uri.of_string
            "postgresql://9sako6:password@localhost:5432/caqti_demo_db")
       >>= Caqti_lwt.or_fail |> Lwt_main.run)

module Query = struct
  open Caqti_request.Infix

  let plus = (Caqti_type.(tup2 int int) ->! Caqti_type.int) "SELECT ? + ?"

  let select_users =
    Caqti_type.(unit ->* tup3 int string string)
      "SELECT user_id, name, email FROM users"
end

let run_plus x y () =
  let%lwt result = Db.find Query.plus (x, y) in
  Caqti_lwt.or_fail result

let run_select_users () =
  let%lwt users = Db.collect_list Query.select_users () in
  Caqti_lwt.or_fail users

let _ = print_newline ()

let _ =
  Lwt_main.run
    (let%lwt result = run_plus 7 13 () in
     Lwt_io.printl (Printf.sprintf "%d" result))

let _ =
  Lwt_main.run
    (let%lwt users = run_select_users () in
     [%yojson_of: (int * string * string) list] users
     |> Yojson.Safe.to_string |> Lwt_io.printl)
