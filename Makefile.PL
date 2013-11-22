
use strict;
use warnings;



use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "List objects, kitchen sink included",
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
    "Class::Method::Modifiers" => 0,
    "Exporter" => 0,
    "List::MoreUtils" => "0.33",
    "List::Util" => "1.18",
    "List::UtilsBy" => "0.09",
    "Module::Runtime" => "0.013",
    "Role::Tiny" => "1.003",
    "Scalar::Util" => 0,
    "Type::Tie" => "0.004",
    "autobox" => 0,
    "overload" => 0,
    "parent" => 0,
    "strictures" => 1
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.88"
  },
  "VERSION" => "2.002002",
  "test" => {
    "TESTS" => "t/*.t t/00_load/*.t t/01_array/*.t t/02_hash/*.t t/03_junctions/*.t t/04_immutable/*.t t/05_typed/*.t t/06_immutable_typed/*.t t/07_json/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Class::Method::Modifiers" => 0,
  "Exporter" => 0,
  "List::MoreUtils" => "0.33",
  "List::Util" => "1.18",
  "List::UtilsBy" => "0.09",
  "Module::Runtime" => "0.013",
  "Role::Tiny" => "1.003",
  "Scalar::Util" => 0,
  "Test::More" => "0.88",
  "Type::Tie" => "0.004",
  "autobox" => 0,
  "overload" => 0,
  "parent" => 0,
  "strictures" => 1
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



