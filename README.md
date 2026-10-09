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

## 5-Automated Scanning with cron
the `antivirus-cron.sh` automates the scanning using cron. and each scan it moves any detected bad file to the quarantine directory.
** Run the scan every minute at second 23**
**1** open the treminal and edit the current user's crontab by writing this:
```bash
crontab -e
```
**2** write this to schedule the scan every minute at second 23
```cron
* * * * * sleep 23; cd /home/labzero/Desktop/project1_1 && ./antivirus-cron.sh /home/labzero/Desktop/project1_1/my_dir /home/labzero/Desktop/project1_1/malicious_dir
```
**so**
* -(* * * * * ): run the job (scan) every minute.
* -(sleep 23) : delays the run 23 seconds to start there not at the start of the minute.
**3** saveing the crontab and verify the scheduled run:
```bash
crontab -1
```

## 6-Run the Scan on the Third Friday of Every Month

To schedule the scan at **12:31 AM on the third Friday of every month**, add the following entry to the crontab:

```cron
31 0 * * 5 [ "$(date +\%d)" -ge 15 ] && [ "$(date +\%d)" -le 21 ] && cd /home/labzero/Desktop/project1_1 && bash antivirus-cron.sh /home/labzero/Desktop/project1_1/my_dir /home/labzero/Desktop/project1_1/malicious_dir >> /home/labzero/Desktop/project1_1/antivirus-cron.log 2>&1
```

- `31 0 * * 5`: Runs the job every Friday at 12:31 AM.
- `date +\%d`: Gets the current day of the month.
- `-ge 15` and `-le 21`: Ensure that the job runs only between the 15th and 21st, identifying the third Friday.

** how to Managing the Cron Job **

- **View scheduled jobs:** Run `crontab -l`.
- **Edit or remove a job:** Run `crontab -e` and modify or delete the corresponding entry.
- **Review execution logs:** Check `antivirus-cron.log` in the project directory.

## 7-whitelist algorithm 
- the whitelist.txt stored in the project directory.
- when the user restore a deleted file from the quarantine files the file name stores in the whitelist.txt file 
- in the antivirusd.sh when the scan starts it checks first if the file name in the whitelist if No do the normal process if yes it skip this file even if the file extension or content matches the malicious rules.
- so in the end it like a memory we store the restored files so we don't delete it agin.




  
