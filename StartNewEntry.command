#!/usr/bin/env python3

import os
import sys
import datetime

# Get date from input
def get_date_from_input():
    date_raw = str(input("Enter date in ISO8601 format: "))
    if date_raw.lower() == "today":
        return datetime.datetime.now().strftime("%Y%m%d")

    date = unicode(str(date_raw), "utf-8")
    return date

def date_is_valid(date):
    return len(date) == 8 and date.isnumeric()   

date = get_date_from_input()
while not date_is_valid(date):
    print("Invalid date. Please try again.")
    date = get_date_from_input()

# Attempt to create journal entry
def get_year_from_date(date):
    return date[0:4]

def get_folder_path_for_year(year):
    current_folder = "/".join(__file__.split("/")[:-1])
    return os.path.join(current_folder, year)

def get_file_path_for_entry(folder_path_year, date):
    return os.path.join(folder_path_year, date) + ".txt"

def folder_exists(path):
    return os.path.isdir(path)

def file_exists(file_path):
    return os.path.exists(file_path)

folder_name = get_year_from_date(date)
folder_path_year = get_folder_path_for_year(folder_name)
file_path = get_file_path_for_entry(folder_path_year, date)

print("\nPROGRAM ACTIONS:")
print("----------------\n")
if not folder_exists(folder_path_year):
    os.mkdir(folder_path_year)
    print("Created directory: " + folder_path_year)

if file_exists(file_path):
    print("File already exists at: " + file_path)
else:
    f = open(file_path, "w")
    f.write("Entry for " + date)
    print("Created file: " + file_path)

print("\n")
