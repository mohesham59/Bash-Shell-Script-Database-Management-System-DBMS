#!/bin/bash
#--------------------------------------------------------------------
# ------- Create Table -------
#--------------------------------------------------------------------
function CreateTb() {
	echo -e "${blue}$bar${reset}"
	
	while true;
	do
		read -p "Enter Table Name: " table_name
		echo -e "${blue}$bar${reset}"


		if [[ ! "$table_name" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
			echo -e "${red}Error: Invalid Table Name.${reset} The Name Must Start With a Letter or Underscore and Contain Only Letters, Numbers, and Underscores."
			continue
		elif [[ -f "$table_name" ]]; then
			echo -e "${yellow}Warning: The Table '$table_name' Already Exists.${reset}"
			return	
		else
			touch "$table_name"
			touch "${table_name}_metadata"
			echo -e "${green}Table '$table_name' Created Successfully.${reset}"
			break
		fi
	done
#--------------------------------------------------------------------

	read -p "Enter Number of Columns: " numColumns

	for ((i=1; i<=numColumns; i++)); 
	do
		while true;
		do
			read -p "Enter Name of Column $i: " columnName
			if [[ "$columnName" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
				break
			else
				echo -e "${red}Error: Invalid Column Name.${reset} The Name Must Start With a Letter or Underscore and Contain Only Letters, Numbers, and Underscores."
			fi
		done
#--------------------------------------------------------------------
		 while true; 
		 do
			read -p "Enter Data Type (str/int) of \"$columnName\": " columnType
				    if [[ "$columnType" == "str" || "$columnType" == "int" ]]; then
					break
				    else
					echo -e "${red}Error: Invalid Column Type.${reset} The Type Must be \"str\" or \"int\"."
				    fi
		done
#--------------------------------------------------------------------
		while true; 
		do
			read -p "Is \"$columnName\" The Primary Key? (y/n): " columnPK
			if [[ "$columnPK" == "y" || "$columnPK" == "n" ]]; then
				break
			else
				echo -e "${red}Error: Invalid Input for Primary Key.${reset} Must be \"y\" or \"n\"."	
			fi
		done
		
		
		echo -e "\"Column Name\": ${columnName}\n\"Column Type\": ${columnType}\n\"Primary Key\": ${columnPK}\n-----" >> "${table_name}_metadata"
		
	done
#--------------------------------------------------------------------
	echo -e "${green}Table '$table_name' With $numColumns Columns Created Successfully!${reset}"
	echo -e "${blue}$bar${reset}"

}

export -f CreateTb
#--------------------------------------------------------------------
# ------- List Table -------
#--------------------------------------------------------------------
function ListTb() {
	echo -e "${blue}$bar${reset}"
	echo -e "${yellow}Available Table:${reset}"
	ls -F | grep -v "metadata"
	echo -e "${blue}$bar${reset}"
}

export -f ListTb
#--------------------------------------------------------------------
# ------- Delete Table -------
#--------------------------------------------------------------------
function DropTb() {
	echo -e "${blue}$bar${reset}"
	read -p "Please, Enter Table Name: " Table_drop
	echo -e "${blue}$bar${reset}"

	if [[ ! "$Table_drop" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
		echo -e "${red}Error: Invalid Table Name.${reset}"
		return
	fi

	if [[ -f "$Table_drop" ]]; then
		rm -f "$Table_drop" "${Table_drop}_metadata"
		echo -e "${green}Table '$Table_drop' Deleted Successfully.${reset}"
	else
		echo -e "${red}Error: Table '$Table_drop' Does not Exist.${reset}"
	fi
	echo -e "${blue}$bar${reset}"
}

export -f DropTb
#--------------------------------------------------------------------
# ------- Insert Table -------
#--------------------------------------------------------------------
function InsertTb() {
	echo -e "${blue}$bar${reset}"
	read -p "Enter Table Name to Insert Data : " Table_insert
	echo -e "${blue}$bar${reset}"

	if [[ ! "$Table_insert" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]]; then
		echo -e "${red}Error: Invalid Table Name.${reset}"
		return
	fi

	if [[ ! -f "$Table_insert" ]]; then
		echo -e "${red}Error: Table '$Table_insert' Does not Exist.${reset}"
		return
	fi

	Metadata_file="${Table_insert}_metadata"

	if [[ ! -f "$Metadata_file" ]]; then
		echo -e "${red}Error: Metadata File for '$Table_insert' is Missing!${reset}"
		return
	fi

	columns=()
	data_types=()
	primary_key_column=""
	while IFS= read -r line; 
	do
		if [[ $line =~ ^\"Column\ Name\":\ (.*) ]]; then
			columns+=("${BASH_REMATCH[1]}")

		elif [[ $line =~ ^\"Column\ Type\":\ (.*) ]]; then
			data_types+=("${BASH_REMATCH[1]}")

		elif [[ $line =~ ^\"Primary\ Key\":\ (y) ]]; then
			primary_key_column="${columns[-1]}"

		fi
	done < "$Metadata_file"


	values=()
    
	for ((i=0; i<${#columns[@]}; i++)); do
		column_name="${columns[i]}"
		column_type="${data_types[i]}"
		
		while true; do
			read -p "Enter Value for '$column_name' ($column_type): " value


			if [[ "$column_type" == "int" && ! "$value" =~ ^[0-9]+$ ]]; then
				echo -e "${red}Error: '$column_name' Must be an Integer.${reset}"
				continue
			fi


			if [[ "$column_name" == "$primary_key_column" ]]; then
				
				if grep -q "^$value|" "$Table_insert"; then
				echo -e "${red}Error: Duplicate Value for Primary Key '$column_name'.${reset}"
				continue
				fi
				
			fi

			values+=("$value")
			break
		done
	done


	echo "${values[*]}" | tr ' ' '|' >> "$Table_insert"
	echo -e "${green}Data Inserted Successfully Into '$Table_insert'.${reset}"
	echo -e "${blue}$bar${reset}"
	
}

export -f InsertTb
#--------------------------------------------------------------------
# ------- Select Table -------
#--------------------------------------------------------------------
function SelectTb() {
	echo -e "${blue}$bar${reset}"
	read -p "Enter Table Name to Retrive Data : " TableSelect
	echo -e "${blue}$bar${reset}"
		
	if [[ ! -f "$TableSelect" ]]; then
		echo -e "${red}Error: Table '$TableSelect' does not exist.${reset}"
		return
	fi

	
	columns=()
	while IFS= read -r line; 
	do
	
		if [[ $line =~ ^\"Column\ Name\":\ (.*) ]]; then
			columns+=("${BASH_REMATCH[1]}")
		fi
		
	done < "${TableSelect}_metadata"
	
	
	echo -e "${blue}Table: $TableSelect${reset}"
	echo "---------------------------------"
	
	printf "| %-10s | %-10s | %-10s \n" "${columns[@]}"
	echo "---------------------------------"
		
	if [[ -s "$TableSelect" ]]; then
	
		while IFS='|' read -r id name age; 
		do
			printf "| %-10s | %-10s | %-10s \n" "$id" "$name" "$age"
		
		done < "$TableSelect"
		
	else
		echo -e "${yellow}No data found in table '$TableSelect'.${reset}"
	fi

		echo "---------------------------------"
	echo -e "${blue}$bar${reset}"
}

export -f SelectTb
#--------------------------------------------------------------------
# ------- Delete from Table -------
#--------------------------------------------------------------------
function DeleteFromTb() {
	echo -e "${blue}$bar${reset}"
	read -p "Enter Table Name to Delete Data : " TableSelectDel
	echo -e "${blue}$bar${reset}"


	if [[ ! -f "$TableSelectDel" ]]; then
	echo -e "${red}Error: Table '$TableSelectDel' does not exist.${reset}"
	return
	fi


	primary_key_column=""
	current_column=""

	while IFS= read -r line; 
	do
		if [[ $line =~ ^\"Column\ Name\":\ (.*) ]]; then
		
			current_column="${BASH_REMATCH[1]}"
			
		elif [[ $line =~ ^\"Primary\ Key\":\ (y) ]]; then
		
			primary_key_column="$current_column"
			break
			
		fi
	done < "${TableSelectDel}_metadata"


	if [[ -z "$primary_key_column" ]]; then
		echo -e "${red}Error: No Primary Key found in table metadata.${reset}"
		return
	fi


	read -p "Enter $primary_key_column value to delete: " pk_value


	if ! grep -q "^$pk_value|" "$TableSelectDel"; then
		echo -e "${yellow}No record found with $primary_key_column = '$pk_value'.${reset}"
		return
	fi


	grep -v "^$pk_value|" "$TableSelectDel" > temp_table && mv temp_table "$TableSelectDel"

	echo -e "${green}Record with $primary_key_column = '$pk_value' deleted successfully.${reset}"
	echo -e "${blue}$bar${reset}"
}

export -f DeleteFromTb
#--------------------------------------------------------------------
# ------- Update Table -------
#--------------------------------------------------------------------
function UpdateTb() {
	echo -e "${blue}$bar${reset}"
	read -p "Enter Table name to update: " TableUpdate
	echo -e "${blue}$bar${reset}"


	if [[ ! -f "$TableUpdate" || ! -f "${TableUpdate}_metadata" ]]; then
		echo -e "${red}Error: Table or metadata file not found.${reset}"
		return
	fi


	primary_key_column=""
	current_column=""
	columns=()

	while IFS= read -r line; 
	do
		[[ "$line" == "-----" || -z "$line" ]] && continue

		if [[ $line =~ ^\"Column\ Name\":\ (.*) ]]; then
			current_column="${BASH_REMATCH[1]}"
			columns+=("$current_column")
			
		elif [[ $line =~ ^\"Primary\ Key\":\ (y) ]]; then
		    	primary_key_column="$current_column"
		fi
		
	done < "${TableUpdate}_metadata"

	if [[ -z "$primary_key_column" ]]; then
		echo -e "${red}Error: No Primary Key found.${reset}"
		return
	fi

	echo "Primary Key Column: $primary_key_column"


	echo -e "${blue}Available Columns:${reset}"
	for col in "${columns[@]}"; 
	do
		echo "- $col"
	done


	read -p "Enter $primary_key_column value to update: " pk_value


	if ! grep -q "^$pk_value|" "$TableUpdate"; then
		echo -e "${yellow}No record found with $primary_key_column = '$pk_value'.${reset}"
		return
	fi


	read -p "Enter column name to update: " column_name
	
	if [[ ! " ${columns[@]} " =~ " $column_name " ]]; then
		echo -e "${red}Error: Column '$column_name' not found.${reset}"
		return
	fi


	if [[ "$column_name" == "$primary_key_column" ]]; then
		echo -e "${red}Error: Cannot update the primary key column.${reset}"
		return
	fi


	read -p "Enter new value for $column_name: " new_value


	col_index=-1
	for i in "${!columns[@]}"; 
	do
		if [[ "${columns[i]}" == "$column_name" ]]; then
			col_index=$((i + 1))
			break
		fi
	done

	if [[ $col_index -eq -1 ]]; then
		echo -e "${red}Error: Column index not found.${reset}"
		return
	fi


	awk -F'|' -v pk="$pk_value" -v col_num="$col_index" -v new_val="$new_value" '
	BEGIN { OFS="|"; found=0; }
	{
	if ($1 == pk) {
	    $col_num = new_val;
	    found=1;
	}
	print;
	}
	END {
	if (!found) print "Error: Record not updated." > "/dev/stderr";
	}' "$TableUpdate" > temp_table && mv temp_table "$TableUpdate"

	echo -e "${green}Record updated successfully.${reset}"
}

export -f UpdateTb
