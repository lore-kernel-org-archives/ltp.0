From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:32 +0100
Subject: [LTP] [COMMITTED] [PATCH 10/23] syscalls/kill12: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of UCLINUX ifdefs

* Remove useless comments

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/kill/kill12.c | 38 +++------------------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill12.c b/testcases/kernel/syscalls/kill/kill12.c
index d7c4147..8ab641d 100644
--- a/testcases/kernel/syscalls/kill/kill12.c
+++ b/testcases/kernel/syscalls/kill/kill12.c
@@ -25,8 +25,8 @@
 /*======================================================================
 >KEYS:  < kill(), wait(), signal()
 >WHAT:  < Check that when a child is killed by its parent, it returns the
-   	< correct values to the waiting parent--the child sets signal to
-   	< ignore the kill
+	< correct values to the waiting parent--the child sets signal to
+	< ignore the kill
 >HOW:   < For each signal: Send that signal to a child that has elected
 	< to catch the signal, check that the correct status was returned
 	< to the waiting parent.
@@ -46,8 +46,6 @@
 #include <sys/wait.h>
 #include <errno.h>
 
-//char progname[] = "kill2()";
-/*****  LTP Port        *****/
 #include "test.h"
 #define ITER    3
 #define FAILED 0
@@ -71,29 +69,19 @@ void ok_exit();
 int forkfail();
 void do_child();
 
-/*****  **      **      *****/
-
 int chflag;
 
-/*--------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
-/***** BEGINNING OF MAIN. *****/
 	int pid, npid;
 	int nsig, exno, nexno, status;
 	int ret_val = 0;
 	int core;
 	void chsig();
 
-#ifdef UCLINUX
-
 	tst_parse_opts(argc, argv, NULL, NULL);
 
-	maybe_run_child(&do_child, "dd", &temp, &sig);
-#endif
-
 	setup();
-	//tempdir();            /* move to new directory */ 12/20/2003
 	blenter();
 
 	exno = 1;
@@ -113,14 +101,7 @@ int main(int argc, char **argv)
 		}
 
 		if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv[0], "dd", temp, sig) < 0) {
-				tst_brkm(TBROK, NULL, "self_exec FAILED - "
-					 "terminating test.");
-			}
-#else
 			do_child();
-#endif
 		} else {
 			//fprintf(temp, "Testing signal %d\n", sig);
 
@@ -196,19 +177,15 @@ int main(int argc, char **argv)
 	if (ret_val)
 		local_flag = FAILED;
 
-/*--------------------------------------------------------------------*/
 	anyfail();
 	tst_exit();
-}					/******** END OF MAIN. ********/
-
-/*--------------------------------------------------------------------*/
+}
 
 void chsig(void)
 {
 	chflag++;
 }
 
-/****** LTP Port        *****/
 int anyfail(void)
 {
 	(local_flag == FAILED) ? tst_resm(TFAIL,
@@ -221,13 +198,6 @@ void do_child(void)
 {
 	int exno = 1;
 
-#ifdef UCLINUX
-	if (sigset(SIGCHLD, chsig) == SIG_ERR) {
-		fprintf(temp, "\tsigset failed, errno = %d\n", errno);
-		fail_exit();
-	}
-#endif
-
 	sigset(sig, SIG_IGN);	/* set to ignore signal */
 	kill(getppid(), SIGCHLD);	/* tell parent we are ready */
 	while (!chflag)
@@ -264,5 +234,3 @@ int forkfail(void)
 {
 	tst_brkm(TBROK, NULL, "FORK FAILED - terminating test.");
 }
-
-/****** ** **   *******/
-- 
2.10.2

