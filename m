From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  7 Sep 2017 17:57:45 +0200
Subject: [LTP] [PATCH] [RFC] lib/tst_test: Report 0 if test has both TPASS
	and TCONF
Message-ID: <20170907155745.9116-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It's probably a bit more logical to report a succes if only part of the
test was skipped and the rest was sucessful. That way we can distinguish
tests that were compiled-out completely or where the kernel does not
support the particular syscall at all. The difference is about 15
testcases that report TPASS instead of TCONF after this change.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_res.c  | 11 ++++++++++-
 lib/tst_test.c |  2 +-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index ff0ad685f..8cf5f0d4a 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -91,6 +91,7 @@ static void tst_condense(int tnum, int ttype, const char *tmesg);
 static void tst_print(const char *tcid, int tnum, int ttype, const char *tmesg);
 
 static int T_exitval = 0;	/* exit value used by tst_exit() */
+static int passed_cnt;
 static int T_mode = VERBOSE;	/* flag indicating print mode: VERBOSE, */
 				/* NOPASS, DISCARD */
 
@@ -166,6 +167,9 @@ static void tst_res__(const char *file, const int lineno, int ttype,
 	 */
 	T_exitval |= ttype_result;
 
+	if (ttype_result == TPASS)
+		passed_cnt++;
+
 	check_env();
 
 	/*
@@ -390,7 +394,12 @@ void tst_exit(void)
 
 	tst_flush();
 
-	exit(T_exitval & ~TINFO);
+	T_exitval &= ~TINFO;
+
+	if (T_exitval == TCONF && passed_cnt)
+		T_exitval &= ~TCONF;
+
+	exit(T_exitval);
 }
 
 pid_t tst_fork(void)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 4c30edab5..f72de82d4 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -561,7 +561,7 @@ static void do_exit(int ret)
 		if (results->failed)
 			ret |= TFAIL;
 
-		if (results->skipped)
+		if (results->skipped && !results->passed)
 			ret |= TCONF;
 
 		if (results->warnings)
-- 
2.13.0

