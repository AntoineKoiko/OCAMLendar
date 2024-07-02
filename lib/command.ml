open Calendar
open Employee
open Meeting

type command =
    | FireEmployyees of int list (* employees ids*)
    | NewEmployee of string * string * string * string (* last_name * first_name * position * zipcode  *)
    | InfoEmployees
    | NewMeeting of string * string * int list (* place (zipcode) * date * participant id's *)
    | InfoMeetings
    | Quit
    | Unknown


(* PARSE  *)

let parse_new_employee (cmds: string list): command =
    match  List.length cmds with
    | 5 -> NewEmployee (List.nth cmds 1, List.nth cmds 2, List.nth cmds 3, List.nth cmds 4)
    | _ -> Unknown

let parse_fire_employees (cmds: string list): command =
    match List.length cmds with
    | n when n < 2 -> Unknown
    | _ -> let ids = List.tl cmds |> List.map int_of_string in
            FireEmployyees ids


let parse_new_meeting (cmds: string list): command =
    match List.length cmds with
    | n when n < 4 -> Unknown
    | _ -> let place = List.nth cmds 1 in
            let date = List.nth cmds 2 in
            let str_ids = List.tl cmds |> List.tl |> List.tl in
            let ids = List.map int_of_string str_ids in
            NewMeeting (place, date, ids)

let parse_command  (str: string) : command =
    let words = String.split_on_char ' ' str in
    let fst_word = List.hd words in
    match fst_word with
    | "quit" -> Quit
    | "new_employee" -> parse_new_employee words
    | "info_employees" -> InfoEmployees
    | "fire" -> parse_fire_employees words
    | "new_meeting" -> parse_new_meeting words
    | "info_meetings" -> InfoMeetings
    | _ -> Unknown


(* HANDLE  *)

let handle_new_employee (cmd: command) (cal: calendar): calendar =
    let new_id = cal_get_emp_max_id cal |> (+) 1 in
    match cmd with
    | NewEmployee (ln, fn, pos, zipcode) -> cal_add_employee cal (emp_create new_id ln fn pos zipcode )
    | _ -> cal


let handle_fire_employees (ids: int list) (cal: calendar): calendar =
    let rec loop (ids: int list) (cal: calendar): calendar =
        match ids with
        | [] -> cal
        | hd::tl -> loop tl (cal_fire_employee cal hd)
    in loop ids cal


let handle_new_meeting (place: string) (date: string) (ids: int list) (cal: calendar) : calendar=
    let new_id = cal_get_meet_max_id cal |> (+) 1 in
    let meet = meet_create_w_participants new_id place date ids in
    cal_add_meeting cal meet


let handle_command (com: command) (cal: calendar): calendar =
    match com with
    | Quit -> print_endline "Quit"; cal
    | NewEmployee _ -> handle_new_employee com cal
    | FireEmployyees ids -> handle_fire_employees ids cal
    | InfoEmployees -> cal_display_employees cal; cal
    | NewMeeting (place, date, ids) -> handle_new_meeting place date ids cal
    | InfoMeetings -> cal_display_meetings cal; cal
    | Unknown -> print_endline "Unknown"; cal
