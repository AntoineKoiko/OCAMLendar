open Calendar

type command =
    | FireEmployyees of int list (* employees ids*)
    | NewEmployee of string * string * string * string (* last_name * first_name * position * zipcode  *)
    | InfoEmployees
    | NewMeeting of string * string * int list (* place (zipcode) * date * participant id's *)
    | InfoMeetings
    | Quit
    | Unknown

val handle_command: command -> calendar -> calendar

val parse_command: string -> command

