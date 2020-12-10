From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Dec 2020 15:15:40 +0100
Subject: [LTP] [PATCH v2 02/10] syscalls/uname: Make use of TST_EXP_MACROS
In-Reply-To: <20201210141548.10982-1-chrubis@suse.cz>
References: <20201210141548.10982-1-chrubis@suse.cz>
Message-ID: <20201210141548.10982-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/uname/uname01.c | 13 +++----------
 testcases/kernel/syscalls/uname/uname02.c | 17 +----------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/uname/uname01.c b/testcases/kernel/syscalls/uname/uname01.c
index bd3b05303..5e2f5ffac 100644
--- a/testcases/kernel/syscalls/uname/uname01.c
+++ b/testcases/kernel/syscalls/uname/uname01.c
@@ -18,24 +18,17 @@ static void verify_uname(void)
 
 	memset(&un, 0, sizeof(un));
 
-	TEST(uname(&un));
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "uname() failed");
-		return;
-	}
+	TST_EXP_PASS(uname(&un));
 
-	if (TST_RET != 0) {
-		tst_res(TFAIL | TTERRNO,
-			"uname() returned invalid value %ld", TST_RET);
+	if (!TST_PASS)
 		return;
-	}
 
 	if (strcmp(un.sysname, "Linux")) {
 		tst_res(TFAIL, "sysname is not Linux");
 		return;
 	}
 
-	tst_res(TPASS, "uname() succeeded");
+	tst_res(TPASS, "sysname set to Linux");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/uname/uname02.c b/testcases/kernel/syscalls/uname/uname02.c
index 1903dae24..cd4b15487 100644
--- a/testcases/kernel/syscalls/uname/uname02.c
+++ b/testcases/kernel/syscalls/uname/uname02.c
@@ -16,22 +16,7 @@ static void *bad_addr;
 
 static void verify_uname(void)
 {
-	TEST(uname(bad_addr));
-	if (TST_RET == 0) {
-		tst_res(TFAIL, "uname() succeed when failure expected");
-		return;
-	}
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "Invalid uname() return value %ld", TST_RET);
-		return;
-	}
-
-	if (TST_ERR == EFAULT)
-		tst_res(TPASS, "uname() got EFAULT as expected");
-	else
-		tst_res(TFAIL | TTERRNO, "uname() failed unexpectedly");
-
+	TST_EXP_FAIL(uname(bad_addr), EFAULT);
 }
 
 static void setup(void)
-- 
2.26.2

