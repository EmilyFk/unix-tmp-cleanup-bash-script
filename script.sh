#!/bin/bash
#The welcome function
function Welcome() {
  echo "Hi! What's your name? "
  read PERSON
  echo " "
  echo "Welcome to my script, $PERSON ! "
  echo " "
  echo "Let's start with the Menu... "
  echo " "
  echo "Press any key  "
  read KEY
}

#The menu function
function Menu() {
  echo " "
  echo " * ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ MENU ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ *"
  echo " |                                                        |"
  echo " |   1. Today is...              (Press 1)                |"
  echo " |   2. Backup Temp Directory    (Press 2)                |"
  echo " |   3. Clear Temp Directory     (Press 3)                |"
  echo " |   4. Restore Temp Directory   (Press 4)                |"
  echo " |   5. Script Info              (Press 5)                |"
  echo " |   6. Exit                     (Press 6)                |"
  echo " |                                                        |"
  echo " * ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~*"
}

#The answer of the Menu function
function Answer() {
  echo "And now select your numeric choice..."
  read THEANSWER
  echo " "

  if [[ "$THEANSWER" == "1" ]]; then
    Today

  elif [[ "$THEANSWER" == "2" ]]; then
    BackUpTempDirectory

  elif [[ "$THEANSWER" == "3" ]]; then
    ClearTempDirectory

  elif [[ "$THEANSWER" == "4" ]]; then
    RestoreTempDirectory

  elif [[ "$THEANSWER" == "5" ]]; then
    Info

  elif [[ "$THEANSWER" == "6" ]]; then
    Bye

  else
    echo "Wrong value.."
    echo "Try again!"
    Continue
  fi
}

# press1_today_function
function Today() {
  echo "--> 1.Today  "
  echo " "
  echo "Today is : "
  date
  echo " "
  echo "... And this is the calendar : "
  cal
  Continue
}

#press2_AbackUpDirectory_function
function BackUpTempDirectory() {
  echo "--> 2.Backup Temp directory"
  echo " "
  cd /tmp
  cd ..
  echo " These are your current temp contents: "
  echo " "
  ls
  echo " "

  if [ -d backupTmp ]; then
    echo "The backupTmp directory exists, contents will be overwritten."
    echo " "
    rm -rf /backupTmp/*
  fi

  cp -r tmp backupTmp
  echo "Your backupTmp directory is now created!"
  echo " "
  echo "These are the backup contents: "
  ls

  Continue
}

#press3_ClearTmp_function
function ClearTempDirectory() {
  echo "--> 3.Clear Temp Directory"
  echo " "
  echo "~> These are the contents of your temp: "
  cd /tmp
  ls
  echo " "
  echo " Now, cleaning tmp directory "
  rm -rf /tmp/*
  echo "Cleaned succesfully"
  cd /tmp
  ls

  Continue
}

#press4_restoreTemp_function
function RestoreTempDirectory() {
  echo "--> 4.Restore Temp Directory"
  echo " "
  echo "Starting restore of temp directory .."
  echo " "
  cd /tmp
  cd ..
  echo "~> These are the contents of your temp:  "
  ls
  if [ -d backupTmp ]; then
    cp -a /backupTmp/. /tmp/
    echo " "
    echo "Restore succesfully"
    echo "~> BackupTmp Directory Contents: "
    cd /backupTmp
    ls
    echo " "
    echo "~> Temp directory contents:"
    cd /tmp
    ls
  else
    echo " "
    echo "~> BackupTmp directory does not exist"
    echo " "
    echo "Please, select 2nd option in the main menu for backup creation"
  fi

  Continue
}

#press5_infoScript_function
function Info() {
  echo "--> 5.Script Info: "
  echo " "
  echo "Created by Emily Fakou"
  echo "For Operation Systems studies at 2020-2021 "
  echo "Version: 1.0.0 "
  Continue
}

#press0/6_exit_function
function Bye() {
  echo "--> Time for exit <-- "
  echo " "
  echo "      .. Wait for 3 seconds "
  sleep 3
  echo " "
  echo " You have now exitted of the script."
  echo " "
  echo "                 Bye, $PERSON !!"
  echo " "
  echo "          ~ * ~ "
}

#theContinue_function
function Continue() {
  echo " "
  echo "        - - - - - "
  echo " "
  echo "Do you want to continue? "
  echo "Press 0 for exit or 1 to continue "
  read VAR

  if [[ "$VAR" == "0" ]]; then
    Bye
  else
    Menu
    Answer
  fi
}

#theEntry_function
function CheckUser() {
  if ! [ $(id -u) = 0 ]; then
    echo "The script need to be run as root." >&2
    exit 1
  fi
}

#start_with:
CheckUser
Welcome
echo " "
Menu
echo " "
Answer
echo " "
