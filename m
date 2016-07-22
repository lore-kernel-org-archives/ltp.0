From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:51 -0700
Subject: [LTP] [PATCH V3 18/23] replace SIGCLD with SIGCHLD
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-18-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

SIGCLD is defined with SIGCHLD anyway

see

bits/signum.h:#define     SIGCLD          SIGCHLD /* Same as SIGCHLD(System V).  */

additionally these tests can now compile on systemd with
musl libc

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 doc/man3/tst_sig.3                               |  8 ++++----
 doc/man3/tst_tmpdir.3                            |  2 +-
 include/old/test.h                               |  4 ++--
 include/tst_cmd.h                                |  2 +-
 lib/signame.h                                    |  6 +++---
 lib/tst_sig.c                                    |  8 ++++----
 testcases/kernel/fs/doio/doio.c                  |  4 ++--
 testcases/kernel/fs/doio/growfiles.c             |  2 +-
 testcases/kernel/ipc/ipc_stress/signal_test_04.c |  2 +-
 testcases/kernel/ipc/ipc_stress/signals.h        |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl11.c        |  8 ++++----
 testcases/kernel/syscalls/fcntl/fcntl17.c        |  8 ++++----
 testcases/kernel/syscalls/fcntl/fcntl19.c        |  8 ++++----
 testcases/kernel/syscalls/fcntl/fcntl20.c        |  8 ++++----
 testcases/kernel/syscalls/fcntl/fcntl21.c        |  8 ++++----
 testcases/kernel/syscalls/kill/kill02.c          |  6 +++---
 testcases/kernel/syscalls/kill/kill12.c          |  8 ++++----
 testcases/kernel/syscalls/mkdir/mkdir09.c        | 12 ++++++------
 testcases/kernel/syscalls/sighold/sighold02.c    |  2 +-
 tools/top-LTP/proc/sig.c                         |  2 +-
 20 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/doc/man3/tst_sig.3 b/doc/man3/tst_sig.3
index 485c010..7550644 100644
--- a/doc/man3/tst_sig.3
+++ b/doc/man3/tst_sig.3
@@ -55,18 +55,18 @@ of exiting following an unexpected interruption by a signal.
 program.
 .P
 The \fIfork_flag\fR parameter is used to tell \fItst_sig\fR
-whether or not to ignore the SIGCLD signal caused by the death of a
+whether or not to ignore the SIGCHLD signal caused by the death of a
 child process that had previously been created by the
 \fIfork\fR(2) system call (see \fIsignal\fR(2) for more
-information on the SIGCLD signal).
+information on the SIGCHLD signal).
 .P
 Setting \fIfork_flag\fR to FORK will cause \fItst_sig\fR to
-ignore the SIGCLD signal.  This option should be set if the
+ignore the SIGCHLD signal.  This option should be set if the
 test program directly (eg. call \fIfork\fR(2)) or indirectly
 (eg. call \fIsystem\fR(3S)) creates a child process.
 .P
 Setting \fIfork_flag\fR to NOFORK will cause \fItst_sig\fR to
-treat the SIGCLD signal just as any other unexpected
+treat the SIGCHLD signal just as any other unexpected
 signal (ie. the \fIhandler\fR will be called).
 This option should be set by any test program which does not
 directly or indirectly create any child processes.
diff --git a/doc/man3/tst_tmpdir.3 b/doc/man3/tst_tmpdir.3
index 4baa359..b8a8d79 100644
--- a/doc/man3/tst_tmpdir.3
+++ b/doc/man3/tst_tmpdir.3
@@ -61,7 +61,7 @@ to \fBtst_tmpdir()\fR and should be called immediately prior to the test
 exiting via \fBtst_exit()\fR.
 .P
 \fBtst_rmdir()\fR uses the \fBsystem\fR(3S) library routine (which in turn
-calls \fBfork\fR(2)), so tests that use it \fBcannot\fR treat SIGCLD as an
+calls \fBfork\fR(2)), so tests that use it \fBcannot\fR treat SIGCHLD as an
 unexpected signal.
 .P
 Users may gain access to the name of the temporary directory by declaring the
diff --git a/include/old/test.h b/include/old/test.h
index 9c52a83..cb22961 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -72,8 +72,8 @@
 
 
 /* defines for unexpected signal setup routine (set_usig.c) */
-#define FORK    1		/* SIGCLD is to be ignored */
-#define NOFORK  0		/* SIGCLD is to be caught */
+#define FORK    1		/* SIGCHLD is to be ignored */
+#define NOFORK  0		/* SIGCHLD is to be caught */
 #define DEF_HANDLER SIG_ERR	/* tells set_usig() to use default signal handler */
 
 /*
diff --git a/include/tst_cmd.h b/include/tst_cmd.h
index 78c1822..9f4240e 100644
--- a/include/tst_cmd.h
+++ b/include/tst_cmd.h
@@ -92,7 +92,7 @@ static inline int tst_run_cmd(void (cleanup_fn)(void),
 }
 #endif
 
-/* Wrapper function for system(3), ignorcing SIGCLD signal.
+/* Wrapper function for system(3), ignorcing SIGCHLD signal.
  * @command: the command to be run.
  */
 int tst_system(const char *command);
diff --git a/lib/signame.h b/lib/signame.h
index 19d38d9..932ad1f 100644
--- a/lib/signame.h
+++ b/lib/signame.h
@@ -51,9 +51,9 @@ const char *tst_strsig(int sig)
 		PAIR(SIGSTKFLT)
 	#endif
 
-	#ifdef SIGCLD
-		/* SIGCLD same as SIGCHLD */
-		STRPAIR(SIGCHLD, "SIGCHLD/SIGCLD")
+	#ifdef SIGCHLD
+		/* SIGCHLD same as SIGCHLD */
+		STRPAIR(SIGCHLD, "SIGCHLD/SIGCHLD")
 	#else
 		PAIR(SIGCHLD)
 	#endif
diff --git a/lib/tst_sig.c b/lib/tst_sig.c
index 3af5ffd..36565e1 100644
--- a/lib/tst_sig.c
+++ b/lib/tst_sig.c
@@ -49,7 +49,7 @@
 		fork_flag - set to FORK or NOFORK depending upon whether the
 			calling program executes a fork() system call.  It
 			is normally the case that the calling program treats
-			SIGCLD as an expected signal if fork() is being used.
+			SIGCHLD as an expected signal if fork() is being used.
 
 		handler - a pointer to the unexpected signal handler to
 			be executed after an unexpected signal has been
@@ -82,7 +82,7 @@ static void (*tst_setup_signal(int, void (*)(int))) (int);
 
 /****************************************************************************
  * tst_sig() : set-up to catch unexpected signals.  fork_flag is set to NOFORK
- *    if SIGCLD is to be an "unexpected signal", otherwise it is set to
+ *    if SIGCHLD is to be an "unexpected signal", otherwise it is set to
  *    FORK.  cleanup points to a cleanup routine to be executed before
  *    tst_exit is called (cleanup is set to NULL if no cleanup is desired).
  *    handler is a pointer to the signal handling routine (if handler is
@@ -117,7 +117,7 @@ void tst_sig(int fork_flag, void (*handler) (), void (*cleanup) ())
 	for (sig = 1; sig < NSIG; sig++) {
 		/*
 		 * SIGKILL is never unexpected.
-		 * SIGCLD is only unexpected when
+		 * SIGCHLD is only unexpected when
 		 *    no forking is being done.
 		 * SIGINFO is used for file quotas and should be expected
 		 */
@@ -205,7 +205,7 @@ void tst_sig(int fork_flag, void (*handler) (), void (*cleanup) ())
 #endif
 			break;
 
-		case SIGCLD:
+		case SIGCHLD:
 			if (fork_flag == FORK)
 				continue;
 
diff --git a/testcases/kernel/fs/doio/doio.c b/testcases/kernel/fs/doio/doio.c
index 4b0dec5..5f65ef9 100644
--- a/testcases/kernel/fs/doio/doio.c
+++ b/testcases/kernel/fs/doio/doio.c
@@ -573,7 +573,7 @@ int main(int argc, char **argv)
 		case SIGTSTP:
 		case SIGSTOP:
 		case SIGCONT:
-		case SIGCLD:
+		case SIGCHLD:
 		case SIGBUS:
 		case SIGSEGV:
 		case SIGQUIT:
@@ -615,7 +615,7 @@ int main(int argc, char **argv)
 	}
 
 	sigemptyset(&block_mask);
-	sigaddset(&block_mask, SIGCLD);
+	sigaddset(&block_mask, SIGCHLD);
 	sigprocmask(SIG_BLOCK, &block_mask, &omask);
 
 	/*
diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
index 09e7f35..bbad230 100644
--- a/testcases/kernel/fs/doio/growfiles.c
+++ b/testcases/kernel/fs/doio/growfiles.c
@@ -1640,7 +1640,7 @@ int set_sig(void)
 #ifdef SIGRESTART
 		case SIGRESTART:
 #endif /* SIGRESTART */
-		case SIGCLD:
+		case SIGCHLD:
 			break;
 
 		default:
diff --git a/testcases/kernel/ipc/ipc_stress/signal_test_04.c b/testcases/kernel/ipc/ipc_stress/signal_test_04.c
index e33a46f..9ee75ce 100644
--- a/testcases/kernel/ipc/ipc_stress/signal_test_04.c
+++ b/testcases/kernel/ipc/ipc_stress/signal_test_04.c
@@ -147,7 +147,7 @@ int main(int argc, char **argv)
 	 * stop upon receiving the signal).
 	 *
 	 * Wait for the child process to receive the SIGSTOP signal
-	 * and send a corresponding SIGCLD interrupt to the parent.
+	 * and send a corresponding SIGCHLD interrupt to the parent.
 	 *
 	 * Send SIGKILL signal to child process (child process
 	 * will exit upon receiving the signal).
diff --git a/testcases/kernel/ipc/ipc_stress/signals.h b/testcases/kernel/ipc/ipc_stress/signals.h
index a842123..d9b6e14 100644
--- a/testcases/kernel/ipc/ipc_stress/signals.h
+++ b/testcases/kernel/ipc/ipc_stress/signals.h
@@ -38,7 +38,7 @@ char * signames [] =
  "SIGALRM", //         14      // Alarm clock (POSIX).
  "SIGTERM", //         15      // Termination (ANSI).
  "SIGSTKFLT", //       16      // Stack fault.
- "SIGCLD/SIGCHLD", //  SIGCHLD // Same as SIGCHLD (System V).
+ "SIGCHLD/SIGCHLD", //  SIGCHLD // Same as SIGCHLD (System V).
  //"SIGCHLD", //       17      // Child status has changed (POSIX).
  "SIGCONT", //         18      // Continue (POSIX).
  "SIGSTOP", //         19      // Stop, unblockable (POSIX).
diff --git a/testcases/kernel/syscalls/fcntl/fcntl11.c b/testcases/kernel/syscalls/fcntl/fcntl11.c
index fa6ce53..2de2b6c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl11.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl11.c
@@ -105,10 +105,10 @@ void setup(void)
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
 	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGCLD);
-	if ((sigaction(SIGCLD, &act, NULL)) < 0)
+	sigaddset(&act.sa_mask, SIGCHLD);
+	if ((sigaction(SIGCHLD, &act, NULL)) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup,
-			 "sigaction(SIGCLD, ..) failed");
+			 "sigaction(SIGCHLD, ..) failed");
 }
 
 void do_child(void)
@@ -227,7 +227,7 @@ void stop_child(void)
 {
 	struct flock fl;
 
-	signal(SIGCLD, SIG_DFL);
+	signal(SIGCHLD, SIG_DFL);
 	fl.l_type = STOP;
 	parent_put(&fl);
 	wait(0);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl17.c b/testcases/kernel/syscalls/fcntl/fcntl17.c
index 229e490..e055f1a 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl17.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl17.c
@@ -150,9 +150,9 @@ int setup(void)
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
 	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGCLD);
-	if (sigaction(SIGCLD, &act, NULL) < 0) {
-		tst_resm(TFAIL, "SIGCLD signal setup failed, errno: %d", errno);
+	sigaddset(&act.sa_mask, SIGCHLD);
+	if (sigaction(SIGCHLD, &act, NULL) < 0) {
+		tst_resm(TFAIL, "SIGCHLD signal setup failed, errno: %d", errno);
 		return 1;
 	}
 	return 0;
@@ -390,7 +390,7 @@ void stop_children(void)
 {
 	int arg;
 
-	signal(SIGCLD, SIG_DFL);
+	signal(SIGCHLD, SIG_DFL);
 	arg = STOP;
 	child_free(child_pipe1[1], arg);
 	child_free(child_pipe2[1], arg);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl19.c b/testcases/kernel/syscalls/fcntl/fcntl19.c
index a542cfc..88c91d6 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl19.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl19.c
@@ -112,9 +112,9 @@ void setup(void)
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
 	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGCLD);
-	if ((sigaction(SIGCLD, &act, NULL)) < 0) {
-		tst_resm(TFAIL, "SIGCLD signal setup failed, errno: %d", errno);
+	sigaddset(&act.sa_mask, SIGCHLD);
+	if ((sigaction(SIGCHLD, &act, NULL)) < 0) {
+		tst_resm(TFAIL, "SIGCHLD signal setup failed, errno: %d", errno);
 		fail = 1;
 	}
 }
@@ -265,7 +265,7 @@ void stop_child(void)
 {
 	struct flock fl;
 
-	signal(SIGCLD, SIG_DFL);
+	signal(SIGCHLD, SIG_DFL);
 	fl.l_type = STOP;
 	parent_put(&fl);
 	wait(0);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl20.c b/testcases/kernel/syscalls/fcntl/fcntl20.c
index aa06bab..99fd783 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl20.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl20.c
@@ -109,9 +109,9 @@ void setup(void)
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
 	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGCLD);
-	if (sigaction(SIGCLD, &act, NULL) == -1)
-		tst_brkm(TFAIL | TERRNO, cleanup, "SIGCLD signal setup failed");
+	sigaddset(&act.sa_mask, SIGCHLD);
+	if (sigaction(SIGCHLD, &act, NULL) == -1)
+		tst_brkm(TFAIL | TERRNO, cleanup, "SIGCHLD signal setup failed");
 }
 
 void cleanup(void)
@@ -264,7 +264,7 @@ void stop_child(void)
 {
 	struct flock fl;
 
-	signal(SIGCLD, SIG_DFL);
+	signal(SIGCHLD, SIG_DFL);
 	fl.l_type = STOP;
 	parent_put(&fl);
 	wait(0);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl21.c b/testcases/kernel/syscalls/fcntl/fcntl21.c
index 5307021..8f1a67c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl21.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl21.c
@@ -110,9 +110,9 @@ void setup(void)
 	memset(&act, 0, sizeof(act));
 	act.sa_handler = catch_child;
 	sigemptyset(&act.sa_mask);
-	sigaddset(&act.sa_mask, SIGCLD);
-	if ((sigaction(SIGCLD, &act, NULL)) < 0) {
-		tst_resm(TFAIL, "SIGCLD signal setup failed, errno: %d", errno);
+	sigaddset(&act.sa_mask, SIGCHLD);
+	if ((sigaction(SIGCHLD, &act, NULL)) < 0) {
+		tst_resm(TFAIL, "SIGCHLD signal setup failed, errno: %d", errno);
 		fail = 1;
 	}
 }
@@ -272,7 +272,7 @@ void stop_child(void)
 {
 	struct flock fl;
 
-	signal(SIGCLD, SIG_DFL);
+	signal(SIGCHLD, SIG_DFL);
 	fl.l_type = STOP;
 	parent_put(&fl);
 	wait(0);
diff --git a/testcases/kernel/syscalls/kill/kill02.c b/testcases/kernel/syscalls/kill/kill02.c
index 9d6cc68..08360dd 100644
--- a/testcases/kernel/syscalls/kill/kill02.c
+++ b/testcases/kernel/syscalls/kill/kill02.c
@@ -701,7 +701,7 @@ void setup(void)
 
 	/*
 	 *  Set to catch unexpected signals.
-	 *  SIGCLD is set to be ignored because we do not wait for termination status.
+	 *  SIGCHLD is set to be ignored because we do not wait for termination status.
 	 *  SIGUSR1 is set to be ignored because this is the signal we are using for
 	 *  the test and we are not concerned with the parent getting it.
 	 */
@@ -713,9 +713,9 @@ void setup(void)
 			 "signal(SIGUSR1, SIG_IGN) failed");
 	}
 
-	if (signal(SIGCLD, SIG_IGN) == SIG_ERR) {
+	if (signal(SIGCHLD, SIG_IGN) == SIG_ERR) {
 		tst_brkm(TBROK | TERRNO, NULL,
-			 "signal(SIGCLD, SIG_IGN) failed");
+			 "signal(SIGCHLD, SIG_IGN) failed");
 	}
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/kill/kill12.c b/testcases/kernel/syscalls/kill/kill12.c
index 7a47a4a..d7c4147 100644
--- a/testcases/kernel/syscalls/kill/kill12.c
+++ b/testcases/kernel/syscalls/kill/kill12.c
@@ -98,7 +98,7 @@ int main(int argc, char **argv)
 
 	exno = 1;
 
-	if (sigset(SIGCLD, chsig) == SIG_ERR) {
+	if (sigset(SIGCHLD, chsig) == SIG_ERR) {
 		fprintf(temp, "\tsigset failed, errno = %d\n", errno);
 		fail_exit();
 	}
@@ -128,7 +128,7 @@ int main(int argc, char **argv)
 				sleep(1);
 
 			kill(pid, sig);	/* child should ignroe this sig */
-			kill(pid, SIGCLD);	/* child should exit */
+			kill(pid, SIGCHLD);	/* child should exit */
 
 #ifdef BCS
 			while ((npid = wait(&status)) != pid
@@ -222,14 +222,14 @@ void do_child(void)
 	int exno = 1;
 
 #ifdef UCLINUX
-	if (sigset(SIGCLD, chsig) == SIG_ERR) {
+	if (sigset(SIGCHLD, chsig) == SIG_ERR) {
 		fprintf(temp, "\tsigset failed, errno = %d\n", errno);
 		fail_exit();
 	}
 #endif
 
 	sigset(sig, SIG_IGN);	/* set to ignore signal */
-	kill(getppid(), SIGCLD);	/* tell parent we are ready */
+	kill(getppid(), SIGCHLD);	/* tell parent we are ready */
 	while (!chflag)
 		sleep(1);	/* wait for parent */
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir09.c b/testcases/kernel/syscalls/mkdir/mkdir09.c
index 41c20e9..07b4fb8 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir09.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir09.c
@@ -122,10 +122,10 @@ int main(int argc, char *argv[])
 
 	}
 
-	/* Set up to catch SIGCLD signal */
-	if (signal(SIGCLD, chld) == SIG_ERR) {
+	/* Set up to catch SIGCHLD signal */
+	if (signal(SIGCHLD, chld) == SIG_ERR) {
 		tst_brkm(TFAIL, cleanup,
-			 "Error setting up SIGCLD signal, ERRNO = %d", errno);
+			 "Error setting up SIGCHLD signal, ERRNO = %d", errno);
 
 	}
 
@@ -236,9 +236,9 @@ int runtest(void)
 		tst_brkm(TFAIL, cleanup,
 			 "Error resetting SIGTERM signal, ERRNO = %d", errno);
 	}
-	if (signal(SIGCLD, SIG_DFL) == SIG_ERR) {
+	if (signal(SIGCHLD, SIG_DFL) == SIG_ERR) {
 		tst_brkm(TFAIL, cleanup,
-			 "Error resetting SIGCLD signal, ERRNO = %d", errno);
+			 "Error resetting SIGCHLD signal, ERRNO = %d", errno);
 	}
 
 	if (test_time) {
@@ -372,7 +372,7 @@ void term(int sig)
 
 void chld(int sig)
 {
-	/* Routine to handle SIGCLD signal. */
+	/* Routine to handle SIGCHLD signal. */
 
 	sigchld++;
 	if (jump) {
diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
index e3076fb..be01874 100644
--- a/testcases/kernel/syscalls/sighold/sighold02.c
+++ b/testcases/kernel/syscalls/sighold/sighold02.c
@@ -77,7 +77,7 @@ static int sigs_map[NUMSIGS];
 static int skip_sig(int sig)
 {
 	switch (sig) {
-	case SIGCLD:
+	case SIGCHLD:
 	case SIGKILL:
 	case SIGALRM:
 	case SIGSTOP:
diff --git a/tools/top-LTP/proc/sig.c b/tools/top-LTP/proc/sig.c
index 1cfad86..0f9bdee 100644
--- a/tools/top-LTP/proc/sig.c
+++ b/tools/top-LTP/proc/sig.c
@@ -23,7 +23,7 @@
  * You get SIGSTKFLT and SIGUNUSED instead on i386, m68k, ppc, and arm.
  * (this is a Linux & libc bug -- both must be fixed)
  *
- * Total garbage: SIGIO SIGINFO SIGIOT SIGLOST SIGCLD
+ * Total garbage: SIGIO SIGINFO SIGIOT SIGLOST SIGCHLD
  *                 (popular ones are handled as aliases)
  * Nearly garbage: SIGSTKFLT SIGUNUSED (nothing else to fill slots)
  */
-- 
2.9.0

