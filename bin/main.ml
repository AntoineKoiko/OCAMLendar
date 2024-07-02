open MyCalendarLib
open  Command
open Calendar

(* let main_loop (cal: calendar) : unit =
 try while true do
    let input = input_line stdin in
    let cmd = parse_command input in
    handle_command cmd
  done with End_of_file -> ()
 *)

 let rec main_loop (cal: calendar) : unit =
   let input = input_line stdin in
    let cmd = parse_command input in
    handle_command cmd cal |> main_loop

let () =
  main_loop cal_init

