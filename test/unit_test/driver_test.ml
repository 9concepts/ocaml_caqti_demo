open Lwt.Infix

module Db =
  (val Caqti_lwt.connect
         (Uri.of_string
            "postgresql://9sako6:password@localhost:5432/caqti_demo_db")
       >>= Caqti_lwt.or_fail |> Lwt_main.run)

let%test_module "plus" =
  (module struct
    let%expect_test "calculate 7 + 13" =
      Lwt_main.run
        (let%lwt result = Ocaml_caqti_demo.Driver.plus (module Db) 7 13 in
         print_endline (string_of_int result);
         Lwt.return_unit);
      [%expect {| 20 |}]
  end)

let%test_module "select_users" =
  (module struct
    let%expect_test "fetch all users" =
      Lwt_main.run
        (let%lwt users = Ocaml_caqti_demo.Driver.select_users (module Db) in
         [%yojson_of: (int * string * string) list] users
         |> Yojson.Safe.to_string |> print_endline;
         Lwt.return_unit);
      [%expect
        {| [[1,"test-user-1","test-1@example.com"],[2,"test-user-2","test-2@example.com"],[3,"test-user-3","test-3@example.com"],[4,"test-user-4","test-4@example.com"]] |}]
  end)
