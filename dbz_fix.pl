use strict;

my @chaptersToFix = (
	229
);

my @files = <./DBZrawjpgs/*>;

foreach my $chapterToFix (@chaptersToFix)
{
	print "Chapter to fix: $chapterToFix\n";
	if ($chapterToFix < 10) { $chapterToFix = "00".$chapterToFix; }
	elsif ($chapterToFix < 1) { $chapterToFix = "0".$chapterToFix; }
	
	my %filelist;
	my $count = 1;
	print "Getting the list of files";
	foreach my $file (@files)
	{
		if ($file =~ /Dragon Ball $chapterToFix/)
		{
			$file =~ s/(\.\/DBZrawjpgs\/)(.*)(\.jpg)/$2/g;
			$filelist{$count} = $file;
			$count++;
		}
	}
	print "Total number of pages: $count\n";
	my $toAdd = $count - 9;
	my $i;
	for (my $i = 2; $i <= $toAdd + 1; $i++)
	{
		my $page = $filelist{$i};
	}
}