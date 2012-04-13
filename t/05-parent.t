use strict;
use warnings;
use Test::More tests => 9;

use class;

class "Grandfather" => (
	property => 'land',
	fullname => sub { 'Joe' },
);
class "Father" => parent("Grandfather") => (
	property => 'money',
	fullname => sub { $_[0]->super('fullname').' Mike' },
);
class "Son" => (
	parent => 'Father',
	property => 'honor',
	fullname => sub { $_[0]->super('fullname').' Tom' },
);
class "Grandson < Son" => (
	property => 'girlfriend',
	fullname => sub { $_[0]->super('fullname').' Mark' },
);

new_ok("Grandfather");
new_ok("Father");
new_ok("Son");
new_ok("Grandson");

my $grandson = Grandson->new(
	land => 'the South Pole',
	money => 1_000_000,
	honor => 'a Nobel prize',
	girlfriend => 'Anne',
);

is($grandson->land, 'the South Pole');
is($grandson->money, 1_000_000);
is($grandson->honor, 'a Nobel prize');
is($grandson->girlfriend, 'Anne');
is($grandson->fullname, 'Joe Mike Tom Mark');

