#!/usr/bin/perl
# -*- perl -*-

#
# $Id: test.pl,v 1.2 2002/08/14 11:26:36 eserte Exp $
# Author: Slaven Rezic
#

use strict;

BEGIN {
    if (!eval q{
	use Test;
	1;
    }) {
	print "# tests only work with installed Test module\n";
	print "1..1\n";
	print "ok 1\n";
	exit;
    }
}

BEGIN { plan tests => 1 }

use future qw(encoding warnings);

use encoding 'iso-8859-1';
use warnings 'all';

ok(1);

my $warn = "";
$SIG{__WARN__} = sub { $warn = join("", @_) };

my $x;
my $y = $x + 1;

if ($] >= 5.006) {
    ok($warn =~ /Use of uninitialized value in addition/);
} else {
    ok($warn, "");
}

__END__
