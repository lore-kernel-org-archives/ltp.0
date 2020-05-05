From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  5 May 2020 14:50:19 +0200
Subject: [LTP] [PATCH COMMITTED] syscalls/lremovexattr01: use strncmp() to
 check attribute value
Message-ID: <135538f22cc17bd92eeff77a21a8bb8dbf926c4a.1588683000.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix the test failure and following compile warning (gcc version 10.0.1):
  lremovexattr01.c: In function ?verify_lremovexattr?:
  lremovexattr01.c:98:6: warning: ?strcmp? of a string of length 13 and an array of size 13 evaluates to nonzero [-Wstring-compare]
     98 |  if (strcmp(got_value, XATTR_VALUE)) {
        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/lremovexattr/lremovexattr01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
index 0c19c62ace50..590f5a6f32a0 100644
--- a/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
+++ b/testcases/kernel/syscalls/lremovexattr/lremovexattr01.c
@@ -95,7 +95,7 @@ static void verify_lremovexattr(void)
 		return;
 	}
 
-	if (strcmp(got_value, XATTR_VALUE)) {
+	if (strncmp(got_value, XATTR_VALUE, XATTR_VALUE_SIZE)) {
 		tst_res(TFAIL, "lremovexattr(2) changed file attribute");
 		return;
 	}
-- 
2.18.1

