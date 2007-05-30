# 01-method.t
#
# Test suite for Integer::Partition
# Test the module methods
#
# copyright (C) 2007 David Landgren

use strict;

eval qq{use Test::More tests => 3};
if( $@ ) {
    warn "# Test::More not available, no tests performed\n";
    print "1..1\nok 1\n";
    exit 0;
}

use Integer::Partition;

my $Unchanged = 'The scalar remains the same';
$_ = $Unchanged;

{
    my $s = Integer::Partition->new(1);
    my $p = $s->next;
    is_deeply( $p, [1], 'partition of 1' );
    $p = $s->next;
    ok( !defined($p), '...exhausted');
}

cmp_ok( $_, 'eq', $Unchanged, '$_ has not been altered' );

