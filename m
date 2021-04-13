From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Tue, 13 Apr 2021 19:35:49 +0800
Subject: [LTP] [PATCH v2] tst_res: Replace tst_res with tst_brk for shell
 testcases
Message-ID: <20210413113549.3604-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need replace tst_res with tst_brk to terminate the test immediately since
there is no sence to go on.

For those:
	testcases/commands/lsmod/lsmod01.sh
        testcases/network/virt/sit01.sh

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2:remove the modification of ima_measurements.sh
---
 testcases/commands/lsmod/lsmod01.sh | 3 +--
 testcases/network/virt/sit01.sh     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 2e044c718..44ca59b95 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -23,8 +23,7 @@ setup()
 		tst_require_cmds insmod
 		insmod "$TST_MODPATH"
 		if [ $? -ne 0 ]; then
-			tst_res TBROK "insmod failed"
-			return
+			tst_brk TBROK "insmod failed"
 		fi

 		module_inserted=1
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

