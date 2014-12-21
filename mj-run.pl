#!/usr/bin/env perl

use strict;
use warnings;
use Path::Tiny qw/path/;
use JSON qw/decode_json/;
use Cwd;
use 5.10.0;
use Data::Dumper;

my $SVRLIST = decode_json(path('config.json')->slurp);
my $cmd = $ARGV[0] || 'restart';

if ($cmd eq 'start') {
    mojo_start();
    sleep 1;
} elsif ($cmd eq 'restart') {
    mojo_stop();
    sleep 1;
    mojo_start();
} elsif ($cmd eq 'stop') {
    mojo_stop();
    sleep 1;
} else {
    say "USAGE: mj-run [start|stop|restart]";
}

sub mojo_stop {
    foreach my $server (keys %{$SVRLIST}) {
        next unless is_server_config($SVRLIST->{$server});
        say "Stopping $server.";
        my $port    = $SVRLIST->{$server}{port};
        my $http    = $SVRLIST->{$server}{http};
        my $logfile = $SVRLIST->{$server}{logpath};
        system("pkill -9 -f 'morbo.*$http.*$port $server.pl'");
        system("pkill -9 -f 'tail -f $logfile'");
    }
}

sub mojo_start {
    foreach my $server (keys %{$SVRLIST}) {
        next unless is_server_config($SVRLIST->{$server});
        say "Starting $server.";
        my $port    = $SVRLIST->{$server}{port};
        my $http    = $SVRLIST->{$server}{http};
        my $logfile = $SVRLIST->{$server}{logpath};
        system("morbo -l $http://*:$port $server.pl &");
        system("tail -f $logfile &");
    }
}

sub is_server_config {
    my $config = shift;
    return ((ref $config eq 'HASH') &&
            (defined($config->{port})) &&
            (defined($config->{http})) &&
            (defined($config->{logpath})));
}

=pod Sample config.json
{ 
    "PROD" : { 
        "PushServer" : { 
            "port"   : "3020",
            "http"   : "http",
            "logpath": "log/PushServer-prod.log",
            "pushdb" : "db/Push.db"
        }
    },

    "TEST" : { 
        "PushServer" : { 
            "port"   : "6020", 
            "http"   : "http",
            "logpath": "log/PushServer-test.log",
            "pushdb" : "db/test-Push.db"
        }
    },

    "_output_files" : [ "config.json" ]
}
=cut


