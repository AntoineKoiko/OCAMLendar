open Calendar
open Employee
open Meeting
open Utils

type command =
    | FireEmployyees of int list (* employees ids*)
    | NewEmployee of string * string * string * string (* last_name * first_name * position * zipcode  *)
    | InfoEmployees
    | NewMeeting of string * string * int list (* place (zipcode) * date * participant id's *)
    | InfoMeetings
    | InviteToMeeting of int * int list (* meet_id * emp_id*)
    | ExcludeToMeeting of int * int list (*meet_id * empids*)
    | CancelMeetings of int list (*meet_ids*)
    | Quit
    | Unknown
    | Error of string
    | Help


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

let parse_invite_to_meetings (cmds: string list) : command =
    match List.length cmds with
    | n when n < 3 -> Error (Printf.sprintf "Expected: at least 3 args | Actual: %d" n)
    | _ -> let meet_id = List.nth cmds 1 |> int_of_string in
            let emp_str_ids = List.tl cmds |> List.tl in
            let emp_ids = List.map int_of_string emp_str_ids in
            InviteToMeeting (meet_id, emp_ids)

let parse_exclude_to_meeting (cmds: string list) : command =
    match List.length cmds with
    |  n when n < 3 -> Error (Printf.sprintf "Expected: at least 3 args | Actual: %d" n)
    | _ ->
        let meet_id = List.nth cmds 1 |> int_of_string in
        let emp_str_ids = List.tl cmds |> List.tl in
        let emp_ids = List.map int_of_string emp_str_ids in
        ExcludeToMeeting (meet_id, emp_ids)


let parse_cancel_meets (cmds: string list) : command =
    let str_ids = List.tl cmds in
    CancelMeetings (List.map int_of_string str_ids)

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
    | "invite" -> parse_invite_to_meetings words
    | "exclude" -> parse_exclude_to_meeting words
    | "cancel" -> parse_cancel_meets words
    | "end" -> Quit
    | "help" -> Help
    | _ -> Error (Printf.sprintf "Unknown command: %s, type \'help` for more info" fst_word)


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


let rec handle_invite_to_meet (meet_id: int) (emp_ids: int list) (cal: calendar) =
    match emp_ids with
    | [] -> cal
    | emp_id::tl -> cal_invite_employee_to_meeting  cal  emp_id meet_id |> handle_invite_to_meet meet_id tl

let rec handle_exlude_to_meet (meet_id: int) (emp_ids: int list) (cal: calendar) =
    match emp_ids with
    | [] -> cal
    | emp_id::tl -> cal_exclude_employee_to_meeting  cal  emp_id meet_id |> handle_exlude_to_meet meet_id tl


let rec handle_cancel_meets (meet_ids: int list) (cal: calendar) : calendar =
    match meet_ids with
    | [] -> cal
    | meet_id::tl -> cal_rm_meeting  cal  meet_id |> handle_cancel_meets tl

let handle_command (com: command) (cal: calendar): calendar option =
    match com with
    | NewEmployee _ -> Some (handle_new_employee com cal)
    | FireEmployyees ids -> Some (handle_fire_employees ids cal)
    | InfoEmployees -> cal_display_employees cal; Some cal
    | NewMeeting (place, date, ids) -> Some (handle_new_meeting place date ids cal)
    | InfoMeetings -> cal_display_meetings cal; Some cal
    | InviteToMeeting (meet_id, emp_ids) -> Some (handle_invite_to_meet meet_id emp_ids cal)
    | ExcludeToMeeting (meet_id, emp_ids) -> Some (handle_exlude_to_meet meet_id emp_ids cal)
    | CancelMeetings meet_ids -> Some (handle_cancel_meets meet_ids cal)
    | Unknown -> print_endline "Unknown"; Some cal
    | Error (str) -> print_endline (Printf.sprintf "Error: %s" str); Some cal
    | Quit -> None
    | Help -> display_help (); Some cal
