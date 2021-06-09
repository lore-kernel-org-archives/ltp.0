From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  9 Jun 2021 13:46:57 +0200
Subject: [LTP] [PATCH 2/4] lib: tst_test: Move timeout scaling out of
 fork_testrun()
In-Reply-To: <20210609114659.2445-1-chrubis@suse.cz>
References: <20210609114659.2445-1-chrubis@suse.cz>
Message-ID: <20210609114659.2445-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

There is no point in setting the results->timeout in each iteration of
the tests (either for .all_filesystems or .test_variants) and it's cleaner to
do this once at the start of the testrun.

This also fixes a case where .all_filesystems or .test_variants would
call tst_set_timeout() in a test setup() that would be changed back on
second and subsequent runs because we called the tst_set_timeout()
incorrectly at the start of the fork_testrun().

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_test.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 36a4809c7..7c9061d6d 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1296,7 +1296,7 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	return timeout * timeout_mul;
 }
 
-void tst_set_timeout(int timeout)
+static void set_timeout(int timeout)
 {
 	if (timeout == -1) {
 		tst_res(TINFO, "Timeout per run is disabled");
@@ -1311,24 +1311,22 @@ void tst_set_timeout(int timeout)
 	tst_res(TINFO, "Timeout per run is %uh %02um %02us",
 		results->timeout/3600, (results->timeout%3600)/60,
 		results->timeout % 60);
+}
 
-	if (getpid() == lib_pid)
-		alarm(results->timeout);
-	else
-		heartbeat();
+void tst_set_timeout(int timeout)
+{
+	set_timeout(timeout);
+	heartbeat();
 }
 
 static int fork_testrun(void)
 {
 	int status;
 
-	if (tst_test->timeout)
-		tst_set_timeout(tst_test->timeout);
-	else
-		tst_set_timeout(300);
-
 	SAFE_SIGNAL(SIGINT, sigint_handler);
 
+	alarm(results->timeout);
+
 	test_pid = fork();
 	if (test_pid < 0)
 		tst_brk(TBROK | TERRNO, "fork()");
@@ -1417,6 +1415,11 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 	SAFE_SIGNAL(SIGALRM, alarm_handler);
 	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);
 
+	if (tst_test->timeout)
+		set_timeout(tst_test->timeout);
+	else
+		set_timeout(300);
+
 	if (tst_test->test_variants)
 		test_variants = tst_test->test_variants;
 
-- 
2.31.1

