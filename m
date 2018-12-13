From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Dec 2018 16:35:59 +0800
Subject: [LTP] [PATCH v3 2/3] lib/tst_test.c: Update result counters when
	calling tst_brk()
In-Reply-To: <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1544690160-13900-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Catch and report the TFAIL exit status of child process.
2) Only update result counters in library process and main test
   process because the exit status of child can be reported by
   main test process.
3) Print TCONF message and increase skipped when calling tst_brk(TCONF).
   Print TBROK message and increase broken when calling tst_brk(TBROK).
   Print TFAIL message and increase failed when calling tst_brk(TFAIL).
4) Remove duplicate update_results() in run_tcases_per_fs().

Fixes: #408

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_test.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbf..e46ab8e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -55,6 +55,7 @@ struct results {
 	int skipped;
 	int failed;
 	int warnings;
+	int broken;
 	unsigned int timeout;
 };
 
@@ -177,6 +178,9 @@ static void update_results(int ttype)
 	case TFAIL:
 		tst_atomic_inc(&results->failed);
 	break;
+	case TBROK:
+		tst_atomic_inc(&results->broken);
+	break;
 	}
 }
 
@@ -305,11 +309,15 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
 	 * specified but CLONE_THREAD is not. Use direct syscall to avoid
 	 * cleanup running in the child.
 	 */
-	if (syscall(SYS_getpid) == main_pid)
+	if (syscall(SYS_getpid) == main_pid) {
+		update_results(TTYPE_RESULT(ttype));
 		do_test_cleanup();
+	}
 
-	if (getpid() == lib_pid)
+	if (getpid() == lib_pid) {
+		update_results(TTYPE_RESULT(ttype));
 		do_exit(TTYPE_RESULT(ttype));
+	}
 
 	exit(TTYPE_RESULT(ttype));
 }
@@ -350,6 +358,7 @@ static void check_child_status(pid_t pid, int status)
 	switch (ret) {
 	case TPASS:
 	break;
+	case TFAIL:
 	case TBROK:
 	case TCONF:
 		tst_brk(ret, "Reported by child (%i)", pid);
@@ -591,6 +600,7 @@ static void do_exit(int ret)
 		printf("failed   %d\n", results->failed);
 		printf("skipped  %d\n", results->skipped);
 		printf("warnings %d\n", results->warnings);
+		printf("broken   %d\n", results->broken);
 
 		if (results->passed && ret == TCONF)
 			ret = 0;
@@ -603,6 +613,9 @@ static void do_exit(int ret)
 
 		if (results->warnings)
 			ret |= TWARN;
+
+		if (results->broken)
+			ret |= TBROK;
 	}
 
 	do_cleanup();
@@ -1155,12 +1168,7 @@ static int run_tcases_per_fs(void)
 			mntpoint_mounted = 0;
 		}
 
-		if (ret == TCONF) {
-			update_results(ret);
-			continue;
-		}
-
-		if (ret == 0)
+		if (ret == TCONF || ret == 0)
 			continue;
 
 		do_exit(ret);
-- 
1.8.3.1



