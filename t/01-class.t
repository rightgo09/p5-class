use strict;
use warnings;
use Test::More tests => 2;
use class;

class "Foo" => (
	bar => sub { 'buz' },
);

my $foo = new_ok("Foo");
is($foo->bar, "buz");

