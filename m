From: Dan Rue <dan.rue@linaro.org>
Date: Thu,  9 Nov 2017 14:38:41 -0600
Subject: [LTP] [RFC] [PATCH] netns: Fix race in virtual interface bringup
Message-ID: <20171109203841.28856-1-dan.rue@linaro.org>
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
veth0 (due to -I veth0), but cannot. Waiting for two seconds fixes the
test in my testcases. 1 second is not long enough.

dmesg shows the following during the test:

    [Nov 7 15:39] LTP: starting netns_comm_ip_ipv6_ioctl (netns_comm.sh ip ipv6 ioctl)
    [  +0.302401] IPv6: ADDRCONF(NETDEV_UP): veth0: link is not ready
    [  +0.048059] IPv6: ADDRCONF(NETDEV_CHANGE): veth0: link becomes ready

Signed-off-by: Dan Rue <dan.rue@linaro.org>
---

We've periodically hit this problem across many arm64 kernels and boards, and
it seems to be caused by "ping6" running before the virtual interface is
actually ready. "sleep 2" works around the issue and proves that it is a race
condition, but I would prefer something faster and deterministic. Please
suggest a better implementation.

Also, is it correct that "ifconfig veth0 up" returns before the interface is
actually ready?

See also this isolated test script:
https://gist.github.com/danrue/7b76bbcbc23a6296030b7295650b69f3

 testcases/kernel/containers/netns/netns_helper.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
index a95cdf206..99172c0c0 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -285,6 +285,7 @@ netns_set_ip()
 			tst_brkm TBROK "enabling veth1 device failed"
 		;;
 	esac
+	sleep 2
 }
 
 netns_ns_exec_cleanup()
-- 
2.13.6

