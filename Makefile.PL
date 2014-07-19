use inc::Module::Install;

name     'FCGI-ProcManager-MaxSize';
all_from 'lib/FCGI/ProcManager/MaxSize.pm';
author   'Dean Pearce <deanpearce@gmail.com>';
license  'perl';

build_requires 'Test::More';

requires 'FCGI::ProcManager';
requires 'Proc::ProcessTable';

WriteAll;

