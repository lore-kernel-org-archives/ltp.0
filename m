From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 10 May 2019 20:31:26 +0200
Subject: [LTP] [RFC PATCH v2 0/6] net/route: Rewrite route{4, 6}-change-{dst,
	gw} into C
Message-ID: <20190510183132.31039-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

another attempt to rewrite route{4,6}-change-{dst,gw}.
I'm not much happy with it.

I was trying to create server side validation over UDP, but failed.
I didn't figure out setup where server could be on single IP address
(there is probably a solution), so I created threads, each thread bind
to single IP (number of threads is the same as number of IP addresses
created in shell). Due limitation of IPv6 routes over gateway (which
must be on rhost, for testsuite changing destination this is not
necessary) I run server on rhost. Testsuite got complicated:
waiting for threads to bind, save port and IP config into files
and load it in client... => unfinished and posted solution without server.
I can see packets sent with tcpdump, but that does not mean it reached
server. With this result it's questionable whether moving into C code is
a benefit, maybe shell code below is just good enough.

Other questionable thing is tst_ipaddr_un() incomplete implementation in C.
Alternatively IP addresses could be passed from shell via getopts, but
that can be hard to debug (too long argument passed).
Originally I wanted to create IP addresses also in C, but that's not
possible due rhost not reachable from C.

Changes from v1:
* Handle also route{4,6}-change-gw
* Use libmnl
* new commits (more comments at the commits):
- net: Move setup_addrinfo() from netstress.c into tst_net.h
- tst_net.sh: Minor code and doc cleanup
- tst_net.sh: Add -a IP and -s options to tst_init_iface()
- net: Introduce TST_GET_UNUSED_PORT() macro into C API
- net/route: Remove route{4,6}-change-if

Draft of alternative implementation in shell:
* route-change-dst
TST_TESTFUNC="do_test"
TST_SETUP="do_setup"
TST_CLEANUP="restore_ipaddr"
TST_NEEDS_CMDS="ip"
TST_CNT=$NS_TIMES

. tst_net_stress.sh

do_setup()
{
	# FIXME: remove duplicity
	mask=$IPV4_LPREFIX
	udp_size=1472
	if [ "$TST_IPV6" ]; then
		mask=$IPV6_LPREFIX
		udp_size=1452
	fi
	netstress_setup
	tst_res TINFO "change IPv$TST_IPVER route destination $NS_TIMES times"
}

do_test()
{
	local iface=$(tst_iface)
	local addr new_rt

	new_rt="$(tst_ipaddr_un $1)/$mask"
	addr="$(tst_ipaddr_un $1 1)"

	tst_res TINFO "testing route '$new_rt'"

	tst_rhost_run -s -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
	ROD ip route add $new_rt dev $iface
	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface

	EXPECT_PASS ns-udpsender -f $TST_IPVER -D $addr -p $1 -o -s $udp_size

	ROD ip neigh del $addr lladdr $(tst_hwaddr rhost) dev $iface
	ROD ip route del $new_rt dev $iface
	tst_rhost_run -c "ip addr del $addr/$mask dev $(tst_iface rhost)"
}

tst_run

* route-change-gw:
TST_TESTFUNC="do_test"
TST_SETUP="do_setup"
TST_CLEANUP="restore_ipaddr"
TST_NEEDS_CMDS="ip"
TST_CNT=$NS_TIMES

. tst_net_stress.sh

do_setup()
{
	mask=$IPV4_LPREFIX
	udp_size=1472
	if [ "$TST_IPV6" ]; then
		mask=$IPV6_LPREFIX
		udp_size=1452
	fi
	netstress_setup
	tst_res TINFO "change IPv$TST_IPVER route gateway $NS_TIMES times"

	rt="$(tst_ipaddr_un 1 0)/$mask"
	addr="$(tst_ipaddr_un 1 1)"
	tst_rhost_run -s -c "ip addr add $addr/$mask dev $(tst_iface rhost)"
}

do_test()
{
	local iface=$(tst_iface)
	local new_gw="$(tst_ipaddr_un 1 $(($1 + 1)))"

	tst_res TINFO "testing gw '$new_gw'"

	ROD ip addr add $new_gw/$mask dev $(tst_iface)
	ROD ip route replace $rt dev $iface via $new_gw
	ROD ip neigh replace $addr lladdr $(tst_hwaddr rhost) nud permanent dev $iface

	EXPECT_PASS ns-udpsender -f $TST_IPVER -D $addr -p $1 -o -s $udp_size

	ROD ip neigh del $addr lladdr $(tst_hwaddr rhost) dev $iface
	ROD ip route del $rt dev $iface via $new_gw
	ROD ip addr del $new_gw/$mask dev $(tst_iface)
}

tst_run
---

Petr Vorel (6):
  net/route: Remove route{4,6}-change-if
  net: Introduce TST_GET_UNUSED_PORT() macro into C API
  tst_net.sh: Add -a IP and -s options to tst_init_iface()
  tst_net.sh: Minor code and doc cleanup
  net: Move setup_addrinfo() from netstress.c into tst_net.h
  net/route: Rewrite route{4,6}-change-{dst,gw} into C

 configure.ac                                  |   1 +
 include/mk/config.mk.default                  |   2 +
 include/mk/config.mk.in                       |   2 +
 include/old/old_safe_net.h                    |   3 +
 include/old/test.h                            |   7 -
 include/safe_net_fn.h                         |  13 +-
 include/tst_net.h                             |  90 +++--
 include/tst_safe_net.h                        |   9 +-
 lib/safe_net.c                                |  66 ++++
 lib/tst_net.c                                 |  89 -----
 m4/ltp-libmnl.m4                              |   7 +
 runtest/net_stress.route                      |  12 +-
 testcases/kernel/syscalls/bind/bind01.c       |   2 +-
 testcases/kernel/syscalls/connect/connect01.c |   2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg01.c |   2 +-
 testcases/lib/tst_net.sh                      | 147 ++++----
 testcases/network/netstress/netstress.c       |  14 +-
 testcases/network/stress/route/.gitignore     |   1 +
 .../network/stress/route/00_Descriptions.txt  |  64 +---
 testcases/network/stress/route/Makefile       |  30 +-
 testcases/network/stress/route/route-change.c | 243 +++++++++++++
 .../network/stress/route/route-change.sh      |  52 +++
 .../network/stress/route/route4-change-dst    | 276 ---------------
 .../network/stress/route/route4-change-gw     | 292 ----------------
 .../network/stress/route/route4-change-if     | 324 ------------------
 .../network/stress/route/route6-change-dst    | 272 ---------------
 .../network/stress/route/route6-change-gw     | 292 ----------------
 .../network/stress/route/route6-change-if     | 323 -----------------
 tools/apicmds/ltpapicmd.c                     |   2 +-
 travis/debian.cross-compile.aarch64.sh        |   6 +-
 travis/debian.cross-compile.ppc64le.sh        |   8 +-
 travis/debian.i386.sh                         |   3 +-
 travis/debian.minimal.sh                      |  28 +-
 travis/debian.sh                              |  55 +--
 travis/fedora.sh                              |   5 +-
 travis/tumbleweed.sh                          |   7 +-
 36 files changed, 626 insertions(+), 2125 deletions(-)
 delete mode 100644 lib/tst_net.c
 create mode 100644 m4/ltp-libmnl.m4
 create mode 100644 testcases/network/stress/route/.gitignore
 create mode 100644 testcases/network/stress/route/route-change.c
 create mode 100755 testcases/network/stress/route/route-change.sh
 delete mode 100644 testcases/network/stress/route/route4-change-dst
 delete mode 100644 testcases/network/stress/route/route4-change-gw
 delete mode 100644 testcases/network/stress/route/route4-change-if
 delete mode 100644 testcases/network/stress/route/route6-change-dst
 delete mode 100644 testcases/network/stress/route/route6-change-gw
 delete mode 100644 testcases/network/stress/route/route6-change-if

-- 
2.21.0

