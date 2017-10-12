#!/usr/bin/perl

use strict;
use warnings;

my $fna = shift;
my @p = split(/\//, $fna);
my $pref = $p[-1];
$pref =~ s/\.fna$/_as/;
my $logfile = $pref.'.log';
my $as_cmd = "antismash --outputfolder $pref $fna";
system("echo 'WHOAMI:' >> $logfile");
system("whoami >> $logfile 2>&1");
system("echo 'which antismash:' >> $logfile");
system("which antismash >> $logfile 2>&1");
system("echo 'antismash permissions:' >> $logfile");
system("ls -l /miniconda2/bin/antismash >> $logfile 2>&1");
system("echo 'CMD: $as_cmd' >> $logfile");
system("$as_cmd >> $logfile 2>&1");
my $tgz_cmd = "tar zcf $pref.tgz $pref $logfile";
system("echo 'CMD: $tgz_cmd' >> $logfile");
system("$tgz_cmd");
