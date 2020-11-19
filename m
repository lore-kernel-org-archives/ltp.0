From: Joerg Vehlow <lkml@jv-coder.de>
Date: Thu, 19 Nov 2020 08:49:11 +0100
Subject: [LTP] [PATCH v2 1/3] network/stress/multicast/packet-flood:
 Update to new API
In-Reply-To: <057bc703-d3b6-5d8a-4831-609e332fdc36@oracle.com>
References: <20201117124320.783802-1-lkml@jv-coder.de>
 <057bc703-d3b6-5d8a-4831-609e332fdc36@oracle.com>
Message-ID: <98732a50-84e4-97b2-5124-757d91eba7a4@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> The following command should support both udp/udp6:
>
> local mcast_port=$(tst_get_unused_port ipv${TST_IPVER} dgram)
Actually find_portbundle doesn't distinguish between ipv6 and ipv4 when 
looking for a window of free ports, so it works for both variants. The 
only thing that can happen, is that it finds no free ports at all, even 
if there are some free ports, but that is probably highly unlikely.
Still I would say: Let's get rid of this function and remove usage as we 
go: I will change it anyway, because I don't like this.
> This check can be replaced with
>
> ROD ns-mcast_receiver -f $TST_IPVER -I $(tst_iface lhost) -m $mcast_addr -p $mcast_port -b
ACK
> What if we swap sender and receiver, i.e.
>
> local ns_opts="-f $TST_IPVER -p $mcast_port"
>
> tst_rhost_run -s -c "ns-mcast_receiver $ns_opts -I $(tst_iface rhost) -m $mcast_addr -b"
> EXPECT_PASS ns-udpsender -D $mcast_addr $ns_opts -s 32767 -m -I $(tst_iface) -t $NS_DURATION
>
> By default, ltp is using network namespace, so it's probably better
> to run the background service there.
I think the "thing-under-test" here is the receiver, not the sender. I 
don't see any benefit swapping this, it will only move the test to the 
wrong machine, if network namespaces are not in us
>
>> +	done
>> +
>> +	sleep $NS_DURATION
>
> It would be nice to have a small loop instead of a single 'sleep' and
> periodically check that the background senders are really running...
I also don't normally like sleeps, but? actually the way the test is 
implemented at the moment it would make little sense to add all the 
complexity required, to collect pids, to check the senders and implement 
a timeout Right after the last ns-udpsender is started, that runs for 
NS_DURATION, the sleep is executed for NS_DURATION. Even if the sleep 
exits before ns-udpsender, it doesn't matter, because it is just a bit 
earlier and the test time is actually variable. I wouldn't change this 
to be more complex, although I would design it differently, if I would 
implement the this as a new test.
An alternative would be to not background the last ns-udpsender 
execution, but that could be a bit obscure

J?rg
