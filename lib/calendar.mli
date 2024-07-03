open Employee
open Meeting

exception CalendarNotIplemented of string

type calendar = employee list * meeting list

val cal_init: calendar

val cal_add_employee: calendar -> employee -> calendar

val cal_add_meeting: calendar -> meeting -> calendar

val cal_rm_employee: calendar -> int -> calendar

val cal_rm_meeting: calendar -> int -> calendar

val cal_employee_exist : calendar -> int -> bool

val cal_meeting_exist : calendar -> int -> bool

val cal_invite_employee_to_meeting: calendar -> int -> int -> calendar
(* cal, meet_id, emp_id *)

val  cal_fire_employee : calendar -> int -> calendar
(* Remove employee from employee list and from meetings where he was invited *)

val cal_rm_participant: calendar -> int -> int -> calendar
(* Remove participant from meeting: emp_id -> meet_id *)

val cal_display_employees: calendar -> unit
(* Display all employees *)

val cal_get_emp_max_id: calendar -> int
(* Get the max id of employees *)

val cal_get_meet_max_id: calendar -> int
(* Get the max id of meetings *)

val cal_display_meetings: calendar -> unit
(* Display all meetings *)