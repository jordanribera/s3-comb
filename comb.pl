#!/usr/bin/perl
use strict;
use warnings;
sub prompt {
    my ($query) = @_; # take a prompt string as argument
    local $| = 1; # activate autoflush to immediately show the prompt
    print $query;
    chomp(my $answer = <STDIN>);
    return $answer;
}

##########

# Setup AWS CLI
system("aws configure");

# Get buckets
my$target_bucket=prompt"Enter the target bucket (e.g. sysnetsites.com: ";
my$target_filename=prompt"Enter the target filename (e.g. sysnetsites.com-new: ";

# delete all matching files from the target bucket.
system("aws s3 rm --recursive s3://$target_bucket/ --exclude \"*\" --include \"*/$target_filename\"");

exit 0;