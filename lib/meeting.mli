type meeting = int * string * string * int list (* id , day, zipcode, paticipants ids*)

val meet_get_id : meeting -> int

val meet_create : int -> string -> string -> meeting

val meet_create_w_participants : int -> string -> string -> int list -> meeting

val eq_meeting : meeting -> meeting -> bool

val meet_add_participant : meeting -> int -> meeting

val meet_rm_participant : meeting -> int -> meeting

val meet_to_string : meeting -> string
(* Convert meeting to string *)