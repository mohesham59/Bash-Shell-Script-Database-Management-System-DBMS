#!/bin/bash

#--------------------------------------------------------------------
# ------- Create Database -------
#--------------------------------------------------------------------
function CreateDb(){
	echo -e "${blue}$bar${reset}"
	read -p "Please, Enter Database Name: " Database_create
	echo -e "${blue}$bar${reset}"

	if [[ ! "$Database_create" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
		echo -e "${red}Error: Invalid Database Name.${reset} The Name Must Start With a Letter or Underscore and Contain Only Letters, Numbers, and Underscores."
	
	elif [[ -d $Database_create || -f $Database_create ]]; then
		echo -e "${yellow}Warning: The Database '$Database_create' Already Exists.${reset}"
	
	else
		mkdir "$Database_create"
		echo -e "${green}Database '$Database_create' Created Successfully.${reset}"
	fi
	echo -e "${blue}$bar${reset}"
}
export -f CreateDb
#--------------------------------------------------------------------
# ------- List Databases -------
#--------------------------------------------------------------------
function ListDb(){
	echo -e "${blue}$bar${reset}"
	echo -e "${yellow}Available Databases:${reset}"
	ls -F | grep /
	echo -e "${blue}$bar${reset}"
}
export -f ListDb
#--------------------------------------------------------------------
# ------- Connect To Databases -------
#--------------------------------------------------------------------
function ConnectDb(){
	echo -e "${blue}$bar${reset}"
	read -p "Please, Enter Database Name: " Database_connect
	echo -e "${blue}$bar${reset}"

	if [[ ! "$Database_connect" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
		echo -e "${red}Error: Invalid Database Name.${reset}"
	
	elif [[ -d $Database_connect ]]; then
		cd "$Database_connect" || exit
		echo -e "${green}Connected to '$Database_connect'.${reset}"

		if [[ -f "$PROJECT_DIR/table_Database.sh" ]]; then
			source "$PROJECT_DIR/table_Database.sh"
		else
			echo -e "${red}Error: table_Database.sh not Found.${reset}"
			exit 1
		fi
	
	else
		echo -e "${red}Error: Database '$Database_connect' Does not Exist.${reset}"
	fi
	echo -e "${blue}$bar${reset}"
}
export -f ConnectDb
#--------------------------------------------------------------------
# ------- Drop Database -------
#--------------------------------------------------------------------
function DropDb(){
	echo -e "${blue}$bar${reset}"
	read -p "Please, Enter Database Name: " Database_drop
	echo -e "${blue}$bar${reset}"

	if [[ ! "$Database_drop" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
		echo -e "${red}Error: Invalid Database Name.${reset}"
	
	elif [[ -d "$Database_drop" ]]; then
		rm -rf "$Database_drop"
		echo -e "${green}Database '$Database_drop' Deleted Successfully.${reset}"
	
	else
		echo -e "${red}Error: Database '$Database_drop' Does not Exist.${reset}"
	fi

	echo -e "${blue}$bar${reset}"
}
export -f DropDb


