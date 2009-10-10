
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'AnyEvent-Mojo',
  NAME      => 'AnyEvent::Mojo',
  AUTHOR    => "Pedro\ Melo\ \<melo\@cpan\.org\>",
  ABSTRACT  => "Start\ async\ Mojo\ servers\ easly",
  VERSION   => '0.8002',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Mojo" => '0.991251',
    "AnyEvent" => '5.201',
    "parent" => '0',
    "Test::Exception" => '0',
    "Pod::Man" => '2.22',
    "AnyEvent::HTTP" => '1.43',
    "Carp" => '0',
    "Test::More" => '0.92',
    "IO::Socket" => '0',
    "AnyEvent::Socket" => '0',
    "AnyEvent::Handle" => '0',
    "Test::Deep" => '0',
  },
  test => {TESTS => 't/*.t'}
);

