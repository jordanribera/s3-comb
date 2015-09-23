# s3-comb
This script will iterate through each top-level folder of a specified S3 bucket, deleting a file located at a specified relative path within each.

Only files which match the specific relative path within each folder will be deleted.


### Requirements
This script requires perl to run.


### Usage
This script is executed using `perl comb.pl`. It does not require or use any parameters, All necessary parameters are aquired through user prompts.

The script will show a confirmation prompt before executing deletion.

### Testing
This repository includes a premade folder/file structure for testing. In order to test using this structure, upload the *contents* of `test_structure/` to an empty S3 bucket and follow the steps below:

