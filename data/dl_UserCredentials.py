import pyodbc 
import json
from db_connection import *

def SelUserCredentials( userId ):	
	# Declare local variables
	results = []
	
	cursor.execute('{CALL Sel_User_Credentials(?)}', userId)
	
	# Get column names and corresponding field values
	fieldCount = len(cursor.description) - 1
	fieldNames = [i[0] for i in cursor.description]
	rowValues = cursor.fetchall()
	
	# Format returned data into a dictionary library
	for i in range(0, fieldCount):
		d = dict()
		d[fieldNames[i]] = rowValues[0][i]
		results.append(d)
	
	'''
		Output results for testing purposes
	'''
	for result in results:
		print result
		
SelUserCredentials(0)