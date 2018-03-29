From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 17:45:35 +0200
Subject: [LTP] [RFC PATCH 1/3] test_net.sh: Support both old and new shell
	APIs
In-Reply-To: <20180329154537.32711-1-pvorel@suse.cz>
References: <20180329154537.32711-1-pvorel@suse.cz>
Message-ID: <20180329154537.32711-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is temporary solution, after migrating all tests to new SHELL API
the compatibility layer and old SHELL API support should be removed and
file renamed to tst_net.sh.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/test_net.sh | 126 ++++++++++++++++++++++++++++------------------
 testcases/lib/tst_test.sh |   1 +
 2 files changed, 79 insertions(+), 48 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 203464f0d..3af2ee0b0 100644
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
@@ -19,7 +19,54 @@
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
+	OPTIND=0
+	while getopts "$TST_OPTS" opt; do
+		$TST_PARSE_ARGS "$opt"
+	done
+	OPTIND=0
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
+	[ -n "$TST_USE_NEW_API" ] && . tst_test.sh || . test.sh
+fi
+
+[ -z "$TST_USE_NEW_API" ] && tst_read_opts $*
+
+# old vs. new API compatibility layer
+_tst_res()
+{
+	[ -n "$TST_USE_NEW_API" ] && tst_res $@ || tst_resm $@
+}
+_tst_brk()
+{
+	[ -n "$TST_USE_NEW_API" ] && tst_brk $@ || tst_brkm $@
+}
 
 init_ltp_netspace()
 {
@@ -81,7 +128,7 @@ tst_rhost_run()
 		s) safe=1 ;;
 		c) cmd="$OPTARG" ;;
 		u) user="$OPTARG" ;;
-		*) tst_brkm TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
+		*) _tst_brk TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
 		esac
 	done
 
@@ -89,8 +136,8 @@ tst_rhost_run()
 
 	if [ -z "$cmd" ]; then
 		[ "$safe" -eq 1 ] && \
-			tst_brkm TBROK "tst_rhost_run: command not defined"
-		tst_resm TWARN "tst_rhost_run: command not defined"
+			_tst_brk TBROK "tst_rhost_run: command not defined"
+		_tst_res TWARN "tst_rhost_run: command not defined"
 		return 1
 	fi
 
@@ -110,7 +157,7 @@ tst_rhost_run()
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
 		[ "$safe" -eq 1 ] && \
-			tst_brkm TBROK "'$cmd' failed on '$RHOST': '$output'"
+			_tst_brk TBROK "'$cmd' failed on '$RHOST': '$output'"
 	fi
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"
@@ -122,9 +169,9 @@ EXPECT_RHOST_PASS()
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
 
@@ -132,9 +179,9 @@ EXPECT_RHOST_FAIL()
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
 
@@ -200,23 +247,6 @@ tst_iface()
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
@@ -302,7 +332,7 @@ tst_init_iface()
 	local type="${1:-lhost}"
 	local link_num="${2:-0}"
 	local iface="$(tst_iface $type $link_num)"
-	tst_resm TINFO "initialize '$type' '$iface' interface"
+	_tst_res TINFO "initialize '$type' '$iface' interface"
 
 	if [ "$type" = "lhost" ]; then
 		ip xfrm policy flush || return $?
@@ -340,12 +370,12 @@ tst_add_ipaddr()
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
 
@@ -390,7 +420,7 @@ tst_wait_ipv6_dad()
 		[ $ret -ne 0 -a $? -ne 0 ] && return
 
 		[ $(($i % 10)) -eq 0 ] && \
-			tst_resm TINFO "wait for IPv6 DAD completion $((i / 10))/5 sec"
+			_tst_res TINFO "wait for IPv6 DAD completion $((i / 10))/5 sec"
 
 		tst_sleep 100ms
 	done
@@ -443,7 +473,7 @@ tst_netload()
 		f) cs_opts="${cs_opts}-f " ;;
 		F) cs_opts="${cs_opts}-F " ;;
 		e) expect_res="$OPTARG" ;;
-		*) tst_brkm TBROK "tst_netload: unknown option: $OPTARG" ;;
+		*) _tst_brk TBROK "tst_netload: unknown option: $OPTARG" ;;
 		esac
 	done
 	OPTIND=0
@@ -455,37 +485,37 @@ tst_netload()
 
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
@@ -516,9 +546,9 @@ tst_ping()
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
@@ -558,9 +588,9 @@ tst_icmp()
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
@@ -644,10 +674,10 @@ if [ -z "$TST_PARSE_VARIABLES" ]; then
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
 
@@ -687,7 +717,7 @@ export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
 # in the following document: testcases/network/stress/README
 
 if [ "$TST_NEEDS_TMPDIR" = 1 ]; then
-	tst_tmpdir
+	[ -z "$TST_USE_NEW_API" ] && tst_tmpdir
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
-- 
2.16.2

