From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 Jul 2021 12:04:15 +0200
Subject: [LTP] [PATCH 3/3] netns_helper.sh: Formatting and style cleanup
In-Reply-To: <20210716100415.27410-1-pvorel@suse.cz>
References: <20210716100415.27410-1-pvorel@suse.cz>
Message-ID: <20210716100415.27410-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replace spaces with tabs, use shorter if clauses, add missing local.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/containers/netns/netns_helper.sh   | 41 ++++++++-----------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index c296b8726..d7d4d2c2d 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -79,9 +79,8 @@ netns_setup()
 	case "$1" in
 	ns_exec)
 		setns_check
-		if [ $? -eq 32 ]; then
-			tst_brk TCONF "setns not supported"
-		fi
+		[ $? -eq 32 ] && tst_brk TCONF "setns not supported"
+
 		NS_TYPE="net"
 		netns_ns_exec_setup
 		TST_CLEANUP=netns_ns_exec_cleanup
@@ -124,17 +123,20 @@ netns_setup()
 
 	case "$2" in
 	ipv4)
-		IP0=$4; IP1=$5
-		tping="ping"; NETMASK=24
+		IP0=$4
+		IP1=$5
+		tping="ping"
+		NETMASK=24
 		;;
 	ipv6)
 		IFCONF_IN6_ARG="inet6 add"
-		IP0=$6; IP1=$7;
+		IP0=$6
+		IP1=$7
 
 		if tst_cmd_available ping6; then
-		    tping="ping6"
+			tping="ping6"
 		else
-		    tping="ping -6"
+			tping="ping -6"
 			tst_res_ TINFO "ping6 binary/symlink is missing, using workaround. Please, report missing ping6 to your distribution."
 		fi
 		NETMASK=64
@@ -153,6 +155,8 @@ netns_setup()
 # ethernet device is then created for each namespace.
 netns_ns_exec_setup()
 {
+	local ret
+
 	NS_EXEC="ns_exec"
 
 	NS_HANDLE0=$(ns_create $NS_TYPE)
@@ -172,13 +176,8 @@ netns_ns_exec_setup()
 
 	$NS_EXEC $NS_HANDLE0 $NS_TYPE ns_ifmove veth1 $NS_HANDLE1
 	ret=$?
-	if [ $ret -eq 0 ]; then
-		return;
-	fi
-
-	if [ $ret -eq 32 ]; then
-		tst_brk TCONF "IFLA_NET_NS_PID not supported"
-	fi
+	[ $ret -eq 0 ] && return
+	[ $ret -eq 32 ] && tst_brk TCONF "IFLA_NET_NS_PID not supported"
 
 	tst_brk TBROK "unable to add device veth1 to the separate network namespace"
 }
@@ -215,9 +214,7 @@ netns_ip_setup()
 # of them (IPv4/IPv6 variant is decided by netns_setup() function).
 netns_set_ip()
 {
-	if [ -z "$NS_EXEC" ]; then
-		tst_brk TBROK "netns_setup() function must be called first"
-	fi
+	[ "$NS_EXEC" ] || tst_brk TBROK "netns_setup() function must be called first"
 
 	# This applies only for ipv6 variant:
 	# Do not accept Router Advertisements (accept_ra) and do not use
@@ -259,9 +256,7 @@ netns_set_ip()
 
 netns_ns_exec_cleanup()
 {
-	if [ -z "$NS_EXEC" ]; then
-		return
-	fi
+	[ "$NS_EXEC" ] || return
 
 	# removes veth0 device (which also removes the paired veth1 device)
 	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link delete veth0
@@ -273,9 +268,7 @@ netns_ns_exec_cleanup()
 
 netns_ip_cleanup()
 {
-	if [ -z "$NS_EXEC" ]; then
-		return
-	fi
+	[ "$NS_EXEC" ] || return
 
 	# removes veth0 device (which also removes the paired veth1 device)
 	$NS_EXEC $NS_HANDLE0 ip link delete veth0
-- 
2.32.0

