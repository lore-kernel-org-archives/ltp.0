Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UdGVs-0003KB-S1
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 08:59:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UdGVo-0003b9-BX
	for ltp-list@lists.sourceforge.net; Fri, 17 May 2013 08:59:44 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r4H8xYbP007850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 17 May 2013 04:59:34 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r4H8xTSw018909
	for <ltp-list@lists.sourceforge.net>; Fri, 17 May 2013 04:59:33 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 17 May 2013 10:59:22 +0200
Message-Id: <f86dfe8123738c73c9dc2fd08309bfbe09e925e6.1368780870.git.jstancek@redhat.com>
In-Reply-To: <4e8cb837f8dd19db77ca70bd3b0094b060b0b0a0.1368780870.git.jstancek@redhat.com>
References: <4e8cb837f8dd19db77ca70bd3b0094b060b0b0a0.1368780870.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 2/2] waitid02: split code into separate testcases
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

Previous code in main was:
- using sleep for synchronization
  The sleep make take longer if run in overcommitted
  z/VM environment with considerably high steal time, which
  causes testcase to hang.
- missing wait for last child

This patch splits code from main() into separate testcases,
each with its own setup/cleanup and expected outcome.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/waitid/waitid02.c |  361 +++++++++++++++++----------
 1 files changed, 230 insertions(+), 131 deletions(-)

diff --git a/testcases/kernel/syscalls/waitid/waitid02.c b/testcases/kernel/syscalls/waitid/waitid02.c
index e265c32..bd5a13c 100644
--- a/testcases/kernel/syscalls/waitid/waitid02.c
+++ b/testcases/kernel/syscalls/waitid/waitid02.c
@@ -50,31 +50,246 @@
 #include "usctest.h"
 #include "linux_syscall_numbers.h"
 
+struct testcase_t {
+	const char *msg;
+	idtype_t idtype;
+	id_t id;
+	pid_t child;
+	int options;
+	int exp_ret;
+	int exp_errno;
+	int pipefd[2];
+	void (*setup) (struct testcase_t *);
+	void (*cleanup) (struct testcase_t *);
+};
+
+static void setup(void);
+static void cleanup(void);
+
+static void setup2(struct testcase_t *);
+static void setup3(struct testcase_t *);
+static void setup4(struct testcase_t *);
+static void setup5(struct testcase_t *);
+static void setup6(struct testcase_t *);
+static void cleanup2(struct testcase_t *);
+static void cleanup5(struct testcase_t *);
+static void cleanup6(struct testcase_t *);
+
+struct testcase_t tdat[] = {
+	{
+		.msg = "WNOHANG",
+		.idtype = P_ALL,
+		.id = 0,
+		.options = WNOHANG,
+		.exp_ret = -1,
+		.exp_errno = EINVAL,
+	},
+	{
+		.msg = "WNOHANG | WEXITED no child",
+		.idtype = P_ALL,
+		.id = 0,
+		.options = WNOHANG | WEXITED,
+		.exp_ret = -1,
+		.exp_errno = ECHILD,
+	},
+	{
+		.msg = "WNOHANG | WEXITED with child",
+		.idtype = P_ALL,
+		.id = 0,
+		.options = WNOHANG | WEXITED,
+		.exp_ret = 0,
+		.setup = setup2,
+		.cleanup = cleanup2
+	},
+	{
+		.msg = "P_PGID, WEXITED wait for child",
+		.idtype = P_PGID,
+		.options = WEXITED,
+		.exp_ret = 0,
+		.setup = setup3,
+	},
+	{
+		.msg = "P_PID, WEXITED wait for child",
+		.idtype = P_PID,
+		.options = WEXITED,
+		.exp_ret = 0,
+		.setup = setup4,
+	},
+	{
+		.msg = "P_PID, WSTOPPED | WNOWAIT",
+		.idtype = P_PID,
+		.options = WSTOPPED | WNOWAIT,
+		.exp_ret = 0,
+		.setup = setup5,
+		.cleanup = cleanup5
+	},
+	{
+		.msg = "P_PID, WCONTINUED",
+		.idtype = P_PID,
+		.options = WCONTINUED,
+		.exp_ret = 0,
+		.setup = setup6,
+		.cleanup = cleanup6
+	},
+
+};
+
 char *TCID = "waitid02";
-int testno;
-int TST_TOTAL = 4;
+static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
 
-static void cleanup(void)
+static void makechild(struct testcase_t *t,
+	void (*childfn)(struct testcase_t *))
 {
-	TEST_CLEANUP;
-	tst_rmdir();
+	t->child = fork();
+	switch (t->child) {
+	case -1:
+		tst_brkm(TBROK | TERRNO, cleanup, "fork");
+		break;
+	case 0:
+		childfn(t);
+		exit(0);
+	}
+}
 
-	tst_exit();
+static void wait4child(pid_t pid)
+{
+	int status;
+	if (waitpid(pid, &status, 0) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "waitpid");
+	if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "child returns %d", status);
+}
+
+static void dummy_child(struct testcase_t *t)
+{
+}
+
+static void waiting_child(struct testcase_t *t)
+{
+	int dummy;
+	read(t->pipefd[0], &dummy, 1);
+}
+
+static void stopped_child(struct testcase_t *t)
+{
+	int dummy;
+	kill(getpid(), SIGSTOP);
+	read(t->pipefd[0], &dummy, 1);
+}
+
+static void setup2(struct testcase_t *t)
+{
+	if (pipe(t->pipefd) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "pipe");
+	makechild(t, waiting_child);
+}
+
+static void cleanup2(struct testcase_t *t)
+{
+	write(t->pipefd[1], "", 1);
+	wait4child(t->child);
+	close(t->pipefd[0]);
+	close(t->pipefd[1]);
+}
+
+static void setup3(struct testcase_t *t)
+{
+	t->id = getpgid(0);
+	makechild(t, dummy_child);
+}
+
+static void setup4(struct testcase_t *t)
+{
+	makechild(t, dummy_child);
+	t->id = t->child;
+}
+
+static void setup5(struct testcase_t *t)
+{
+	if (pipe(t->pipefd) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "pipe");
+	makechild(t, stopped_child);
+	t->id = t->child;
+}
+
+static void cleanup5(struct testcase_t *t)
+{
+	kill(t->child, SIGCONT);
+	write(t->pipefd[1], "", 1);
+	wait4child(t->child);
+	close(t->pipefd[0]);
+	close(t->pipefd[1]);
+}
+
+static void setup6(struct testcase_t *t)
+{
+	siginfo_t infop;
+	if (pipe(t->pipefd) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "pipe");
+	makechild(t, stopped_child);
+	t->id = t->child;
+	if (waitid(P_PID, t->child, &infop, WSTOPPED) != 0)
+		tst_brkm(TBROK | TERRNO, cleanup, "waitpid setup6");
+	kill(t->child, SIGCONT);
+}
+
+static void cleanup6(struct testcase_t *t)
+{
+	write(t->pipefd[1], "", 1);
+	wait4child(t->child);
+	close(t->pipefd[0]);
+	close(t->pipefd[1]);
 }
 
 static void setup(void)
 {
 	TEST_PAUSE;
-	tst_tmpdir();
 }
 
-int main(int ac, char **av)
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+static void test_waitid(struct testcase_t *t)
 {
-	id_t pgid;
-	id_t id1, id2, id3;
 	siginfo_t infop;
 
-	int lc;
+	if (t->setup)
+		t->setup(t);
+
+	tst_resm(TINFO, "%s", t->msg);
+	tst_resm(TINFO, "(%d) waitid(%d, %d, %p, %d)", getpid(), t->idtype,
+			t->id, &infop, t->options);
+	memset(&infop, 0, sizeof(infop));
+
+	TEST(waitid(t->idtype, t->id, &infop, t->options));
+	if (TEST_RETURN == t->exp_ret) {
+		if (TEST_RETURN == -1) {
+			if (TEST_ERRNO == t->exp_errno)
+				tst_resm(TPASS, "exp_errno=%d", t->exp_errno);
+			else
+				tst_resm(TFAIL|TTERRNO, "exp_errno=%d",
+					t->exp_errno);
+		} else {
+			tst_resm(TPASS, "ret: %d", t->exp_ret);
+		}
+	} else {
+		tst_resm(TFAIL|TTERRNO, "ret=%ld expected=%d",
+			TEST_RETURN, t->exp_ret);
+	}
+	tst_resm(TINFO, "si_pid = %d ; si_code = %d ; si_status = %d",
+			infop.si_pid, infop.si_code,
+			infop.si_status);
+
+	if (t->cleanup)
+		t->cleanup(t);
+}
+
+int main(int ac, char **av)
+{
+	int lc, testno;
 	char *msg;
 
 	msg = parse_opts(ac, av, NULL, NULL);
@@ -84,127 +299,11 @@ int main(int ac, char **av)
 	}
 
 	setup();
-
 	for (lc = 0; TEST_LOOPING(lc); ++lc) {
-		tst_count = 0;
-		for (testno = 0; testno < TST_TOTAL; ++testno) {
-
-			TEST(waitid(P_ALL, 0, &infop, WNOHANG));
-			if (TEST_RETURN == -1)
-				tst_resm(TPASS, "Success1 ... -1 is returned."
-					" error is %d.", TEST_ERRNO);
-			else {
-				tst_resm(TFAIL, "%s Failed1 ...", TCID);
-			}
-
-			/* option == WEXITED | WCONTINUED | WSTOPPED |
-			 * WNOHANG | WNOWAIT */
-
-			TEST(id1 = fork());
-			if (TEST_RETURN == 0) {
-				tst_resm(TINFO,
-					 "I'm a child 1,my id is %d,gpid is %d",
-					 id1 = getpid(), __getpgid(0));
-				sleep(1);
-				exit(5);
-			}
-
-			TEST(id2 = fork());
-			if (TEST_RETURN == 0) {
-				sleep(3);
-				tst_resm(TINFO,
-					 "I'm a child 2,my id is %d,gpid is %d",
-					 id2 = getpid(), __getpgid(0));
-				exit(7);
-			}
-
-			TEST(id3 = fork());
-			if (TEST_RETURN == 0) {
-				sleep(2);
-				TEST(kill(id2, SIGCONT));
-				tst_resm(TINFO,
-					 "I'm a child 3,my id is %d,gpid is %d",
-					 id3 = getpid(), __getpgid(0));
-				exit(6);
-			}
-
-			TEST(waitid(P_ALL, 0, &infop, WNOHANG | WEXITED));
-			if (TEST_RETURN == 0)
-				tst_resm(TPASS, "Success 2 ...0 is returned.."
-					" error is %d.", TEST_ERRNO);
-			else {
-				tst_resm(TFAIL | TTERRNO, "%s Failed 2", TCID);
-				tst_exit();
-			}
-
-			tst_resm(TINFO, "I'm a Parent,my id is %d,gpid is %d",
-				 getpid(), pgid = __getpgid(0));
-
-			TEST(waitid(P_PGID, pgid, &infop, WEXITED));
-			if (TEST_RETURN == 0) {
-				tst_resm(TPASS, "Success3 ... 0 is returned.");
-				tst_resm(TINFO, "si_pid = %d ; si_code = %d ;"
-					" si_status = %d",
-					 infop.si_pid, infop.si_code,
-					 infop.si_status);
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "Fail3 ...  %ld is returned",
-					 TEST_RETURN);
-				tst_exit();
-			}
-
-			TEST(kill(id2, SIGSTOP));
-
-			TEST(waitid(P_PID, id2, &infop, WSTOPPED | WNOWAIT));
-			if (TEST_RETURN == 0) {
-				/*EINVAL*/
-				tst_resm(TINFO,	"si_pid = %d, si_code = %d,"
-					" si_status = %d",
-					infop.si_pid, infop.si_code,
-					infop.si_status);
-				tst_resm(TPASS, "Success4 ... 0 is returned");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					"Fail4 ...  %ld is returned",
-					TEST_RETURN);
-				tst_exit();
-			}
-
-			TEST(waitid(P_PID, id3, &infop, WEXITED));
-			if (TEST_RETURN == 0) {
-				/*NOCHILD*/
-				tst_resm(TINFO,
-					"si_pid = %d, si_code = %d, "
-					"si_status = %d",
-					infop.si_pid, infop.si_code,
-					infop.si_status);
-				tst_resm(TPASS, "Success5 ... 0 is returned");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "Fail5 ...  %ld is returned",
-					 TEST_RETURN);
-				tst_exit();
-			}
-
-			TEST(waitid(P_PID, id2, &infop, WCONTINUED));
-			if (TEST_RETURN == 0) {
-				/*EINVAL*/
-				tst_resm(TINFO,
-					"si_pid = %d, si_code = %d, "
-					"si_status = %d",
-					infop.si_pid, infop.si_code,
-					infop.si_status);
-				tst_resm(TPASS, "Success6 ... 0 is returned");
-			} else {
-				tst_resm(TFAIL | TTERRNO,
-					 "Fail6 ...  %ld is returned",
-					 TEST_RETURN);
-				tst_exit();
-			}
-
-			sleep(3);
-		}
+		/* setup alarm for unlikely event that test blocks */
+		alarm(5);
+		for (testno = 0; testno < TST_TOTAL; testno++)
+			test_waitid(&tdat[testno]);
 	}
 	cleanup();
 	tst_exit();
-- 
1.7.1


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
