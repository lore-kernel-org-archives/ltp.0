From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 10:28:39 +0800
Subject: [LTP] [PATCH v3] network/sit01.sh: Replace tst_res with tst_brk
Message-ID: <20210429022839.24503-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need replace tst_res with tst_brk to terminate the test
immediately since there is no sence to go on.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v2->v3: split into two separate commits
 testcases/network/virt/sit01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/virt/sit01.sh b/testcases/network/virt/sit01.sh
index 4ecc1f8c0..27fa0ee77 100755
--- a/testcases/network/virt/sit01.sh
+++ b/testcases/network/virt/sit01.sh
@@ -11,7 +11,7 @@ virt_type="sit"

 do_setup()
 {
-	[ -n "$TST_IPV6" ] && tst_res TBROK "invalid option '-6' for sit tunnel"
+	[ -n "$TST_IPV6" ] && tst_brk TBROK "invalid option '-6' for sit tunnel"

 	virt_lib_setup

--
2.17.1

