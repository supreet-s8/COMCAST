#!/usr/bin/perl

use POSIX qw(strftime);

use Net::OpenSSH;
$username=root;
$password=guavus123;
my $ssh = Net::OpenSSH->new('192.168.202.102', user => $username, password => $password,
                            master_opts => [-o => 'StrictHostKeyChecking=no']);

$day=$ssh->capture('date +"%d"');

$ssh->error and die "remote ls command failed: " . $ssh->error;

#$day = strftime "%d", localtime;

$log_file=$ARGV[0];

open(IN,"$log_file") || die "$!\n";

open(OUT,">","/data/TOOLS_TEAM/root/TWC/out.txt") || die "$!\n";

@array=<IN>;

foreach $i (0..$#array){


	if($array[$i]=~/^host/){
	#print "$array[$i]\n";
	@hst=split(/:/,$array[$i]);
	$hst[1]=~s/\s//g;
	$host=$hst[1];
	}

	if ($array[$i]=~/^Filesystem/){
	#print "hi\n";
		while($array[$i] !~ /^$/){
			@mo=split(/\s+/,$array[$i]);
			$mo[4] =~ s/\%//g;
			#print "$mo[4]\n";	
			if($mo[4] > 80){
				print OUT "High diskSapce for HOST : $host\n";
				print OUT "$array[$i]\n";
				}
			
			$i++;
			}
		#next;
	}

	if ($array[$i]=~/uptime/){
		
		$array[$i+1]=~s/^\s//g;
		if ($array[$i+1]=~/day/){
			@uptime=split(/\s/,$array[$i+1]);
			#print "$host : $uptime[2] $uptime[3]\n";
			#print "$uptime[2]\n";	
			if($uptime[2] < 1){
				print OUT "Host $host is recently rebooted, uptime time is : $array[$i+1]\n";
			}
		}else{

			print OUT "Host $host is recently rebooted, uptime time is : $array[$i+1]\n";
		}
		#@uptime=split(/\s/,$array[$i+1]);
		#print "$host : $uptime[2] $uptime[3]\n";
		#print "$uptime[2]\n";	
		#if($uptime[2] < 2){	
		#	print OUT "Host $host is recently rebooted, uptime time is : $array[$i+1]\n";
		#}
		
		
	}
	
	if ($array[$i]=~/ps\sauxw/){
		my $j=$i+1;
		my $count=0;
		while($array[$j] !~ /^$/){
			$count++;
			$j++;
		}
		if ($count < 2){
			print OUT "number of java processes on collector $host : $count\n";

		}
	}


	if ($array[$i]=~/retention/){
		@list=split(/\s+/,$array[$i+1]);
		#print "$list[6]\n";
		#$t=4;
		if ($list[6] < $day ){print OUT "\"retention\" files generated on $host are old, please check below script logs \n";}
	}

	if ($array[$i]=~/nzsession/){
		my $j=$i+1;
		while($array[$j] !~ /^$/){
			
			if ($array[$j]=~/tx-idle/){
				
				print OUT "$host has nzsession \"tx-idle\" sessios, check below script logs and report to TWC\n";
			}
		$j++;
		}
	}
}


close(IN);
close(OUT);

