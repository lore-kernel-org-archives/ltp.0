From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 28 Nov 2016 15:45:28 +0100
Subject: [LTP] [PATCH v4 2/2] testcases/clock_nanosleep01: convert to
 use new test library API
In-Reply-To: <63536c64bfca6f5d86e0854fdcbd41fde452bc76.1480075381.git-series.pvorel@suse.cz>
References: <26cbebb57e3e9df7ed9f76b7ccc67d5f104ad376.1480075381.git-series.pvorel@suse.cz>
 <63536c64bfca6f5d86e0854fdcbd41fde452bc76.1480075381.git-series.pvorel@suse.cz>
Message-ID: <20161128144528.GB4935@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with cosmetic changes (see below), thanks.

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index cee0a45..f64378c 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -117,15 +117,14 @@ static void do_test(unsigned int i)
 {
 	struct test_case *tc = &tcase[i];
 	struct timespec rm = {0};
-	long long elapsed_ms, expect_ms = 0, remain_ms = 0;
+	long long elapsed_ms, expect_ms, remain_ms = 0;
 	pid_t pid = 0;
 
 	tst_res(TINFO, "case %s", tc->desc);
 
 	/* setup */
-	if (tc->ttype == SEND_SIGINT) {
+	if (tc->ttype == SEND_SIGINT)
 		pid = create_sig_proc(SIGINT, 40, 500000);
-	}
 
 	/* test */
 	tst_timer_start(CLOCK_MONOTONIC);
@@ -140,7 +139,7 @@ static void do_test(unsigned int i)
 	}
 
 	/* cleanup */
-	if (pid > 0) {
+	if (pid) {
 		SAFE_KILL(pid, SIGTERM);
 		SAFE_WAIT(NULL);
 	}
@@ -174,7 +173,8 @@ static void do_test(unsigned int i)
 		return;
 	}
 
-	tst_res(TPASS, "returned %ld", TEST_RETURN);
+	tst_res(TPASS, "returned %s (%ld)",
+		tst_strerrno(TEST_RETURN), TEST_RETURN);
 }
 
 static struct tst_test test = {

-- 
Cyril Hrubis
chrubis@suse.cz
