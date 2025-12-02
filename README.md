# PlatinumRx Assignment – README

## 📌 Overview
This project demonstrates **SQL, Excel, and Python data analysis** skills required in the PlatinumRx Data Analyst assignment.  
All deliverables are structured into separate folders for clarity.

---

## 📁 Folder Structure



PlatinumRx_Submission_Complete/
│
├── SQL/
│ ├── 01_Hotel_Schema_Setup.sql
│ ├── 02_Hotel_Queries.sql
│ ├── 03_Clinic_Schema_Setup.sql
│ └── 04_Clinic_Queries.sql
│
├── Spreadsheets/
│ └── Ticket_Analysis.xlsx
│
├── Python/
│ ├── 01_Time_Converter.py
│ └── 02_Remove_Duplicates.py
│
└── README.md


---

## 🧪 SQL Instructions

### **1️⃣ Hotel System**
1. Run `01_Hotel_Schema_Setup.sql` to create the Hotel tables.  
2. Run `02_Hotel_Queries.sql` to execute the 5 Part-A queries.

### **2️⃣ Clinic System**
3. Run `03_Clinic_Schema_Setup.sql` to create the Clinic tables.  
4. Run `04_Clinic_Queries.sql` to execute Part-B queries.

✔️ Make sure **schema files are executed before queries**.

---

## 📊 Excel Instructions (Ticket_Analysis.xlsx)

Open the file `Ticket_Analysis.xlsx`.

### **Sheet: ticket**
Contains the log of all ticket activities.

### **Sheet: feedbacks**
Includes formulas for time & lookup analysis:

- `created_at_lookup` → Uses **VLOOKUP** to fetch timestamps.  
- `Same_Day` → Compares **date portion only**.  
- `Same_Hour` → Compares **hour portion** of timestamps.

---

## 🐍 Python Instructions

### **1️⃣ Time Converter**
File: `01_Time_Converter.py`

- **Input:** minutes (example: 130)  
- **Output:** `2 hrs 10 minutes`

### **2️⃣ Remove Duplicates Script**
File: `02_Remove_Duplicates.py`

- **Input:** any string  
- **Output:** removes repeating characters but **keeps original order**

Example:  
Input → `"aaabbbcccdd"`  
Output → `"abcd"`

---

## 📝 Notes
This README explains how to:
- Execute SQL scripts  
- Understand Excel formulas  
- Run Python scripts  
- Navigate the submission directory  

---

## 🔗 Submission Info
This assignment contains all required SQL, Excel, and Python artifacts as per PlatinumRx guidelines.

---

# ✅ End of README
