From: shuang.qiu@oracle.com <shuang.qiu@oracle.com>
Date: Fri, 24 Jun 2016 11:36:02 +0800
Subject: [LTP] [PATCH] syscalls/removexattr02:skip the test if no xattr
	support
Message-ID: <1466739362-5914-1-git-send-email-shuang.qiu@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Shuang Qiu <shuang.qiu@oracle.com>

Return TCONF if there is no xattr support in fs or mount without user_xattr option

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 .../kernel/syscalls/removexattr/removexattr02.c    |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/removexattr/removexattr02.c b/testcases/kernel/syscalls/removexattr/removexattr02.c
index 58f310a..cea8733 100644
--- a/testcases/kernel/syscalls/removexattr/removexattr02.c
+++ b/testcases/kernel/syscalls/removexattr/removexattr02.c
@@ -85,6 +85,10 @@ static void verify_removexattr(struct test_case *tc)
 {
 
 	TEST(removexattr(tc->path, tc->name));
+	if (TEST_RETURN == -1 && TEST_ERRNO == ENOTSUP)
+		tst_brkm(TCONF, cleanup, "No xattr support in fs or "
+			 "mount without user_xattr option");
+
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "removexattr() succeeded unexpectedly");
 		return;
-- 
1.7.9.5

