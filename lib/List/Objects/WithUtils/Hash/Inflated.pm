package List::Objects::WithUtils::Hash::Inflated;
{
  $List::Objects::WithUtils::Hash::Inflated::VERSION = '1.010000';
}
use strictures 1;
require Carp;

sub new {
  bless +{ @_[1 .. $#_] }, $_[0]
}

sub DEFLATE { %{ $_[0] } }

our $AUTOLOAD;

sub can {
  my ($self, $method) = @_;
  if (my $sub = $self->SUPER::can($method)) {
    return $sub
  }
  return unless exists $self->{$method};
  sub { 
    my ($self) = @_;
    if (my $sub = $self->SUPER::can($method)) {
      goto $sub
    }
    $AUTOLOAD = $method; 
    goto &AUTOLOAD 
  }
}

sub AUTOLOAD {
  my $self = shift || return;
  ( my $method = $AUTOLOAD ) =~ s/.*:://;
  
  Carp::confess "Can't locate object method '$method'"
    unless exists $self->{$method};
  Carp::confess "Accessor '$method' is read-only"
    if @_;

  $self->{$method}
}

sub DESTROY {}

1;

=pod

=for Pod::Coverage new can AUTOLOAD DEFLATE

=cut