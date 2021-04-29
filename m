From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 10:09:22 +0800
Subject: [LTP] [PATCH v3] commands/lsmod01.sh: Replace tst_res with tst_brk
Message-ID: <20210429020922.24085-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need replace tst_res with tst_brk to terminate the test immediately since
there is no sence to go on.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v2->v3: split into two separate commits
 testcases/commands/lsmod/lsmod01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/lsmod/lsmod01.sh b/testcases/commands/lsmod/lsmod01.sh
index 2e044c718..4ed91eca5 100755
--- a/testcases/commands/lsmod/lsmod01.sh
+++ b/testcases/commands/lsmod/lsmod01.sh
@@ -23,7 +23,7 @@ setup()
 		tst_require_cmds insmod
 		insmod "$TST_MODPATH"
 		if [ $? -ne 0 ]; then
-			tst_res TBROK "insmod failed"
+			tst_brk TBROK "insmod failed"
 			return
 		fi

--
2.17.1

