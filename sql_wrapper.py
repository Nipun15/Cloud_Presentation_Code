import sqlite3
import csv
import itertools

#Open connect to db
conn = sqlite3.connect(':memory:')
curs = conn.cursor()

#Drop table if already exists
curs.execute("DROP TABLE IF EXISTS cfpb")

#Create table in db
curs.execute("CREATE TABLE cfpb (ComplaintID INTEGER, product TEXT, state TEXT)")

#Read in the CFPB file and load to the database
with open ('/home/ec2-user/cfpb/cfpb_consumer_complaints.csv') as f:
     lines = itertools.islice(f,1,None)
     reader = csv.reader(lines)
     for row in reader:
         to_db = [row[0], row[1], row[5]]
         curs.execute("INSERT INTO cfpb VALUES (?,?,?)", to_db)

#Commit the changes
conn.commit()

#Write SQL analysis code here and print output
curs.execute("SELECT product, count(*) FROM cfpb GROUP BY product")


#print the output
r = curs.fetchall()
print ('Complaints By Product')
print ('------------------------------')
for row in r:
    print ('\t%s = %s' % (row[0], row[1]))

#Close the connection
conn.close()
