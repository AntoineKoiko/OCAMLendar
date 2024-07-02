type meeting = int * string * string * int list (* id , day, zipcode, paticipants ids*)

let meet_create (id: int) (day: string) (zipcode: string) =
    (id, day, zipcode, [])

let meet_create_w_participants (id: int) (day: string) (zipcode: string) (participants: int list) =
    (id, day, zipcode, participants)

let meet_get_id (meet: meeting) =
    let (id, _, _, _) = meet in
    id

let eq_meeting (m1 : meeting) (m2 : meeting) : bool =
    let (id1, _, _, _) = m1 in
    let (id2, _, _, _) = m2 in
    id1 = id2

let meet_add_participant (meet: meeting) (emp_id: int) =
    let (id, day, zipcode, participants) = meet in
    (id, day, zipcode, emp_id :: participants)

let meet_rm_participant (meet: meeting) (emp_id: int) =
    let (id, day, zipcode, participants) = meet in
    let filtered_parts = List.filter (fun x -> x <> emp_id) participants in
    (id, day, zipcode, filtered_parts)

let meet_to_string (meet: meeting) =
    let (id, day, zipcode, participants) = meet in
    let str_parts = List.map string_of_int participants in
    Printf.sprintf "Meeting %d: %s %s \n[%s]" id day zipcode (String.concat ", " str_parts)