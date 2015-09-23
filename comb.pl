#!/usr/bin/perl
use strict;
use warnings;
use JSON;

use Data::Dumper;

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
my$target_bucket=prompt"Enter the target bucket (e.g. sysnetsites.com): ";
my$target_subpath=prompt"Enter the target subpath (e.g. subfolder/deleteme.txt): ";

#my $command = "aws s3 rm --recursive s3://$target_bucket/ --exclude \"*\" --include \"/*/$target_subpath\"";
#print $command;

# delete all matching files from the target bucket.
# system("aws s3 rm --recursive s3://$target_bucket/ --exclude \"*\" --include \"/*/$target_subpath\"");

my $objects = `aws s3api list-objects --bucket \"$target_bucket\"`;
$objects = JSON->new->utf8->decode($objects)->{'Contents'};
#print Dumper($objects);

my %top_folders;
foreach my $check_object (@$objects)
{

	my $fullkey = $check_object->{'Key'};
	my @splitted = split(/\//, $fullkey, 2);

	if(@splitted == 2)
	{

		if (exists($top_folders{$splitted[0]}))
		{

			#top folder already seen

		}
		else
		{

			$top_folders{$splitted[0]} = 1;

		}

	}

}

my @top_folders_set = keys %top_folders;

print "proceeding will delete \"" . $target_subpath . "\" in " . @top_folders_set . " folders. \n";
my $proceed_choice = prompt "type \"delete\" to proceed: ";

if ($proceed_choice eq "delete")
{

	my $actual_deletions = 0;

	foreach my $object (@$objects)
	{

		my $fullkey = $object->{'Key'};

		my @splitted = split(/\//, $fullkey, 2);
		if (@splitted == 2)
		{

			my $parent_folder = $splitted[0];
			my $sub_path = $splitted[1];

			#the object is in a folder, see if the first level path is equal to what we want
			if ($splitted[1] eq $target_subpath)
			{

				print "deleting \"" . $sub_path . "\" inside of \"" . $parent_folder . "\"\n";
				system("aws s3api delete-object --bucket \"$target_bucket\" --key \"$fullkey\"");
				$actual_deletions++;

			}

		}

	}

	print "deletion completed. deleted " . $actual_deletions . " files. \n";

}
else
{

	print "deletion aborted. \n";

}

exit 0;