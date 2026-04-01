import re
from typing import Dict, List, Tuple, Set

def select(table, conditionFunction):
    return [row for row in table if conditionFunction(row)]

def project(table, attributes):
    columns = []
    for item in table:
        columns.append(item[attributes])
    return columns

def rowsFiltered(table, tableName):
    selectTable = tableName

    if selectTable == "students":
        rowSelect = input("Please enter which row you wish to filter (Name or Age) ").lower()

        if rowSelect == "age":
            conditFunc = input("Please enter an operator (>, <, =, etc) ")
            ageNumb = int(input("Please enter what age you wish to filter out "))
            if conditFunc == '>':
                result = select(table, lambda row: row['age'] > (ageNumb))
            elif conditFunc == '<':
                result = select(table, lambda row: row['age'] < (ageNumb))
            else:
                result = select(table, lambda row: row['age'] == (ageNumb))
        else:
            nameIn = input("Please enter a name ")
            result = [row for row in table if row['name'] == nameIn]

    if selectTable == "degreeEval":
        rowSelect = input("Please enter which row you wish to filter (Degree or GPA) ").lower()

        if rowSelect == "gpa":
            conditFunc = input("Please enter an operator (>, <, =, etc) ")
            gpaNumn = float(input("Please enter what GPA you wish to filter out "))
            if conditFunc == '>':
                result = select(table, lambda row: row['gpa'] > (gpaNumn))
            elif conditFunc == '<':
                result = select(table, lambda row: row['gpa'] < (gpaNumn))
            else:
                result = select(table, lambda row: row['gpa'] == (gpaNumn))
        else:
            notRight = True
            while notRight == True:
                nameIn = input("Please enter a Degree (English, Mathematics, Computer Science, Biology) ").lower()
                if (nameIn != "english" and nameIn != "mathematics" and nameIn != "computer science" and nameIn !=
                        "biology"):
                    print("Please input one of the four available degrees")
                else:
                    result = [row for row in table if row['degree'].lower() == nameIn]
                    notRight = False

    print(result)

def main():

    students = [
        {'sid': 1, 'name': 'Sidney', 'age': 29},
        {'sid': 2, 'name': 'Mathew', 'age': 30},
        {'sid': 3, 'name': 'Rachael', 'age': 23},
        {'sid': 4, 'name': 'Cornell', 'age': 23},
        {'sid': 5, 'name': 'Antonia', 'age': 21},
        {'sid': 6, 'name': 'Antoinette', 'age': 19},
        {'sid': 7, 'name': 'Mathew', 'age': 24},
        {'sid': 8, 'name': 'Sergio', 'age': 24},
        {'sid': 9, 'name': 'Ina', 'age': 24},
        {'sid': 10, 'name': 'Christian', 'age':21},
        {'sid': 11, 'name': 'Ana', 'age': 22},
        {'sid': 12, 'name': 'Amanda', 'age': 22},
        {'sid': 13, 'name': 'Gerard', 'age': 22},
        {'sid': 14, 'name': 'Polly', 'age': 21},
        {'sid': 15, 'name': 'Darrel', 'age': 21},
        {'sid': 16, 'name': 'Viola', 'age': 23},
        {'sid': 17, 'name': 'Janis', 'age': 19},
        {'sid': 18, 'name': 'Paris', 'age': 20},
        {'sid': 19, 'name': 'Edna', 'age': 20},
        {'sid': 20, 'name': 'Coleen', 'age': 20}
    ]
    degreeEval = [
        {'sid': 1, 'degree': 'English', 'gpa': 3.83},
        {'sid': 2, 'degree': 'Computer Science', 'gpa': 2.54},
        {'sid': 3, 'degree': 'Biology', 'gpa': 1.72},
        {'sid': 4, 'degree': 'Biology', 'gpa': 3.01},
        {'sid': 5, 'degree': 'Mathematics', 'gpa': 2.87},
        {'sid': 6, 'degree': 'English', 'gpa': 3.10},
        {'sid': 7, 'degree': 'Computer Science', 'gpa': 3.50},
        {'sid': 8, 'degree': 'Biology', 'gpa': 2.38},
        {'sid': 9, 'degree': 'English', 'gpa': 1.90},
        {'sid': 10, 'degree': 'English', 'gpa': 3.00},
        {'sid': 11, 'degree': 'Computer Science', 'gpa': 2.00},
        {'sid': 12, 'degree': 'Mathematics', 'gpa': 2.99},
        {'sid': 13, 'degree': 'Mathematics', 'gpa': 3.47},
        {'sid': 14, 'degree': 'Mathematics', 'gpa': 2.68},
        {'sid': 15, 'degree': 'English', 'gpa': 2.50},
        {'sid': 16, 'degree': 'Computer Science', 'gpa': 3.10},
        {'sid': 17, 'degree': 'Biology', 'gpa': 3.05},
        {'sid': 18, 'degree': 'Computer Science', 'gpa': 3.00},
        {'sid': 19, 'degree': 'Biology', 'gpa': 3.78},
        {'sid': 20, 'degree': 'Mathematics', 'gpa': 2.87}
    ]
    selectTask = input("Please Select if you wish to project or select ").lower()


    selectTable = input("Please select which table you wish to filter (Students or Degree Evaluation) ").lower()
    if selectTable != "students" and selectTable != "degreeEval":
        selectTable = "degreeEval"

    if selectTask == "select" or selectTask == "selects":
        if selectTable == "students":
            rowsFiltered(students, selectTable)
        else:
            rowsFiltered(degreeEval, selectTable)

    else:
        if selectTable == "students" or selectTable == "student":
            attribute = input("Please type either age or name or all ")
            if attribute != "all":
                print(project(students, attribute))
            else:
                print([row for row in students])
        else:
            attribute = input("Please type either degree or gpa or all ")
            if attribute != "all":
                print(project(degreeEval, attribute))
            else:
                print([row for row in degreeEval])



if __name__ == "__main__":
    main()
