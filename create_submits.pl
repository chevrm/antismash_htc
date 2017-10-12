#!/bin/env perl

use strict;
use warnings;
use Cwd 'abs_path';

my @spath = split(/\//, abs_path($0));
my $basedir = join('/', @spath[0..$#spath-1]);

foreach my $srcfna (@ARGV){
    my @p = split(/\//, $srcfna);
    my $f = $p[-1];
    $f =~ s/\.fna$//;

    my $logfile = $f.'_as.$(Cluster).log';
    my $outfile = $f.'_as.$(Cluster).out';
    my $errfile = $f.'_as.$(Cluster).err';
    my $cmd = './fire_antismash.pl';
    my $submit = join("\n",
		      '## antismash.sub',
		      '## img source = https://hub.docker.com/r/chevrm/antismash_htc',
		      'universe = docker',
		      'docker_image = chevrm/antismash_htc',
		      'requirements = (OpSysMajorVer == 7)',
		      'log = '.$logfile,
		      'error = '.$errfile,
		      'executable = '.$cmd,
		      'arguments = '.$p[-1],
		      'output = '.$outfile,
		      'should_transfer_files = YES',
		      'when_to_transfer_output = ON_EXIT',
		      'transfer_input_files = '.$srcfna,
		      'request_cpus = 1',
		      'request_memory = 3GB',
		      'request_disk = 30GB',
		      'queue 1'
	);
    my $subfile = $f.'_as.sub';
    open my $sfh, '>', $subfile or die $!;
    print $sfh $submit;
    close $sfh;
    system("condor_submit $subfile");
}
