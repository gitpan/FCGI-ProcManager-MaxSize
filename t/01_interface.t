use strict;
use warnings;
use Test::More tests => 4;

use FCGI::ProcManager::MaxSize;

my $m = FCGI::ProcManager::MaxSize->new();
is($m->max_size, 200, 'max_size default is 200');

$m->max_size(500);
is($m->max_size, 500, 'max_size can be set through accessor');

$m = FCGI::ProcManager::MaxSize->new({max_size => 125});
is($m->max_size, 125, 'max_size set in constructor');

$ENV{PM_MAX_SIZE} = 250;
$m = FCGI::ProcManager::MaxSize->new();
is($m->max_size, 250, 'max_size default set to PM_MAX_REQUESTS env if it exists');
