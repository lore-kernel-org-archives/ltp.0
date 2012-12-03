Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TfVow-0003ZZ-MM
	for ltp-list@lists.sourceforge.net; Mon, 03 Dec 2012 13:12:26 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TfVor-0002RI-3x
	for ltp-list@lists.sourceforge.net; Mon, 03 Dec 2012 13:12:26 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qB3DCEIg002484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Dec 2012 08:12:15 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id qB3CK2Uk026337
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Dec 2012 07:20:08 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  3 Dec 2012 13:19:57 +0100
Message-Id: <1354537197-5353-2-git-send-email-jstancek@redhat.com>
Subject: [LTP] [PATCH] clone: wait until child completes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

If parent doesn't wait for child to finish,
ltp-pan detects these as 'orpahns' and will try
to kill them, which can result in TBROK messages:
http://article.gmane.org/gmane.linux.ltp/16993

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clone/clone01.c |   12 +++++++-----
 testcases/kernel/syscalls/clone/clone03.c |   10 +++++++---
 testcases/kernel/syscalls/clone/clone05.c |   10 +++++++---
 testcases/kernel/syscalls/clone/clone06.c |   10 +++++++---
 testcases/kernel/syscalls/clone/clone07.c |    6 ++++--
 5 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone01.c b/testcases/kernel/syscalls/clone/clone01.c
index dbf3315..4788802 100644
--- a/testcases/kernel/syscalls/clone/clone01.c
+++ b/testcases/kernel/syscalls/clone/clone01.c
@@ -105,17 +105,19 @@ int main(int ac, char **av)
 	Tst_count = 0;
 
 	TEST(ltp_clone(SIGCHLD, do_child, NULL, CHILD_STACK_SIZE, child_stack));
+	if (TEST_RETURN == -1)
+		tst_resm(TFAIL|TTERRNO, "clone failed");
 
-again:
 	child_pid = wait(&status);
+	if (child_pid == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "wait failed, status: %d",
+			status);
 
-	/* check return code */
 	if (TEST_RETURN == child_pid)
 		tst_resm(TPASS, "clone returned %ld", TEST_RETURN);
-	else if (TEST_RETURN == -1)
-		tst_resm(TFAIL|TTERRNO, "clone failed for pid = %d", child_pid);
 	else
-		goto again;
+		tst_resm(TFAIL, "clone returned %ld, wait returned %d",
+			TEST_RETURN, child_pid);
 
 	free(child_stack);
 
diff --git a/testcases/kernel/syscalls/clone/clone03.c b/testcases/kernel/syscalls/clone/clone03.c
index 24ee8e6..881aa6d 100644
--- a/testcases/kernel/syscalls/clone/clone03.c
+++ b/testcases/kernel/syscalls/clone/clone03.c
@@ -74,6 +74,7 @@
 
 #include <errno.h>
 #include <sched.h>
+#include <sys/wait.h>
 #include "test.h"
 #include "usctest.h"
 
@@ -95,7 +96,7 @@ int main(int ac, char **av)
 	char *msg;
 	void *child_stack;	/* stack for child */
 	char buff[10];
-	int child_pid;
+	int child_pid, status;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -120,7 +121,7 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-		TEST(ltp_clone(0, child_fn, NULL, CHILD_STACK_SIZE,
+		TEST(ltp_clone(SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
 				child_stack));
 
 		/* check return code */
@@ -152,6 +153,9 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "Test failed");
 		}
 
+		if ((wait(&status)) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"wait failed, status: %d", status);
 	}
 
 	free(child_stack);
@@ -165,7 +169,7 @@ int main(int ac, char **av)
 void setup()
 {
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/clone/clone05.c b/testcases/kernel/syscalls/clone/clone05.c
index f557787..cb8a452 100644
--- a/testcases/kernel/syscalls/clone/clone05.c
+++ b/testcases/kernel/syscalls/clone/clone05.c
@@ -93,7 +93,7 @@ int TST_TOTAL = 1;		/* Total number of test cases. */
 int main(int ac, char **av)
 {
 
-	int lc;
+	int lc, status;
 	char *msg;
 	void *child_stack;	/* stack for child */
 
@@ -114,7 +114,7 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-		TEST(ltp_clone(FLAG, child_fn, NULL, CHILD_STACK_SIZE,
+		TEST(ltp_clone(FLAG|SIGCHLD, child_fn, NULL, CHILD_STACK_SIZE,
 				child_stack));
 
 		/* check return code & parent_variable */
@@ -124,6 +124,10 @@ int main(int ac, char **av)
 			tst_resm(TFAIL, "Test Failed");
 		}
 
+		if ((wait(&status)) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"wait failed, status: %d", status);
+
 		/* Reset parent_variable */
 		parent_variable = 0;
 	}
@@ -139,7 +143,7 @@ int main(int ac, char **av)
 void setup()
 {
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/clone/clone06.c b/testcases/kernel/syscalls/clone/clone06.c
index 6cb8b4d..2cfcd03 100644
--- a/testcases/kernel/syscalls/clone/clone06.c
+++ b/testcases/kernel/syscalls/clone/clone06.c
@@ -97,7 +97,7 @@ int TST_TOTAL = 1;		/* Total number of test cases. */
 int main(int ac, char **av)
 {
 
-	int lc;
+	int lc, status;
 	char *msg;
 	void *child_stack;	/* stack for child */
 	char *parent_env;
@@ -123,7 +123,7 @@ int main(int ac, char **av)
 		/*
 		 * Call clone(2)
 		 */
-		TEST(ltp_clone(0, child_environ, NULL, CHILD_STACK_SIZE,
+		TEST(ltp_clone(SIGCHLD, child_environ, NULL, CHILD_STACK_SIZE,
 				child_stack));
 
 		/* check return code */
@@ -152,6 +152,10 @@ int main(int ac, char **av)
 		} else {
 			tst_resm(TFAIL, "Test Failed");
 		}
+
+		if ((wait(&status)) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"wait failed, status: %d", status);
 	}
 
 	free(child_stack);
@@ -164,7 +168,7 @@ int main(int ac, char **av)
 void setup()
 {
 
-	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/clone/clone07.c b/testcases/kernel/syscalls/clone/clone07.c
index 3ad7fe7..c4df76d 100644
--- a/testcases/kernel/syscalls/clone/clone07.c
+++ b/testcases/kernel/syscalls/clone/clone07.c
@@ -98,7 +98,7 @@ static int fail = FALSE;
 int main(int ac, char **av)
 {
 
-	int lc;
+	int lc, status;
 	char *msg;
 	void *child_stack;	/* stack for child */
 
@@ -120,7 +120,9 @@ int main(int ac, char **av)
 		 */
 		child_pid = ltp_clone(SIGCHLD, do_child, NULL,
 				CHILD_STACK_SIZE, child_stack);
-		wait(NULL);
+		if ((wait(&status)) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"wait failed, status: %d", status);
 		free(child_stack);
 	}
 
-- 
1.7.1


------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
BUILD Helping you discover the best ways to construct your parallel projects.
http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
