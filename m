From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 19 Feb 2019 17:47:51 +0300
Subject: [LTP] [PATCH 2/4] lib/tst_net.sh: add new TST_NET_MAX_PKT env
	variable
In-Reply-To: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
References: <1550587673-7995-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1550587673-7995-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is critical for performance tests, which compare virtual
devices with the real ones. Trigger the fragmentation but keep
the number of fragments at the minimum for those cases.

Also improve the test timing if MTU is not large.

The previous numbers can be restored with TST_NET_MAX_PKT
environment variable.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net.sh |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 06b8ad6..3148643 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -710,6 +710,13 @@ tst_cleanup_rhost()
 	tst_rhost_run -c "rm -rf $TST_TMPDIR"
 }
 
+tst_default_max_pkt()
+{
+	local mtu="$(cat /sys/class/net/$(tst_iface)/mtu)"
+
+	echo "$((mtu + mtu / 10))"
+}
+
 # Management Link
 [ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
@@ -797,7 +804,8 @@ export MCASTNUM_HEAVY="${MCASTNUM_HEAVY:-4000}"
 # want to use more ifaces.
 export LHOST_IFACES="${LHOST_IFACES:-eth0}"
 export RHOST_IFACES="${RHOST_IFACES:-eth0}"
-
+# Maximum payload size for 'virt' performance tests, by default eqauls to 1.1 * MTU
+export TST_NET_MAX_PKT="${TST_NET_MAX_PKT:-$(tst_default_max_pkt)}"
 # Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
 export LHOST_HWADDRS="${LHOST_HWADDRS:-$(tst_get_hwaddrs lhost)}"
 export RHOST_HWADDRS="${RHOST_HWADDRS:-$(tst_get_hwaddrs rhost)}"
-- 
1.7.1

