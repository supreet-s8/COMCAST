#!/usr/bin/perl

use Net::OpenSSH;
use Expect;


#`/usr/sbin/vpnc`;

$ip="192.168.202.104";
$username=root;
$password=guavus123;

my $ssh = Net::OpenSSH->new($ip, user => $username, password => $password,
                            master_opts => [-o => 'StrictHostKeyChecking=no']);

print "host : (UI)";
$ssh->system('hostname') or die "remote command failed: " . $ssh->error;
print  "command : uptime\n";
$ssh->system('uptime') or die "remote command failed: " . $ssh->error;
print  "\n command : df -h\n";
$ssh->system('df -h') or die "remote command failed: " . $ssh->error;
print  "\n command : free -m\n";
$ssh->system('free -m') or die "remote command failed: " . $ssh->error;

print  "\n-------------------------------------------------------------------\n";


my $ssh1 = Net::OpenSSH->new('192.168.202.106', user => $username, password => $password,
                            master_opts => [-o => 'StrictHostKeyChecking=no']);

print "host : (Alerting & Montoring) ";
$ssh1->system('hostname') or die "remote command failed: " . $ssh->error;
print  "command : uptime\n";
$ssh1->system('uptime') or die "remote command failed: " . $ssh->error;
print  "\n command : df -h\n";
$ssh1->system('df -h') or die "remote command failed: " . $ssh->error;
print  "\n command : free -m\n";
$ssh1->system('free -m') or die "remote command failed: " . $ssh->error;

print  "\n-------------------------------------------------------------------\n";

my $ssh2 = Net::OpenSSH->new('192.168.202.102', user => $username, password => $password,
                            master_opts => [-o => 'StrictHostKeyChecking=no']);


print "host : (Collector) ";
$ssh2->system('hostname') or die "remote command failed: " . $ssh->error;
print  "command : uptime\n";
$ssh2->system('uptime') or die "remote command failed: " . $ssh->error;
print  "\n command : df -h\n";
$ssh2->system('df -h') or die "remote command failed: " . $ssh->error;
print  "\n command : free -m\n";
$ssh2->system('free -m') or die "remote command failed: " . $ssh->error;
print  "\n command : \"ps auxw | grep java|grep -v grep\" \n";
$ssh2->system('ps auxw | grep java |grep -v grep') or die "remote command failed: " . $ssh->error;
print "\n command : ls -lrt /data/carereflex/jail/home/guavus-scp/produce/ \n";
$ssh2->system('ls -lrt /data/carereflex/jail/home/guavus-scp/produce/') or die "remote command failed: " . $ssh->error;
print "\n command : ls  -lrt /data/carereflex/jail/home/guavus-scp/retention | tail \n";
$ssh2->system('ls  -lrt /data/carereflex/jail/home/guavus-scp/retention | tail') or die "remote command failed: " . $ssh->error;

#$day=$ssh->capture('date +"%d"') or die "remote command failed: " . $ssh->error;

print  "\n-------------------------------------------------------------------\n";

$username_db=nz;
$pssword_db="a8n3t3##a";
my $ssh3 = Net::OpenSSH->new('192.168.202.199', user => $username_db, password => $pssword_db,
                            master_opts => [-o => 'StrictHostKeyChecking=no']);

print "host : (DB Netezza) ";
$ssh3->system('hostname') or die "remote command failed: " . $ssh->error;
print  "command : uptime\n";
$ssh3->system('uptime') or die "remote command failed: " . $ssh->error;
print  "\n command : df -h\n";
$ssh3->system('df -h') or die "remote command failed: " . $ssh->error;
print  "\n command : free -m\n";
$ssh3->system('free -m') or die "remote command failed: " . $ssh->error;
print  "\n command : nzsession";
$ssh3->system('nzsession') or die "remote command failed: " . $ssh->error;

print  "\n-------------------------------------------------------------------\n";
