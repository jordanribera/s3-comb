import boto3
#from boto3.session import session

session = boto3.session.Session(aws_access_key_id='AKIAITENMIYRT6XQBQJA', aws_secret_access_key='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', region_name='us-west-2')

print("#### displaying buckets ####")

s3 = session.resource('s3');
for bucket in s3.buckets.all():
	print(bucket.name);

print('')
print('#### displaying contents ####')

bucket = s3.Bucket('s3-comb-test')
for object in bucket.objects.all():
	the_object = s3.Object('s3-comb-test', object.key)
	print(the_object)
