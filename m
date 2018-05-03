From: Anton Smorodskyi <asmorodskyi@suse.com>
Date: Thu,  3 May 2018 13:36:37 +0200
Subject: [LTP] [PATCH 1/1] ipneigh01: Replace TCONF error message with TINFO
Message-ID: <20180503113637.21573-1-asmorodskyi@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When test case catch that arp command not support ipv6
it is more appropriate to send this as TINFO message

Signed-off-by: Anton Smorodskyi <asmorodskyi@suse.com>
---
 testcases/network/tcp_cmds/ipneigh/ipneigh01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
index 9af3aa31e..24e540dd0 100755
--- a/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
+++ b/testcases/network/tcp_cmds/ipneigh/ipneigh01.sh
@@ -76,7 +76,7 @@ rhost=$(tst_ipaddr rhost)
 if [ -z "$TST_IPV6" ]; then
 	do_test "arp -a" "arp -d $rhost"
 else
-	tst_resm TCONF "'arp cmd doesn't support IPv6, skipping test-case"
+	tst_resm TINFO "'arp cmd doesn't support IPv6, skipping test-case"
 fi
 
 do_test "ip neigh show" "ip neigh del $rhost dev $(tst_iface)"
-- 
2.13.6

