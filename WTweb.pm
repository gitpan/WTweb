package WTweb;

# WAYCALL TOOL web
# 20043112
# Gm Gamboni
#
# 0
# 0.test

use strict;

sub new{
	my $self = shift;
	my $class = ref($self) || $self;

 	my %VARS = ();	
	
	my $this = {}; 
	
	$this->{DEBUG} = 0; # 0 debug off != 0 debug on 
	$this->{HTMLDIR};
	$this->{HYPER_PTR};
	$this->{F_POS};	



	bless $this, $class;
	return $this;
}


sub processhtml{
	my $this   = shift;
	my %params = @_;
	
 	my $fname = $params{'FileName'};
	my $prhdr = $params{'Header'};
	if($fname){
		delete ($params{'FileName'});	
		}else{
			die "No filename Given\n";
	}
	if($prhdr){
		print "Content-Type: text/html\n\n";
		delete($params{'Header'});
	}
	$this->{F_POS} = $this->fileseek($fname);
	my $alen = $this->{HYPER_PTR};
	my $acpy = @$alen[$this->{F_POS}];
	my $ac;
	my @ary;
	foreach my $lc(@$acpy){ push(@ary, $lc)};
	shift(@ary);
	foreach $ac(@ary){
		while((my $key, my $value) = each(%params)){
			$ac =~ s/$key/$value/g;
		}
		print $ac;
	}
}

sub fileseek{
  	my $this = shift;		
	my $fts  = shift;	
	my $cnt = 0;
	my $alen = $this->{HYPER_PTR};
	foreach my $ar(@$alen){
		return $cnt if(@$ar[0] =~ /$fts/);
		$cnt++
	}		
	return -1;
}

sub sethtmldir{
	my $this= shift;
	my $dir = shift;
	
	# Debug - expression validate input
		
	$this->{HTMLDIR} = $dir;
	return 1;
}

sub fileload{
	my $this = shift;
	my @filenames = @_;
	return -1 unless @filenames;
	my($cnt,@HYPER);
	foreach my $file(@filenames){
		open(FH, "<$this->{HTMLDIR}/$file")or return 0;
		my @lines = <FH>;
		close FH;
		unshift(@lines, $file);
		@HYPER[$cnt] = \@lines,
		$cnt++; 
	}
	$this->{HYPER_PTR}= \@HYPER;
	return 1;
}

sub prv_parse{
	my @line = @_;
	print "INIT--------------------\n";	
	foreach my $l(@line){
		print "$l";
		if($l =~ /(_\w+_)/){
			print "Var: $1\n";
		}
	}
	print "END--------------------\n";
}



1;
__END__
