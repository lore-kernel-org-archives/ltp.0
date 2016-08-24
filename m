From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:50 +0300
Subject: [LTP] [PATCH V2 02/11] waitpid10: use the new API
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-3-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* update the description to match the actions performed in the test
* make use of the new API
* make use of reap_children() in do_fork()
* put the test function inside do_child_1(), i.e. it forks one more time
  than in the original test. It's just for similarity with other test
  cases. This change brings no harm or improvements.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
Changes since V1:
 * Update the commit description to explain why I use do_child_1() here

 testcases/kernel/syscalls/waitpid/waitpid10.c |  312 ++++---------------------
 1 files changed, 47 insertions(+), 265 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index d239fda..a505ade 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -14,263 +14,59 @@
  * the GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
- * along with this program;  if not, write to the Free Software Foundation,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ * along with this program.
  */
 
 /*
- * Tests to see if pid's returned from fork and waitpid are same
+ * Tests to see if pids returned from fork and waitpid are same
  *
- * Set up to catch SIGINTs, SIGALRMs, and the real time timer. Until the timer
- * interrupts, do the following. Fork 8 kids, 2 will immediately exit, 2 will
- * sleep, 2 will be compute bound, and 2 will fork another child, both which
- * will do mkdirs on the same directory 50 times. When the timer expires, kill
- * all kids and remove the directory.
+ * Fork 8 kids, 2 will immediately exit, 2 will sleep, 2 will be compute bound
+ * and 2 will fork/reap a child for 50 times.
  */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
+#include "waitpid_common.h"
 
-#include <stdio.h>
-#include <signal.h>
-#include <errno.h>
-#include "test.h"
-
-#define	MAXKIDS	8
-
-char *TCID = "waitpid10";
-int TST_TOTAL = 1;
-
-volatile int intintr;
-
-static void setup(void);
-static void cleanup(void);
-static void inthandlr();
-static void wait_for_parent(void);
-static void do_exit(void);
 static void do_compute(void);
 static void do_fork(void);
 static void do_sleep(void);
 
-static int fail;
-static int fork_kid_pid[MAXKIDS];
-
-#ifdef UCLINUX
-static char *argv0;
-#endif
-
-int main(int ac, char **av)
+static void do_child_1(void)
 {
-	int kid_count, ret_val, status, nkids;
-	int i, j, k, found;
-	int wait_kid_pid[MAXKIDS];
-
-	int lc;
-
-	tst_parse_opts(ac, av, NULL, NULL);
-
-#ifdef UCLINUX
-	argv0 = av[0];
-
-	maybe_run_child(&do_exit, "n", 1);
-	maybe_run_child(&do_compute, "n", 2);
-	maybe_run_child(&do_fork, "n", 3);
-	maybe_run_child(&do_sleep, "n", 4);
-#endif
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		fail = 0;
-		kid_count = 0;
-		intintr = 0;
-		for (i = 0; i < MAXKIDS; i++) {
-			ret_val = FORK_OR_VFORK();
-			if (ret_val < 0)
-				tst_brkm(TBROK|TERRNO, cleanup,
-					 "Fork kid %d failed.", i);
-
-			if (ret_val == 0) {
-				if (i == 0 || i == 1) {
-#ifdef UCLINUX
-					if (self_exec(argv0, "n", 1) < 0)
-						tst_brkm(TBROK|TERRNO, cleanup,
-							 "self_exec %d failed",
-							 i);
-#else
-					do_exit();
-#endif
-				}
-
-				if (i == 2 || i == 3) {
-#ifdef UCLINUX
-					if (self_exec(argv0, "n", 2) < 0)
-						tst_brkm(TBROK|TERRNO, cleanup,
-							 "self_exec %d failed",
-							 i);
-#else
-					do_compute();
-#endif
-				}
-
-				if (i == 4 || i == 5) {
-#ifdef UCLINUX
-					if (self_exec(argv0, "n", 3) < 0)
-						tst_brkm(TBROK|TERRNO, cleanup,
-							 "self_exec %d failed",
-							 i);
-#else
-					do_fork();
-#endif
-				}
-
-				if (i == 6 || i == 7) {
-#ifdef UCLINUX
-					if (self_exec(argv0, "n", 4) < 0)
-						tst_brkm(TBROK|TERRNO, cleanup,
-							 "self_exec %d failed",
-							 i);
-#else
-					do_sleep();
-#endif
-
-				}
-
-			}
-
-			fork_kid_pid[kid_count++] = ret_val;
-		}
-
-		nkids = kid_count;
-
-		/*
-		 * Now send all the kids a SIGUSR1 to tell them to
-		 * proceed. We sleep for a while first to allow the
-		 * children to initialize their "intintr" variables
-		 * and get set up.
-		 */
-		sleep(15);
+	pid_t pid;
+	int i;
 
-		for (i = 0; i < nkids; i++) {
-			if (kill(fork_kid_pid[i], SIGUSR1) < 0) {
-				tst_brkm(TBROK|TERRNO, cleanup, "Kill of child "
-						"%d failed", i);
-			}
-		}
+	for (i = 0; i < MAXKIDS; i++) {
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			if (i == 0 || i == 1)
+				do_exit(0);
 
-		/* Wait till all kids have terminated. */
-		kid_count = 0;
-		errno = 0;
-		for (i = 0; i < nkids; i++) {
-			while (((ret_val = waitpid(fork_kid_pid[i],
-							&status, 0)) != -1)
-					|| (errno == EINTR)) {
-				if (ret_val == -1)
-					continue;
+			if (i == 2 || i == 3)
+				do_compute();
 
-				wait_kid_pid[kid_count++] = ret_val;
-			}
-		}
+			if (i == 4 || i == 5)
+				do_fork();
 
-		/*
-		 * Check that for every entry in the fork_kid_pid
-		 * array, there is a matching pid in the
-		 * wait_kid_pid array.
-		 */
-		for (i = 0; i < MAXKIDS; i++) {
-			found = 0;
-			for (j = 0; j < MAXKIDS; j++) {
-				if (fork_kid_pid[i] == wait_kid_pid[j]) {
-					found = 1;
-					break;
-				}
-			}
-			if (!found) {
-				tst_resm(TFAIL, "Did not find a "
-						"wait_kid_pid for the "
-						"fork_kid_pid of %d",
-						fork_kid_pid[i]);
-				for (k = 0; k < nkids; k++) {
-					tst_resm(TFAIL,
-							"fork_kid_pid[%d] = "
-							"%d", k,
-							fork_kid_pid[k]);
-				}
-				for (k = 0; k < kid_count; k++) {
-					tst_resm(TFAIL,
-							"wait_kid_pid[%d] = "
-							"%d", k,
-							wait_kid_pid[k]);
-				}
-				fail = 1;
-			}
+			if (i == 6 || i == 7)
+				do_sleep();
 		}
 
-		memset(fork_kid_pid, 0, sizeof(fork_kid_pid));
-
-		if (fail)
-			tst_resm(TFAIL, "Test FAILED");
-		else
-			tst_resm(TPASS, "Test PASSED");
+		fork_kid_pid[i] = pid;
 	}
 
-	cleanup();
-	tst_exit();
-}
-
-static void setup(void)
-{
-	struct sigaction act;
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-	TEST_PAUSE;
+	if (reap_children(0, 0, fork_kid_pid, MAXKIDS))
+		return;
 
-	act.sa_handler = inthandlr;
-	act.sa_flags = SA_RESTART;
-	sigemptyset(&act.sa_mask);
-
-	if (sigaction(SIGUSR1, &act, NULL) < 0)
-		tst_brkm(TBROK|TERRNO, cleanup,
-			 "sigaction(SIGUSR1, ...) failed");
-
-	intintr = 0;
-
-}
-
-static void cleanup(void)
-{
-	int i;
-
-	for (i = 0; i < MAXKIDS; i++) {
-		if (fork_kid_pid[i] > 0)
-			kill(fork_kid_pid[i], SIGKILL);
-	}
-}
-
-static void inthandlr(void)
-{
-	intintr++;
-}
-
-static void wait_for_parent(void)
-{
-	while (!intintr)
-		usleep(100);
-}
-
-static void do_exit(void)
-{
-	wait_for_parent();
-	exit(3);
+	tst_res(TPASS, "Test PASSED");
 }
 
 static void do_compute(void)
 {
 	int i;
 
-	wait_for_parent();
+	TST_CHECKPOINT_WAIT(0);
 
 	for (i = 0; i < 100000; i++) ;
 	for (i = 0; i < 100000; i++) ;
@@ -283,57 +79,43 @@ static void do_compute(void)
 	for (i = 0; i < 100000; i++) ;
 	for (i = 0; i < 100000; i++) ;
 
-	exit(4);
+	exit(3);
 }
 
 static void do_fork(void)
 {
-	int fork_pid, wait_pid;
-	int status, i;
+	pid_t fork_pid;
+	int i;
 
-	wait_for_parent();
+	TST_CHECKPOINT_WAIT(0);
 
 	for (i = 0; i < 50; i++) {
-		fork_pid = FORK_OR_VFORK();
-		if (fork_pid < 0) {
-			tst_brkm(TBROK|TERRNO, NULL, "Fork failed");
-		}
-		if (fork_pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(argv0, "n", 1) < 0) {
-				tst_brkm(TFAIL, NULL,
-					 "do_fork self_exec failed");
-			}
-#else
-			do_exit();
-#endif
-		}
-
-		errno = 0;
-		while (((wait_pid = waitpid(fork_pid, &status, 0)) != -1) ||
-		       (errno == EINTR)) {
-			if (wait_pid == -1)
-				continue;
+		fork_pid = SAFE_FORK();
+		if (fork_pid == 0)
+			exit(3);
 
-			if (fork_pid != wait_pid) {
-				tst_resm(TFAIL, "Didnt get a pid returned "
-					 "from waitpid that matches the one "
-					 "returned by fork");
-				tst_resm(TFAIL, "fork pid = %d, wait pid = "
-					 "%d", fork_pid, wait_pid);
-				fail = 1;
-			}
-		}
+		if (reap_children(fork_pid, 0, &fork_pid, 1))
+			break;
 	}
 
-	exit(4);
+	exit(3);
 }
 
 static void do_sleep(void)
 {
-	wait_for_parent();
+	TST_CHECKPOINT_WAIT(0);
+
 	sleep(1);
 	sleep(1);
 
-	exit(4);
+	exit(3);
 }
+
+static struct tst_test test = {
+	.tid = "waitpid10",
+	.forks_child = 1,
+	.needs_checkpoints = 1,
+	.setup = waitpid_setup,
+	.cleanup = waitpid_cleanup,
+	.test_all = waitpid_test,
+};
-- 
1.7.1

