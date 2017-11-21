From: Dan Rue <dan.rue@linaro.org>
Date: Tue, 21 Nov 2017 15:36:41 -0600
Subject: [LTP] [PATCH] netns: Fix duplicate address detection (dad)
Message-ID: <20171121213641.27837-1-dan.rue@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Symptoms (+ command, error):
    netns_comm_ip_ipv6_ioctl:
        + ip netns exec tst_net_ns1 ping6 -q -c2 -I veth1 fd00::2
        connect: Cannot assign requested address

    netns_comm_ip_ipv6_netlink:
        + ip netns exec tst_net_ns0 ping6 -q -c2 -I veth0 fd00::3
        connect: Cannot assign requested address

    netns_comm_ns_exec_ipv6_ioctl:
        + ns_exec 6689 net ping6 -q -c2 -I veth0 fd00::3
        connect: Cannot assign requested address

    netns_comm_ns_exec_ipv6_netlin:
        + ns_exec 6891 net ping6 -q -c2 -I veth0 fd00::3
        connect: Cannot assign requested address

The error is coming from ping6, which is trying to get an IP address for
veth0 (due to -I veth0), but cannot, because the interface is not
immediately available due to dad. The existing code to disable dad is
disables it for the virtual interfaces, but it needs to be disabled for
all interfaces in the network namespace to be effective.

Also, changed it to use sysctl -w because I think it is a little cleaner
to read and understand.

Lastly, dropped setting accept_ra. It does not seem to be necessary to
disable.

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---
 testcases/kernel/containers/netns/netns_helper.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a95cdf206..95add0544 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -256,12 +256,10 @@ netns_set_ip()
 	# there is no other host with the same address, the address is
 	# considered to be "tentative" (attempts to bind() to the address fail
 	# with EADDRNOTAVAIL) which may cause problems for tests using ipv6.
-	echo 0 | $NS_EXEC $NS_HANDLE0 $NS_TYPE \
-		tee /proc/sys/net/ipv6/conf/veth0/accept_dad \
-		/proc/sys/net/ipv6/conf/veth0/accept_ra >/dev/null
-	echo 0 | $NS_EXEC $NS_HANDLE1 $NS_TYPE \
-		tee /proc/sys/net/ipv6/conf/veth1/accept_dad \
-		/proc/sys/net/ipv6/conf/veth1/accept_ra >/dev/null
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE sysctl -w net.ipv6.conf.all.accept_dad=0
+	$NS_EXEC $NS_HANDLE0 $NS_TYPE sysctl -w net.ipv6.conf.veth0.accept_dad=0
+	$NS_EXEC $NS_HANDLE1 $NS_TYPE sysctl -w net.ipv6.conf.all.accept_dad=0
+	$NS_EXEC $NS_HANDLE1 $NS_TYPE sysctl -w net.ipv6.conf.veth1.accept_dad=0
 
 	case $USE_IFCONFIG in
 	1)
-- 
2.14.3

