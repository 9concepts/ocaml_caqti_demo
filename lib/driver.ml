module Query = struct
  open Caqti_request.Infix

  let plus = (Caqti_type.(tup2 int int) ->! Caqti_type.int) "SELECT ? + ?"
  let delete_users = Caqti_type.(unit ->. unit) "DELETE FROM users"

  let select_users =
    Caqti_type.(unit ->* tup3 int string string)
      "SELECT user_id, name, email FROM users"

  let insert_user =
    Caqti_type.(tup2 string string ->. unit)
      "INSERT INTO users (name, email) VALUES (?, ?)"
end

let plus (module Db : Caqti_lwt.CONNECTION) x y =
  let%lwt result = Db.find Query.plus (x, y) in
  Caqti_lwt.or_fail result

let delete_users (module Db : Caqti_lwt.CONNECTION) =
  let%lwt result = Db.exec Query.delete_users () in
  Caqti_lwt.or_fail result

let select_users (module Db : Caqti_lwt.CONNECTION) =
  let%lwt users = Db.collect_list Query.select_users () in
  Caqti_lwt.or_fail users

let insert_user (module Db : Caqti_lwt.CONNECTION) name email =
  let%lwt result = Db.exec Query.insert_user (name, email) in
  Caqti_lwt.or_fail result
