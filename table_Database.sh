#!/bin/bash

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$PROJECT_DIR/utilities_table.sh"
source "$PROJECT_DIR/utilities_main.sh"
#--------------------------------------------------------------------
# -------  Display Table Menu ------
#--------------------------------------------------------------------
bar="════════════════════════════════════════════════════════════"
echo -e "${blue}$bar${reset}"

table_menu=" Display Table Menu "
padding=$(( ((${#bar} - ${#table_menu}) / 2) - 1 ))
space=$(printf "%*s" $padding "")
echo -e "${green}║${space}${table_menu}${space}║${reset}"

echo -e "${blue}$bar${reset}"
echo -e "${yellow}Please, Select Your Choice.${reset}"
echo -e "${blue}$bar${reset}"

select var in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Exit"
do
    case $var in
        "Create Table" ) CreateTb

        ;;
        "List Tables" ) ListTb

        ;;
        "Drop Table" ) DropTb

        ;;
        "Insert into Table" ) InsertTb

        ;;
        "Select From Table" ) SelectTb

        ;;
	"Delete From Table" ) DeleteFromTb

	;;
	"Update Table" ) UpdateTb

	;;
	"Exit" )
		echo -e "${blue}$bar${reset}"
		echo -e "${green}\nBack To Main Menu ^_^ .......${reset}"
		echo -e "${blue}$bar${reset}"
		cd ..
		mainMenu
	;;
        * )
            echo "Invalid option. Please select a valid choice."
        ;;
    esac
done
