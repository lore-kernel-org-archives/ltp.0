From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 28 May 2019 15:32:26 +0300
Subject: [LTP] [RFC PATCH v2 0/6] net/route: Rewrite route{4,
 6}-change-{dst, gw} into C
In-Reply-To: <20190510183132.31039-1-pvorel@suse.cz>
References: <20190510183132.31039-1-pvorel@suse.cz>
Message-ID: <187fa31b-3295-6f1f-e330-1373b2fb4c66@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On 5/10/19 9:31 PM, Petr Vorel wrote:
> Hi,
> 
> another attempt to rewrite route{4,6}-change-{dst,gw}.
> I'm not much happy with it.
> 
> I was trying to create server side validation over UDP, but failed.
> I didn't figure out setup where server could be on single IP address
> (there is probably a solution), so I created threads, each thread bind
> to single IP (number of threads is the same as number of IP addresses
> created in shell). Due limitation of IPv6 routes over gateway (which
> must be on rhost, for testsuite changing destination this is not
> necessary) I run server on rhost. Testsuite got complicated:
> waiting for threads to bind, save port and IP config into files
> and load it in client... => unfinished and posted solution without server.
> I can see packets sent with tcpdump, but that does not mean it reached
> server. With this result it's questionable whether moving into C code is
> a benefit, maybe shell code below is just good enough.
> 
> Other questionable thing is tst_ipaddr_un() incomplete implementation in C.
> Alternatively IP addresses could be passed from shell via getopts, but
> that can be hard to debug (too long argument passed).
> Originally I wanted to create IP addresses also in C, but that's not
> possible due rhost not reachable from C.
> 
> Changes from v1:
> * Handle also route{4,6}-change-gw
> * Use libmnl
> * new commits (more comments at the commits):
> - net: Move setup_addrinfo() from netstress.c into tst_net.h
> - tst_net.sh: Minor code and doc cleanup
> - tst_net.sh: Add -a IP and -s options to tst_init_iface()
> - net: Introduce TST_GET_UNUSED_PORT() macro into C API
> - net/route: Remove route{4,6}-change-if
> 
> Draft of alternative implementation in shell:
> * route-change-dst
> TST_TESTFUNC="do_test"
> TST_SETUP="do_setup"
> TST_CLEANUP="restore_ipaddr"
> TST_NEEDS_CMDS="ip"
> TST_CNT=$NS_TIMES
> 
> . tst_net_stress.sh
> 
> do_setup()
> {
> 	# FIXME: remove duplicity
> 	mask=$IPV4_LPREFIX
> 	udp_size=1472
> 	if [ "$TST_IPV6" ]; then
> 		mask=$IPV6_LPREFIX
> 		udp_size=1452
> 	fi
> 	netstress_setup
> 	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
> }
> 
> do_test()
> {
> 	local iface=$(tst_iface)
> 	local addr new_rt
> 
> 	new_rt="$(tst_ipaddr_un $1)/$mask"
> 	addr="$(tst_ipaddr_un $1 1)"
> 
> 	tst_res TINFO "testing route '$new_rt'"
> 
> 	tst_rhost_run -s -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
> 	ROD ip route add $new_rt dev $iface
> 	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface
> > 	EXPECT_PASS ns-udpsender -f $TST_IPVER -D $addr -p $1 -o -s $udp_size
> 
> 	ROD ip neigh del $addr lladdr $(tst_hwaddr rhost) dev $iface
> 	ROD ip route del $new_rt dev $iface
> 	tst_rhost_run -c "ip addr del $addr/$mask dev $(tst_iface rhost)"

With ns-udpsender, I think it can be without setting ip addresses:
 	ROD ip route add $new_rt dev $iface
 	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface
 	EXPECT_PASS ns-udpsender -f $TST_IPVER -D $addr -p $1 -o -s $udp_size> 
	ROD ip neigh del $addr lladdr $(tst_hwaddr rhost) dev $iface
 	ROD ip route del $new_rt dev $iface

But with ping and neighbor discovery:
 	tst_rhost_run -s -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
 	ROD ip route add $new_rt dev $iface
 	EXPECT_PASS ping$TST_IPVER ...
 	ROD ip route del $new_rt dev $iface
 	tst_rhost_run -c "ip addr del $addr/$mask dev $(tst_iface rhost)"
