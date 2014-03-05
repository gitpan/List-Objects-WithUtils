
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.06

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/List/Objects/WithUtils.pm',
    'lib/List/Objects/WithUtils/Array.pm',
    'lib/List/Objects/WithUtils/Array/Immutable.pm',
    'lib/List/Objects/WithUtils/Array/Immutable/Typed.pm',
    'lib/List/Objects/WithUtils/Array/Junction.pm',
    'lib/List/Objects/WithUtils/Array/Typed.pm',
    'lib/List/Objects/WithUtils/Autobox.pm',
    'lib/List/Objects/WithUtils/Hash.pm',
    'lib/List/Objects/WithUtils/Hash/Immutable.pm',
    'lib/List/Objects/WithUtils/Hash/Immutable/Typed.pm',
    'lib/List/Objects/WithUtils/Hash/Inflated.pm',
    'lib/List/Objects/WithUtils/Hash/Inflated/RW.pm',
    'lib/List/Objects/WithUtils/Hash/Typed.pm',
    'lib/List/Objects/WithUtils/Role/Array.pm',
    'lib/List/Objects/WithUtils/Role/Array/Immutable.pm',
    'lib/List/Objects/WithUtils/Role/Array/TiedRO.pm',
    'lib/List/Objects/WithUtils/Role/Array/Typed.pm',
    'lib/List/Objects/WithUtils/Role/Array/WithJunctions.pm',
    'lib/List/Objects/WithUtils/Role/Hash.pm',
    'lib/List/Objects/WithUtils/Role/Hash/Immutable.pm',
    'lib/List/Objects/WithUtils/Role/Hash/TiedRO.pm',
    'lib/List/Objects/WithUtils/Role/Hash/Typed.pm',
    'lib/Lowu.pm'
);

notabs_ok($_) foreach @files;
done_testing;
