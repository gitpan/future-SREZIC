# -*- perl -*-

#
# $Id: future.pm,v 1.2 2002/08/14 11:18:54 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2002 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven.rezic@berlin.de
# WWW:  http://www.rezic.de/eserte/
#

package future;

# The perl version of the first occurance of the module. These list
# may be inaccurate, i.e. I did not look into pre-5.004 versions and
# did not distinguish between patchlevels.
%pragmas = (
	    'attributes'  => 5.006,
	    'attrs'       => 5.005,
	    'autouse'     => 5.004,
	    'base'        => 5.004,
	    'bigint'      => 5.008,
	    'bignum'      => 5.008,
	    'bigrat'      => 5.008,
	    'blib'        => 5.004,
	    'bytes'       => 5.006,
	    'charnames'   => 5.006,
	    'constant'    => 5.004,
	    'diagnostics' => 5.004,
	    'encoding'    => 5.008,
	    'fields'      => 5.005,
	    'filetest'    => 5.006,
	    'if'          => 5.008,
	    'integer'     => 5.004,
	    'less'        => 5.004,
	    'lib'         => 5.004,
	    'locale'      => 5.004,
	    'open'        => 5.006,
	    'ops'         => 5.004,
	    'overload'    => 5.004,
	    're'          => 5.005,
	    'sigtrap'     => 5.005,
	    'sort'        => 5.008,
	    'strict'      => 5.004,
	    'subs'        => 5.004,
	    'threads'     => 5.008,
	    'utf8'        => 5.006,
	    'vars'        => 5.004,
	    'vmsish'      => 5.004,
	    'warnings'    => 5.006,
	   );

sub import {
    shift;
    foreach my $pragma (@_) {
	if ($pragma eq ':all') {
	    pseudo_define($_) for keys %pragmas;
	} elsif (exists $pragmas{$pragma}) {
	    pseudo_define($pragma);
	} else {
	    warn "future does not handle pragma $pragma";
	}
    }
}

sub pseudo_define {
    my($pragma) = @_;
    my $perl_version = $pragmas{$pragma};
    if ($] < $perl_version) {
	$INC{$pragma.".pm"} = 1;
	if (!defined(&{"${pragma}::unimport"})) {
	    *{"${pragma}::import"} = sub {};
	    *{"${pragma}::unimport"} = sub {};
	}
    }
}

1;

__END__

=head1 NAME

future - make pragmas optional

=head1 SYNOPSIS

    # require all users to have future.pm installed
    use future qw(encoding sort);
    use encoding 'iso-8859-1';
    use sort '_qsort';

    # require only users of old perl versions to have future.pm installed
    BEGIN { eval 'use future qw(warnings)' }
    use warnings "all";

=head1 DESCRIPTION

This module is for authors which would like to use "modern" pragmas in
their modules and scripts, but also want to remain backward-compatible
to older versions of perl without these pragmas. Suppose you want to
"use warnings":

    use warnings;
    # your script

This will croak on perl 5.005_03 and older, because there is no
C<warnings.pm> for these versions. Now you could try some tricks like:

    BEGIN { eval 'use warnings' }

but this will not work, because pragmas are often lexically scoped, so
the warnings pragma would be only valid in the BEGIN block (or even in
the eval block, I have not checked).

With C<future.pm> you can either write:

    use future qw(warnings);
    use warnings 'whatever';

which would enable the warnings pragma for perl 5.6.0 and newer and
make the pragma an no-op for older perls. If you do not want your
users to install the C<future.pm> module (after all it is a
non-standard module), then you can write:

    BEGIN { eval 'use future qw(warnings)' }
    use warnings "whatever";

Note that the new pragma C<if> cannot do this --- if you think it can,
then tell me and I retract this module C<:-)>

=head1 AUTHOR

Slaven Rezic <slaven.rezic@berlin.de>

=head1 COPYRIGHT

Copyright (c) 2002 Slaven Rezic. All rights reserved.
This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

perlmodlib(1), if(3).

=cut
