use strict;
use warnings;
use Test::More tests => 8;

use t::Foo;
use t::Hoo;

my $foo = new_ok("t::Foo");
my $hoo = new_ok("t::Hoo");

is($foo->bar, 'baz');
is($hoo->bar, 'baz');
$hoo->hoge('HOGE');
is($hoo->hoge, 'HOGE');
$hoo->fuga('FUGA');
is($hoo->fuga, 'FUGA');


use t::Hoo2;
my $hoo2 = t::Hoo2->new;
is($hoo2->bar, 'baz');
$hoo2->hoge('HOGE');
is($hoo2->hoge, 'HOGE');

