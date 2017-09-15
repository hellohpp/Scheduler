import pyodbc 
from config import *

cnxn = pyodbc.connect(SQLCONNSTRING)
cursor = cnxn.cursor()