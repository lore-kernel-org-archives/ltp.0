From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 9 Nov 2018 15:06:19 +0800
Subject: [LTP] [PATCH v2 2/2] lib/tst_test.c: Update result counters when
	calling tst_brk()
In-Reply-To: <1541747179-15679-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <60497535.71361444.1541699583188.JavaMail.zimbra@redhat.com>
 <1541747179-15679-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1541747179-15679-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Only update result counters in library process and main test
   process because the exit status of child can be reported by
   main test process.
2) Increase the skipped counter when calling tst_brk(TCONF).
3) Increase the warnings counter when calling tst_brk(TBROK/TFAIL)
   in test cleanup(), other than that increase the failed counter
   when calling tst_brk(TBROK/TFAIL).
4) Remove duplicate update_results() in run_tcases_per_fs().

Fix: #408

Note:
It is based on the following patch:
http://lists.linux.it/pipermail/ltp/2018-November/009923.html

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 lib/tst_test.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 661fbbf..b98be0d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -174,6 +174,7 @@ static void update_results(int ttype)
 	case TWARN:
 		tst_atomic_inc(&results->warnings);
 	break;
+	case TBROK:
 	case TFAIL:
 		tst_atomic_inc(&results->failed);
 	break;
@@ -275,7 +276,9 @@ static void (*tst_brk_handler)(const char *file, const int lineno, int ttype,
 static void tst_cvres(const char *file, const int lineno, int ttype,
 		      const char *fmt, va_list va)
 {
-	if (TTYPE_RESULT(ttype) == TBROK) {
+	if (TTYPE_RESULT(ttype) == TBROK || TTYPE_RESULT(ttype) == TFAIL) {
+		tst_res(TINFO, "Convert ttype %s to TWARN in test cleanup",
+			tst_strttype(ttype));
 		ttype &= ~TTYPE_MASK;
 		ttype |= TWARN;
 	}
@@ -305,11 +308,15 @@ void tst_vbrk_(const char *file, const int lineno, int ttype,
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
@@ -1155,12 +1162,7 @@ static int run_tcases_per_fs(void)
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



