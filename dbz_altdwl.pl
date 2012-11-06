use strict;

my @urls = (
'http://i24.mangareader.net/dragon-ball/217/dragon-ball-1949795.jpg',
'http://i27.mangareader.net/dragon-ball/217/dragon-ball-1949797.jpg',
'http://i29.mangareader.net/dragon-ball/217/dragon-ball-1949799.jpg',
'http://i33.mangareader.net/dragon-ball/217/dragon-ball-1949801.jpg'
);

my %map = (
'http://i24.mangareader.net/dragon-ball/217/dragon-ball-1949795.jpg' => 'Dragon Ball 217 - Page 4.jpg',
'http://i27.mangareader.net/dragon-ball/217/dragon-ball-1949797.jpg' => 'Dragon Ball 217 - Page 5.jpg',
'http://i29.mangareader.net/dragon-ball/217/dragon-ball-1949799.jpg' => 'Dragon Ball 217 - Page 6.jpg',
'http://i33.mangareader.net/dragon-ball/217/dragon-ball-1949801.jpg' => 'Dragon Ball 217 - Page 7.jpg'
);

foreach my $url (@urls)
{
	my $imageSourceName = $url;
	$imageSourceName =~ s/http:\/\/(.*)\.mangareader\.net\/dragon-ball\/(\d+)\/(dragon-ball-(\d+).jpg)/$3/g;
			
	system('C:\Cygwin\bin\wget '.$url);
	rename $imageSourceName, $map{$url};
	sleep 2;
}
