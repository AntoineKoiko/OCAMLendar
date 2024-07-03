open MyCalendarLib
open  Command
open Calendar
open Meeting
open Employee

let regeister_exceptions =
  Printexc.register_printer
    (function
      | CalendarEmployeeNotExist (id, emps) ->
        let ids_str = List.map emp_get_id emps |> List.map string_of_int |> String.concat ", " in
        Some (Printf.sprintf "EmployeeNotExist(%d, [%s])" id ids_str)
      | CalendarMeetingNotExist (id, meets) ->
        let ids_str = List.map meet_get_id meets |> List.map string_of_int |> String.concat ", " in
        Some (Printf.sprintf "MeetingNotExist(%d, [%s])" id ids_str)
      | _ -> None (* for other exceptions *)
    )

let rec main_loop (cal: calendar) : unit =
  try
    let input = input_line stdin in
    let cmd = parse_command input in
    handle_command cmd cal |> main_loop
 with
  | End_of_file -> ()
  | e -> raise e

let () =
  regeister_exceptions;
  main_loop cal_init

