From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Nov 2018 17:33:45 +0100
Subject: [LTP] [PATCH v3 1/2] syscalls/fremovexattr: Add fremovexattr()
	tests
In-Reply-To: <20181108183320.11262-1-rafael.tinoco@linaro.org>
References: <20181107153855.GA8153@rei>
 <20181108183320.11262-1-rafael.tinoco@linaro.org>
Message-ID: <20181115163344.GA29013@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor simplification, mainly removing unreachable branches
from the second test, thanks.

Diff:

diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
index 96b92fb24..a3ea1aa2b 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr01.c
@@ -50,9 +50,7 @@ static void verify_fremovexattr(void)
 		return;
 	}
 
-	memset(&got_value, 0, XATTR_TEST_VALUE_SIZE);
-
-	TEST(fgetxattr(fd, XATTR_TEST_KEY, got_value, XATTR_TEST_VALUE_SIZE));
+	TEST(fgetxattr(fd, XATTR_TEST_KEY, got_value, sizeof(got_value)));
 
 	if (TST_RET >= 0) {
 		tst_res(TFAIL, "fremovexattr(2) did not remove attribute");
@@ -60,7 +58,8 @@ static void verify_fremovexattr(void)
 	}
 
 	if (TST_RET < 0 && TST_ERR != ENOATTR) {
-		tst_brk(TBROK, "fremovexattr(2) could not verify removal");
+		tst_brk(TBROK | TTERRNO,
+			"fremovexattr(2) could not verify removal");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
index 8eb1e9a99..534179eae 100644
--- a/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
+++ b/testcases/kernel/syscalls/fremovexattr/fremovexattr02.c
@@ -42,24 +42,20 @@ static int fd = -1;
 struct test_case {
 	int fd;
 	char *key;
-	int exp_ret;
 	int exp_err;
 };
 
 struct test_case tc[] = {
 	{				/* case 1: attribute does not exist */
 	 .key = XATTR_TEST_KEY,
-	 .exp_ret = -1,
 	 .exp_err = ENODATA,
 	 },
 	{				/* case 2: file descriptor is invalid */
 	 .fd = -1,
 	 .key = XATTR_TEST_KEY,
-	 .exp_ret = -1,
 	 .exp_err = EBADF,
 	 },
 	{				/* case 3: bad name attribute */
-	 .exp_ret = -1,
 	 .exp_err = EFAULT,
 	},
 };
@@ -71,20 +67,19 @@ static void verify_fremovexattr(unsigned int i)
 	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
 		tst_brk(TCONF, "fremovexattr(2) not supported");
 
-	if (tc[i].exp_ret == TST_RET) {
-
-		if (tc[i].exp_err) {
-			if (tc[i].exp_err == TST_ERR) {
-				tst_res(TPASS, "fremovexattr(2) passed");
-				return;
-			}
-		} else  {
-			tst_res(TPASS, "fremovexattr(2) passed");
-			return;
+	if (TST_RET == -1) {
+		if (tc[i].exp_err == TST_ERR) {
+			tst_res(TPASS | TTERRNO,
+				"fremovexattr(2) failed expectedly");
+		} else {
+			tst_res(TFAIL | TTERRNO,
+				"fremovexattr(2) should fail with %s",
+				tst_strerrno(tc[i].exp_err));
 		}
+		return;
 	}
 
-	tst_res(TFAIL | TTERRNO, "fremovexattr(2) failed");
+	tst_res(TFAIL, "fremovexattr(2) returned %li", TST_RET);
 }

-- 
Cyril Hrubis
chrubis@suse.cz
