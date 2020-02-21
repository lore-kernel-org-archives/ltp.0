From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 21 Feb 2020 17:12:54 +0100
Subject: [LTP] [PATCH] lib: fputs() in print_result() is not signal safe
Message-ID: <bac938d8a2d57653b9f22e55c6d222a990b6a5cf.1582301521.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have tests that use tst_res() from signal handler and current
implementation leads to rare hangs if signal arrives in bad time:
  main
   tst_run_tcases
    fork_testrun
     testrun
      run_tests
       run
        tst_res_ -> TINFO from main process
         tst_vres_
          print_result
           fputs
            __lll_lock_wait_private
            <signal handler called>
             tst_res_ -> TINFO from signal handler
              tst_vres_
               print_result
                fputs
                 __lll_lock_wait_private -> HANGS

One example is timer_settime01, where we have TPASS from main process
and TINFO as response to SIGALRM. SIGALRM happening immediately on older
kernels might be a bug, but that is beside the point of this patch.

Replace fputs() with write() to avoid this hang.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/tst_test.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 9a24cffc5011..220d7fdfc548 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -181,7 +181,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 {
 	char buf[1024];
 	char *str = buf;
-	int ret, size = sizeof(buf), ssize, int_errno;
+	int ret, size = sizeof(buf), ssize, int_errno, buflen;
 	const char *str_errno = NULL;
 	const char *res;
 
@@ -255,7 +255,17 @@ static void print_result(const char *file, const int lineno, int ttype,
 
 	snprintf(str, size, "\n");
 
-	fputs(buf, stderr);
+	/* we might be called from signal handler, so use write() */
+	buflen = str - buf + 1;
+	str = buf;
+	while (buflen) {
+		ret = write(STDERR_FILENO, str, buflen);
+		if (ret <= 0)
+			break;
+
+		str += ret;
+		buflen -= ret;
+	}
 }
 
 void tst_vres_(const char *file, const int lineno, int ttype,
-- 
2.18.1

