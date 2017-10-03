From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:52 +0200
Subject: [LTP] [COMMITTED] [PATCH 19/40] Make use of SAFE_WAIT()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-19-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/pidns/pidns20.c     |  5 ++---
 testcases/kernel/syscalls/alarm/alarm03.c       |  5 ++---
 testcases/kernel/syscalls/alarm/alarm07.c       |  5 ++---
 testcases/kernel/syscalls/execve/execve05.c     |  9 +++------
 testcases/kernel/syscalls/flock/flock04.c       |  5 ++---
 testcases/kernel/syscalls/getpid/getpid02.c     |  5 ++---
 testcases/kernel/syscalls/getppid/getppid02.c   |  5 ++---
 testcases/kernel/syscalls/ipc/semctl/semctl01.c |  4 ++--
 testcases/kernel/syscalls/openat/openat02.c     |  3 +--
 testcases/kernel/syscalls/sigrelse/sigrelse01.c |  3 +--
 testcases/kernel/syscalls/unshare/unshare01.c   | 13 ++++---------
 testcases/kernel/syscalls/unshare/unshare02.c   | 11 +++--------
 12 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns20.c b/testcases/kernel/containers/pidns/pidns20.c
index 630e6c393..70e9356fd 100644
--- a/testcases/kernel/containers/pidns/pidns20.c
+++ b/testcases/kernel/containers/pidns/pidns20.c
@@ -48,6 +48,7 @@
 #include <stdio.h>
 #include "pidns_helper.h"
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "pidns20";
 int TST_TOTAL = 1;
@@ -189,9 +190,7 @@ int main(int argc, char *argv[])
 	}
 
 	/* collect exit status of child */
-	if (wait(&status) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "wait failed");
-	}
+	SAFE_WAIT(NULL, &status);
 
 	if (WIFSIGNALED(status)) {
 		if (WTERMSIG(status) == SIGUSR1)
diff --git a/testcases/kernel/syscalls/alarm/alarm03.c b/testcases/kernel/syscalls/alarm/alarm03.c
index 5853a29e6..60141f1ad 100644
--- a/testcases/kernel/syscalls/alarm/alarm03.c
+++ b/testcases/kernel/syscalls/alarm/alarm03.c
@@ -98,6 +98,7 @@
 #include <stdlib.h>
 #include <sys/wait.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -160,9 +161,7 @@ int main(int ac, char **av)
 					 "alarm(100), fork, alarm(0) parent's alarm returned %ld",
 					 TEST_RETURN);
 			}
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			SAFE_WAIT(cleanup, &status);
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				tst_resm(TFAIL, "see failures reported above");
 
diff --git a/testcases/kernel/syscalls/alarm/alarm07.c b/testcases/kernel/syscalls/alarm/alarm07.c
index b270309f6..5f4d6e44e 100644
--- a/testcases/kernel/syscalls/alarm/alarm07.c
+++ b/testcases/kernel/syscalls/alarm/alarm07.c
@@ -71,6 +71,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "alarm07";
 int TST_TOTAL = 1;
@@ -121,9 +122,7 @@ int main(int ac, char **av)
 			}
 		} else {
 			/* Wait for child to complete execution */
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			SAFE_WAIT(cleanup, &status);
 			if (!WIFEXITED(status) ||
 			    WEXITSTATUS(status) != 0)
 				tst_brkm(TBROK | TERRNO, cleanup,
diff --git a/testcases/kernel/syscalls/execve/execve05.c b/testcases/kernel/syscalls/execve/execve05.c
index 444bead23..66290f63d 100644
--- a/testcases/kernel/syscalls/execve/execve05.c
+++ b/testcases/kernel/syscalls/execve/execve05.c
@@ -44,6 +44,7 @@
 #include <sys/stat.h>
 #include <sys/wait.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #undef DEBUG			/* change this to #define if needed */
 
@@ -144,9 +145,7 @@ int main(int ac, char **av)
 #ifdef DEBUG
 			tst_resm(TINFO, "Main - started pid %d", pid);
 #endif
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			SAFE_WAIT(cleanup, &status);
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				tst_resm(TFAIL, "child exited abnormally");
 
@@ -169,9 +168,7 @@ int main(int ac, char **av)
 #ifdef DEBUG
 			tst_resm(TINFO, "Main - started pid %d", pid);
 #endif
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			SAFE_WAIT(cleanup, &status);
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				tst_resm(TFAIL, "child exited abnormally");
 
diff --git a/testcases/kernel/syscalls/flock/flock04.c b/testcases/kernel/syscalls/flock/flock04.c
index 87f1dfbda..87f8fc0ad 100644
--- a/testcases/kernel/syscalls/flock/flock04.c
+++ b/testcases/kernel/syscalls/flock/flock04.c
@@ -76,6 +76,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup(void);
 void cleanup(void);
@@ -117,9 +118,7 @@ int main(int argc, char **argv)
 						 "flock() PASSED in acquiring shared lock on "
 						 "Share Locked file");
 				exit(0);
-			} else if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			} else SAFE_WAIT(cleanup, &status);
 
 			pid = FORK_OR_VFORK();
 			if (pid == -1)
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 8a4197b8c..6c44ea96a 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -71,6 +71,7 @@
 #include <sys/wait.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -107,9 +108,7 @@ int main(int ac, char **av)
 				exit(1);
 			exit(0);
 		} else {
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			SAFE_WAIT(cleanup, &status);
 			if (!WIFEXITED(status) ||
 			    WEXITSTATUS(status) != 0)
 				tst_resm(TFAIL, "getpid() returned "
diff --git a/testcases/kernel/syscalls/getppid/getppid02.c b/testcases/kernel/syscalls/getppid/getppid02.c
index 60181e9e0..ae3c8eb26 100644
--- a/testcases/kernel/syscalls/getppid/getppid02.c
+++ b/testcases/kernel/syscalls/getppid/getppid02.c
@@ -44,6 +44,7 @@
 #include <err.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "getppid02";
 int TST_TOTAL = 1;
@@ -81,9 +82,7 @@ int main(int ac, char **av)
 				       "value match\n");
 			exit(0);
 		} else {
-			if (wait(&status) == -1)
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "wait failed");
+			SAFE_WAIT(cleanup, &status);
 			if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
 				tst_resm(TFAIL,
 					 "getppid functionality incorrect");
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
index 39cf64e11..739eb5e4e 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
@@ -47,6 +47,7 @@
 #endif
 #include <sys/wait.h>
 #include "ipcsem.h"
+#include "safe_macros.h"
 
 char *TCID = "semctl01";
 
@@ -135,8 +136,7 @@ static void kill_all_children(void)
 	 * make sure children finished before we proceed with next testcase
 	 */
 	for (j = 0; j < NCHILD; j++) {
-		if (wait(&status) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "wait() failed");
+		SAFE_WAIT(cleanup, &status);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/openat/openat02.c b/testcases/kernel/syscalls/openat/openat02.c
index 580b08636..e2eefda04 100644
--- a/testcases/kernel/syscalls/openat/openat02.c
+++ b/testcases/kernel/syscalls/openat/openat02.c
@@ -172,8 +172,7 @@ void testfunc_cloexec(void)
 
 	SAFE_CLOSE(cleanup, TEST_RETURN);
 
-	if (wait(&status) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "wait() failed");
+	SAFE_WAIT(cleanup, &status);
 
 	if (WIFEXITED(status)) {
 		switch ((int8_t)WEXITSTATUS(status)) {
diff --git a/testcases/kernel/syscalls/sigrelse/sigrelse01.c b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
index f94ba3534..38086caa7 100644
--- a/testcases/kernel/syscalls/sigrelse/sigrelse01.c
+++ b/testcases/kernel/syscalls/sigrelse/sigrelse01.c
@@ -291,8 +291,7 @@ static void parent(void)
 	/*
 	 * child is now releasing signals, wait and check exit value
 	 */
-	if (wait(&term_stat) < 0)
-		tst_brkm(TBROK | TERRNO, getout, "wait() failed");
+	SAFE_WAIT(getout, &term_stat);
 
 	/* check child's signal exit value */
 	if ((sig = CHILD_SIG(term_stat)) != 0)
diff --git a/testcases/kernel/syscalls/unshare/unshare01.c b/testcases/kernel/syscalls/unshare/unshare01.c
index 84d18926e..52c774530 100644
--- a/testcases/kernel/syscalls/unshare/unshare01.c
+++ b/testcases/kernel/syscalls/unshare/unshare01.c
@@ -92,6 +92,7 @@
 #include <stdio.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "config.h"
 
 char *TCID = "unshare01";
@@ -187,9 +188,7 @@ int main(int ac, char **av)
 				}
 				exit(rval);
 			} else {
-				if (wait(&rval) == -1)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "wait failed");
+				SAFE_WAIT(cleanup, &rval);
 				if (rval != 0 && WIFEXITED(rval)) {
 					switch (WEXITSTATUS(rval)) {
 					case 1:
@@ -225,9 +224,7 @@ int main(int ac, char **av)
 				}
 				exit(rval);
 			} else {
-				if (wait(&rval) == -1)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "wait failed");
+				SAFE_WAIT(cleanup, &rval);
 				if (rval != 0 && WIFEXITED(rval)) {
 					switch (WEXITSTATUS(rval)) {
 					case 1:
@@ -263,9 +260,7 @@ int main(int ac, char **av)
 				}
 				exit(rval);
 			} else {
-				if (wait(&rval) == -1)
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "wait failed");
+				SAFE_WAIT(cleanup, &rval);
 				if (rval != 0 && WIFEXITED(rval)) {
 					switch (WEXITSTATUS(rval)) {
 					case 1:
diff --git a/testcases/kernel/syscalls/unshare/unshare02.c b/testcases/kernel/syscalls/unshare/unshare02.c
index 9221f9299..18b8bf522 100644
--- a/testcases/kernel/syscalls/unshare/unshare02.c
+++ b/testcases/kernel/syscalls/unshare/unshare02.c
@@ -56,6 +56,7 @@
 #include <stdio.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "config.h"
 
 char *TCID = "unshare02";
@@ -153,10 +154,7 @@ int main(int ac, char **av)
 				}
 				exit(rval);
 			} else {
-				if (wait(&rval) == -1) {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "wait failed");
-				}
+				SAFE_WAIT(cleanup, &rval);
 				if (rval != 0 && WIFEXITED(rval)) {
 					switch (WEXITSTATUS(rval)) {
 					case 1:
@@ -191,10 +189,7 @@ int main(int ac, char **av)
 				}
 				exit(rval);
 			} else {
-				if (wait(&rval) == -1) {
-					tst_brkm(TBROK | TERRNO, cleanup,
-						 "wait failed");
-				}
+				SAFE_WAIT(cleanup, &rval);
 				if (rval != 0 && WIFEXITED(rval)) {
 					switch (WEXITSTATUS(rval)) {
 					case 1:
-- 
2.13.5

