From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 11 Jan 2017 15:53:54 +0300
Subject: [LTP] [PATCH] test_net.sh: add tst_wait_ipv6_dad()
Message-ID: <1484139234-14043-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

New function is waiting for IPv6 DAD completion on the specified
interfaces.

Add it to netns setup to make sure previously configured
IPv6 addresses are ready to be used by tests.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 71df6be..04d420c 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -44,6 +44,7 @@ init_ltp_netspace()
 	TST_IPV6=6 tst_add_ipaddr
 	TST_IPV6=6 tst_add_ipaddr rhost
 
+	tst_wait_ipv6_dad
 }
 
 # Run command on remote host.
@@ -278,6 +279,33 @@ tst_restore_ipaddr()
 	return $ret
 }
 
+# tst_wait_ipv6_dad [LHOST_IFACE] [RHOST_IFACE]
+# wait for IPv6 DAD completion
+tst_wait_ipv6_dad()
+{
+	local ret=
+	local i=
+	local iface_loc=${1:-$(tst_iface)}
+	local iface_rmt=${2:-$(tst_iface rhost)}
+
+	for i in $(seq 1 5); do
+		ip a sh $iface_loc | grep -q tentative
+		ret=$?
+
+		tst_rhost_run -c "ip a sh $iface_rmt | grep -q tentative"
+
+		[ $ret -ne 0 -a $? -ne 0 ] && return
+
+		if [ $i -ne 5 ]; then
+			tst_resm TINFO "wait for IPv6 DAD completion $i/5 sec"
+			tst_sleep 1s
+			continue
+		fi
+
+		tst_resm TWARN "Interface has tentative IP address(es)"
+	done
+}
+
 # tst_netload ADDR [FILE] [TYPE] [OPTS]
 # Run network load test
 # ADDR: IP address
-- 
1.7.1

