let help_text = "
Available commands:
new_employee name forename job zipcode
   - Add a new employee with the specified name, forename, job, and zipcode.

new_meeting place date idEmployee1 idEmployee2 [idEmployee3 ...]
   - Schedule a new meeting at the specified place and date, and invite employees by their ids.

invite idMeeting idEmployee1 [idEmployee2 ...]
   - Invite additional employees to an existing meeting by the meeting id and employee ids.

exclude idMeeting idEmployee1 [idEmployee2 ...]
   - Exclude employees from an existing meeting by the meeting id and employee ids.

info_employees sortByE [idEmployee1 ...]
   - Display information about employees, optionally sorted by the specified criterion.

info_meetings sortByM [idMeeting1 ...]
   - Display information about meetings, optionally sorted by the specified criterion.

cancel idMeeting1 [idMeeting2 ...]
   - Cancel one or more meetings by their ids.

fire idEmployee1 [idEmployee2 ...]
   - Fire one or more employees by their ids.

end
   - End the program.

help
   - Display this help text.
"

let display_help () =
  print_endline help_text
