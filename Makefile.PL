use inc::Module::Install;
name 'class';
all_from 'lib/class.pm';

requires 'Class::Load';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
