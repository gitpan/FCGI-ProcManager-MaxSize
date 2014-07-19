#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'FCGI::ProcManager::MaxSize' );
}

diag( "Testing FCGI::ProcManager::MaxSize $FCGI::ProcManager::MaxSize::VERSION" );
