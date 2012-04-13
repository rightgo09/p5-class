use strict;
use warnings;
use Test::More tests => 2*2;
use class;

class "Foo" => (
	bar => sub { 'buz' },
	property => [qw/ name /],
);

my $foo = Foo->new;
$foo->name('hoge');
is($foo->name, 'hoge');
$foo->name('fuga');
is($foo->name, 'fuga');


class "Hoge" => (
	property => 'name',
);
my $hoge = Hoge->new(name => 'Fuga');
is($hoge->name, 'Fuga');
$hoge->name('Fooooo');
is($hoge->name, 'Fooooo');

