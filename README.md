# s3-comb
This script will iterate through each top-level folder of a specified S3 bucket, deleting a file located at a specified relative path within each.

Only files which match the specific relative path within each folder will be deleted.


### Requirements
This script requires perl to run.


### Usage
This script is executed using `perl comb.pl`. It does not require or use any parameters, All necessary parameters are aquired through user prompts.

The script will show a confirmation prompt before executing deletion.

### Testing
This repository includes a premade folder/file structure for testing. In order to test using this structure, upload the *contents* (d01, d02, d03 etc. should be at the top level of the bucket) of `test_structure/` to an empty S3 bucket and follow the steps below:

1. Run the script: `perl comb.pl`
2. Follow the prompts for `aws configure`:
   * Enter AWS Access Key ID
   * Enter AWS Secret Access Key
   * Enter default region name
   * Enter output format (json)
3. Enter the name of the target S3 bucket
4. Enter the target relative path (e.g. `subfolder/deleteme.txt`)
5. Review the warning about the requested operation, and type `delete` to proceed.
6. Check the test structure in your S3 bucket. Only the specific files matching the relative path should be deleted.

The output should look like this:
```
AWS Access Key ID [********************]: 
AWS Secret Access Key [********************]: 
Default region name [us-west-2]: 
Default output format [json]: 
Enter the target bucket (e.g. sysnetsites.com): your-bucket-name
Enter the target subpath (e.g. subfolder/deleteme.txt): subfolder/deleteme.txt

proceeding will delete "subfolder/deleteme.txt" in 11 folders. 
type "delete" to proceed: delete

deleting "subfolder/deleteme.txt" inside of "d01"
deleting "subfolder/deleteme.txt" inside of "d02"
deleting "subfolder/deleteme.txt" inside of "d03"
deleting "subfolder/deleteme.txt" inside of "d04"
deleting "subfolder/deleteme.txt" inside of "d05"
deleting "subfolder/deleteme.txt" inside of "d06"
deleting "subfolder/deleteme.txt" inside of "d07"
deleting "subfolder/deleteme.txt" inside of "d08"
deleting "subfolder/deleteme.txt" inside of "d09"
deleting "subfolder/deleteme.txt" inside of "d10"

deletion completed. deleted 10 files.
```

