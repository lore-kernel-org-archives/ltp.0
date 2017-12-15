From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 15 Dec 2017 21:13:17 +0800
Subject: [LTP] [PATCH] netns/netns_helper.sh: Fix failure when testing ipv6
	in netns
Message-ID: <1513343597-5720-1-git-send-email-yangx.jy@cn.fujitsu.com>
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

We could fix this issue by waiting enough time(5s) for address
to pass duplicate address detection.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/containers/netns/netns_helper.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a95cdf2..72112c8 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -78,6 +78,16 @@ tst_check_iproute()
 	fi
 }
 
+check_ipv6_tentative()
+{
+	local info0=$($NS_EXEC $NS_HANDLE0 $NS_TYPE ip -6 address show tentative 2>&1)
+	local info1=$($NS_EXEC $NS_HANDLE1 $NS_TYPE ip -6 address show tentative 2>&1)
+
+	[ -z "$info0" ] && [ -z "$info1" ] && return 0
+
+	return 1;
+}
+
 ##
 # Sets up global variables which can be used in test cases (documented above),
 # creates two network namespaces and a pair of virtual ethernet devices, each
@@ -285,6 +295,16 @@ netns_set_ip()
 			tst_brkm TBROK "enabling veth1 device failed"
 		;;
 	esac
+
+	if [ "$tping" = "ping6" ]; then
+		for ((i=0; i<5; i++)); do
+			check_ipv6_tentative && return
+			tst_resm TINFO \
+				"address was in tentative state, wait and retry"
+			sleep 1
+		done
+		tst_brkm TBROK "address was always in tentative state"
+	fi
 }
 
 netns_ns_exec_cleanup()
-- 
1.8.3.1



