From: shile.zhang@linux.alibaba.com <shile.zhang@linux.alibaba.com>
Date: Mon,  4 Mar 2019 16:49:29 +0800
Subject: [LTP] [PATCH] network/virt: add mode l3s in ipvlan test
Message-ID: <1551689369-224152-1-git-send-email-shile.zhang@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shile Zhang <shile.zhang@linux.alibaba.com>

Signed-off-by: Shile Zhang <shile.zhang@linux.alibaba.com>
---
 testcases/network/virt/ipvlan01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/virt/ipvlan01.sh b/testcases/network/virt/ipvlan01.sh
index f0a5466..e8b1063 100755
--- a/testcases/network/virt/ipvlan01.sh
+++ b/testcases/network/virt/ipvlan01.sh
@@ -8,7 +8,7 @@
 # interface multiple times.
 
 virt_type="ipvlan"
-TST_TEST_DATA="mode l2,mode l3"
+TST_TEST_DATA="mode l2,mode l3,mode l3s"
 TST_TEST_DATA_IFS=","
 TST_TESTFUNC=virt_test_02
 . virt_lib.sh
-- 
1.8.3.1

