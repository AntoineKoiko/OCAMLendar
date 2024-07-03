(lang dune 3.6)

(name OCAMLendar)

(generate_opam_files true)

(source
 (github AntoineKoiko/OCAMLendar))

(authors "AntoineKoiko")

(maintainers "AntoineKoiko")

(license MIT)

(documentation https://url/to/documentation)

(package
 (name OCAMLendar)
 (synopsis "A CLI to manage meetings and employees")
 (description "OCMLendar is a command-line interface (CLI) application for managing employees and meetings, written in OCaml using the functional programming paradigm. This program allows you to add new employees, schedule meetings, invite or exclude employees from meetings, display information about employees and meetings, cancel meetings, and fire employees.")
 (depends ocaml dune)
 (tags
  (topics "CLI" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
