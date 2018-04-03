From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Apr 2018 17:47:13 +0200
Subject: [LTP] [RFC PATCH v3 1/5] tst_net.sh: Support both old and new shell
	APIs + rename it
In-Reply-To: <20180403154717.22491-1-pvorel@suse.cz>
References: <20180403154717.22491-1-pvorel@suse.cz>
Message-ID: <20180403154717.22491-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The new name states that library supports new API.

This is temporary solution, after migrating all tests to new SHELL API
the compatibility layer and old SHELL API support should be removed.

Add TST_USE_LEGACY_API=1 to all scripts using tst_net.sh (including
testscripts/network.sh).

Filter out TST_IPV6 variable in tst_test.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/{test_net.sh => tst_net.sh}          | 135 +++++++++++++--------
 testcases/lib/tst_test.sh                          |   1 +
 testcases/network/README.md                        |   4 +-
 testcases/network/busy_poll/busy_poll01.sh         |   3 +-
 testcases/network/busy_poll/busy_poll02.sh         |   3 +-
 testcases/network/busy_poll/busy_poll03.sh         |   3 +-
 testcases/network/dccp/dccp01.sh                   |   3 +-
 testcases/network/dctcp/dctcp01.sh                 |   3 +-
 testcases/network/dhcp/dhcpd_tests.sh              |   3 +-
 testcases/network/dhcp/dnsmasq_tests.sh            |   3 +-
 testcases/network/iproute/ip_tests.sh              |   3 +-
 testcases/network/multicast/mc_cmds/mc_cmds        |   3 +-
 testcases/network/multicast/mc_commo/mc_commo      |   3 +-
 testcases/network/multicast/mc_member/mc_member    |   3 +-
 testcases/network/multicast/mc_opts/mc_opts        |   3 +-
 testcases/network/nfs/fsx-linux/fsx.sh             |   3 +-
 testcases/network/nfs/nfs_stress/nfs01             |   3 +-
 testcases/network/nfs/nfs_stress/nfs02             |   3 +-
 testcases/network/nfs/nfs_stress/nfs03             |   3 +-
 testcases/network/nfs/nfs_stress/nfs04             |   3 +-
 testcases/network/nfs/nfs_stress/nfs05             |   3 +-
 testcases/network/nfs/nfs_stress/nfs06             |   3 +-
 testcases/network/nfs/nfslock01/nfslock01          |   3 +-
 testcases/network/nfs/nfsstat01/nfsstat01          |   3 +-
 testcases/network/rpc/basic_tests/rpc01/rpc01      |   3 +-
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |   3 +-
 testcases/network/rpc/basic_tests/rup/rup01        |   3 +-
 testcases/network/rpc/basic_tests/rusers/rusers01  |   3 +-
 testcases/network/rpc/rpc-tirpc/rpc_test.sh        |   3 +-
 testcases/network/sctp/sctp01.sh                   |   3 +-
 testcases/network/sockets/bind_noport01.sh         |   3 +-
 .../network/stress/broken_ip/broken_ip4-checksum   |   3 +-
 .../network/stress/broken_ip/broken_ip4-dstaddr    |   3 +-
 .../network/stress/broken_ip/broken_ip4-fragment   |   3 +-
 testcases/network/stress/broken_ip/broken_ip4-ihl  |   3 +-
 .../network/stress/broken_ip/broken_ip4-protcol    |   3 +-
 .../network/stress/broken_ip/broken_ip4-totlen     |   3 +-
 .../network/stress/broken_ip/broken_ip4-version    |   3 +-
 .../network/stress/broken_ip/broken_ip6-dstaddr    |   3 +-
 .../network/stress/broken_ip/broken_ip6-nexthdr    |   3 +-
 testcases/network/stress/broken_ip/broken_ip6-plen |   3 +-
 .../network/stress/broken_ip/broken_ip6-version    |   3 +-
 testcases/network/stress/dns/dns-stress            |   3 +-
 testcases/network/stress/ftp/ftp-download-stress   |   3 +-
 testcases/network/stress/ftp/ftp-upload-stress     |   3 +-
 testcases/network/stress/http/http-stress          |   3 +-
 testcases/network/stress/interface/if4-addr-change |   3 +-
 testcases/network/stress/ipsec/ipsec_lib.sh        |   3 +-
 .../network/stress/ns-tools/test_net_stress.sh     |   5 +-
 testcases/network/stress/ssh/ssh-stress            |   3 +-
 testcases/network/tcp_cmds/arping/arping01.sh      |   3 +-
 .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   3 +-
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh    |   3 +-
 testcases/network/tcp_cmds/ping/ping01.sh          |   3 +-
 testcases/network/tcp_cmds/ping/ping02.sh          |   3 +-
 testcases/network/tcp_cmds/rlogin/rlogin01         |   3 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |   3 +-
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |   3 +-
 testcases/network/tcp_cmds/telnet/telnet01         |   3 +-
 .../network/tcp_cmds/tracepath/tracepath01.sh      |   3 +-
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   3 +-
 testcases/network/traceroute/traceroute01.sh       |   3 +-
 testcases/network/virt/geneve01.sh                 |   3 +-
 testcases/network/virt/gre01.sh                    |   3 +-
 testcases/network/virt/ipvlan01.sh                 |   3 +-
 testcases/network/virt/macvlan01.sh                |   3 +-
 testcases/network/virt/macvtap01.sh                |   3 +-
 testcases/network/virt/vlan01.sh                   |   3 +-
 testcases/network/virt/vlan02.sh                   |   3 +-
 testcases/network/virt/vlan03.sh                   |   3 +-
 testcases/network/virt/vxlan01.sh                  |   3 +-
 testcases/network/virt/vxlan02.sh                  |   3 +-
 testcases/network/virt/vxlan03.sh                  |   3 +-
 testcases/network/xinetd/xinetd_tests.sh           |   3 +-
 testscripts/network.sh                             |   6 +-
 75 files changed, 233 insertions(+), 128 deletions(-)
 rename testcases/lib/{test_net.sh => tst_net.sh} (87%)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/tst_net.sh
similarity index 87%
rename from testcases/lib/test_net.sh
rename to testcases/lib/tst_net.sh
index 203464f0d..b592391df 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 # Copyright (c) 2014-2017 Oracle and/or its affiliates. All Rights Reserved.
-# Copyright (c) 2016-2017 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2016-2018 Petr Vorel <pvorel@suse.cz>
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License as
@@ -19,12 +19,62 @@
 # Author: Alexey Kodanev <alexey.kodanev@oracle.com>
 #
 
-[ -z "$TST_LIB_LOADED" ] && . test.sh
+TST_OPTS=":6"
+TST_PARSE_ARGS=parse_args
+TST_USAGE=usage
+
+# Blank for an IPV4 test; 6 for an IPV6 test.
+TST_IPV6=
+
+parse_args()
+{
+	case $1 in
+	6) TST_IPV6=6;;
+	esac
+}
+
+tst_read_opts()
+{
+	local OPTIND
+	while getopts "$TST_OPTS" opt; do
+		$TST_PARSE_ARGS "$opt"
+	done
+}
+
+usage()
+{
+	cat << EOF
+usage: $0 [-6]
+
+OPTIONS
+-6     Use IPv6
+EOF
+}
+
+if [ -z "$TST_LIB_LOADED" ]; then
+	[ -n "$TST_USE_LEGACY_API" ] && . test.sh || . tst_test.sh
+fi
+
+[ -n "$TST_USE_LEGACY_API" ] && tst_read_opts $*
+
+# old vs. new API compatibility layer
+tst_res_()
+{
+	[ -z "$TST_USE_LEGACY_API" ] && tst_res $@ || tst_resm $@
+}
+tst_brk_()
+{
+	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
+}
+tst_require_root_()
+{
+	[ -z "$TST_USE_LEGACY_API" ] && TST_NEEDS_ROOT=1 || tst_require_root
+}
 
 init_ltp_netspace()
 {
 	tst_check_cmds ip
-	tst_require_root
+	tst_require_root_
 
 	local pid=
 
@@ -81,7 +131,7 @@ tst_rhost_run()
 		s) safe=1 ;;
 		c) cmd="$OPTARG" ;;
 		u) user="$OPTARG" ;;
-		*) tst_brkm TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
+		*) tst_brk_ TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
 		esac
 	done
 
@@ -89,8 +139,8 @@ tst_rhost_run()
 
 	if [ -z "$cmd" ]; then
 		[ "$safe" -eq 1 ] && \
-			tst_brkm TBROK "tst_rhost_run: command not defined"
-		tst_resm TWARN "tst_rhost_run: command not defined"
+			tst_brk_ TBROK "tst_rhost_run: command not defined"
+		tst_res_ TWARN "tst_rhost_run: command not defined"
 		return 1
 	fi
 
@@ -110,7 +160,7 @@ tst_rhost_run()
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
 		[ "$safe" -eq 1 ] && \
-			tst_brkm TBROK "'$cmd' failed on '$RHOST': '$output'"
+			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
 	fi
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"
@@ -122,9 +172,9 @@ EXPECT_RHOST_PASS()
 {
 	tst_rhost_run -c "$*" > /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TPASS "$* passed as expected"
+		tst_res_ TPASS "$* passed as expected"
 	else
-		tst_resm TFAIL "$* failed unexpectedly"
+		tst_res_ TFAIL "$* failed unexpectedly"
 	fi
 }
 
@@ -132,9 +182,9 @@ EXPECT_RHOST_FAIL()
 {
 	tst_rhost_run -c "$* 2> /dev/null"
 	if [ $? -ne 0 ]; then
-		tst_resm TPASS "$* failed as expected"
+		tst_res_ TPASS "$* failed as expected"
 	else
-		tst_resm TFAIL "$* passed unexpectedly"
+		tst_res_ TFAIL "$* passed unexpectedly"
 	fi
 }
 
@@ -200,23 +250,6 @@ tst_iface()
 	echo "$(tst_get_ifaces $type)" | awk '{ print $'"$link_num"' }'
 }
 
-# Blank for an IPV4 test; 6 for an IPV6 test.
-TST_IPV6=
-
-tst_read_opts()
-{
-	OPTIND=0
-	while getopts ":6" opt; do
-		case "$opt" in
-		6)
-			TST_IPV6=6;;
-		esac
-	done
-	OPTIND=0
-}
-
-tst_read_opts $*
-
 # Get IP address
 # tst_ipaddr [TYPE]
 # TYPE: { lhost | rhost }; Default value is 'lhost'.
@@ -302,7 +335,7 @@ tst_init_iface()
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
 	local iface="$(tst_iface $type $link_num)"
-	tst_resm TINFO "initialize '$type' '$iface' interface"
+	tst_res_ TINFO "initialize '$type' '$iface' interface"
 
 	if [ "$type" = "lhost" ]; then
 		ip xfrm policy flush || return $?
@@ -340,12 +373,12 @@ tst_add_ipaddr()
 	local iface=$(tst_iface $type $link_num)
 
 	if [ $type = "lhost" ]; then
-		tst_resm TINFO "set local addr $(tst_ipaddr)/$mask"
+		tst_res_ TINFO "set local addr $(tst_ipaddr)/$mask"
 		ip addr add $(tst_ipaddr)/$mask dev $iface
 		return $?
 	fi
 
-	tst_resm TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
+	tst_res_ TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
 	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface"
 }
 
@@ -356,7 +389,7 @@ tst_add_ipaddr()
 tst_restore_ipaddr()
 {
 	tst_check_cmds ip
-	tst_require_root
+	tst_require_root_
 
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
@@ -390,7 +423,7 @@ tst_wait_ipv6_dad()
 		[ $ret -ne 0 -a $? -ne 0 ] && return
 
 		[ $(($i % 10)) -eq 0 ] && \
-			tst_resm TINFO "wait for IPv6 DAD completion $((i / 10))/5 sec"
+			tst_res_ TINFO "wait for IPv6 DAD completion $((i / 10))/5 sec"
 
 		tst_sleep 100ms
 	done
@@ -443,7 +476,7 @@ tst_netload()
 		f) cs_opts="${cs_opts}-f " ;;
 		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
-		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
+		*) tst_brk_ TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
 	done
 	OPTIND=0
@@ -455,37 +488,37 @@ tst_netload()
 
 	tst_rhost_run -c "pkill -9 netstress\$"
 	s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
-	tst_resm TINFO "run server 'netstress $s_opts'"
+	tst_res_ TINFO "run server 'netstress $s_opts'"
 	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_netload.log
 		local ttype="TFAIL"
 		grep -e 'CONF:' tst_netload.log && ttype="TCONF"
-		tst_brkm $ttype "server failed"
+		tst_brk_ $ttype "server failed"
 	fi
 
 	local port=$(tst_rhost_run -s -c "cat $TST_TMPDIR/netstress_port")
 	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"
 
-	tst_resm TINFO "run client 'netstress -l $c_opts'"
+	tst_res_ TINFO "run client 'netstress -l $c_opts'"
 	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
 	tst_rhost_run -c "pkill -9 netstress\$"
 
 	if [ "$expect_ret" -ne "$ret" ]; then
 		tst_dump_rhost_cmd
 		cat tst_netload.log
-		tst_brkm TFAIL "expected '$expect_res' but ret: '$ret'"
+		tst_brk_ TFAIL "expected '$expect_res' but ret: '$ret'"
 	fi
 
 	if [ "$ret" -eq 0 ]; then
 		if [ ! -f $rfile ]; then
 			tst_dump_rhost_cmd
 			cat tst_netload.log
-			tst_brkm TFAIL "can't read $rfile"
+			tst_brk_ TFAIL "can't read $rfile"
 		fi
-		tst_resm TPASS "netstress passed, time spent '$(cat $rfile)' ms"
+		tst_res_ TPASS "netstress passed, time spent '$(cat $rfile)' ms"
 	else
-		tst_resm TPASS "netstress failed as expected"
+		tst_res_ TPASS "netstress failed as expected"
 	fi
 
 	return $ret
@@ -516,9 +549,9 @@ tst_ping()
 			-s $size -i 0 > /dev/null 2>&1
 		ret=$?
 		if [ $ret -eq 0 ]; then
-			tst_resm TPASS "$msg $size: pass"
+			tst_res_ TPASS "$msg $size: pass"
 		else
-			tst_resm TFAIL "$msg $size: fail"
+			tst_res_ TFAIL "$msg $size: fail"
 			break
 		fi
 	done
@@ -558,9 +591,9 @@ tst_icmp()
 		ns-icmpv${ver}_sender -s $size $opts
 		ret=$?
 		if [ $ret -eq 0 ]; then
-			tst_resm TPASS "'ns-icmpv${ver}_sender -s $size $opts' pass"
+			tst_res_ TPASS "'ns-icmpv${ver}_sender -s $size $opts' pass"
 		else
-			tst_resm TFAIL "'ns-icmpv${ver}_sender -s $size $opts' fail"
+			tst_res_ TFAIL "'ns-icmpv${ver}_sender -s $size $opts' fail"
 			break
 		fi
 	done
@@ -597,7 +630,7 @@ tst_cleanup_rhost()
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
 export PASSWD="${PASSWD:-}"
-# Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
+# Don't use it in new tests, use tst_rhost_run() from tst_net.sh instead.
 export LTP_RSH="${LTP_RSH:-rsh -n}"
 
 # Test Links
@@ -644,10 +677,10 @@ if [ -z "$TST_PARSE_VARIABLES" ]; then
 	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
 		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
 
-	tst_resm TINFO "Network config (local -- remote):"
-	tst_resm TINFO "$LHOST_IFACES -- $RHOST_IFACES"
-	tst_resm TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
-	tst_resm TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+	tst_res_ TINFO "Network config (local -- remote):"
+	tst_res_ TINFO "$LHOST_IFACES -- $RHOST_IFACES"
+	tst_res_ TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
+	tst_res_ TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
 	export TST_PARSE_VARIABLES="yes"
 fi
 
@@ -687,7 +720,7 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 # in the following document: testcases/network/stress/README
 
 if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
-	tst_tmpdir
+	[ -n "$TST_USE_LEGACY_API" ] && tst_tmpdir
 	tst_rhost_run -c "mkdir -p $TST_TMPDIR"
 	tst_rhost_run -c "chmod 777 $TST_TMPDIR"
 	export TST_TMPDIR_RHOST=1
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 48afb9cc4..78bd328a2 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -255,6 +255,7 @@ tst_run()
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
+			IPV6);;
 			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
 			esac
 		done
diff --git a/testcases/network/README.md b/testcases/network/README.md
index ebaab9956..3a9c98125 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -68,7 +68,7 @@ Testcases and network tools must be in PATH, e.g.:
 ```sh
 export PATH=/opt/ltp/testcases/bin:/usr/bin:$PATH
 ```
-Default values for all LTP network variables are set in testcases/lib/test_net.sh.
+Default values for all LTP network variables are set in testcases/lib/tst_net.sh.
 If you need to override some parameters please export them before test run or
 specify them when running ltp-pan or testscripts/network.sh.
 
@@ -79,7 +79,7 @@ To run the test type the following:
 TEST_VARS ./network.sh OPTIONS
 ```
 Where
-* TEST_VARS - non-default network parameters (see testcases/lib/test_net.sh), they
+* TEST_VARS - non-default network parameters (see testcases/lib/tst_net.sh), they
   could be exported before test run;
 * OPTIONS - test group(s), use '-h' to see available ones.
 
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 3c3035600..12d3cb5c7 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -21,7 +21,8 @@ TST_TOTAL=1
 TCID="busy_poll01"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . busy_poll_lib.sh
 
 cleanup()
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 427857996..4873dc342 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -21,7 +21,8 @@ TST_TOTAL=1
 TCID="busy_poll02"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . busy_poll_lib.sh
 
 cleanup()
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 6ccbbd921..01444653c 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -21,7 +21,8 @@ TST_TOTAL=2
 TCID="busy_poll03"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . busy_poll_lib.sh
 
 cleanup()
diff --git a/testcases/network/dccp/dccp01.sh b/testcases/network/dccp/dccp01.sh
index 4c32fb817..0b7894d64 100755
--- a/testcases/network/dccp/dccp01.sh
+++ b/testcases/network/dccp/dccp01.sh
@@ -21,7 +21,8 @@ TST_TOTAL=3
 TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 cleanup()
 {
diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
index a92e41b2e..92ac97d09 100755
--- a/testcases/network/dctcp/dctcp01.sh
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -23,7 +23,8 @@ TST_NEEDS_TMPDIR=1
 def_alg="cubic"
 prev_alg=
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 set_cong_alg()
 {
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index 0dc283090..332f9cec6 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -24,7 +24,8 @@ TST_TOTAL=1
 TCID="dhcpd"
 dhcp_name="dhcpd"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . dhcp_lib.sh
 
 setup_dhcpd_conf()
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index c11cb158b..2dc9fdb04 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -22,7 +22,8 @@ TST_TOTAL=1
 TCID="dnsmasq"
 dhcp_name="dnsmasq"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . dhcp_lib.sh
 
 start_dhcp()
diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index e6da18b58..065cbf439 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -24,7 +24,8 @@ TST_CLEANUP=cleanup
 TST_TOTAL=6
 TCID="ip_tests"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 rm_dummy=
 
diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 00e0166a5..00bbbeedf 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -29,7 +29,8 @@
 TCID=mc_cmds
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 knob="net.ipv4.icmp_echo_ignore_broadcasts"
 knob_changed=
diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index fdb2dcb63..203c22576 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -31,7 +31,8 @@ OUTFILE=mc_commo_out
 TCID=mc_commo
 TST_TOTAL=2
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/multicast/mc_member/mc_member b/testcases/network/multicast/mc_member/mc_member
index 2982976ea..721a60cab 100755
--- a/testcases/network/multicast/mc_member/mc_member
+++ b/testcases/network/multicast/mc_member/mc_member
@@ -33,7 +33,8 @@ TCID=mc_member
 TST_TOTAL=1
 TST_COUNT=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 setup()
 {
diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
index 6a38cde4f..28042ae0e 100755
--- a/testcases/network/multicast/mc_opts/mc_opts
+++ b/testcases/network/multicast/mc_opts/mc_opts
@@ -32,7 +32,8 @@ EXECUTABLES=${EXECUTABLES:-"mc_verify_opts mc_verify_opts_error"}
 TCID=mc_opts
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 COUNT=1
 while [ $COUNT -le 10 ]; do
diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index 9f2e43720..473ecb2da 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -26,7 +26,8 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_test()
 {
diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
index a2dfe68b8..93bf088b6 100755
--- a/testcases/network/nfs/nfs_stress/nfs01
+++ b/testcases/network/nfs/nfs_stress/nfs01
@@ -25,7 +25,8 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_test()
 {
diff --git a/testcases/network/nfs/nfs_stress/nfs02 b/testcases/network/nfs/nfs_stress/nfs02
index a73e9587e..74aa3d8ec 100755
--- a/testcases/network/nfs/nfs_stress/nfs02
+++ b/testcases/network/nfs/nfs_stress/nfs02
@@ -25,7 +25,8 @@ TST_TOTAL=3
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_test1()
 {
diff --git a/testcases/network/nfs/nfs_stress/nfs03 b/testcases/network/nfs/nfs_stress/nfs03
index e0d0d6e1a..3279a224c 100755
--- a/testcases/network/nfs/nfs_stress/nfs03
+++ b/testcases/network/nfs/nfs_stress/nfs03
@@ -25,7 +25,8 @@ TST_TOTAL=1
 TST_CLEANUP="nfs03_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 DIR_NUM=${DIR_NUM:-"100"}
 FILE_NUM=${FILE_NUM:-"100"}
diff --git a/testcases/network/nfs/nfs_stress/nfs04 b/testcases/network/nfs/nfs_stress/nfs04
index e2002279c..254c987f3 100755
--- a/testcases/network/nfs/nfs_stress/nfs04
+++ b/testcases/network/nfs/nfs_stress/nfs04
@@ -28,7 +28,8 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 nfs_setup
 
diff --git a/testcases/network/nfs/nfs_stress/nfs05 b/testcases/network/nfs/nfs_stress/nfs05
index af23e33f9..8c39cde04 100755
--- a/testcases/network/nfs/nfs_stress/nfs05
+++ b/testcases/network/nfs/nfs_stress/nfs05
@@ -29,7 +29,8 @@ FILE_NUM=${FILE_NUM:-"50"}
 THREAD_NUM=${THREAD_NUM:-"8"}
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_check_cmds make gcc
 
diff --git a/testcases/network/nfs/nfs_stress/nfs06 b/testcases/network/nfs/nfs_stress/nfs06
index eb351579d..be7c5424a 100755
--- a/testcases/network/nfs/nfs_stress/nfs06
+++ b/testcases/network/nfs/nfs_stress/nfs06
@@ -25,7 +25,8 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_test()
 {
diff --git a/testcases/network/nfs/nfslock01/nfslock01 b/testcases/network/nfs/nfslock01/nfslock01
index ab0424619..a545fa01c 100755
--- a/testcases/network/nfs/nfslock01/nfslock01
+++ b/testcases/network/nfs/nfslock01/nfslock01
@@ -26,7 +26,8 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 LUSER=${LUSER:=root}
 
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 256fe60de..afd239fa6 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -22,7 +22,8 @@ TST_TOTAL=4
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 setup()
 {
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index fd8915ac6..7cc69f0fa 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -19,7 +19,8 @@ TCID="rpc01"
 TST_TOTAL=6
 TST_CLEANUP=do_cleanup
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 NUMLOOPS=${NUMLOOPS:=3}
 DATAFILES=${DATAFILES:="file.1 file.2"}
diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01 b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
index 6fe3639ab..afdfdb351 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
@@ -19,7 +19,8 @@ TCID="rpcinfo01"
 TST_TOTAL=16
 TST_CLEANUP=tst_rmdir
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/rpc/basic_tests/rup/rup01 b/testcases/network/rpc/basic_tests/rup/rup01
index 2340dead6..44f0e73d2 100755
--- a/testcases/network/rpc/basic_tests/rup/rup01
+++ b/testcases/network/rpc/basic_tests/rup/rup01
@@ -18,7 +18,8 @@
 TCID="rup01"
 TST_TOTAL=7
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/rpc/basic_tests/rusers/rusers01 b/testcases/network/rpc/basic_tests/rusers/rusers01
index 9f20a8523..554bfa01c 100755
--- a/testcases/network/rpc/basic_tests/rusers/rusers01
+++ b/testcases/network/rpc/basic_tests/rusers/rusers01
@@ -18,7 +18,8 @@
 TCID="rusers01"
 TST_TOTAL=5
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 54ea4fdd5..88e383ed6 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -82,7 +82,8 @@ TST_TOTAL=1
 TST_COUNT=1
 TST_CLEANUP=cleanup
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 if [ ! -z "$SERVER" ]; then
 	$SERVER $PROGNUMNOSVC &
diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index d5c5f6d69..bf13521c2 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -21,7 +21,8 @@ TST_TOTAL=4
 TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 cleanup()
 {
diff --git a/testcases/network/sockets/bind_noport01.sh b/testcases/network/sockets/bind_noport01.sh
index 951712d53..dc4e621b9 100755
--- a/testcases/network/sockets/bind_noport01.sh
+++ b/testcases/network/sockets/bind_noport01.sh
@@ -18,7 +18,8 @@ TST_TOTAL=1
 TCID="bind_noport"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 cleanup()
 {
diff --git a/testcases/network/stress/broken_ip/broken_ip4-checksum b/testcases/network/stress/broken_ip/broken_ip4-checksum
index ff30fbf78..53c6868ba 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-checksum
+++ b/testcases/network/stress/broken_ip/broken_ip4-checksum
@@ -21,7 +21,8 @@
 TCID=broken_ip4-checksum01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong chksum field for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip4-dstaddr b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
index eb236f28b..b940d7661 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
@@ -21,7 +21,8 @@
 TCID=broken_ip4-dstaddr01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong dst address for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip4-fragment b/testcases/network/stress/broken_ip/broken_ip4-fragment
index 8f2aca925..e5d90b464 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-fragment
+++ b/testcases/network/stress/broken_ip/broken_ip4-fragment
@@ -21,7 +21,8 @@
 TCID=broken_ip4-fragment01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong frag. info for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip4-ihl b/testcases/network/stress/broken_ip/broken_ip4-ihl
index 2e136a579..de8324537 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-ihl
+++ b/testcases/network/stress/broken_ip/broken_ip4-ihl
@@ -21,7 +21,8 @@
 TCID=broken_ip4-ihl01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong header len field for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip4-protcol b/testcases/network/stress/broken_ip/broken_ip4-protcol
index a57ce6120..0fee79364 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-protcol
+++ b/testcases/network/stress/broken_ip/broken_ip4-protcol
@@ -21,7 +21,8 @@
 TCID=broken_ip4-protocol01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong proto field for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip4-totlen b/testcases/network/stress/broken_ip/broken_ip4-totlen
index 446648741..cd5f31177 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-totlen
+++ b/testcases/network/stress/broken_ip/broken_ip4-totlen
@@ -21,7 +21,8 @@
 TCID=broken_ip4-totlen01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong total len field for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip4-version b/testcases/network/stress/broken_ip/broken_ip4-version
index 83cf56881..a5e30b4b6 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-version
+++ b/testcases/network/stress/broken_ip/broken_ip4-version
@@ -21,7 +21,8 @@
 TCID=broken_ip4-version01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong version field for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip6-dstaddr b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
index ea7d66dea..69e993c2f 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
@@ -21,7 +21,8 @@
 TCID=broken_ip6-dstaddr01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv6 with wrong dst address for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip6-nexthdr b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
index ebbef5e91..2510fd235 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-nexthdr
+++ b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
@@ -21,7 +21,8 @@
 TCID=broken_ip6-nexthdr01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong next header for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip6-plen b/testcases/network/stress/broken_ip/broken_ip6-plen
index e93cdcc51..960902b3d 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-plen
+++ b/testcases/network/stress/broken_ip/broken_ip6-plen
@@ -21,7 +21,8 @@
 TCID=broken_ip6-plen01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong payload len for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/broken_ip/broken_ip6-version b/testcases/network/stress/broken_ip/broken_ip6-version
index 3eff2d703..b189ba1dd 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-version
+++ b/testcases/network/stress/broken_ip/broken_ip6-version
@@ -21,7 +21,8 @@
 TCID=broken_ip6-version01
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_resm TINFO "Sending ICMPv6 with wrong version field for $NS_DURATION sec"
 
diff --git a/testcases/network/stress/dns/dns-stress b/testcases/network/stress/dns/dns-stress
index 06b470915..c0c397d4e 100755
--- a/testcases/network/stress/dns/dns-stress
+++ b/testcases/network/stress/dns/dns-stress
@@ -22,7 +22,8 @@ TCID=dns-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 # Minimum host ID in the zone file.
 # The ID is used as the host portion of the address
diff --git a/testcases/network/stress/ftp/ftp-download-stress b/testcases/network/stress/ftp/ftp-download-stress
index e1f3a8c48..13ecbd067 100644
--- a/testcases/network/stress/ftp/ftp-download-stress
+++ b/testcases/network/stress/ftp/ftp-download-stress
@@ -23,7 +23,8 @@ TCID=ftp-download-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 # Big file size to upload/download in ftp tests (byte)
 DOWNLOAD_BIGFILESIZE=${DOWNLOAD_BIGFILESIZE:-2147483647}
diff --git a/testcases/network/stress/ftp/ftp-upload-stress b/testcases/network/stress/ftp/ftp-upload-stress
index c8c64be6a..402f50f65 100644
--- a/testcases/network/stress/ftp/ftp-upload-stress
+++ b/testcases/network/stress/ftp/ftp-upload-stress
@@ -23,7 +23,8 @@ TCID=ftp-upload-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 # Big file size to upload (byte)
 UPLOAD_BIGFILESIZE=${UPLOAD_BIGFILESIZE:-2147483647}  # 2GB - 1
diff --git a/testcases/network/stress/http/http-stress b/testcases/network/stress/http/http-stress
index db1823789..211cd90aa 100644
--- a/testcases/network/stress/http/http-stress
+++ b/testcases/network/stress/http/http-stress
@@ -23,7 +23,8 @@ TCID=http-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 cleanup()
 {
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 4eaabd70c..a452f3da5 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -21,7 +21,8 @@ TST_TOTAL=1
 TCID=if4-addr-change
 TST_CLEANUP="do_cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
 # Maximum host portion of the IPv4 address on the local host
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index cee755fe0..0fb122374 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -19,7 +19,8 @@
 #
 #######################################################################
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 # Authenticated encryption with associated data
 AEALGO="rfc4106_128"
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
index 3cf9e5f05..d71762972 100644
--- a/testcases/network/stress/ns-tools/test_net_stress.sh
+++ b/testcases/network/stress/ns-tools/test_net_stress.sh
@@ -21,11 +21,12 @@
 #
 # Library for all network/stress/ tests.
 # NOTE: More information about network variables can be found
-# in test_net.sh and testcases/network/stress/README.
+# in tst_net.sh and testcases/network/stress/README.
 
 export TCID="${TCID:-$(basename $0)}"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 ipver=${TST_IPV6:-4}
 
diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 3fdb5c2b8..00b47c27f 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -24,7 +24,8 @@ TCID=ssh-stress
 TST_TOTAL=3
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 # Temporary directory to store sshd setting or ssh key
 # Note: ssh doesn't work when those directory is under /tmp.
diff --git a/testcases/network/tcp_cmds/arping/arping01.sh b/testcases/network/tcp_cmds/arping/arping01.sh
index 66f161bc6..cc72f3ac1 100755
--- a/testcases/network/tcp_cmds/arping/arping01.sh
+++ b/testcases/network/tcp_cmds/arping/arping01.sh
@@ -18,7 +18,8 @@
 
 TCID=arping01
 TST_TOTAL=1
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_require_root
 tst_check_cmds arping
diff --git a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
index 627274c9a..219ff1d33 100755
--- a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
+++ b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
@@ -18,7 +18,8 @@
 
 TCID=clockdiff01
 TST_TOTAL=1
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 tst_require_root
 tst_check_cmds cut clockdiff
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index c35443d04..9af3aa31e 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -19,7 +19,8 @@
 TCID=ipneigh01
 NUMLOOPS=${NUMLOOPS:-50}
 TST_TOTAL=2
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
index 73f1180f5..01743ffcc 100755
--- a/testcases/network/tcp_cmds/ping/ping01.sh
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -28,7 +28,8 @@
 TST_TOTAL=10
 TCID="ping01"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index 6a9878e42..9696bf1ee 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -17,7 +17,8 @@
 TST_TOTAL=10
 TCID="ping02"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup()
 {
diff --git a/testcases/network/tcp_cmds/rlogin/rlogin01 b/testcases/network/tcp_cmds/rlogin/rlogin01
index 162b8f0d8..2ebc15d63 100755
--- a/testcases/network/tcp_cmds/rlogin/rlogin01
+++ b/testcases/network/tcp_cmds/rlogin/rlogin01
@@ -20,7 +20,8 @@
 TCID="rlogin01"
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 setup()
 {
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index 98e4f445b..b9af042ee 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -102,7 +102,8 @@ do_cleanup()
 	tst_rmdir
 }
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup
 do_test
diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 6ed8e25e3..1738e5197 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -64,7 +64,8 @@ do_cleanup()
 	tst_rmdir
 }
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 do_setup
 do_test
diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
index f2f2444a8..bdbcdc117 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01
+++ b/testcases/network/tcp_cmds/telnet/telnet01
@@ -20,7 +20,8 @@
 TCID="telnet01"
 TST_TOTAL=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 setup()
 {
diff --git a/testcases/network/tcp_cmds/tracepath/tracepath01.sh b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
index f1662f578..d0d202333 100755
--- a/testcases/network/tcp_cmds/tracepath/tracepath01.sh
+++ b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
@@ -18,7 +18,8 @@
 
 TCID=tracepath01
 TST_TOTAL=1
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 test_tracepath()
 {
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index e9094fc45..5bdb02ea8 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -23,7 +23,8 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 while getopts :hr:n:R:6 opt; do
 	case "$opt" in
diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 04759697a..057572086 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -19,7 +19,8 @@ TST_TOTAL=6
 TCID="traceroute01"
 TST_CLEANUP="cleanup"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 cleanup()
 {
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 1e723d84d..709201358 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -27,7 +27,8 @@ start_id=16700000
 # that is why using here 'vxlan_*' library functions.
 vxlan_dst_addr="uni"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 VIRT_PERF_THRESHOLD=${VIRT_PERF_THRESHOLD:-160}
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index bb2817d84..74ecb4898 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -24,7 +24,8 @@ TCID=gre01
 TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 virt_type="gre"
 [ "$TST_IPV6" ] && virt_type="ip6gre"
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index c20769316..b69444644 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -24,7 +24,8 @@ TST_TOTAL=2
 
 virt_type="ipvlan"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 options="mode l2,mode l3"
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index ffb7536c5..cf0462ec4 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -24,7 +24,8 @@ TST_TOTAL=4
 
 virt_type="macvlan"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 options="mode private,mode vepa,mode bridge,mode passthru"
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 5c54e99cd..e647f9009 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -24,7 +24,8 @@ TST_TOTAL=4
 
 virt_type="macvtap"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 options="mode private,mode vepa,mode bridge,mode passthru"
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 50cdfcbcc..890848fee 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -24,7 +24,8 @@ TST_TOTAL=9
 
 virt_type="vlan"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 p0="protocol 802.1Q"
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index b10596d43..4cb4856ba 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -25,7 +25,8 @@ TST_TOTAL=1
 
 virt_type="vlan"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 virt_add_delete_test "id 4094"
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 814cc4c6c..63a9d517d 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -29,7 +29,8 @@ TST_NEEDS_TMPDIR=1
 
 virt_type="vlan"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 TST_CLEANUP="virt_cleanup"
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 3042e6e38..8d96db257 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -25,7 +25,8 @@ TST_TOTAL=5
 virt_type="vxlan"
 start_id=16700000
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 options="l2miss l3miss,norsc nolearning noproxy,\
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 23c303f20..07cf656d7 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -26,7 +26,8 @@ TST_TOTAL=1
 virt_type="vxlan"
 start_id=16700000
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 [ "$TST_IPV6" ] && mult_addr="ff02::abc" || mult_addr="239.1.1.1"
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 5d1d00032..6d3792ab7 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -33,7 +33,8 @@ start_id=16700000
 # Destination address, can be unicast or multicast address
 vxlan_dst_addr="uni"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 . virt_lib.sh
 
 # In average cases (with small packets less then 150 bytes) VxLAN slower
diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index 8aa998875..e400ae7ba 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -20,7 +20,8 @@ TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
 . daemonlib.sh
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 setup()
 {
diff --git a/testscripts/network.sh b/testscripts/network.sh
index eb991b656..2f90020f1 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -88,12 +88,12 @@ fi
 TST_TOTAL=1
 TCID="network_settings"
 
-. test_net.sh
+TST_USE_LEGACY_API=1
+. tst_net.sh
 
 # Reset variables.
 # Don't break the tests which are using 'testcases/lib/cmdlib.sh'
-export TCID=
-export TST_LIB_LOADED=
+unset TCID TST_LIB_LOADED TST_USE_LEGACY_API
 
 rm -f $CMDFILE
 
-- 
2.16.2

