package FCGI::ProcManager::MaxSize;
use strict;

use base 'FCGI::ProcManager';

use Proc::ProcessTable;

our $VERSION = '0.01';

sub new {
    my $proto = shift;
    my $self = $proto->SUPER::new(@_);
    $self->{max_size} = $ENV{PM_MAX_SIZE} || 200 unless defined $self->{max_size};
    return $self;
}

sub max_size { shift->pm_parameter('max_size', @_); }

# returns memory usage in bytes
sub memory_usage {
    my $proc = Proc::ProcessTable->new;

    foreach my $cur (@{$proc->table}) {
        next if not $cur->pid eq $$;
        return $cur->size;
    };

    # should we warn?
    return 0;
}

sub pm_post_dispatch {
    my $self = shift;

    my $memory_size = memory_usage() / 1024 / 1024;

    if ($self->max_size > 0 && $memory_size > $self->max_size ) {
        $self->pm_exit("safe exit after max_size");
    }

    $self->SUPER::pm_post_dispatch();
}

=head1 NAME

FCGI::ProcManager::MaxSize - restrict size of fcgi child processes

=head1 SYNOPSIS

Usage same as FCGI::ProcManager:

    use CGI::Fast;
    use FCGI::ProcManager::MaxSize;

    my $m = FCGI::ProcManager::MaxSize->new({
        n_processes => 10,
        max_size => 200,
    });
    $m->manage;

    while( my $cgi = CGI::Fast->new() ) {
        $m->pm_pre_dispatch();
        ...
        $m->pm_post_dispatch();
    }

=head1 DESCRIPTION

FCGI-ProcManager-MaxSize is a extension of FCGI-ProcManager that allows
the size of child processes to be restricted. This is an alternate to
L<FCGI::ProcManager::MaxSize> that allows you to define your operating
parameters based on memory.

This module subclass L<FCGI::ProcManager>. Once the defined value for 
PM_MAX_SIZE is reached, the child process will exit gracefully.

=head1 OVERLOADED METHODS

=head2 new

    my $pm = FCGI::ProcManager::MaxSize->new(\%args);

Constructs new proc manager object.

=head2 max_size

    $pm->max_size($max_size);
    my $max_size = $pm->max_size;

Allows you to set or get the maximum process size, in MB.

=head2 pm_post_dispatch

At the end of a request, check the current memory size of the child process. If it
exceeds the size defined in max_size, exit gracefully.

=head1 METHODS

=head2 memory_usage

Find the memory usage for the current child process. 

=head1 USING WITH CATALYST

At this time, L<Catalyst::Engine::FastCGI> do not allow set any args to L<FCGI::ProcManager> constructor.
An environment variable PM_MAX_SIZE will need to be set. If the engine is set with -M and no argument, a 
default of 200MB is used for the child process size.

    PM_MAX_SIZE=500 ./script/myapp_fastcgi.pl -n 10 -l <host>:<port> -d -M FCGI::ProcManager::MaxSize

=head1 AUTHOR

Dean Pearce, C<< <deanpearce at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests via rt.cpan.org. This will
automatically notify me of your request and allow you to track it.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc FCGI::ProcManager::MaxSize

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2014 Dean Pearce

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

=cut

1;
