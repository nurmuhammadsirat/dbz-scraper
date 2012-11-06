use strict;

use LWP::UserAgent;

##############################################
my $startPage = 'http://www.mangareader.net/105-2100-1/dragon-ball/chapter-1.html';
##############################################

my $basePage  = 'http://www.mangareader.net';
my $endPage   = 'http://www.mangareader.net/dragon-ball/521';


my $currentPage = $startPage;

while ( $currentPage ne $endPage ) {
	my $ua = LWP::UserAgent->new;
	$ua->agent('Mozilla/5.0');
	my $resp = $ua->get($currentPage);

	if ( $resp->is_success ) {
		my $content = $resp->content;
		#print $content;
		if ($content =~ /<div id="imgholder">(.*)<a href="(.*)"><img id="img" width="(\d+)" height="(\d+)" src="(http:\/\/.*\.jpg)" alt="(Dragon Ball (\d+) - Page (\d+))" name="img" \/><\/a> <\/div>/)
		{
			my $linkedPage = $basePage.$2;
			my $image = $5;
			my $imageNewName = $6.".jpg";
			
			my $imageSourceName = $image;
			$imageSourceName =~ s/http:\/\/(.*)\.mangareader\.net\/dragon-ball\/(\d+)\/(dragon-ball-(\d+).jpg)/$3/g;
			
			print 'Comic src : '.$image."\n";
			print 'Source jpg: '.$imageSourceName."\n";
			print 'Comic page: '.$imageNewName."\n";
			print 'Next page : '.$linkedPage."\n\n";
			
			system('C:\Cygwin\bin\wget '.$image);
			rename $imageSourceName, $imageNewName;
			sleep 2;
			
			$currentPage = $linkedPage;
		}
	}
	else {
		if ($resp->status_line =~ /504/)
		{
			print 'Got a '.$resp->status_line.".\n";
			print 'Current URL: '.$currentPage.".\n";
			print "Waiting for 10 seconds before retrying...\n";
			my $i;
			for ($i = 10; $i > 0; $i-- )
			{
				print "$i...";
				sleep 1;
			}
			print "\n\n";
		}
#		elsif ($resp->status_line =~ /500/)
#		{
#			print 'Got a '.$resp->status_line.".\n";
#			print 'Current URL: '.$currentPage.".\n";
#			print "Waiting for 30 seconds before retrying...\n";
#			sleep 10;
#			print "Waiting for 20 seconds before retrying...\n";
#			sleep 10;
#			my $i;
#			for ($i = 10; $i > 0; $i-- )
#			{
#				print "$i...";
#				sleep 1;
#			}
#			print "\n\n";
#		}
		else
		{
			die 'Died while getting '.$currentPage.'. HTTP Response: '.$resp->status_line;
		}
	}
}
