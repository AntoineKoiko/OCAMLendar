

type employee =  int * string * string * string * string


let emp_get_id (emp: employee) : int =
  let (id, _, _, _, _) = emp in
  id


let emp_create (id: int) (last_name: string) (first_name: string) (position: string) (zipcode: string) : employee =
  (id, last_name, first_name, position, zipcode)

let eq_employee (e1: employee) (e2: employee) : bool =
  (emp_get_id e1) = (emp_get_id e2)


(* // Util funciton *)

let emp_cmp_by_forename (e1: employee) (e2: employee) : int =
  let (id1, _, fn1, _, _) = e1 in
  let (id2, _, fn2, _, _) = e2 in
  match String.compare fn1 fn2 with
  | 0 -> id1 - id2
  | n -> n

(*  *)

let emp_sort_by_name (emps: employee list):  employee list =
  emps |> List.sort emp_cmp_by_forename

let emp_to_string (e: employee) : string =
  let (id, ln, fn, pos, zip) = e in
  Printf.sprintf "Employee (%d)\n %s %s %s %s" id ln fn pos zip
