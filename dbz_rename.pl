use strict;


my @files = <*>;
foreach my $file (@files)
{
	if ($file =~ /Dragon Ball (\d+) - Page (\d+)/)
	{
		my $chapter = $1;
		my $page = $2;
		
		if ($chapter < 10)
		{
			$chapter = "00".$chapter;
		}
		elsif ($chapter < 100)
		{
			$chapter = "0".$chapter;
		}
		
		if ($page < 10)
		{
			$page = "0".$page;
		}
		
		#print "Need to rename \"$file\" to \"Dragon Ball $chapter - Page $page\"\n";
		rename $file, 'Dragon Ball '.$chapter.' - Page '.$page.'.jpg';
	}
}