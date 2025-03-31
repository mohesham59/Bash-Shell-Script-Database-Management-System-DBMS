# **Bash Shell Script Database Management System (DBMS)**  

## 📌 **Project Overview**  
This project is a simple yet powerful **Database Management System (DBMS)** implemented using **Bash Shell Scripting**. It allows users to create, manage, and interact with databases stored on disk through a **command-line interface (CLI)**. The system organizes **databases as directories** and **tables as files** (`CSV`, `JSON`, or `XML`).  

---

## ⚡ **Features**  

### **📂 Main Menu**  
1. **Create Database** – Creates a new database (stored as a directory).  
2. **List Databases** – Displays all available databases.  
3. **Connect to Database** – Allows users to select and interact with a database.  
4. **Drop Database** – Deletes an existing database.  
5. **Rename Database** – Renames an existing database.  

### **📋 Database Menu (After Connecting to a Database)**  
1. **Create Table** – Defines a new table with column metadata and data storage.  
2. **List Tables** – Shows all tables in the selected database.  
3. **Drop Table** – Deletes a table.  
4. **Insert into Table** – Adds new records to a table.  
5. **Select From Table** – Displays stored records in a structured format.  
6. **Delete From Table** – Removes specific records using the primary key.  
7. **Update Row** – Modifies existing records while maintaining data integrity.  

---

## 🛠 **Implementation Details**  

- **Database Structure**:  
  - Databases are represented as **directories**.  
  - Tables are stored as **files** (`CSV`, `JSON`, `XML`).  
  - Each **database has its own directory**, and each **table is a separate file**.  

- **Table Metadata**:  
  - When a table is created, metadata is stored to define:  
    - **Table name**  
    - **Number of columns**  
    - **Column names and data types**  
  - Metadata is stored separately in a `_metadata` file.  

- **Data Handling**:  
  - The **first column** is always the **Primary Key**, ensuring unique records.  
  - Data is validated based on column **data types** (`int` or `str`).  
  - **Primary keys cannot be duplicated** to maintain database integrity.  

- **Query Execution**:  
  - User input is processed through **menu-driven operations**.  
  - Queries like **INSERT, SELECT, DELETE, and UPDATE** modify the stored data.  

---

## 📌 **Requirements**  

✅ **Operating System**: Linux-based (Tested on CentOS 9)  
✅ **Shell**: Bash  
✅ **Required Utilities**:  
   - `awk`, `sed`, `grep` (for text processing)  
   - `dialog` (optional, for an enhanced CLI menu interface)  

---

## 🚀 **Installation and Setup**  

### **1️⃣ Clone the Repository**  
```bash
git clone https://github.com/mohesham59/Bash-Shell-Script-Database-Management-System-DBMS.git
cd Bash-Shell-Script-Database-Management-System-DBMS
```

### **2️⃣ Make the Scripts Executable**  
```bash
chmod +x *.sh
```

### **3️⃣ Run the Main Script**  
```bash
./main_Database.sh
```

📌 The script will display a menu where you can create databases, manage tables, and insert/select data.

---

## 🔥 **Usage Examples**  

### **📌 Creating a Database**  
```bash
Main Menu:
1. Create Database
2. List Databases
3. Connect to Database
4. Drop Database
5. Rename Database
Enter your choice: 1

Enter database name: students_db
Database 'students_db' created successfully.
```

### **📌 Creating a Table**  
```bash
Database: students_db
1. Create Table
2. List Tables
3. Drop Table
4. Insert into Table
5. Select From Table
6. Delete From Table
7. Update Row
Enter your choice: 1

Enter table name: students
Enter number of columns: 3
Enter column 1 name: id
Enter column 1 data type (int/str): int
Enter column 2 name: name
Enter column 2 data type (int/str): str
Enter column 3 name: age
Enter column 3 data type (int/str): int
Table 'students' created successfully.
```

### **📌 Inserting Data into a Table**  
```bash
Database: students_db > students table
1. Insert into Table
2. Select From Table
3. Delete From Table
4. Update Row
Enter your choice: 1

Enter id: 2020
Enter name: Ali
Enter age: 23
Record inserted successfully.
```

### **📌 Selecting Data**  
```bash
Database: students_db > students table
1. Insert into Table
2. Select From Table
3. Delete From Table
4. Update Row
Enter your choice: 2

-----------------------
| id   | name  | age  |
-----------------------
| 2020 | Ali   | 23   |
-----------------------
```

### **📌 Updating Data**  
```bash
Enter the primary key (id) of the record to update: 2020
Enter column to update: age
Enter new value: 20
Record updated successfully.
```

### **📌 Deleting a Record**  
```bash
Enter the primary key (id) of the record to delete: 2020
Record deleted successfully.
```
