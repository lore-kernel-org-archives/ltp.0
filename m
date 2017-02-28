From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:25 +0100
Subject: [LTP] [COMMITTED] [PATCH 03/23] syscalls/rename14: Small cleanup
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Get rid of UCLINUX ifdefs

* Make use of tst_parse_opts()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/rename/rename14.c | 45 +++++++----------------------
 1 file changed, 11 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename14.c b/testcases/kernel/syscalls/rename/rename14.c
index 7e74c26..f79b5c6 100644
--- a/testcases/kernel/syscalls/rename/rename14.c
+++ b/testcases/kernel/syscalls/rename/rename14.c
@@ -43,7 +43,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
-/** LTP Port **/
 #include "test.h"
 
 #define FAILED 0
@@ -53,30 +52,25 @@ int local_flag = PASSED;
 
 char *TCID = "rename14";
 int TST_TOTAL = 1;
-/**************/
 
 #define RUNTIME	45
 
 int kidpid[2];
 int parent_pid;
 
+int term(void);
+int al(void);
+void dochild1(void);
+void dochild2(void);
+
 int main(int argc, char *argv[])
 {
 	int pid;
 	sigset_t set;
 	struct sigaction act, oact;
-	int term();
-	int al();
-	void dochild1();
-	void dochild2();
-
-#ifdef UCLINUX
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
-	maybe_run_child(&dochild1, "n", 1);
-	maybe_run_child(&dochild2, "n", 2);
-#endif
 	sigemptyset(&set);
 	act.sa_handler = (void (*)())term;
 	act.sa_mask = set;
@@ -94,21 +88,13 @@ int main(int argc, char *argv[])
 	}
 	parent_pid = getpid();
 	tst_tmpdir();
-/*--------------------------------------------------------------*/
 
 	pid = FORK_OR_VFORK();
-	if (pid < 0) {
+	if (pid < 0)
 		tst_brkm(TBROK, NULL, "fork() returned %d", pid);
-	}
-	if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv[0], "n", 1) < 0) {
-			tst_resm(TBROK, "self_exec failed");
-		}
-#else
+	if (pid == 0)
 		dochild1();
-#endif
-	}
+
 	kidpid[0] = pid;
 	pid = FORK_OR_VFORK();
 	if (pid < 0) {
@@ -116,15 +102,9 @@ int main(int argc, char *argv[])
 		(void)unlink("./rename14");
 		tst_brkm(TBROK, NULL, "fork() returned %d", pid);
 	}
-	if (pid == 0) {
-#ifdef UCLINUX
-		if (self_exec(argv[0], "n", 1) < 0) {
-			tst_resm(TBROK, "self_exec failed");
-		}
-#else
+	if (pid == 0)
 		dochild2();
-#endif
-	}
+
 	kidpid[1] = pid;
 
 	alarm(RUNTIME);
@@ -148,8 +128,6 @@ int main(int argc, char *argv[])
 	tst_exit();
 }
 
-/* FUNCTIONS GO HERE */
-
 int term(void)
 {
 	if (parent_pid != getpid())
@@ -183,7 +161,6 @@ void dochild1(void)
 
 void dochild2(void)
 {
-	for (;;) {
+	for (;;)
 		rename("./rename14", "./rename14xyz");
-	}
 }
-- 
2.10.2

