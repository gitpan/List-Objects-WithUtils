
use strict;
use warnings;

use 5.008009;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Object interfaces to lists with useful methods",
  "AUTHOR" => "Jon Portnoy <avenj\@cobaltirc.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "List-Objects-WithUtils",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "List::Objects::WithUtils",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "List::MoreUtils" => "0.33",
    "List::Util" => 0,
    "List::UtilsBy" => "0.09",
    "Module::Runtime" => "0.013",
    "Role::Tiny" => 1,
    "Scalar::Util" => 0,
    "Storable" => 0,
    "Syntax::Keyword::Junction" => "0.003003",
    "autobox" => 0,
    "strictures" => 1
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.88"
  },
  "VERSION" => "1.003000",
  "test" => {
    "TESTS" => "t/*.t t/t_autoboxed/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  my $tr = delete $WriteMakefileArgs{TEST_REQUIRES};
  my $br = $WriteMakefileArgs{BUILD_REQUIRES};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



