open Employee
open Meeting

open List

exception CalendarNotIplemented of string

exception CalendarMeetingNotExist of int * meeting list

exception CalendarEmployeeNotExist of int * employee list


type calendar = employee list * meeting list

let cal_init = ([], [])

let cal_add_employee (cal: calendar)  (emp: employee) =
    let (emps, meets) = cal in
    (emp::emps, meets)

let cal_add_meeting (cal: calendar) (met: meeting) =
    let (emps, meets) = cal in
    (emps, met::meets)

let cal_rm_employee ((emps, meets): calendar) (emp_id: int) =
    (filter (fun (emp: employee) -> (emp_get_id emp) <> emp_id) emps, meets)

let cal_rm_meeting ((emps, meets): calendar) (meet_id: int) =
    (emps, filter (fun (meet: meeting) -> meet_get_id meet <> meet_id) meets)

let cal_employee_exist ((emps, _): calendar) (emp_id: int): bool =
    exists (fun (emp: employee) -> (emp_get_id emp) = emp_id) emps

let cal_meeting_exist ((_, meets): calendar) (meet_id: int): bool =
    exists (fun (meet: meeting) -> meet_get_id meet = meet_id) meets


let cal_invite_employee_to_meeting ((emps, meets): calendar) (emp_id: int) (meet_id: int): calendar =
    match cal_employee_exist (emps, meets) emp_id with
    | false -> raise (CalendarEmployeeNotExist  (emp_id, emps))
    | true -> match cal_meeting_exist (emps, meets) meet_id  with
        | false -> raise (CalendarMeetingNotExist (meet_id, meets))
        | true ->
            let meet = find (fun (meet: meeting) -> meet_get_id meet = meet_id) meets in
            let meet = meet_add_participant meet emp_id in
            let filtered_meets = cal_rm_meeting (emps, meets) meet_id |> snd in
            (emps, meet::filtered_meets)


let cal_exclude_employee_to_meeting ((emps, meets): calendar) (emp_id: int) (meet_id: int): calendar =
    match cal_employee_exist (emps, meets) emp_id with
    | false -> raise (CalendarEmployeeNotExist  (emp_id, emps))
    | true -> match cal_meeting_exist (emps, meets) meet_id  with
        | false -> raise (CalendarMeetingNotExist (meet_id, meets))
        | true ->
            let meet = find (fun (meet: meeting) -> meet_get_id meet = meet_id) meets in
            let meet = meet_rm_participant meet emp_id in
            let filtered_meets = cal_rm_meeting (emps, meets) meet_id |> snd in
            (emps, meet::filtered_meets)

let cal_fire_employee ((emps, meets): calendar) (emp_id: int) : calendar =
    let filtered_emps = cal_rm_employee (emps, meets) emp_id |> fst in
    let filter_part (meet: meeting) = Meeting.meet_rm_participant meet emp_id in
    let filtered_meets = map filter_part meets in
    (filtered_emps, filtered_meets)

let cal_rm_participant ((emps, meets): calendar) (emp_id: int) (meet_id: int): calendar =
    match cal_meeting_exist (emps, meets) meet_id with
    | false -> (emps, meets)
    | true ->
        let meet = find (fun (meet: meeting) -> meet_get_id meet = meet_id) meets in
        let filtered_meets = cal_rm_meeting (emps, meets) meet_id |> snd in
        let cleaned_meet = Meeting.meet_rm_participant meet emp_id in
        (emps, cleaned_meet::filtered_meets)

let cal_display_employees (cal: calendar) : unit =
    let (emps, _) = cal in
    print_endline "*********\n\tEMPLOYEES";
    iter (fun (emp: employee) -> print_endline (emp_to_string emp)) emps;
    print_endline "*********"

let cal_get_emp_max_id ((emps, _): calendar) : int =
    match emps with
    | [] -> 0
    | _ -> fold_left (fun acc (emp: employee) -> max acc (emp_get_id emp)) 0 emps



let cal_get_meet_max_id ((_, meets): calendar) : int =
    match meets with
    | [] -> 0
    | _ -> fold_left (fun acc (meet: meeting) -> max acc (meet_get_id meet)) 0 meets

let cal_display_meetings ((_, meets): calendar) : unit =
    print_endline "*********\n\tMEETIGNS";
    iter (fun (meet: meeting) -> print_endline (meet_to_string meet)) meets;
    print_endline "*********"

