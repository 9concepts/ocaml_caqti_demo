module Query = struct
  open Caqti_request.Infix

  let plus = (Caqti_type.(tup2 int int) ->! Caqti_type.int) "SELECT ? + ?"

  let select_users =
    Caqti_type.(unit ->* tup3 int string string)
      "SELECT user_id, name, email FROM users"
end

let plus (module Db : Caqti_lwt.CONNECTION) x y =
  let%lwt result = Db.find Query.plus (x, y) in
  Caqti_lwt.or_fail result

let select_users (module Db : Caqti_lwt.CONNECTION) =
  let%lwt users = Db.collect_list Query.select_users () in
  Caqti_lwt.or_fail users
