import boto
import boto.s3.connection

from boto.s3.connection import S3Connection
 
AWS_KEY = 'AKIAJZFN5EIBI33FUGVA'
AWS_SECRET = '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'

aws_connection = S3Connection(AWS_KEY, AWS_SECRET)
bucket = aws_connection.get_bucket('cfpbfile')

#for file_key in bucket.list():
#    print file_key.name

key = bucket.get_key('cfpb_consumer_complaints.csv')
key.get_contents_to_filename('/home/ec2-user/cfpb/cfpb_consumer_complaints.csv')
