use inc::Module::Install;
name 'Acme-NyanDoku';
all_from 'lib/Acme/NyanDoku.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

test_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
