

type employee =  int * string * string * string * string
(* employee = id * last_name * first_name * position zipcode *)

val emp_get_id : employee -> int
(* [emp_get_id emp] retourne l'id de l'employé [emp]. *)

val emp_create : int -> string -> string -> string -> string -> employee
(* [emp_create id last_name first_name position zipcode] crée un employé avec
    les valeurs passées en paramètres. *)

val eq_employee : employee -> employee -> bool
(* [eq_employee e1 e2] retourne vrai si les 2 employés [e1] et [e2] ont les
    mêmes valeurs pour les champs [id], [last_name], [first_name], [position]
    et [zipcode]. *)

val emp_sort_by_name : employee list -> employee list
(* [emp_sort_by_name emps] retourne la liste des employés [emps] triée par
    ordre alphabétique sur les champs [last_name] puis [first_name]. *)

val emp_to_string: employee -> string
(* [emp_to_string emp] retourne une chaîne de caractères représentant l'employé
    [emp]. *)
