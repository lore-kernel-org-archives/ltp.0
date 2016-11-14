From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 14 Nov 2016 16:33:24 +0300
Subject: [LTP] [PATCH][RFC] network: test_net.sh: allow to run tests on a
	single machine
Message-ID: <1479130404-31787-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When 'TST_USE_NETNS' environment variable is defined, test_net.sh
will setup 'ltp_ns' netns and configure veth pair according to
other LTP network variables. Then, each tst_rhost_run() call will
be executed in the new netns on the same host.

Usage:
TST_USE_NETNS=1... ./network.sh -i

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   50 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 40 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index dc52d95..67c702b 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -20,6 +20,31 @@
 
 [ -z "$TST_LIB_LOADED" ] && . test.sh
 
+init_ltp_netspace()
+{
+	if [ ! -f /var/run/netns/ltp_ns ]; then
+		ROD ip net add ltp_ns
+		ROD ip li add name ltp_veth1 type veth peer name ltp_veth2
+		ROD ip li set dev ltp_veth1 netns ltp_ns
+	fi
+
+	LHOST_IFACES=${LHOST_IFACES:-"ltp_ns_veth2"}
+	RHOST_IFACES=${RHOST_IFACES:-"ltp_ns_veth1"}
+
+	export TST_INIT_NETNS="no"
+	export LTP_NETNS=${LTP_NETNS:-"ip netns exec ltp_ns"}
+
+	tst_init_iface
+	tst_init_iface rhost
+
+	tst_add_ipaddr
+	tst_add_ipaddr rhost
+
+	TST_IPV6=6 tst_add_ipaddr
+	TST_IPV6=6 tst_add_ipaddr rhost
+
+}
+
 # Run command on remote host.
 # Options:
 # -b run in background
@@ -67,6 +92,9 @@ tst_rhost_run()
 	if [ -n "$TST_USE_SSH" ]; then
 		output=`ssh -n -q $user@$RHOST "sh -c \
 			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
+	elif [ -n "$TST_USE_NETNS" ]; then
+		output=`$LTP_NETNS sh -c \
+			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
 	else
 		output=`rsh -n -l $user $RHOST "sh -c \
 			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
@@ -346,22 +374,14 @@ tst_ping()
 }
 
 # Management Link
-[ -z "$RHOST" ] && tst_brkm TBROK "RHOST variable not defined"
+[ -z "$RHOST" -a -z "$TST_USE_NETNS" ] && \
+	tst_brkm TBROK "RHOST variable not defined"
 export RHOST="$RHOST"
 export PASSWD=${PASSWD:-""}
 # Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
 export LTP_RSH=${LTP_RSH:-"rsh -n"}
 
 # Test Links
-# Warning: make sure to set valid interface names and IP addresses below.
-# Set names for test interfaces, e.g. "eth0 eth1"
-export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
-export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
-
-# Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
-export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
-export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
-
 # Set first three octets of the network address, default is '10.0.0'
 export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
 # Set local host last octet, default is '2'
@@ -408,5 +428,15 @@ export UPLOAD_REGFILESIZE=${UPLOAD_REGFILESIZE:-"1024"}
 export MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-"20"}
 export MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-"40000"}
 
+[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
+
+# Warning: make sure to set valid interface names and IP addresses below.
+# Set names for test interfaces, e.g. "eth0 eth1"
+export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
+export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
+# Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
+export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
+export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
+
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
-- 
1.7.1

