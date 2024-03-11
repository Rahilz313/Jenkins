import boto3
import csv
import io

def lambda_handler(event, context):
    # bucket and object key
    bucket_name = 'jenkins-bucket-with-terraform'
    object_key = 'month.csv'

    # Create an S3 client
    s3 = boto3.client('s3')

    try:
        # Get the object from S3
        response = s3.get_object(Bucket=bucket_name, Key=object_key)
        # Read the CSV content from the S3 object
        csv_content = response['Body'].read().decode("utf-8")
        
        # Parse the CSV content
        csv_reader = csv.reader(io.StringIO(csv_content))
        
        # Process each row in the CSV
        for row in csv_reader:
            # Do something with each row
            print(row)

        return {
            'statusCode': 200,
            'body': 'CSV data read successfully.'
        }

    except Exception as e:
        print("Error reading CSV from S3:", e)
        return {
            'statusCode': 500,
            'body': 'Error reading CSV from S3.'
        }
