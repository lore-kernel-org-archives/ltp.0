From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Mon, 13 Sep 2021 15:39:35 +0300
Subject: [LTP] [PATCH 2/2] lib/tst_net.sh: disable ipv6_dad work on test
 interfaces
In-Reply-To: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
References: <20210913123935.10761-1-aleksei.kodanev@bell-sw.com>
Message-ID: <20210913123935.10761-2-aleksei.kodanev@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To fix intermittent issues with ping (in flood mode) [1] tests
after initial test interfaces setup.

We're already adding IPv6 addresses with nodad option, but it
should disable ipv6_dad for link-local addresses too, so that
they are fully functional when tests start to use them.

It could also be tst_wait_ipv6_dad(), but it slows down a test
setup.

[1]: https://github.com/iputils/iputils/issues/300

Tested-by: Su Yue <suy.fnst@fujitsu.com>
Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
---
 testcases/lib/tst_net.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 7f2a1bab3..89d4c79ec 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -517,6 +517,7 @@ tst_init_iface()
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
+		sysctl -qw net.ipv6.conf.$iface.accept_dad=0 || return $?
 		ip link set $iface up
 		return $?
 	fi
@@ -528,6 +529,7 @@ tst_init_iface()
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
+	tst_rhost_run -c "sysctl -qw net.ipv6.conf.$iface.accept_dad=0" || return $?
 	tst_rhost_run -c "ip link set $iface up"
 }
 
-- 
2.25.1

