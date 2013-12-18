package List::Objects::WithUtils::Role::Hash::TiedRO;
{
  $List::Objects::WithUtils::Role::Hash::TiedRO::VERSION = '2.004002';
}
use strictures 1;
use Carp ();

use Role::Tiny;

around $_ => sub {
  Carp::croak "Attempted to modify a read-only value"
} for qw/
  STORE
  DELETE
  CLEAR
/;

1;
