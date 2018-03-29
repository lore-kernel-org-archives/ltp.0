From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Mar 2018 01:31:32 +0200
Subject: [LTP] [RFC PATCH v2 1/3] test_net.sh: Support both old and new
	shell APIs
In-Reply-To: <20180329233134.24151-1-pvorel@suse.cz>
References: <20180329233134.24151-1-pvorel@suse.cz>
Message-ID: <20180329233134.24151-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is temporary solution, after migrating all tests to new SHELL API
the compatibility layer and old SHELL API support should be removed and
file renamed to tst_net.sh.

Add TST_USE_LEGACY_API=1 to all scripts using tst_net.sh (including
testscripts/network.sh).

Filter out TST_IPV6 variable in tst_test.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh                          | 133 +++++++++++++--------
 testcases/lib/tst_test.sh                          |   1 +
 testcases/network/busy_poll/busy_poll01.sh         |   1 +
 testcases/network/busy_poll/busy_poll02.sh         |   1 +
 testcases/network/busy_poll/busy_poll03.sh         |   1 +
 testcases/network/dccp/dccp01.sh                   |   1 +
 testcases/network/dctcp/dctcp01.sh                 |   1 +
 testcases/network/dhcp/dhcpd_tests.sh              |   1 +
 testcases/network/dhcp/dnsmasq_tests.sh            |   1 +
 testcases/network/iproute/ip_tests.sh              |   1 +
 testcases/network/multicast/mc_cmds/mc_cmds        |   1 +
 testcases/network/multicast/mc_commo/mc_commo      |   1 +
 testcases/network/multicast/mc_member/mc_member    |   1 +
 testcases/network/multicast/mc_opts/mc_opts        |   1 +
 testcases/network/nfs/fsx-linux/fsx.sh             |   1 +
 testcases/network/nfs/nfs_stress/nfs01             |   1 +
 testcases/network/nfs/nfs_stress/nfs02             |   1 +
 testcases/network/nfs/nfs_stress/nfs03             |   1 +
 testcases/network/nfs/nfs_stress/nfs04             |   1 +
 testcases/network/nfs/nfs_stress/nfs05             |   1 +
 testcases/network/nfs/nfs_stress/nfs06             |   1 +
 testcases/network/nfs/nfslock01/nfslock01          |   1 +
 testcases/network/nfs/nfsstat01/nfsstat01          |   1 +
 testcases/network/rpc/basic_tests/rpc01/rpc01      |   1 +
 .../network/rpc/basic_tests/rpcinfo/rpcinfo01      |   1 +
 testcases/network/rpc/basic_tests/rup/rup01        |   1 +
 testcases/network/rpc/basic_tests/rusers/rusers01  |   1 +
 testcases/network/rpc/rpc-tirpc/rpc_test.sh        |   1 +
 testcases/network/sctp/sctp01.sh                   |   1 +
 testcases/network/sockets/bind_noport01.sh         |   1 +
 .../network/stress/broken_ip/broken_ip4-checksum   |   1 +
 .../network/stress/broken_ip/broken_ip4-dstaddr    |   1 +
 .../network/stress/broken_ip/broken_ip4-fragment   |   1 +
 testcases/network/stress/broken_ip/broken_ip4-ihl  |   1 +
 .../network/stress/broken_ip/broken_ip4-protcol    |   1 +
 .../network/stress/broken_ip/broken_ip4-totlen     |   1 +
 .../network/stress/broken_ip/broken_ip4-version    |   1 +
 .../network/stress/broken_ip/broken_ip6-dstaddr    |   1 +
 .../network/stress/broken_ip/broken_ip6-nexthdr    |   1 +
 testcases/network/stress/broken_ip/broken_ip6-plen |   1 +
 .../network/stress/broken_ip/broken_ip6-version    |   1 +
 testcases/network/stress/dns/dns-stress            |   1 +
 testcases/network/stress/ftp/ftp-download-stress   |   1 +
 testcases/network/stress/ftp/ftp-upload-stress     |   1 +
 testcases/network/stress/http/http-stress          |   1 +
 testcases/network/stress/interface/if4-addr-change |   1 +
 testcases/network/stress/ipsec/ipsec_lib.sh        |   1 +
 .../network/stress/ns-tools/test_net_stress.sh     |   1 +
 testcases/network/stress/ssh/ssh-stress            |   1 +
 testcases/network/tcp_cmds/arping/arping01.sh      |   1 +
 .../network/tcp_cmds/clockdiff/clockdiff01.sh      |   1 +
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh    |   1 +
 testcases/network/tcp_cmds/ping/ping01.sh          |   1 +
 testcases/network/tcp_cmds/ping/ping02.sh          |   1 +
 testcases/network/tcp_cmds/rlogin/rlogin01         |   1 +
 testcases/network/tcp_cmds/sendfile/sendfile01     |   1 +
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |   1 +
 testcases/network/tcp_cmds/telnet/telnet01         |   1 +
 .../network/tcp_cmds/tracepath/tracepath01.sh      |   1 +
 testcases/network/tcp_fastopen/tcp_fastopen_run.sh |   1 +
 testcases/network/traceroute/traceroute01.sh       |   1 +
 testcases/network/virt/geneve01.sh                 |   1 +
 testcases/network/virt/gre01.sh                    |   1 +
 testcases/network/virt/ipvlan01.sh                 |   1 +
 testcases/network/virt/macvlan01.sh                |   1 +
 testcases/network/virt/macvtap01.sh                |   1 +
 testcases/network/virt/vlan01.sh                   |   1 +
 testcases/network/virt/vlan02.sh                   |   1 +
 testcases/network/virt/vlan03.sh                   |   1 +
 testcases/network/virt/vxlan01.sh                  |   1 +
 testcases/network/virt/vxlan02.sh                  |   1 +
 testcases/network/virt/vxlan03.sh                  |   1 +
 testcases/network/xinetd/xinetd_tests.sh           |   1 +
 testscripts/network.sh                             |   4 +-
 74 files changed, 157 insertions(+), 52 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 203464f0d..f95fe27e7 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
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
+_tst_res()
+{
+	[ -z "$TST_USE_LEGACY_API" ] && tst_res $@ || tst_resm $@
+}
+_tst_brk()
+{
+	[ -z "$TST_USE_LEGACY_API" ] && tst_brk $@ || tst_brkm $@
+}
+_tst_require_root()
+{
+	[ -z "$TST_USE_LEGACY_API" ] && TST_NEEDS_ROOT=1 || tst_require_root
+}
 
 init_ltp_netspace()
 {
 	tst_check_cmds ip
-	tst_require_root
+	_tst_require_root
 
 	local pid=
 
@@ -81,7 +131,7 @@ tst_rhost_run()
 		s) safe=1 ;;
 		c) cmd="$OPTARG" ;;
 		u) user="$OPTARG" ;;
-		*) tst_brkm TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
+		*) _tst_brk TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
 		esac
 	done
 
@@ -89,8 +139,8 @@ tst_rhost_run()
 
 	if [ -z "$cmd" ]; then
 		[ "$safe" -eq 1 ] && \
-			tst_brkm TBROK "tst_rhost_run: command not defined"
-		tst_resm TWARN "tst_rhost_run: command not defined"
+			_tst_brk TBROK "tst_rhost_run: command not defined"
+		_tst_res TWARN "tst_rhost_run: command not defined"
 		return 1
 	fi
 
@@ -110,7 +160,7 @@ tst_rhost_run()
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
 		[ "$safe" -eq 1 ] && \
-			tst_brkm TBROK "'$cmd' failed on '$RHOST': '$output'"
+			_tst_brk TBROK "'$cmd' failed on '$RHOST': '$output'"
 	fi
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"
@@ -122,9 +172,9 @@ EXPECT_RHOST_PASS()
 {
 	tst_rhost_run -c "$*" > /dev/null
 	if [ $? -eq 0 ]; then
-		tst_resm TPASS "$* passed as expected"
+		_tst_res TPASS "$* passed as expected"
 	else
-		tst_resm TFAIL "$* failed unexpectedly"
+		_tst_res TFAIL "$* failed unexpectedly"
 	fi
 }
 
@@ -132,9 +182,9 @@ EXPECT_RHOST_FAIL()
 {
 	tst_rhost_run -c "$* 2> /dev/null"
 	if [ $? -ne 0 ]; then
-		tst_resm TPASS "$* failed as expected"
+		_tst_res TPASS "$* failed as expected"
 	else
-		tst_resm TFAIL "$* passed unexpectedly"
+		_tst_res TFAIL "$* passed unexpectedly"
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
+	_tst_res TINFO "initialize '$type' '$iface' interface"
 
 	if [ "$type" = "lhost" ]; then
 		ip xfrm policy flush || return $?
@@ -340,12 +373,12 @@ tst_add_ipaddr()
 	local iface=$(tst_iface $type $link_num)
 
 	if [ $type = "lhost" ]; then
-		tst_resm TINFO "set local addr $(tst_ipaddr)/$mask"
+		_tst_res TINFO "set local addr $(tst_ipaddr)/$mask"
 		ip addr add $(tst_ipaddr)/$mask dev $iface
 		return $?
 	fi
 
-	tst_resm TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
+	_tst_res TINFO "set remote addr $(tst_ipaddr rhost)/$mask"
 	tst_rhost_run -c "ip addr add $(tst_ipaddr rhost)/$mask dev $iface"
 }
 
@@ -356,7 +389,7 @@ tst_add_ipaddr()
 tst_restore_ipaddr()
 {
 	tst_check_cmds ip
-	tst_require_root
+	_tst_require_root
 
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
@@ -390,7 +423,7 @@ tst_wait_ipv6_dad()
 		[ $ret -ne 0 -a $? -ne 0 ] && return
 
 		[ $(($i % 10)) -eq 0 ] && \
-			tst_resm TINFO "wait for IPv6 DAD completion $((i / 10))/5 sec"
+			_tst_res TINFO "wait for IPv6 DAD completion $((i / 10))/5 sec"
 
 		tst_sleep 100ms
 	done
@@ -443,7 +476,7 @@ tst_netload()
 		f) cs_opts="${cs_opts}-f " ;;
 		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
-		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
+		*) _tst_brk TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
 	done
 	OPTIND=0
@@ -455,37 +488,37 @@ tst_netload()
 
 	tst_rhost_run -c "pkill -9 netstress\$"
 	s_opts="${cs_opts}${s_opts}-R $s_replies -B $TST_TMPDIR"
-	tst_resm TINFO "run server 'netstress $s_opts'"
+	_tst_res TINFO "run server 'netstress $s_opts'"
 	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_netload.log
 		local ttype="TFAIL"
 		grep -e 'CONF:' tst_netload.log && ttype="TCONF"
-		tst_brkm $ttype "server failed"
+		_tst_brk $ttype "server failed"
 	fi
 
 	local port=$(tst_rhost_run -s -c "cat $TST_TMPDIR/netstress_port")
 	c_opts="${cs_opts}${c_opts}-a $c_num -r $c_requests -d $rfile -g $port"
 
-	tst_resm TINFO "run client 'netstress -l $c_opts'"
+	_tst_res TINFO "run client 'netstress -l $c_opts'"
 	netstress -l $c_opts > tst_netload.log 2>&1 || ret=1
 	tst_rhost_run -c "pkill -9 netstress\$"
 
 	if [ "$expect_ret" -ne "$ret" ]; then
 		tst_dump_rhost_cmd
 		cat tst_netload.log
-		tst_brkm TFAIL "expected '$expect_res' but ret: '$ret'"
+		_tst_brk TFAIL "expected '$expect_res' but ret: '$ret'"
 	fi
 
 	if [ "$ret" -eq 0 ]; then
 		if [ ! -f $rfile ]; then
 			tst_dump_rhost_cmd
 			cat tst_netload.log
-			tst_brkm TFAIL "can't read $rfile"
+			_tst_brk TFAIL "can't read $rfile"
 		fi
-		tst_resm TPASS "netstress passed, time spent '$(cat $rfile)' ms"
+		_tst_res TPASS "netstress passed, time spent '$(cat $rfile)' ms"
 	else
-		tst_resm TPASS "netstress failed as expected"
+		_tst_res TPASS "netstress failed as expected"
 	fi
 
 	return $ret
@@ -516,9 +549,9 @@ tst_ping()
 			-s $size -i 0 > /dev/null 2>&1
 		ret=$?
 		if [ $ret -eq 0 ]; then
-			tst_resm TPASS "$msg $size: pass"
+			_tst_res TPASS "$msg $size: pass"
 		else
-			tst_resm TFAIL "$msg $size: fail"
+			_tst_res TFAIL "$msg $size: fail"
 			break
 		fi
 	done
@@ -558,9 +591,9 @@ tst_icmp()
 		ns-icmpv${ver}_sender -s $size $opts
 		ret=$?
 		if [ $ret -eq 0 ]; then
-			tst_resm TPASS "'ns-icmpv${ver}_sender -s $size $opts' pass"
+			_tst_res TPASS "'ns-icmpv${ver}_sender -s $size $opts' pass"
 		else
-			tst_resm TFAIL "'ns-icmpv${ver}_sender -s $size $opts' fail"
+			_tst_res TFAIL "'ns-icmpv${ver}_sender -s $size $opts' fail"
 			break
 		fi
 	done
@@ -644,10 +677,10 @@ if [ -z "$TST_PARSE_VARIABLES" ]; then
 	eval $(tst_net_vars $IPV6_LHOST/$IPV6_LPREFIX \
 		$IPV6_RHOST/$IPV6_RPREFIX || echo "exit $?")
 
-	tst_resm TINFO "Network config (local -- remote):"
-	tst_resm TINFO "$LHOST_IFACES -- $RHOST_IFACES"
-	tst_resm TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
-	tst_resm TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
+	_tst_res TINFO "Network config (local -- remote):"
+	_tst_res TINFO "$LHOST_IFACES -- $RHOST_IFACES"
+	_tst_res TINFO "$IPV4_LHOST/$IPV4_LPREFIX -- $IPV4_RHOST/$IPV4_RPREFIX"
+	_tst_res TINFO "$IPV6_LHOST/$IPV6_LPREFIX -- $IPV6_RHOST/$IPV6_RPREFIX"
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
diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 3c3035600..11b20cc0e 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -21,6 +21,7 @@ TST_TOTAL=1
 TCID="busy_poll01"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . busy_poll_lib.sh
 
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 427857996..82624ee75 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -21,6 +21,7 @@ TST_TOTAL=1
 TCID="busy_poll02"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . busy_poll_lib.sh
 
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 6ccbbd921..fe0cf2372 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -21,6 +21,7 @@ TST_TOTAL=2
 TCID="busy_poll03"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . busy_poll_lib.sh
 
diff --git a/testcases/network/dccp/dccp01.sh b/testcases/network/dccp/dccp01.sh
index 4c32fb817..616ff2e5e 100755
--- a/testcases/network/dccp/dccp01.sh
+++ b/testcases/network/dccp/dccp01.sh
@@ -21,6 +21,7 @@ TST_TOTAL=3
 TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 cleanup()
diff --git a/testcases/network/dctcp/dctcp01.sh b/testcases/network/dctcp/dctcp01.sh
index a92e41b2e..70a29aa60 100755
--- a/testcases/network/dctcp/dctcp01.sh
+++ b/testcases/network/dctcp/dctcp01.sh
@@ -23,6 +23,7 @@ TST_NEEDS_TMPDIR=1
 def_alg="cubic"
 prev_alg=
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 set_cong_alg()
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index 0dc283090..e62e77dc4 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -24,6 +24,7 @@ TST_TOTAL=1
 TCID="dhcpd"
 dhcp_name="dhcpd"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . dhcp_lib.sh
 
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index c11cb158b..77ac808db 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -22,6 +22,7 @@ TST_TOTAL=1
 TCID="dnsmasq"
 dhcp_name="dnsmasq"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . dhcp_lib.sh
 
diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index e6da18b58..1ad3b91a1 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -24,6 +24,7 @@ TST_CLEANUP=cleanup
 TST_TOTAL=6
 TCID="ip_tests"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 rm_dummy=
diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 00e0166a5..0546366fa 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -29,6 +29,7 @@
 TCID=mc_cmds
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 knob="net.ipv4.icmp_echo_ignore_broadcasts"
diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index fdb2dcb63..b3a48551b 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -31,6 +31,7 @@ OUTFILE=mc_commo_out
 TCID=mc_commo
 TST_TOTAL=2
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/multicast/mc_member/mc_member b/testcases/network/multicast/mc_member/mc_member
index 2982976ea..c326e5327 100755
--- a/testcases/network/multicast/mc_member/mc_member
+++ b/testcases/network/multicast/mc_member/mc_member
@@ -33,6 +33,7 @@ TCID=mc_member
 TST_TOTAL=1
 TST_COUNT=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 setup()
diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
index 6a38cde4f..6f51119a0 100755
--- a/testcases/network/multicast/mc_opts/mc_opts
+++ b/testcases/network/multicast/mc_opts/mc_opts
@@ -32,6 +32,7 @@ EXECUTABLES=${EXECUTABLES:-"mc_verify_opts mc_verify_opts_error"}
 TCID=mc_opts
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 COUNT=1
diff --git a/testcases/network/nfs/fsx-linux/fsx.sh b/testcases/network/nfs/fsx-linux/fsx.sh
index 9f2e43720..c85adb159 100755
--- a/testcases/network/nfs/fsx-linux/fsx.sh
+++ b/testcases/network/nfs/fsx-linux/fsx.sh
@@ -26,6 +26,7 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_test()
diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
index a2dfe68b8..76c1f84e0 100755
--- a/testcases/network/nfs/nfs_stress/nfs01
+++ b/testcases/network/nfs/nfs_stress/nfs01
@@ -25,6 +25,7 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_test()
diff --git a/testcases/network/nfs/nfs_stress/nfs02 b/testcases/network/nfs/nfs_stress/nfs02
index a73e9587e..1877dc4fd 100755
--- a/testcases/network/nfs/nfs_stress/nfs02
+++ b/testcases/network/nfs/nfs_stress/nfs02
@@ -25,6 +25,7 @@ TST_TOTAL=3
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_test1()
diff --git a/testcases/network/nfs/nfs_stress/nfs03 b/testcases/network/nfs/nfs_stress/nfs03
index e0d0d6e1a..634674957 100755
--- a/testcases/network/nfs/nfs_stress/nfs03
+++ b/testcases/network/nfs/nfs_stress/nfs03
@@ -25,6 +25,7 @@ TST_TOTAL=1
 TST_CLEANUP="nfs03_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 DIR_NUM=${DIR_NUM:-"100"}
diff --git a/testcases/network/nfs/nfs_stress/nfs04 b/testcases/network/nfs/nfs_stress/nfs04
index e2002279c..0ad7a431b 100755
--- a/testcases/network/nfs/nfs_stress/nfs04
+++ b/testcases/network/nfs/nfs_stress/nfs04
@@ -28,6 +28,7 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 nfs_setup
diff --git a/testcases/network/nfs/nfs_stress/nfs05 b/testcases/network/nfs/nfs_stress/nfs05
index af23e33f9..d8887bb7c 100755
--- a/testcases/network/nfs/nfs_stress/nfs05
+++ b/testcases/network/nfs/nfs_stress/nfs05
@@ -29,6 +29,7 @@ FILE_NUM=${FILE_NUM:-"50"}
 THREAD_NUM=${THREAD_NUM:-"8"}
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_check_cmds make gcc
diff --git a/testcases/network/nfs/nfs_stress/nfs06 b/testcases/network/nfs/nfs_stress/nfs06
index eb351579d..67ba91a32 100755
--- a/testcases/network/nfs/nfs_stress/nfs06
+++ b/testcases/network/nfs/nfs_stress/nfs06
@@ -25,6 +25,7 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_test()
diff --git a/testcases/network/nfs/nfslock01/nfslock01 b/testcases/network/nfs/nfslock01/nfslock01
index ab0424619..a4fc92b1c 100755
--- a/testcases/network/nfs/nfslock01/nfslock01
+++ b/testcases/network/nfs/nfslock01/nfslock01
@@ -26,6 +26,7 @@ TST_TOTAL=1
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 LUSER=${LUSER:=root}
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 256fe60de..5c46db63b 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -22,6 +22,7 @@ TST_TOTAL=4
 TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 setup()
diff --git a/testcases/network/rpc/basic_tests/rpc01/rpc01 b/testcases/network/rpc/basic_tests/rpc01/rpc01
index fd8915ac6..8d2322543 100755
--- a/testcases/network/rpc/basic_tests/rpc01/rpc01
+++ b/testcases/network/rpc/basic_tests/rpc01/rpc01
@@ -19,6 +19,7 @@ TCID="rpc01"
 TST_TOTAL=6
 TST_CLEANUP=do_cleanup
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 NUMLOOPS=${NUMLOOPS:=3}
diff --git a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01 b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
index 6fe3639ab..00ed0f3be 100755
--- a/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
+++ b/testcases/network/rpc/basic_tests/rpcinfo/rpcinfo01
@@ -19,6 +19,7 @@ TCID="rpcinfo01"
 TST_TOTAL=16
 TST_CLEANUP=tst_rmdir
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/rpc/basic_tests/rup/rup01 b/testcases/network/rpc/basic_tests/rup/rup01
index 2340dead6..65dda02ae 100755
--- a/testcases/network/rpc/basic_tests/rup/rup01
+++ b/testcases/network/rpc/basic_tests/rup/rup01
@@ -18,6 +18,7 @@
 TCID="rup01"
 TST_TOTAL=7
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/rpc/basic_tests/rusers/rusers01 b/testcases/network/rpc/basic_tests/rusers/rusers01
index 9f20a8523..a0267a23a 100755
--- a/testcases/network/rpc/basic_tests/rusers/rusers01
+++ b/testcases/network/rpc/basic_tests/rusers/rusers01
@@ -18,6 +18,7 @@
 TCID="rusers01"
 TST_TOTAL=5
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/rpc/rpc-tirpc/rpc_test.sh b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
index 54ea4fdd5..66c054e40 100755
--- a/testcases/network/rpc/rpc-tirpc/rpc_test.sh
+++ b/testcases/network/rpc/rpc-tirpc/rpc_test.sh
@@ -82,6 +82,7 @@ TST_TOTAL=1
 TST_COUNT=1
 TST_CLEANUP=cleanup
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 if [ ! -z "$SERVER" ]; then
diff --git a/testcases/network/sctp/sctp01.sh b/testcases/network/sctp/sctp01.sh
index d5c5f6d69..8f612f95c 100755
--- a/testcases/network/sctp/sctp01.sh
+++ b/testcases/network/sctp/sctp01.sh
@@ -21,6 +21,7 @@ TST_TOTAL=4
 TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 cleanup()
diff --git a/testcases/network/sockets/bind_noport01.sh b/testcases/network/sockets/bind_noport01.sh
index 951712d53..6199c34ca 100755
--- a/testcases/network/sockets/bind_noport01.sh
+++ b/testcases/network/sockets/bind_noport01.sh
@@ -18,6 +18,7 @@ TST_TOTAL=1
 TCID="bind_noport"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 cleanup()
diff --git a/testcases/network/stress/broken_ip/broken_ip4-checksum b/testcases/network/stress/broken_ip/broken_ip4-checksum
index ff30fbf78..c0da0de0f 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-checksum
+++ b/testcases/network/stress/broken_ip/broken_ip4-checksum
@@ -21,6 +21,7 @@
 TCID=broken_ip4-checksum01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong chksum field for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip4-dstaddr b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
index eb236f28b..638a7525f 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip4-dstaddr
@@ -21,6 +21,7 @@
 TCID=broken_ip4-dstaddr01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong dst address for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip4-fragment b/testcases/network/stress/broken_ip/broken_ip4-fragment
index 8f2aca925..4cfa7a343 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-fragment
+++ b/testcases/network/stress/broken_ip/broken_ip4-fragment
@@ -21,6 +21,7 @@
 TCID=broken_ip4-fragment01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong frag. info for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip4-ihl b/testcases/network/stress/broken_ip/broken_ip4-ihl
index 2e136a579..809563d82 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-ihl
+++ b/testcases/network/stress/broken_ip/broken_ip4-ihl
@@ -21,6 +21,7 @@
 TCID=broken_ip4-ihl01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong header len field for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip4-protcol b/testcases/network/stress/broken_ip/broken_ip4-protcol
index a57ce6120..900ac4415 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-protcol
+++ b/testcases/network/stress/broken_ip/broken_ip4-protcol
@@ -21,6 +21,7 @@
 TCID=broken_ip4-protocol01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong proto field for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip4-totlen b/testcases/network/stress/broken_ip/broken_ip4-totlen
index 446648741..651858934 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-totlen
+++ b/testcases/network/stress/broken_ip/broken_ip4-totlen
@@ -21,6 +21,7 @@
 TCID=broken_ip4-totlen01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong total len field for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip4-version b/testcases/network/stress/broken_ip/broken_ip4-version
index 83cf56881..616e69b24 100644
--- a/testcases/network/stress/broken_ip/broken_ip4-version
+++ b/testcases/network/stress/broken_ip/broken_ip4-version
@@ -21,6 +21,7 @@
 TCID=broken_ip4-version01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong version field for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip6-dstaddr b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
index ea7d66dea..7dda2c014 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-dstaddr
+++ b/testcases/network/stress/broken_ip/broken_ip6-dstaddr
@@ -21,6 +21,7 @@
 TCID=broken_ip6-dstaddr01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv6 with wrong dst address for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip6-nexthdr b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
index ebbef5e91..077f40053 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-nexthdr
+++ b/testcases/network/stress/broken_ip/broken_ip6-nexthdr
@@ -21,6 +21,7 @@
 TCID=broken_ip6-nexthdr01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong next header for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip6-plen b/testcases/network/stress/broken_ip/broken_ip6-plen
index e93cdcc51..6b8fd58f7 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-plen
+++ b/testcases/network/stress/broken_ip/broken_ip6-plen
@@ -21,6 +21,7 @@
 TCID=broken_ip6-plen01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv4 with wrong payload len for $NS_DURATION sec"
diff --git a/testcases/network/stress/broken_ip/broken_ip6-version b/testcases/network/stress/broken_ip/broken_ip6-version
index 3eff2d703..53915d6e9 100644
--- a/testcases/network/stress/broken_ip/broken_ip6-version
+++ b/testcases/network/stress/broken_ip/broken_ip6-version
@@ -21,6 +21,7 @@
 TCID=broken_ip6-version01
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_resm TINFO "Sending ICMPv6 with wrong version field for $NS_DURATION sec"
diff --git a/testcases/network/stress/dns/dns-stress b/testcases/network/stress/dns/dns-stress
index 06b470915..73c67878d 100755
--- a/testcases/network/stress/dns/dns-stress
+++ b/testcases/network/stress/dns/dns-stress
@@ -22,6 +22,7 @@ TCID=dns-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 # Minimum host ID in the zone file.
diff --git a/testcases/network/stress/ftp/ftp-download-stress b/testcases/network/stress/ftp/ftp-download-stress
index e1f3a8c48..1cabdc2aa 100644
--- a/testcases/network/stress/ftp/ftp-download-stress
+++ b/testcases/network/stress/ftp/ftp-download-stress
@@ -23,6 +23,7 @@ TCID=ftp-download-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 # Big file size to upload/download in ftp tests (byte)
diff --git a/testcases/network/stress/ftp/ftp-upload-stress b/testcases/network/stress/ftp/ftp-upload-stress
index c8c64be6a..9bdc2816c 100644
--- a/testcases/network/stress/ftp/ftp-upload-stress
+++ b/testcases/network/stress/ftp/ftp-upload-stress
@@ -23,6 +23,7 @@ TCID=ftp-upload-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 # Big file size to upload (byte)
diff --git a/testcases/network/stress/http/http-stress b/testcases/network/stress/http/http-stress
index db1823789..6f1d0cd1b 100644
--- a/testcases/network/stress/http/http-stress
+++ b/testcases/network/stress/http/http-stress
@@ -23,6 +23,7 @@ TCID=http-stress
 TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 cleanup()
diff --git a/testcases/network/stress/interface/if4-addr-change b/testcases/network/stress/interface/if4-addr-change
index 4eaabd70c..dbb3d3356 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -21,6 +21,7 @@ TST_TOTAL=1
 TCID=if4-addr-change
 TST_CLEANUP="do_cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index cee755fe0..72dc3a65e 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -19,6 +19,7 @@
 #
 #######################################################################
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 # Authenticated encryption with associated data
diff --git a/testcases/network/stress/ns-tools/test_net_stress.sh b/testcases/network/stress/ns-tools/test_net_stress.sh
index 3cf9e5f05..576d4fc1e 100644
--- a/testcases/network/stress/ns-tools/test_net_stress.sh
+++ b/testcases/network/stress/ns-tools/test_net_stress.sh
@@ -25,6 +25,7 @@
 
 export TCID="${TCID:-$(basename $0)}"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 ipver=${TST_IPV6:-4}
diff --git a/testcases/network/stress/ssh/ssh-stress b/testcases/network/stress/ssh/ssh-stress
index 3fdb5c2b8..0f2c2d2ea 100644
--- a/testcases/network/stress/ssh/ssh-stress
+++ b/testcases/network/stress/ssh/ssh-stress
@@ -24,6 +24,7 @@ TCID=ssh-stress
 TST_TOTAL=3
 TST_CLEANUP="cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 # Temporary directory to store sshd setting or ssh key
diff --git a/testcases/network/tcp_cmds/arping/arping01.sh b/testcases/network/tcp_cmds/arping/arping01.sh
index 66f161bc6..d4141defb 100755
--- a/testcases/network/tcp_cmds/arping/arping01.sh
+++ b/testcases/network/tcp_cmds/arping/arping01.sh
@@ -18,6 +18,7 @@
 
 TCID=arping01
 TST_TOTAL=1
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_require_root
diff --git a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
index 627274c9a..f5055d8f1 100755
--- a/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
+++ b/testcases/network/tcp_cmds/clockdiff/clockdiff01.sh
@@ -18,6 +18,7 @@
 
 TCID=clockdiff01
 TST_TOTAL=1
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 tst_require_root
diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index c35443d04..35a3d231f 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -19,6 +19,7 @@
 TCID=ipneigh01
 NUMLOOPS=${NUMLOOPS:-50}
 TST_TOTAL=2
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
index 73f1180f5..a912aab52 100755
--- a/testcases/network/tcp_cmds/ping/ping01.sh
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -28,6 +28,7 @@
 TST_TOTAL=10
 TCID="ping01"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/tcp_cmds/ping/ping02.sh b/testcases/network/tcp_cmds/ping/ping02.sh
index 6a9878e42..2abd3cfe1 100755
--- a/testcases/network/tcp_cmds/ping/ping02.sh
+++ b/testcases/network/tcp_cmds/ping/ping02.sh
@@ -17,6 +17,7 @@
 TST_TOTAL=10
 TCID="ping02"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup()
diff --git a/testcases/network/tcp_cmds/rlogin/rlogin01 b/testcases/network/tcp_cmds/rlogin/rlogin01
index 162b8f0d8..03db88c8b 100755
--- a/testcases/network/tcp_cmds/rlogin/rlogin01
+++ b/testcases/network/tcp_cmds/rlogin/rlogin01
@@ -20,6 +20,7 @@
 TCID="rlogin01"
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 setup()
diff --git a/testcases/network/tcp_cmds/sendfile/sendfile01 b/testcases/network/tcp_cmds/sendfile/sendfile01
index 98e4f445b..017102f0e 100755
--- a/testcases/network/tcp_cmds/sendfile/sendfile01
+++ b/testcases/network/tcp_cmds/sendfile/sendfile01
@@ -102,6 +102,7 @@ do_cleanup()
 	tst_rmdir
 }
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup
diff --git a/testcases/network/tcp_cmds/tcpdump/tcpdump01 b/testcases/network/tcp_cmds/tcpdump/tcpdump01
index 6ed8e25e3..e0788f089 100755
--- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
+++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
@@ -64,6 +64,7 @@ do_cleanup()
 	tst_rmdir
 }
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 do_setup
diff --git a/testcases/network/tcp_cmds/telnet/telnet01 b/testcases/network/tcp_cmds/telnet/telnet01
index f2f2444a8..b5aa5f0e2 100755
--- a/testcases/network/tcp_cmds/telnet/telnet01
+++ b/testcases/network/tcp_cmds/telnet/telnet01
@@ -20,6 +20,7 @@
 TCID="telnet01"
 TST_TOTAL=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 setup()
diff --git a/testcases/network/tcp_cmds/tracepath/tracepath01.sh b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
index f1662f578..b29dc4832 100755
--- a/testcases/network/tcp_cmds/tracepath/tracepath01.sh
+++ b/testcases/network/tcp_cmds/tracepath/tracepath01.sh
@@ -18,6 +18,7 @@
 
 TCID=tracepath01
 TST_TOTAL=1
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 test_tracepath()
diff --git a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
index e9094fc45..61d56ef21 100755
--- a/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
+++ b/testcases/network/tcp_fastopen/tcp_fastopen_run.sh
@@ -23,6 +23,7 @@ TST_TOTAL=1
 TCID="tcp_fastopen"
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 while getopts :hr:n:R:6 opt; do
diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 04759697a..768e0e313 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -19,6 +19,7 @@ TST_TOTAL=6
 TCID="traceroute01"
 TST_CLEANUP="cleanup"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 cleanup()
diff --git a/testcases/network/virt/geneve01.sh b/testcases/network/virt/geneve01.sh
index 1e723d84d..94d1becee 100755
--- a/testcases/network/virt/geneve01.sh
+++ b/testcases/network/virt/geneve01.sh
@@ -27,6 +27,7 @@ start_id=16700000
 # that is why using here 'vxlan_*' library functions.
 vxlan_dst_addr="uni"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/gre01.sh b/testcases/network/virt/gre01.sh
index bb2817d84..4805a4b61 100755
--- a/testcases/network/virt/gre01.sh
+++ b/testcases/network/virt/gre01.sh
@@ -24,6 +24,7 @@ TCID=gre01
 TST_TOTAL=1
 TST_NEEDS_TMPDIR=1
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 virt_type="gre"
diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index c20769316..3b6817d1b 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -24,6 +24,7 @@ TST_TOTAL=2
 
 virt_type="ipvlan"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/macvlan01.sh b/testcases/network/virt/macvlan01.sh
index ffb7536c5..4435a45ea 100755
--- a/testcases/network/virt/macvlan01.sh
+++ b/testcases/network/virt/macvlan01.sh
@@ -24,6 +24,7 @@ TST_TOTAL=4
 
 virt_type="macvlan"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/macvtap01.sh b/testcases/network/virt/macvtap01.sh
index 5c54e99cd..549e4e8a9 100755
--- a/testcases/network/virt/macvtap01.sh
+++ b/testcases/network/virt/macvtap01.sh
@@ -24,6 +24,7 @@ TST_TOTAL=4
 
 virt_type="macvtap"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/vlan01.sh b/testcases/network/virt/vlan01.sh
index 50cdfcbcc..fb6f8a9fe 100755
--- a/testcases/network/virt/vlan01.sh
+++ b/testcases/network/virt/vlan01.sh
@@ -24,6 +24,7 @@ TST_TOTAL=9
 
 virt_type="vlan"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/vlan02.sh b/testcases/network/virt/vlan02.sh
index b10596d43..6d77834ba 100755
--- a/testcases/network/virt/vlan02.sh
+++ b/testcases/network/virt/vlan02.sh
@@ -25,6 +25,7 @@ TST_TOTAL=1
 
 virt_type="vlan"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/vlan03.sh b/testcases/network/virt/vlan03.sh
index 814cc4c6c..9b7a5b4f7 100755
--- a/testcases/network/virt/vlan03.sh
+++ b/testcases/network/virt/vlan03.sh
@@ -29,6 +29,7 @@ TST_NEEDS_TMPDIR=1
 
 virt_type="vlan"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/vxlan01.sh b/testcases/network/virt/vxlan01.sh
index 3042e6e38..cd1dc45ec 100755
--- a/testcases/network/virt/vxlan01.sh
+++ b/testcases/network/virt/vxlan01.sh
@@ -25,6 +25,7 @@ TST_TOTAL=5
 virt_type="vxlan"
 start_id=16700000
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/vxlan02.sh b/testcases/network/virt/vxlan02.sh
index 23c303f20..369376285 100755
--- a/testcases/network/virt/vxlan02.sh
+++ b/testcases/network/virt/vxlan02.sh
@@ -26,6 +26,7 @@ TST_TOTAL=1
 virt_type="vxlan"
 start_id=16700000
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/virt/vxlan03.sh b/testcases/network/virt/vxlan03.sh
index 5d1d00032..811dee556 100755
--- a/testcases/network/virt/vxlan03.sh
+++ b/testcases/network/virt/vxlan03.sh
@@ -33,6 +33,7 @@ start_id=16700000
 # Destination address, can be unicast or multicast address
 vxlan_dst_addr="uni"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 . virt_lib.sh
 
diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index 8aa998875..855dec5ed 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -20,6 +20,7 @@ TST_TOTAL=2
 TST_CLEANUP="cleanup"
 
 . daemonlib.sh
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 setup()
diff --git a/testscripts/network.sh b/testscripts/network.sh
index eb991b656..7b497300a 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -88,12 +88,12 @@ fi
 TST_TOTAL=1
 TCID="network_settings"
 
+TST_USE_LEGACY_API=1
 . test_net.sh
 
 # Reset variables.
 # Don't break the tests which are using 'testcases/lib/cmdlib.sh'
-export TCID=
-export TST_LIB_LOADED=
+unset TCID TST_LIB_LOADED TST_USE_LEGACY_API
 
 rm -f $CMDFILE
 
-- 
2.16.3

