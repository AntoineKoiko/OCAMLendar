# OCMLendar

![OCaml](https://img.shields.io/badge/OCaml-%23E98407.svg?style=for-the-badge&logo=ocaml&logoColor=white)


## Description

OCMLendar is a command-line interface (CLI) application for managing employees and meetings, written in OCaml using the functional programming paradigm. This program allows you to add new employees, schedule meetings, invite or exclude employees from meetings, display information about employees and meetings, cancel meetings, and fire employees.

## Features

- Add new employees with detailed information.
- Schedule and manage meetings with multiple participants.
- Invite or exclude employees from existing meetings.
- Display sorted information about employees and meetings.
- Cancel one or more meetings.
- Fire one or more employees.
- Easy-to-use help command for listing all available commands.

## Installation

To compile and run OCMLendar, you'll need to have OCaml and Dune, the OCaml build system, installed on your system. You can install them using OPAM, the OCaml package manager.

[How to install OPAM](https://opam.ocaml.org/doc/Install.html)

[How to install Dune](https://dune.build/install)


## Getting started


Build the project:
```sh
dune build
```

Run the project:

```sh
dune exec OCAMLendar
```

Explore the commands by typing:
```sh
help
```

## Usage

Commands

- new_employee name forename job zipcode
        Add a new employee with the specified name, forename, job, and zipcode.
- new_meeting place date idEmployee1 idEmployee2 [idEmployee3 ...]
        Schedule a new meeting at the specified place and date, and invite employees by their ids.
- invite idMeeting idEmployee1 [idEmployee2 ...]
        Invite additional employees to an existing meeting by the meeting id and employee ids.
- exclude idMeeting idEmployee1 [idEmployee2 ...]
        Exclude employees from an existing meeting by the meeting id and employee ids.
- info_employees sortByE [idEmployee1 ...]
        Display information about employees, optionally sorted by the specified criterion.
- info_meetings sortByM [idMeeting1 ...]
        Display information about meetings, optionally sorted by the specified criterion.
- cancel idMeeting1 [idMeeting2 ...]
        Cancel one or more meetings by their ids.
- fire idEmployee1 [idEmployee2 ...]
        Fire one or more employees by their ids.
- end
        End the program.
- help
        Display this help text.

## Licence

This project is licensed under the MIT License - see the LICENSE file for details.

## Contribution

Every contributions and comments are welcome!