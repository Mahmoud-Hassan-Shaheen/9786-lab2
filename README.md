# project one is about antivirus and quarantine simple system

## 1-overview and the folder hierarchy
this project is shell scripts project
to monitor any directory for malicious files and then quarantine them
and a simple tool to review and manage the quarantined files as it could be falsely flagged.

Folder hierarchy:
- project folder:
  - antivirusd.sh
  - restore.sh
  - Makefile

## 2-prerequisites and insrallation needed
the scripts need a standard linux environment. and you will use `make` to use the Makefile commands and be easier to run the scripts.
it could be already installed but if not do this 
to install `make` on Ubuntu open the terminal run the following :
`sudo apt update`
`sudo apt install make`

## 3-how to run
you can run it easily by using the makefile:
*   **step 1:** open the terminal in the project directory.
*   **step 2 :** write `make runpart1` to start monitoring the directory form virus.
*   **step 3:** stop the antivirus then write `make runpart2` to review the quarantined files and chose the wanted file and chose the option you want.
*   **step 4: only if you want to create the quarantine directory** write `make setup`.

## 4-falgged extensions and keywords location
they are both inside the `antivirusd.sh` script in the `scan_files` function:
* **flagged extensions:** in the `case` statement.
* **flagged extensions:** in the `grep` command.

  
