#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: Makefile.PL,v 1.2 2002/08/14 11:26:28 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2002 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven.rezic@berlin.de
# WWW:  http://www.rezic.de/eserte/
#

use ExtUtils::MakeMaker;

WriteMakefile
  (
   'NAME'	   => 'future',
   'VERSION'       => '0.02',
#   'EXE_FILES'     => [],
#   'PMLIBDIRS'     => [],
#   'PREREQ_PM'     => { },

   'dist' => {'POSTOP'=>'-$(CHMOD) 644 $(DISTVNAME).tar$(SUFFIX)'},

   'ABSTRACT_FROM' => '',
   'AUTHOR'        => 'Slaven Rezic (slaven.rezic@berlin.de)',
  );

__END__
