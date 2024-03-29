#!perl

use strict;
use warnings;
use Test::More;
use AnyEvent;
use AnyEvent::Mojo;

use lib 't/tlib';
use MyTestServer;


my $port = 4000 + $$ % 10000;
my $server; $server = mojo_server(undef, $port, sub {
  my (undef, $tx) = @_;
  my $res = $tx->res;
  
  $res->code(200);
  $res->headers->content_type('text/plain');
  $res->body('Mary had a little lamb... but she was hungry... Lamb chops for dinner!');
  
  return;
});
ok($server);
is($server->host, '0.0.0.0');
is($server->port, $port);
is(ref($server->handler_cb), 'CODE');

my $t; $t = AnyEvent->timer( after => 1, cb => sub {
  my $url = "http://127.0.0.1:$port/";
  AnyEvent::HTTP::http_get( $url, sub {
    my ($content) = @_;
    
    ok($content, "got content back from ($url)");
    like($content, qr/Lamb chops for dinner/, "... and it is the right content ($url)");
    
    $server->stop;
  });
});

$server->run;
pass("Server stoped properly");

## Test forced host
$server = mojo_server({
  host => '127.0.0.1',
  port => $port,
  handler_cb => sub {},
});
ok($server);
is($server->host, '127.0.0.1');
is($server->port, $port);
is(ref($server->handler_cb), 'CODE');

done_testing();
