From: Li Wang <liwang@redhat.com>
Date: Thu, 12 May 2016 16:49:52 +0800
Subject: [LTP] [PATCH 5/6] syscalls/madvise05: Convert to new test API
In-Reply-To: <1463042993-398-4-git-send-email-liwang@redhat.com>
References: <1463042993-398-1-git-send-email-liwang@redhat.com>
 <1463042993-398-2-git-send-email-liwang@redhat.com>
 <1463042993-398-3-git-send-email-liwang@redhat.com>
 <1463042993-398-4-git-send-email-liwang@redhat.com>
Message-ID: <1463042993-398-5-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise05.c | 64 +++++++++------------------
 1 file changed, 20 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise05.c b/testcases/kernel/syscalls/madvise/madvise05.c
index cdbc26f..612c967 100644
--- a/testcases/kernel/syscalls/madvise/madvise05.c
+++ b/testcases/kernel/syscalls/madvise/madvise05.c
@@ -26,60 +26,36 @@
 
 #include <sys/mman.h>
 #include <errno.h>
-
-#include "test.h"
-#include "safe_macros.h"
+#include "tst_test.h"
 
 #define ALLOC_SIZE (32 * 1024 * 1024)
 
-static void setup(void);
-static void cleanup(void);
-
-char *TCID = "madvise05";
-int TST_TOTAL = 1;
-
-int main(int argc, char *argv[])
+static void verify_madvise(void)
 {
-	int lc;
 	void *p;
 
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		p = SAFE_MMAP(cleanup, NULL, ALLOC_SIZE, PROT_READ,
+	p = SAFE_MMAP(NULL, ALLOC_SIZE, PROT_READ,
 			MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
-		TEST(mprotect(p, ALLOC_SIZE, PROT_NONE));
-		if (TEST_RETURN == -1)
-			tst_brkm(TBROK | TTERRNO, cleanup, "mprotect failed");
-		TEST(madvise(p, ALLOC_SIZE, MADV_WILLNEED));
-		SAFE_MUNMAP(cleanup, p, ALLOC_SIZE);
 
-		if (TEST_RETURN == 0)
-			continue;
+	TEST(mprotect(p, ALLOC_SIZE, PROT_NONE));
+	if (TEST_RETURN == -1)
+		tst_brk(TBROK | TTERRNO, "mprotect failed");
+	TEST(madvise(p, ALLOC_SIZE, MADV_WILLNEED));
+	SAFE_MUNMAP(p, ALLOC_SIZE);
 
-		if (TEST_ERRNO == EBADF)
-			tst_brkm(TCONF, cleanup, "CONFIG_SWAP=n");
-		else
-			tst_brkm(TBROK | TTERRNO, cleanup, "madvise failed");
+	if (TEST_RETURN == 0) {
+		tst_res(TPASS, "issue has not been reproduced");
+		return;
 	}
 
-	tst_resm(TPASS, "issue has not been reproduced");
-
-	cleanup();
-	tst_exit();
+	if (TEST_ERRNO == EBADF)
+		tst_brk(TCONF, "CONFIG_SWAP=n");
+	else
+		tst_brk(TBROK | TTERRNO, "madvise failed");
 }
 
-static void setup(void)
-{
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-	if (tst_kvercmp(3, 9, 0) < 0)
-		tst_brkm(TCONF, NULL, "madvise(MADV_WILLNEED) swap file "
-			"prefetch available only since 3.9");
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-}
+static struct tst_test test = {
+	.tid = "madvice05",
+	.min_kver = "3.9.0",
+	.test_all = verify_madvise,
+};
-- 
1.8.3.1

