From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Apr 2020 13:40:07 +0200
Subject: [LTP] [PATCH] syscalls/clone301: Fix the test race this time for
 real
Message-ID: <20200408114007.4096-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I have messed up the first fix, sorry, the signal handler has to be
estabilished before the clone3() call, not just before the if ().

This also makes the test more verbose in case of failure, we print what
exactly went wrong which saves time on debugging.

Fixes: f17b3862dceb (syscalls/clone301: Fix race between parent and child)

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Richard Palethorpe <rpalethorpe@suse.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/clone3/clone301.c | 65 +++++++++++++++------
 1 file changed, 48 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index 456291b67..bf009e940 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -17,7 +17,7 @@
 #define DATA	777
 
 static int pidfd, child_tid, parent_tid, parent_received_signal;
-static volatile int child_received_signal;
+static volatile int child_received_signal, child_data;
 static struct clone_args *args;
 
 static struct tcase {
@@ -40,8 +40,8 @@ static void child_rx_signal(int sig, siginfo_t *info, void *ucontext)
 {
 	(void) ucontext;
 
-	if (sig == CHILD_SIGNAL && info && info->si_value.sival_int == DATA)
-		child_received_signal = 1;
+	child_received_signal = sig;
+	child_data = info->si_value.sival_int;
 }
 
 static struct sigaction psig_action = {
@@ -60,23 +60,43 @@ static siginfo_t uinfo = {
 };
 
 
-static void do_child(int clone_pidfd, int n)
+static void do_child(int clone_pidfd)
 {
 	int count = 1000;
 
 	if (clone_pidfd) {
 		child_received_signal = 0;
+		child_data = 0;
+
 		SAFE_SIGACTION(CHILD_SIGNAL, &csig_action, NULL);
 
 		TST_CHECKPOINT_WAKE(0);
 
-		while(!child_received_signal && --count)
+		while (child_received_signal != CHILD_SIGNAL && --count)
 			usleep(100);
 
-		if (child_received_signal)
-			tst_res(TPASS, "clone3() passed: Child received correct signal (index %d)", n);
-		else
-			tst_res(TFAIL, "clone3() failed: Child received incorrect signal (index %d)", n);
+		if (!child_received_signal) {
+			tst_res(TFAIL, "Child haven't got signal");
+			exit(0);
+		}
+
+		if (child_received_signal != CHILD_SIGNAL) {
+			tst_res(TFAIL, "Child got %s (%i) signal expected %s",
+				tst_strsig(child_received_signal),
+				child_received_signal,
+				tst_strsig(CHILD_SIGNAL));
+			exit(0);
+		}
+
+		tst_res(TPASS, "Child got correct signal %s",
+			tst_strsig(CHILD_SIGNAL));
+
+		if (child_data != DATA) {
+			tst_res(TFAIL, "Child got wrong si_value=%i expected %i",
+				child_data, DATA);
+		} else {
+			tst_res(TPASS, "Child got correct si_value");
+		}
 	}
 
 	exit(0);
@@ -97,17 +117,17 @@ static void run(unsigned int n)
 	args->stack_size = 0;
 	args->tls = 0;
 
+	parent_received_signal = 0;
+	SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);
+
 	TEST(pid = clone3(args, sizeof(*args)));
 	if (pid < 0) {
 		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
 		return;
 	}
 
-	parent_received_signal = 0;
-	SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);
-
 	if (!pid)
-		do_child(clone_pidfd, n);
+		do_child(clone_pidfd);
 
 	/* Need to send signal to child process */
 	if (clone_pidfd) {
@@ -122,10 +142,21 @@ static void run(unsigned int n)
 
 	SAFE_WAITPID(pid, &status, __WALL);
 
-	if (parent_received_signal == tc->exit_signal)
-		tst_res(TPASS, "clone3() passed: Parent received correct signal (index %d)", n);
-	else
-		tst_res(TFAIL, "clone3() failed: Parent received incorrect signal (index %d)", n);
+	if (!parent_received_signal) {
+		tst_res(TFAIL, "Parent haven't got signal");
+		return;
+	}
+
+	if (parent_received_signal != tc->exit_signal) {
+		tst_res(TFAIL, "Parent got %s (%i) signal expected %s",
+			tst_strsig(parent_received_signal),
+			parent_received_signal,
+			tst_strsig(tc->exit_signal));
+		return;
+	}
+
+	tst_res(TPASS, "Parent got correct signal %s",
+		tst_strsig(parent_received_signal));
 }
 
 static void setup(void)
-- 
2.24.1

