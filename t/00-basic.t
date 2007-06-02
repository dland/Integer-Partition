# 00-basic.t
#
# Test suite for Integer::Partition
# Make sure the basic stuff works
#
# copyright (C) 2007 David Landgren

use strict;

eval qq{ use Test::More tests => 9 };
if( $@ ) {
    warn "# Test::More not available, no tests performed\n";
    print "1..1\nok 1\n";
    exit 0;
}

use Integer::Partition;

my $Unchanged = 'The scalar remains the same';
$_ = $Unchanged;

diag( "testing Integer::Partition v$Integer::Partition::VERSION" );

{
    my $t = Integer::Partition->new(1);
    ok( defined($t), 'new() defines ...' );
    ok( ref($t) eq 'Integer::Partition', '... a Integer::Partition object' );

    my $r = $t->next;
    is( ref($r), 'ARRAY', '... returns an arrayref' );

    $t = Integer::Partition->new(1, 2);
    ok( defined($t), 'new() ignores trailing parameter' );

    $t = Integer::Partition->new(1, [2]);
    ok( defined($t), 'new() ignores trailing ref' );

    $t = Integer::Partition->new(1, {bogus => 2});
    ok( defined($t), 'new() ignores unknown key' );
}

SKIP: {
    skip( 'Test::Pod not installed on this system', 1 )
        unless do {
            eval "use Test::Pod";
            $@ ? 0 : 1;
        };

    pod_file_ok( 'Partition.pm' );}

SKIP: {
    skip( 'Test::Pod::Coverage not installed on this system', 1 )
        unless do {
            eval "use Test::Pod::Coverage";
            $@ ? 0 : 1;
        };
    pod_coverage_ok( 'Integer::Partition', 'POD coverage is go!' );
}

cmp_ok( $_, 'eq', $Unchanged, '$_ has not been altered' );
