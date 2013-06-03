package List::Objects::WithUtils::Role::Hash;
{
  $List::Objects::WithUtils::Role::Hash::VERSION = '1.002001';
}
use strictures 1;

use Module::Runtime 'require_module';
use Scalar::Util 'blessed';

use Role::Tiny;

sub new {
  require_module( $_[0]->array_type );
  bless +{ @_[1 .. $#_] }, $_[0]
}

sub array_type { 'List::Objects::WithUtils::Array' }

sub clear { %{ $_[0] } = () }

sub copy {
  bless +{ %{ $_[0] } }, blessed($_[0])
}

sub defined { CORE::defined $_[0]->{ $_[1] } }
sub exists  { CORE::exists  $_[0]->{ $_[1] } }

sub is_empty { keys %{ $_[0] } ? 0 : 1 }

sub get {
  if (@_ > 2) {
    return $_[0]->array_type->new(
      @{ $_[0] }{@_}
    )
  }
  $_[0]->{ $_[1] }
}

sub sliced {
  blessed($_[0])->new(
    map {;
      exists $_[0]->{$_} ? 
        ( $_ => $_[0]->{$_} )
        : ()
    } @_[1 .. $#_]
  )
}

sub set {
  my $self = shift;
  my @keysidx = grep {; not $_ % 2 } 0 .. $#_ ;
  my @valsidx = grep {; $_ % 2 }     0 .. $#_ ;

  @{$self}{ @_[@keysidx] } = @_[@valsidx];

  $self->array_type->new(
    @{$self}{ @_[@keysidx] }
  )
}

sub delete {
  $_[0]->array_type->new(
    CORE::delete @{ $_[0] }{ @_[1 .. $#_] }
  )
}

sub keys {
  $_[0]->array_type->new(
    CORE::keys %{ $_[0] }
  )
}

sub values {
  $_[0]->array_type->new(
    CORE::values %{ $_[0] }
  )
}

sub kv {
  my ($self) = @_;
  $self->array_type->new(
    CORE::map {;
      [ $_, $self->{ $_ } ]
    } CORE::keys %$self
  )
}

sub export {
  my ($self) = @_;
  %$self
}


1;


=pod

=head1 NAME

List::Objects::WithUtils::Role::Hash - Hash manipulation methods

=head1 SYNOPSIS

  ## Via List::Objects::WithUtils::Hash ->
  use List::Objects::WithUtils 'hash';

  my $hash = hash(foo => 'bar');

  $hash->set(
    foo => 'baz',
    pie => 'tasty',
  );

  my @matches = $hash->keys->grep(sub {
    $_[0] =~ /foo/
  })->all;

  my $pie = $hash->get('pie')
    if $hash->exists('pie');

  for my $pair ( $hash->kv->all ) {
    my ($key, $val) = @$pair;
  }

  ## As a Role ->
  use Role::Tiny::With;
  with 'List::Objects::WithUtils::Role::Hash';

=head1 DESCRIPTION

A L<Role::Tiny> role defining methods for creating and manipulating HASH-type
objects.

=head2 new

Constructs a new HASH-type object.

=head2 export

  my %hash = $hash->export;

Returns a raw key/value list.

=head2 array_type

The class name of list/array-type objects that will be constructed from the
results of list-producing methods.

Defaults to L<List::Objects::WithUtils::Array>.

Subclasses can override C<array_type> to produce different types of array
objects; the method can also be queried to find out what kind of array object
will be returned:

  my $type = $hash->array_type;

=head2 clear

Clears the current hash entirely.

=head2 copy

Creates a shallow clone of the current object.

=head2 is_empty

Returns boolean true if the hash has no keys.

=head2 defined

  if ( $hash->defined($key) ) { ... }

Returns boolean true if the key has a defined value.

=head2 delete

  $hash->delete( @keys );

Deletes keys from the hash.

Returns an L</array_type> object containing the deleted values.

=head2 exists

  if ( $hash->exists($key) ) { ... }

Returns boolean true if the key exists.

=head2 get

  my $val  = $hash->get($key);
  my @vals = $hash->get(@keys)->all;

Retrieves a key or list of keys from the hash.

If we're taking a slice (multiple keys were specified), values are returned
as an L</array_type> object. (See L</sliced> if you'd rather generate a new
hash.)

=head2 keys

  my @keys = $hash->keys->all;

Returns the list of keys in the hash as an L</array_type> object.

=head2 values

  my @vals = $hash->values->all;

Returns the list of values in the hash as an L</array_type> object.

=head2 kv

  for my $pair ($hash->kv->all) {
    my ($key, $val) = @$pair;
  }

Returns an L</array_type> object containing the key/value pairs in the HASH,
each of which is a two-element ARRAY.

=head2 set

  $hash->set(
    key1 => $val,
    key2 => $other,
  )

Sets keys in the hash.

Returns an L</array_type> object containing the new values.

=head2 sliced

  my $newhash = $hash->slice(@keys);

Returns a new hash object built from the specified set of keys.

(See L</get> if you only need the values.)

=head1 SEE ALSO

L<List::Objects::WithUtils>

L<Data::Perl>

=head1 AUTHOR

Jon Portnoy <avenj@cobaltirc.org>

Portions of this code are derived from L<Data::Perl> by Matthew Phillips
(CPAN: MATTP), haarg et al

Licensed under the same terms as Perl.

=cut
