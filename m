From: sujiaxun <sujiaxun@uniontech.com>
Date: Tue, 30 Mar 2021 21:01:15 +0800
Subject: [LTP] [PATCH] bugfix for cpio/cpio_tests.sh
Message-ID: <20210330130115.26575-1-sujiaxun@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In cpio version 2.12 and 2.13,'cpio --help' create is lowercase

Signed-off-by: sujiaxun <sujiaxun@uniontech.com>
---
 testcases/commands/cpio/cpio_tests.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/cpio/cpio_tests.sh b/testcases/commands/cpio/cpio_tests.sh
index a98b7eca7..5f3a13e85 100755
--- a/testcases/commands/cpio/cpio_tests.sh
+++ b/testcases/commands/cpio/cpio_tests.sh
@@ -13,7 +13,7 @@ TST_SETUP="setup"

 setup()
 {
-	if ! cpio --help 2>&1 | grep -q -- '-o.*Create'; then
+	if ! cpio --help 2>&1 | grep -qi -- '-o.*Create'; then
 		tst_brk TCONF "-o flag not supported"
 	fi

--
2.20.1



