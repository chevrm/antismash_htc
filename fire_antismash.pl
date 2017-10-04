#!/usr/bin/perl

use strict;
use warnings;

my $fna = shift;
my @p = split(/\//, $fna);
my $pref = $p[-1];
$pref =~ s/\.fna$/_as/;
my $logfile = $pref.'.log';
my $as_cmd = "antismash --outputfolder $pref $fna";
system("echo 'CMD: $as_cmd' >> $logfile");
system("$as_cmd >> $logfile 2>&1");
my $tgz_cmd = "tar zcf $pref.tgz $pref $logfile";
system("echo 'CMD: $tgz_cmd' >> $logfile");
system("$tgz_cmd");
