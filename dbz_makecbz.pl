use strict;
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );

my $startChapter = 441;
my $endChapter = 520;

sub getChapter
{
	my $filesRef = shift;
	my $count = shift;
	
	my @files = @$filesRef;
	
	if ($count < 10) { $count = "00".$count; }
	elsif ($count < 100) { $count = "0".$count; }
	
	my @chapter;
	
	foreach my $file (@files)
	{
		my ( $prefix, $suffix ) = split (" - ", $file);
		if ($prefix eq "Dragon Ball $count")
		{
			push @chapter, $file;
		}
	}
	
	return @chapter;
}

sub makeCBZ
{
	my $chapterRef = shift;
	my $count = shift;
	my @chapter = @$chapterRef;
	
	if ($count < 10) { $count = "00".$count; }
	elsif ($count < 100) { $count = "0".$count; }
	
	my $cbz = Archive::Zip->new();
	foreach my $file (@chapter)
	{
		my $member = $cbz->addFile($file);
	}
	
	my $status = $cbz->writeToFileNamed( "..\\CBZ\\DragonBall$count.cbz" );
    die "error somewhere" if $status != AZ_OK;
}

# ------------------------------------- #

chdir ".\\DBZrawjpgs";
my @files = <*>;
my $i;

for ($i = $startChapter; $i <= $endChapter; $i++)
{
	print "Getting chapter $i.\n";
	my @chapter = getChapter(\@files, $i);
	print "Making CBZ.\n";
	makeCBZ(\@chapter, $i);
	print "Success!\n\n";
}