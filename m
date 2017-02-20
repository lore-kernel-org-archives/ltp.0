From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Feb 2017 13:48:59 +0300
Subject: [LTP] [COMMITTED][PATCH] mc_cmds: fix test on sparc & when iface
	joined multiple groups
Message-ID: <1487587739-23516-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/proc/net/igmp can have this:

* When iface joinded multiple groups:
5       ltp_ns_veth2:     2      V3
                                FB0000E0     1 0:00000000  0
                                010000E0     1 0:00000000  0

* For sparc byte order is different:
3       ltp_ns_veth2:     1      V3
                                E0000001     1 0:00000000  0

Fix both by grepping 'ip maddr' output from target interface name
till the next interface entry.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/multicast/mc_cmds/mc_cmds |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 9c15ad0..8077b1f 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -51,9 +51,11 @@ do_test()
 
 	ip maddr show $(tst_iface) | grep -q '224.0.0.1'
 	if [ $? -ne 0 ]; then
-		tst_resm TWARN "ip failed to detect multicast, parsing /proc/net/igmp"
-		grep "$(tst_iface)\s*:" -A 1 /proc/net/igmp | grep -q '\s010000E0\s' || \
-			tst_brkm TFAIL "all-host-group for $(tst_iface) not joined"
+		tst_resm TWARN "'ip maddr show $(tst_iface)' failed," \
+			       " parsing 'ip maddr show'"
+		ip maddr show | sed -ne "/\s$(tst_iface)/,/^[0-9]/p" | \
+			grep -q 224.0.0.1 || \
+			tst_brkm TFAIL "$(tst_iface) not joined 224.0.0.1"
 	fi
 
 	tst_resm TINFO "Ping all-host-groups over specified interface"
-- 
1.7.1

