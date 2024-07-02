open MyCalendarLib
open Employee
open Meeting
open Calendar


let test_fun test_fn f_name =
  print_string f_name;
  print_string " ";
  match test_fn () with
  | exception _ ->  print_endline "KO"
  | _ -> print_endline "OK"

let test_eq_employee () =
  let e1 = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let e2 = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let e3 = emp_create 2 "Doe" "John" "PDG" "F-35000" in

  assert (eq_employee e1 e2);
  assert (not (eq_employee e1 e3));
  assert (not (eq_employee e2 e3))

let test_eq_meeting () =
  let m1 = meet_create 1 "2021-01-01" "F-35000" in
  let m2 = meet_create 1 "2021-01-01" "F-35000" in
  let m3 = meet_create 2 "2021-01-01" "F-35000" in

  assert (eq_meeting m1 m2);
  assert (not (eq_meeting m1 m3));
  assert (not (eq_meeting m2 m3))

let test_cal_add_meeting () =
  let c = cal_init in
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let (emps, mets) = cal_add_meeting c m in
  assert (List.length emps = 0);
  assert (List.length mets = 1)

let test_cal_add_employee () =
  let c = cal_init in
  let e = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let (emps, _) = cal_add_employee c e in
  assert (List.length emps = 1)

let test_cal_rm_employee () =
  let c = cal_init in
  let e = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let cal = cal_add_employee c e in
  let (emps, _) = cal_rm_employee cal (emp_get_id e) in
  assert (List.length emps = 0)

let test_cal_rm_meeting () =
  let c = cal_init in
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let cal = cal_add_meeting c m in
  let (_, mets) = cal_rm_meeting cal (meet_get_id m) in
  assert (List.length mets = 0)


let test_meet_add_participant () =
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let m = meet_add_participant m 1 in
  let m = meet_add_participant m 2 in
  let (_, _, _, parts) = m in
  assert (List.length parts = 2)

let test_meet_rm_participant () =
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let m = meet_add_participant m 1 in
  let m = meet_add_participant m 2 in
  let m = meet_rm_participant m 1 in
  let (_, _, _, parts) = m in
  assert (List.length parts = 1)

let test_cal_employee_exist () =
  let c = cal_init in
  let e = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let cal = cal_add_employee c e in
  assert (cal_employee_exist cal (emp_get_id e))

let test_cal_meeting_exist () =
  let c = cal_init in
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let cal = cal_add_meeting c m in
  assert (cal_meeting_exist cal (meet_get_id m))

let test_cal_invite_employee_to_meeting () =
  let c = cal_init in
  let e = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let ce = cal_add_employee c e in
  let cm = cal_add_meeting ce m in
  let cal = cal_invite_employee_to_meeting cm (emp_get_id e) (meet_get_id m) in
  let (_, meets) = cal in
  let meet = List.hd meets in
  let (_, _, _, parts) = meet in
  assert (List.length parts = 1)

let test_cal_fire_employee () =
  let c = cal_init in
  let e = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let ce = cal_add_employee c e in
  let cm = cal_add_meeting ce m in
  let cal = cal_invite_employee_to_meeting cm (emp_get_id e) (meet_get_id m) in
  let cal = cal_fire_employee cal (emp_get_id e) in
  let (emps, meets) = cal in
  let meet = List.hd meets in
  let (_, _, _, parts) = meet in
  assert (List.length emps = 0);
  assert (List.length parts = 0)


let test_cal_rm_participant () =
  let c = cal_init in
  let e = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let m = meet_create 1 "2021-01-01" "F-35000" in
  let ce = cal_add_employee c e in
  let cm = cal_add_meeting ce m in
  let cal = cal_invite_employee_to_meeting cm (emp_get_id e) (meet_get_id m) in
  let cal = cal_rm_participant cal (emp_get_id e) (meet_get_id m) in
  let (emps, meets) = cal in
  let meet = List.hd meets in
  let (_, _, _, parts) = meet in
  assert (List.length parts = 0);
  assert (List.length emps = 1)


(* SORT FUNCTIONS *)

let test_emp_sort_by_forename () =
  let e1 = emp_create 1 "Doe" "John" "PDG" "F-35000" in
  let e2 = emp_create 2 "Doe" "John" "PDG" "F-35000" in
  let e3 = emp_create 3 "Doe" "Alice" "PDG" "F-35000" in
  let emp_list = [e1; e2; e3] in

  let sorted = emp_sort_by_name emp_list in

  assert (List.nth sorted 0 = e3)



(*  *)



let () =
  test_fun test_eq_employee "test_eq_employee";
  test_fun test_eq_meeting "test_eq_meeting";
  test_fun test_cal_add_meeting "test_cal_add_meeting";
  test_fun test_cal_add_employee "test_cal_add_employee";
  test_fun test_cal_rm_employee "test_cal_rm_employee";
  test_fun test_cal_rm_meeting "test_cal_rm_meeting";
  test_fun test_meet_add_participant "test_meet_add_participant";
  test_fun test_meet_rm_participant "test_meet_rm_participant";
  test_fun test_cal_employee_exist "test_cal_employee_exist";
  test_fun test_cal_meeting_exist "test_cal_meeting_exist";
  test_fun test_cal_invite_employee_to_meeting "test_cal_invite_employee_to_meeting";
  test_fun test_cal_fire_employee "test_cal_fire_employee";
  test_fun test_cal_rm_participant "test_cal_rm_participant";
  test_fun test_emp_sort_by_forename "test_emp_sort_by_forename";