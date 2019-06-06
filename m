From: Yann Sionneau <ysionneau@kalray.eu>
Date: Thu,  6 Jun 2019 17:21:17 +0200
Subject: [LTP] [PATCH] Fix use of results after being unmapped
Message-ID: <1559834477-21724-1-git-send-email-ysionneau@kalray.eu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes issue reported there: https://github.com/linux-test-project/ltp/issues/537
---
 lib/tst_test.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 95f389d..73eca58 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -138,6 +138,7 @@ static void cleanup_ipc(void)
 	if (results) {
 		msync((void*)results, size, MS_SYNC);
 		munmap((void*)results, size);
+		results = NULL;
 	}
 }
 
@@ -921,10 +922,11 @@ static void do_cleanup(void)
 	if (tst_test->save_restore)
 		tst_sys_conf_restore(0);
 
-	cleanup_ipc();
-
 	if (tst_test->restore_wallclock)
 		tst_wallclock_restore();
+
+	cleanup_ipc();
+	/* Do not use 'results' after cleanup_ipc(): it has been unmapped. */
 }
 
 static void run_tests(void)
-- 
1.8.3.1

