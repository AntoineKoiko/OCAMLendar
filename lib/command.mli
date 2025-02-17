open Calendar

type command =
    | FireEmployyees of int list (* employees ids*)
    | NewEmployee of string * string * string * string (* last_name * first_name * position * zipcode  *)
    | InfoEmployees
    | NewMeeting of string * string * int list (* place (zipcode) * date * participant id's *)
    | InfoMeetings
    | InviteToMeeting of int * int list (* meet_id * emp_ids*)
    | ExcludeToMeeting of int * int list (*meet_id * empids*)
    | CancelMeetings of int list (*meet_ids*)
    | Quit
    | Unknown
    | Error of string
    | Help

val handle_command: command -> calendar -> calendar option

val parse_command: string -> command

