#!/usr/bin/perl

use strict;
use warnings;

use IO::Socket;
use Cache::Memcached;

my $response = { status => "error", error => "timed out" };
my $port = 11211;
my $cache_time = 8;

$SIG{CHLD} = 'IGNORE';

my $socket = new IO::Socket::INET (
	LocalHost => '0.0.0.0',
	LocalPort => $port,
	Proto => 'tcp',
	Listen => 5,
	Reuse => 1
);

die "cannot create socket $!\n" unless $socket;

print "Memcache kill server running\n";

while ( 1 ) {
	my $client_socket = $socket->accept();
	my $client_address = $client_socket->peerhost();
	my $client_port = $client_socket->peerport();

	my $pid = fork();

	if( $pid == 0 ) {
		my $epoch = 0;

		eval {
			local $SIG{ALRM} = sub { die "alarm\n" };
			alarm 1000;
			sleep 999;
			alarm 0;
		};

		my $data = "ok\r\n";

		$client_socket->send( $data );

		exit 0;
	}
}

$socket->close();
