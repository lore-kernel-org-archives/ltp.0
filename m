From: xiao yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 21 Dec 2017 11:22:40 +0800
Subject: [LTP] [PATCH v2] netns/netns_helper.sh: Fix failure when testing
	ipv6 in netns
In-Reply-To: <9318bde0-cca5-7428-b046-b1f506bfdbba@oracle.com>
References: <9318bde0-cca5-7428-b046-b1f506bfdbba@oracle.com>
Message-ID: <1513826560-26481-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When testing ipv6 in network namespace, we got the following
error on some distros(e.g. RHEL7.5Alpha):
----------------------------------------------------------------------------------
connect: Cannot assign requested address
netns_comm_ns_exec_ipv6_netlink 1 TFAIL: configuration and communication over veth0
connect: Cannot assign requested address
netns_comm_ns_exec_ipv6_netlink 2 TFAIL: configuration and communication over veth1
-----------------------------------------------------------------------------------

On a kernel with commits 35e015e1f577 and a2d3f3e33853, the global
'accept_dad' flag is taken into account and set to 1 by default.
If global flag is non-zero, DAD will be enabled and trigger the
failure on a given interface.  I think it should not be considered
as a bug, and try to fix it by setting all.accept_dad to 0 manually.

The default value of all.accept_dad has been set to 0 in kernel:
'094009531612("ipv6: set all.accept_dad to 0 by default")'

Signed-off-by: xiao yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_helper.sh | 54 +++++++++++++++++++----
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a95cdf2..8f7d3b5 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -78,6 +78,42 @@ tst_check_iproute()
 	fi
 }
 
+check_ipv6_tentative()
+{
+	local info=$($NS_EXEC $NS_HANDLE0 $NS_TYPE ip -6 address show tentative 2>&1)
+	local enabled=$($NS_EXEC $NS_HANDLE0 $NS_TYPE cat /proc/sys/net/ipv6/conf/all/accept_dad)
+
+	# With commits 35e015e1f577 and a2d3f3e33853, the global 'accept_dad'
+	# flag is also taken into account (default value is 1). If either
+	# global or per-interface flag is non-zero, DAD will be enabled on a
+	# given interface.  With commit 094009531612, all.accept_dad is set to
+	# 0 by default.
+	if [ -n "$info" -a $enabled -eq 1 ]; then
+		tst_resm TINFO "all.accept_dad was taken into account and set to 1 by default, and set it to 0 manually"
+		echo 0 | $NS_EXEC $NS_HANDLE0 $NS_TYPE \
+		tee /proc/sys/net/ipv6/conf/all/accept_dad >/dev/null
+		echo 0 | $NS_EXEC $NS_HANDLE1 $NS_TYPE \
+		tee /proc/sys/net/ipv6/conf/all/accept_dad >/dev/null
+
+		case $USE_IFCONFIG in
+		1)
+			$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 down || \
+				tst_brkm TBROK "disabling veth0 device failed"
+			$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 down || \
+				tst_brkm TBROK "disabling veth1 device failed"
+			;;
+		*)
+			$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set veth0 down || \
+				tst_brkm TBROK "disabling veth0 device failed"
+			$NS_EXEC $NS_HANDLE1 $NS_TYPE ip link set veth1 down || \
+				tst_brkm TBROK "disabling veth1 device failed"
+			;;
+		esac
+
+		netns_set_ip
+	fi
+}
+
 ##
 # Sets up global variables which can be used in test cases (documented above),
 # creates two network namespaces and a pair of virtual ethernet devices, each
@@ -174,6 +210,8 @@ netns_setup()
 	esac
 
 	netns_set_ip
+
+	[ "$2" = "ipv6" ] && check_ipv6_tentative
 }
 
 ##
@@ -265,23 +303,23 @@ netns_set_ip()
 
 	case $USE_IFCONFIG in
 	1)
-		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 $IFCONF_IN6_ARG $IP0/$NETMASK ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 $IFCONF_IN6_ARG $IP0/$NETMASK || \
 			tst_brkm TBROK "adding address to veth0 failed"
-		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 $IFCONF_IN6_ARG $IP1/$NETMASK || \
 			tst_brkm TBROK "adding address to veth1 failed"
-		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 up ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ifconfig veth0 up || \
 			tst_brkm TBROK "enabling veth0 device failed"
-		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 up ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ifconfig veth1 up || \
 			tst_brkm TBROK "enabling veth1 device failed"
 		;;
 	*)
-		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP0/$NETMASK dev veth0 ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip address add $IP0/$NETMASK dev veth0 || \
 			tst_brkm TBROK "adding address to veth0 failed"
-		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip address add $IP1/$NETMASK dev veth1 ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip address add $IP1/$NETMASK dev veth1 || \
 			tst_brkm TBROK "adding address to veth1 failed"
-		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set veth0 up ||
+		$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link set veth0 up || \
 			tst_brkm TBROK "enabling veth0 device failed"
-		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip link set veth1 up ||
+		$NS_EXEC $NS_HANDLE1 $NS_TYPE ip link set veth1 up || \
 			tst_brkm TBROK "enabling veth1 device failed"
 		;;
 	esac
-- 
1.8.3.1



