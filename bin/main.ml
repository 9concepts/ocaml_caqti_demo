open Lwt.Infix

module Db =
  (val Caqti_lwt.connect
         (Uri.of_string
            "postgresql://9sako6:password@localhost:5432/caqti_demo_db")
       >>= Caqti_lwt.or_fail |> Lwt_main.run)

let _ = print_newline ()

let _ =
  Lwt_main.run
    (let%lwt result = Ocaml_caqti_demo.Driver.plus (module Db) 7 13 in
     Lwt_io.printl (Printf.sprintf "%d" result))

let _ =
  Lwt_main.run
    (let%lwt users = Ocaml_caqti_demo.Driver.select_users (module Db) in
     [%yojson_of: (int * string * string) list] users
     |> Yojson.Safe.to_string |> Lwt_io.printl)
