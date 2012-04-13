use strict;
use warnings;
use Test::More tests => 6;

use t::Foo;
use t::Hoo;

my $foo = new_ok("Foo");
my $hoo = new_ok("Hoo");

is($foo->bar, 'baz');
is($hoo->bar, 'baz');
$hoo->hoge('HOGE');
is($hoo->hoge, 'HOGE');
$hoo->fuga('FUGA');
is($hoo->fuga, 'FUGA');

