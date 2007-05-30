# 01-method.t
#
# Test suite for Integer::Partition
# Test the module methods
#
# copyright (C) 2007 David Landgren

use strict;

eval qq{use Test::More tests => 36};
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

	$s->reset;
    $p = $s->next;
    is_deeply( $p, [1], 'partition of 1 after reset' );
}

{
    my $s = Integer::Partition->new(2);
    is_deeply( $s->next, [2],    'p(2) 1' );
    is_deeply( $s->next, [1, 1], 'p(2) 2' );
}

{
    my $s = Integer::Partition->new(3);
    is_deeply( $s->next, [3],       'p(3) 1' );
    is_deeply( $s->next, [2, 1],    'p(3) 2' );
    is_deeply( $s->next, [1, 1, 1], 'p(3) 3' );
	$s->reset;
    is_deeply( $s->next, [3],       'p(3) 1 reset' );
}

{
    my $s = Integer::Partition->new(4);
    is_deeply( $s->next, [4],          'p(4) 1' );
    is_deeply( $s->next, [3, 1],       'p(4) 2' );
    is_deeply( $s->next, [2, 2],       'p(4) 3' );
    is_deeply( $s->next, [2, 1, 1],    'p(4) 4' );
    is_deeply( $s->next, [1, 1, 1, 1], 'p(4) 5' );
	$s->reset;
    is_deeply( $s->next, [4],          'p(4) 1 reset' );
}

{
    my $s = Integer::Partition->new(5);
    is_deeply( $s->next, [5            ], 'p(5) 1' );
    is_deeply( $s->next, [4, 1         ], 'p(5) 2' );
    is_deeply( $s->next, [3, 2         ], 'p(5) 3' );
    is_deeply( $s->next, [3, 1, 1      ], 'p(5) 4' );
    is_deeply( $s->next, [2, 2, 1      ], 'p(5) 5' );
    is_deeply( $s->next, [2, 1, 1, 1   ], 'p(5) 6' );
    is_deeply( $s->next, [1, 1, 1, 1, 1], 'p(5) 7' );
	$s->reset;
    is_deeply( $s->next, [5            ], 'p(5) 1 reset' );
}

{
    my $s = Integer::Partition->new(6);
    is_deeply( $s->next, [6               ], 'p(6)  1' );
    is_deeply( $s->next, [5, 1            ], 'p(6)  2' );
    is_deeply( $s->next, [4, 2            ], 'p(6)  3' );
    is_deeply( $s->next, [4, 1, 1         ], 'p(6)  4' );
    is_deeply( $s->next, [3, 3            ], 'p(6)  5' );
    is_deeply( $s->next, [3, 2, 1         ], 'p(6)  6' );
    is_deeply( $s->next, [3, 1, 1, 1      ], 'p(6)  7' );
    is_deeply( $s->next, [2, 2, 2         ], 'p(6)  8' );
    is_deeply( $s->next, [2, 2, 1, 1      ], 'p(6)  9' );
    is_deeply( $s->next, [2, 1, 1, 1, 1   ], 'p(6) 10' );
    is_deeply( $s->next, [1, 1, 1, 1, 1, 1], 'p(6) 11' );
	$s->reset;
    is_deeply( $s->next, [6               ], 'p(6)  1 reset' );
}

cmp_ok( $_, 'eq', $Unchanged, '$_ has not been altered' );

