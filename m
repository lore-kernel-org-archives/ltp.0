From: Kory Maincent <kory.maincent@bootlin.com>
Date: Tue,  1 Dec 2020 14:43:56 +0100
Subject: [LTP] [PATCH v2] net/ip_tests: Return TCONF if driver dummy not
 present
Message-ID: <20201201134356.28635-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes since v1:
 - Use TST_NEEDS_DRIVERS
 - Test ip4_addr before clean to avoid empty grep

 testcases/network/iproute/ip_tests.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index 41c515696..13722afb9 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -13,6 +13,7 @@ TST_CLEANUP="cleanup"
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="cat awk diff"
+TST_NEEDS_DRIVERS="dummy"
 
 . tst_net.sh
 
@@ -51,7 +52,7 @@ cleanup()
 	[ "$rm_dummy" ] && modprobe -r dummy
 
 	# test #5
-	ip route show | grep $ip4_addr && ip route del $ip4_addr
+	[ "$ip4_addr" ] && ip route show | grep $ip4_addr && ip route del $ip4_addr
 }
 
 test1()
-- 
2.17.1

