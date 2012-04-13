use strict;
use warnings;
use Test::More tests => 1;
use class;

class "Foo" => (
	property => 'point',
	require => 'List::Util',
	point_max => sub {
		my $self = shift;
		return List::Util::max(@{ $self->point });
	},
);

my $foo = Foo->new;
$foo->point([qw/ 12 82 73 46 29 11 84 92 83 27 37 48 /]);
cmp_ok($foo->point_max, '==', 92);

