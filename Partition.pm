# Integer::Partition.pm
#
# Copyright (c) 2007 David Landgren
# All rights reserved

package Integer::Partition;
use strict;

use vars qw/$VERSION/;
$VERSION = '0.02';

=head1 NAME

Integer::Partition - Generate all integer partitions of an integer

=head1 VERSION

This document describes version 0.02 of Integer::Partition,
released 2007-xx-xx.

=head1 SYNOPSIS

  use Integer::Partition;

  my $i = Integer::Partition->new(4);
  while (my $p = $i->next) {
    print join( ' ', map { "(@$_)" } @$p ), $/;
  }
  # produces
  4
  3 1
  2 2
  2 1 1
  1 1 1 1

=head1 DESCRIPTION

C<Integer::Partition> takes an integer number and produces an object
that can be used to generate all possible integer partitions of the
original number in reverse lexographic order.

=head1 METHODS

=over 8

=item new

Creates a new C<Integer::Partition> object. Takes an integer as a
parameter.

=cut

sub new {
    my $class = shift;
    my $n     = shift;
    if (!defined $n) {
        require Carp;
        Carp::croak("missing or undefined input");
    }
    elsif ($n < 1) {
        require Carp;
        Carp::croak("$n is not a positive integer");
    }
    elsif ($n != int($n) {
        require Carp;
        Carp::croak("$n is not an integer");
    }

    my @x;
    if (defined $n) {
        @x    = (1) x $n;
        $x[0] = $n;
    }

    return bless {
        n => $n,
        x => \@x,
        m => 0,
        h => 0,
        once => 0,
    },
    $class;
}

=item next

Returns the partition, or C<undef> when all partitions have been
generated.

=cut

sub next {
    my $self = shift;
    return unless defined $self->{n};
    return [$self->{n}] unless $self->{once}++;
    return if $self->{x}[0] == 1;

    if ($self->{x}[$self->{h}] == 2) {
        ++$self->{m};
        $self->{x}[$self->{h}--] = 1;
    }
    else {
        my $r = $self->{x}[$self->{h}] - 1;
        $self->{x}[$self->{h}] = $r;

        my $t = $self->{m} - $self->{h} + 1;
        while ($t >= $r) {
            $self->{x}[++$self->{h}] = $r;
            $t -= $r;
        }
        $self->{m} = $self->{h} + ($t ? 1 : 0);
        $t > 1 and $self->{x}[++$self->{h}] = $t;
    }
    return [@{$self->{x}}[0..$self->{m}]];
}

=item reset

Resets the object, which causes it to enumerate the arrangements from the
beginning.

  $p->reset; # begin again

=cut

sub reset {
    my $self  = shift;
    my @x = (1) x $self->{n};
    $x[0] = $self->{n};
    $self->{x} = \@x;
    $self->{m} = 0;
    $self->{h} = 0;
    $self->{once} = 0;
    return $self;
}

=back

=head1 DIAGNOSTICS

=head2 missing or undefined input

The C<new()> method was called without an input parameter, which
should be a positive integer.

=head2 C<n> is not a positive integer

The C<new()> method was called with zero or a negative integer.

=head2 C<n> is not an integer

The C<new()> method was called with a number containing a decimal
component. Use C<int> or C<sprintf '%d'> on the input if necessary.

=head1 NOTES

This module implements the Zoghbi and Stojmenovic ZS1 algorithms for
generating integer partitions. See
L<http://www.site.uottawa.ca/~ivan/F49-int-part.pdf> for more
information.  These algorithms have been proven to have constant
average delay, that is, the amount of effort it takes to produce
the next result in the series.

They are the fastest known algorithms known for generating integer
partitions (with the ZS1 reverse lexigraphic order algorithm being
slightly faster than the ZS2 lexigraphic order algorithm).

=head1 SEE ALSO

=over 8

=item *

L<http://en.wikipedia.org/wiki/Integer_partition>

=back

=head1 BUGS

Please report all bugs at
L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Set-Partition|rt.cpan.org>

Make sure you include the output from the following two commands:

  perl -MInteger::Partition -le 'print $Integer::Partition::VERSION'
  perl -V

=head1 ACKNOWLEDGEMENTS

Thanks to Antoine Zoghbi and Ivan Stojmenovic, for sharing their
discovery with the world on the internet, and not hiding it in
behind some sort of pay-wall.

=head1 AUTHOR

David Landgren, copyright (C) 2007. All rights reserved.

http://www.landgren.net/perl/

If you (find a) use this module, I'd love to hear about it. If you
want to be informed of updates, send me a note. You know my first
name, you know my domain. Can you guess my e-mail address?

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

'The Lusty Decadent Delights of Imperial Pompeii';
__END__
