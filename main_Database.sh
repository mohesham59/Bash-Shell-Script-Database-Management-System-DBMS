#!/bin/bash

export PROJECT_DIR="$(dirname "$(realpath "$0")")"
source "$PROJECT_DIR/utilities_main.sh"
#--------------------------------------------------------------------
# ------- Initialization Message -------
#--------------------------------------------------------------------
export red="\033[0;31m"
export green="\033[0;32m"
export yellow="\033[0;33m"
export blue="\033[0;34m"
export reset="\033[0m"
#--------------------------------------------------------------------
# ------- Decorative frame -------
#--------------------------------------------------------------------
function header(){
	bar="════════════════════════════════════════════════════════════"
	title=" DATABASE MANAGEMENT SYSTEM "

	# Calculate padding to center the title
	padding=$(( ((${#bar} - ${#title}) / 2) - 1 ))

	# Generate spaces for centering
	space=$(printf "%*s" $padding "")

	# Print header
	echo -e "${blue}$bar${reset}"
	echo -e "${green}║${space}${title}${space}║${reset}"
	echo -e "${blue}$bar${reset}"
}
header
#--------------------------------------------------------------------
# ------- Ensure 'Database' Directory Exists -------
#--------------------------------------------------------------------
if [[ ! -d "Database" ]]; then
    mkdir "Database"
    echo -e "\n${yellow}Database Directory Created.${reset}"
else
	cd "Database" || { echo -e "${red}Failed to Enter Database Directory.${reset}"; exit 1; }
fi
#--------------------------------------------------------------------
# ------- Display Main Menu -------
#--------------------------------------------------------------------
function mainMenu() {
	PS3="Choose an Option: " 
	
	echo -e "${blue}$bar${reset}"
	
	main_menu=" Display Main Menu "
	padding=$(( ((${#bar} - ${#main_menu}) / 2) - 1 ))
	space=$(printf "%*s" $padding "")
	echo -e "${green}║${space}${main_menu}${space} ║${reset}"
	
	echo -e "${blue}$bar${reset}"
	echo -e "${yellow}Please, Select Your Choice.${reset}"
	echo -e "${blue}$bar${reset}"

	select var in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit"
	do
		case $var in
			"Create Database" ) CreateDb
			;;

			"List Databases" ) ListDb
			;;

			"Connect To Databases" ) ConnectDb
			;;

			"Drop Database" ) DropDb
			;;

			"Exit" )
				echo -e "${blue}$bar${reset}"
				echo -e "${green}\\nGood Bye ^_^ .......${reset}"
				echo -e "${blue}$bar${reset}"
				exit
			;;

			* )
				echo -e "${red}Invalid Option. Please Try Again.${reset}"
			;;
		esac
	done
}
mainMenu

