FCGI-ProcManager-MaxSize
========================

FCGI-ProcManager-MaxSize is a extension of FCGI-ProcManager that 
allows the size of the child processes to be restricted to a 
reasonable size for the system. It will allow child processes
to exit cleanly after it finishes serving a request.

*INSTALLATION*

To install this module, run the following commands:

	perl Makefile.PL
	make
	make test
	make install

*SUPPORT AND DOCUMENTATION*

After installing, you can find documentation for this module with the
perldoc command.

    perldoc FCGI::ProcManager::MaxSize

*COPYRIGHT AND LICENCE*

Copyright (C) 2014 Dean Pearce

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
