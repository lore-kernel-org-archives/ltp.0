Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1X1Z8c-0007K8-UR
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 10:48:42 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X1Z8a-0006Ql-TQ
	for ltp-list@lists.sourceforge.net; Mon, 30 Jun 2014 10:48:42 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s5UAmYkt001721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:35 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5UAmXN5023883
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:34 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s5UAmXmR023866
	for <ltp-list@lists.sourceforge.net>; Mon, 30 Jun 2014 10:48:33 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 30 Jun 2014 14:48:24 +0400
Message-Id: <1404125304-28650-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1404125304-28650-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/3] syscalls: use tst_get_unused_pid()
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
Cc: vasily.isaenko@oracle.com

Modified the testcases to use the tst_get_unused_pid() interface.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/capget/capget02.c        |    4 +-
 testcases/kernel/syscalls/cma/process_vm01.c       |   11 +----
 .../syscalls/get_robust_list/get_robust_list01.c   |    7 ++-
 testcases/kernel/syscalls/getpgid/getpgid02.c      |   13 +----
 testcases/kernel/syscalls/getsid/getsid02.c        |    6 +-
 testcases/kernel/syscalls/kill/kill04.c            |   56 ++------------------
 .../syscalls/migrate_pages/migrate_pages01.c       |   13 +----
 .../kernel/syscalls/move_pages/move_pages07.c      |   15 +-----
 testcases/kernel/syscalls/ptrace/ptrace03.c        |   17 ++++---
 .../sched_getaffinity/sched_getaffinity01.c        |   27 ++--------
 .../syscalls/sched_getparam/sched_getparam03.c     |   15 ++++--
 .../sched_getscheduler/sched_getscheduler02.c      |    7 ++-
 .../sched_rr_get_interval03.c                      |   18 ++++---
 .../syscalls/sched_setparam/sched_setparam04.c     |   19 ++++---
 .../sched_setscheduler/sched_setscheduler01.c      |   18 ++++---
 testcases/kernel/syscalls/setpgid/setpgid02.c      |   21 ++++---
 .../kernel/syscalls/setpriority/setpriority04.c    |   25 ++-------
 testcases/kernel/syscalls/tkill/tkill02.c          |   20 +++++---
 18 files changed, 108 insertions(+), 204 deletions(-)

diff --git a/testcases/kernel/syscalls/capget/capget02.c b/testcases/kernel/syscalls/capget/capget02.c
index 946e824..0580541 100644
--- a/testcases/kernel/syscalls/capget/capget02.c
+++ b/testcases/kernel/syscalls/capget/capget02.c
@@ -88,8 +88,6 @@
 /*   version, then you may want to try switching to it. -Robbie W.        */
 /**************************************************************************/
 
-#define INVALID_PID 999999
-
 static void setup();
 static void cleanup();
 static void test_setup(int);
@@ -203,7 +201,7 @@ void test_setup(int i)
 		break;
 	case 4:
 		header.version = _LINUX_CAPABILITY_VERSION;
-		header.pid = INVALID_PID;
+		header.pid = tst_get_unused_pid(cleanup);
 		break;
 	}
 }
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 6ff744c..7e4684f 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -312,11 +312,8 @@ static void cma_test_iov_invalid(void)
 
 static void cma_test_invalid_pid(void)
 {
-	const char pid_max[] = "/proc/sys/kernel/pid_max";
 	pid_t invalid_pid = -1;
 	struct process_vm_params *params;
-	FILE *fp;
-	char buff[512];
 
 	params = cma_alloc_sane_params();
 	tst_resm(TINFO, "test_invalid_pid");
@@ -326,13 +323,7 @@ static void cma_test_invalid_pid(void)
 	cma_check_errno(ESRCH);
 	cma_free_params(params);
 
-	fp = fopen(pid_max, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK, cleanup, "Could not open %s", pid_max);
-	if (!fgets(buff, sizeof(buff), fp))
-		tst_brkm(TBROK, cleanup, "Could not read %s", pid_max);
-	fclose(fp);
-	invalid_pid = atol(buff) + 1;
+	invalid_pid = tst_get_unused_pid(cleanup);
 
 	params = cma_alloc_sane_params();
 	params->pid = invalid_pid;
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index e91a506..5781441 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -68,7 +68,7 @@ struct robust_list_head {
 };
 
 int exp_enos[] = { ESRCH, EPERM, EFAULT, 0 };
-static unsigned int pid_max;
+static pid_t unused_pid;
 
 void setup(void);
 void cleanup(void);
@@ -135,7 +135,7 @@ int main(int argc, char **argv)
 		 * find the task specified by the pid argument.
 		 */
 
-		TEST(ltp_syscall(__NR_get_robust_list, pid_max,
+		TEST(ltp_syscall(__NR_get_robust_list, unused_pid,
 				      (struct robust_list_head *)&head,
 				      &len_ptr));
 
@@ -191,7 +191,8 @@ void setup(void)
 	tst_require_root(NULL);
 
 	TEST_EXP_ENOS(exp_enos);
-	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/pid_max", "%u", &pid_max);
+
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/getpgid/getpgid02.c b/testcases/kernel/syscalls/getpgid/getpgid02.c
index 4bcec58..7b5e530 100644
--- a/testcases/kernel/syscalls/getpgid/getpgid02.c
+++ b/testcases/kernel/syscalls/getpgid/getpgid02.c
@@ -135,18 +135,7 @@ void setup(void)
 
 	pgid_0 = BADPID;
 
-	/*
-	 * Find a pid that isn't currently being used.  Start
-	 * at 'our pid - 1' and go backwards until we find one.
-	 * In this way, we can be reasonably sure that the pid
-	 * we find won't be reused for a while as new pids are
-	 * allocated counting up to PID_MAX.
-	 */
-	for (pgid_1 = getpid() - 1; --pgid_1 > 0;) {
-		if (kill(pgid_1, 0) < 0 && errno == ESRCH) {
-			break;
-		}
-	}
+	pgid_1 = tst_get_unused_pid(cleanup);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/getsid/getsid02.c b/testcases/kernel/syscalls/getsid/getsid02.c
index 58e2feb..3582d63 100644
--- a/testcases/kernel/syscalls/getsid/getsid02.c
+++ b/testcases/kernel/syscalls/getsid/getsid02.c
@@ -28,7 +28,7 @@
 char *TCID = "getsid02";
 int TST_TOTAL = 1;
 
-static unsigned long pid_max;
+static pid_t unused_pid;
 
 static void cleanup(void);
 static void setup(void);
@@ -48,7 +48,7 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		TEST(getsid(pid_max + 1));
+		TEST(getsid(unused_pid));
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL, "call succeed when failure expected");
@@ -74,7 +74,7 @@ int main(int ac, char **av)
 
 void setup(void)
 {
-	SAFE_FILE_SCANF(NULL, "/proc/sys/kernel/pid_max", "%lu", &pid_max);
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/kill/kill04.c b/testcases/kernel/syscalls/kill/kill04.c
index 5f36dd4..8723f67 100644
--- a/testcases/kernel/syscalls/kill/kill04.c
+++ b/testcases/kernel/syscalls/kill/kill04.c
@@ -77,15 +77,11 @@ int main(int ac, char **av)
 {
 	int lc;
 	const char *msg;
-	pid_t pid, fake_pid;
-	int exno, status, fake_status, nsig;
+	pid_t fake_pid;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 	}
-#ifdef UCLINUX
-	maybe_run_child(&do_child, "");
-#endif
 
 	setup();		/* global setup */
 
@@ -96,41 +92,9 @@ int main(int ac, char **av)
 
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
-		status = 1;
-		exno = 1;
-		pid = FORK_OR_VFORK();
-		if (pid < 0) {
-			tst_brkm(TBROK, cleanup, "Fork failed");
-		} else if (pid == 0) {
-#ifdef UCLINUX
-			if (self_exec(av[0], "") < 0) {
-				tst_brkm(TBROK, cleanup,
-					 "self_exec of child failed");
-			}
-#else
-			do_child();
-#endif
-		} else {
-			fake_pid = FORK_OR_VFORK();
-			if (fake_pid < 0) {
-				tst_brkm(TBROK, cleanup, "Second fork failed");
-			} else if (fake_pid == 0) {
-#ifdef UCLINUX
-				if (self_exec(av[0], "") < 0) {
-					tst_brkm(TBROK, cleanup,
-						 "second self_exec "
-						 "of child failed");
-				}
-#else
-				do_child();
-#endif
-			}
-			kill(fake_pid, TEST_SIG);
-			waitpid(fake_pid, &fake_status, 0);
-			TEST(kill(fake_pid, TEST_SIG));
-			kill(pid, TEST_SIG);
-			waitpid(pid, &status, 0);
-		}
+
+		fake_pid = tst_get_unused_pid(cleanup);
+		TEST(kill(fake_pid, TEST_SIG));
 
 		if (TEST_RETURN != -1) {
 			tst_brkm(TFAIL, cleanup, "%s failed - errno = %d : %s "
@@ -143,7 +107,6 @@ int main(int ac, char **av)
 		 * Check to see if the errno was set to the expected
 		 * value of 3 : ESRCH
 		 */
-		nsig = WTERMSIG(status);
 		TEST_ERROR_LOG(TEST_ERRNO);
 		if (TEST_ERRNO == ESRCH) {
 			tst_resm(TPASS, "errno set to %d : %s, as "
@@ -161,17 +124,6 @@ int main(int ac, char **av)
 }
 
 /*
- * do_child()
- */
-void do_child(void)
-{
-	int exno = 1;
-
-	pause();
-	exit(exno);
-}
-
-/*
  * setup() - performs all ONE TIME setup for this test
  */
 void setup(void)
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 6796e0c..e736770 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -75,9 +75,6 @@ static void test_sane_nodes(void)
 
 static void test_invalid_pid(void)
 {
-	const char pid_max[] = "/proc/sys/kernel/pid_max";
-	FILE *fp;
-	char buff[512];
 	pid_t invalid_pid = -1;
 
 	tst_resm(TINFO, "test_invalid_pid -1");
@@ -86,14 +83,8 @@ static void test_invalid_pid(void)
 	check_ret(-1);
 	check_errno(ESRCH);
 
-	tst_resm(TINFO, "test_invalid_pid pid_max+1");
-	fp = fopen(pid_max, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK, cleanup, "Could not open %s", pid_max);
-	if (!fgets(buff, sizeof(buff), fp))
-		tst_brkm(TBROK, cleanup, "Could not read %s", pid_max);
-	fclose(fp);
-	invalid_pid = atol(buff) + 1;
+	tst_resm(TINFO, "test_invalid_pid unused pid");
+	invalid_pid = tst_get_unused_pid(cleanup);
 	TEST(ltp_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
 		     sane_old_nodes, sane_new_nodes));
 	check_ret(-1);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index 3108b44..1c7f17d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -95,7 +95,7 @@ int main(int argc, char **argv)
 		void *pages[TEST_PAGES] = { 0 };
 		int nodes[TEST_PAGES];
 		int status[TEST_PAGES];
-		int ipid;
+		pid_t ipid;
 
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
@@ -107,15 +107,7 @@ int main(int argc, char **argv)
 		for (i = 0; i < TEST_PAGES; i++)
 			nodes[i] = to_node;
 
-		ipid = fork();
-		if (ipid == -1) {
-			tst_resm(TBROK | TERRNO, "fork failed");
-			goto err_free_pages;
-		}
-		if (ipid == 0)
-			exit(0);
-
-		wait(NULL);
+		ipid = tst_get_unused_pid(cleanup);
 
 		ret = numa_move_pages(ipid, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
@@ -125,9 +117,6 @@ int main(int argc, char **argv)
 		else
 			tst_resm(TFAIL|TERRNO, "move pages did not fail "
 				 "with ESRCH ret: %d", ret);
-
-err_free_pages:
-		free_pages(pages, TEST_PAGES);
 	}
 #else
 	tst_resm(TCONF, "move_pages support not found.");
diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index 741e195..17274cb 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -93,8 +93,6 @@
 #include "test.h"
 #include "usctest.h"
 
-#define INVALID_PID 999999
-
 static void setup(void);
 static void cleanup(void);
 
@@ -102,15 +100,19 @@ static int exp_enos[] = { EPERM, ESRCH, 0 };
 
 char *TCID = "ptrace03";
 
+static pid_t init_pid = 1;
+static pid_t unused_pid;
+static pid_t zero_pid;
+
 struct test_case_t {
 	enum __ptrace_request request;
-	pid_t pid;
+	pid_t *pid;
 	int exp_errno;
 } test_cases[] = {
 	{
-	PTRACE_ATTACH, 1, EPERM}, {
-	PTRACE_ATTACH, INVALID_PID, ESRCH}, {
-PTRACE_TRACEME, 0, EPERM},};
+	PTRACE_ATTACH, &init_pid, EPERM}, {
+	PTRACE_ATTACH, &unused_pid, ESRCH}, {
+	PTRACE_TRACEME, &zero_pid, EPERM},};
 
 int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
 
@@ -165,7 +167,7 @@ int main(int ac, char **av)
 				}
 
 				TEST(ptrace(test_cases[i].request,
-					    test_cases[i].pid, NULL, NULL));
+					    *(test_cases[i].pid), NULL, NULL));
 				if ((TEST_RETURN == -1) && (TEST_ERRNO ==
 							    test_cases
 							    [i].exp_errno)) {
@@ -205,6 +207,7 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup(void)
 {
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	/* capture signals
 	   tst_sig(FORK, DEF_HANDLER, cleanup); */
diff --git a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
index 606c8f3..51853f1 100644
--- a/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
+++ b/testcases/kernel/syscalls/sched_getaffinity/sched_getaffinity01.c
@@ -96,7 +96,7 @@ static void do_test(void)
 	int i;
 	cpu_set_t *mask;
 	int nrcpus = 1024;
-	pid_t pid;
+	pid_t unused_pid;
 	unsigned len;
 
 #if __GLIBC_PREREQ(2, 7)
@@ -155,28 +155,9 @@ realloc:
 	/* negative tests */
 	QUICK_TEST(sched_getaffinity(0, len, (cpu_set_t *) - 1));
 	QUICK_TEST(sched_getaffinity(0, 0, mask));
-	/*
-	 * pid_t -> int -- the actual kernel limit is lower
-	 * though, but this is a negative test, not a positive
-	 * one.
-	 *
-	 * Push comes to shove, if the user doesn't have the
-	 * ability to kill(3) processes (errno = EPERM), then
-	 * set the pid to the highest possible represented
-	 * value and cross your fingers in the hope that
-	 * a) Linux somehow hasn't started allocating PIDs
-	 * this high and b) the PID = INT_MAX isn't in fact
-	 * running.
-	 */
-	for (pid = 2; pid < INT_MAX; pid++) {
-		if (kill(pid, 0) == -1) {
-			if (errno == ESRCH)
-				break;
-			else if (errno == EPERM)
-				pid = INT_MAX - 1;
-		}
-	}
-	QUICK_TEST(sched_getaffinity(pid, len, mask));
+
+	unused_pid = tst_get_unused_pid(cleanup);
+	QUICK_TEST(sched_getaffinity(unused_pid, len, mask));
 	CPU_FREE(mask);
 }
 
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index c58d6eb..c1c9e3b 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -88,17 +88,21 @@ char *TCID = "sched_getparam03";
 static int exp_enos[] = { EINVAL, ESRCH, 0 };	/* 0 terminated list of *
 						 * expected errnos */
 
+static pid_t unused_pid;
+static pid_t zero_pid;
+static pid_t inval_pid = -1;
+
 static struct test_case_t {
 	char *desc;
-	pid_t pid;
+	pid_t *pid;
 	struct sched_param *p;
 	int exp_errno;
 	char err_desc[10];
 } test_cases[] = {
 	{
-	"test with non-existing pid", LARGE_PID, &param, ESRCH, "ESRCH"}, {
-	"test invalid pid value", -1, &param, EINVAL, "EINVAL"}, {
-"test with invalid address for p", 0, NULL, EINVAL, "EINVAL"},};
+	"test with non-existing pid", &unused_pid, &param, ESRCH, "ESRCH"}, {
+	"test invalid pid value", &inval_pid, &param, EINVAL, "EINVAL"}, {
+	"test with invalid address for p", &zero_pid, NULL, EINVAL, "EINVAL"},};
 
 int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
 
@@ -123,7 +127,7 @@ int main(int ac, char **av)
 			 * conditions. verify that it fails with -1 return
 			 * value and sets appropriate errno.
 			 */
-			TEST(sched_getparam(test_cases[ind].pid,
+			TEST(sched_getparam(*(test_cases[ind].pid),
 					    test_cases[ind].p));
 
 			if ((TEST_RETURN == -1) &&
@@ -151,6 +155,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
index 45e8e29..6f490be 100644
--- a/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
+++ b/testcases/kernel/syscalls/sched_getscheduler/sched_getscheduler02.c
@@ -46,13 +46,13 @@
 #include "test.h"
 #include "usctest.h"
 
-#define INVALID_PID	999999
-
 char *TCID = "sched_getscheduler02";
 int TST_TOTAL = 1;
 
 int exp_enos[] = { ESRCH, 0 };
 
+static pid_t unused_pid;
+
 void setup(void);
 void cleanup(void);
 
@@ -73,7 +73,7 @@ int main(int ac, char **av)
 		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
-		TEST(sched_getscheduler(INVALID_PID));
+		TEST(sched_getscheduler(unused_pid));
 
 		if (TEST_RETURN != -1) {
 			tst_resm(TFAIL, "sched_getscheduler(2) passed "
@@ -99,6 +99,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
index 632240a..f0613f5 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval03.c
@@ -75,8 +75,6 @@
 #include "test.h"
 #include "usctest.h"
 
-#define PID_DONT_EXISTS 999999
-
 static void setup();
 static void cleanup();
 
@@ -84,18 +82,22 @@ char *TCID = "sched_rr_get_interval03";
 struct timespec tp;
 static int exp_enos[] = { EINVAL, ESRCH, EFAULT, 0 };
 
+static pid_t unused_pid;
+static pid_t inval_pid = -1;
+static pid_t zero_pid;
+
 struct test_cases_t {
-	pid_t pid;
+	pid_t *pid;
 	struct timespec *tp;
 	int exp_errno;
 } test_cases[] = {
 	{
-	-1, &tp, EINVAL}, {
-	PID_DONT_EXISTS, &tp, ESRCH},
+	&inval_pid, &tp, EINVAL}, {
+	&unused_pid, &tp, ESRCH},
 #ifndef UCLINUX
 	    /* Skip since uClinux does not implement memory protection */
 	{
-	0, (struct timespec *)-1, EFAULT}
+	&zero_pid, (struct timespec *)-1, EFAULT}
 #endif
 };
 
@@ -120,7 +122,7 @@ int main(int ac, char **av)
 			/*
 			 * Call sched_rr_get_interval(2)
 			 */
-			TEST(sched_rr_get_interval(test_cases[i].pid,
+			TEST(sched_rr_get_interval(*(test_cases[i].pid),
 						   test_cases[i].tp));
 
 			if ((TEST_RETURN == -1) &&
@@ -161,6 +163,8 @@ void setup(void)
 	if ((sched_setscheduler(0, SCHED_RR, &p)) == -1) {
 		tst_brkm(TBROK, cleanup, "sched_setscheduler() failed");
 	}
+
+	unused_pid = tst_get_unused_pid(cleanup);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
index fc88ed1..16651f6 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
@@ -80,8 +80,6 @@
 #include <sched.h>
 #include <pwd.h>
 
-#define LARGE_PID 999999
-
 static void cleanup(void);
 static void setup(void);
 
@@ -93,18 +91,22 @@ char *TCID = "sched_setparam04";
 static int exp_enos[] = { EINVAL, ESRCH, 0 };	/* 0 terminated list of *
 						 * expected errnos */
 
+static pid_t unused_pid;
+static pid_t inval_pid = -1;
+static pid_t zero_pid;
+
 static struct test_case_t {
 	char *desc;
-	pid_t pid;
+	pid_t *pid;
 	struct sched_param *p;
 	int exp_errno;
 	char err_desc[10];
 } test_cases[] = {
 	{
-	"test with non-existing pid", LARGE_PID, &param, ESRCH, "ESRCH"}, {
-	"test invalid pid value", -1, &param, EINVAL, "EINVAL"}, {
-	"test with invalid address for p", 0, NULL, EINVAL, "EINVAL"}, {
-	"test with invalid p.sched_priority", 0, &param1, EINVAL,
+	"test with non-existing pid", &unused_pid, &param, ESRCH, "ESRCH"}, {
+	"test invalid pid value", &inval_pid, &param, EINVAL, "EINVAL"}, {
+	"test with invalid address for p", &zero_pid, NULL, EINVAL, "EINVAL"}, {
+	"test with invalid p.sched_priority", &zero_pid, &param1, EINVAL,
 		    "EINVAL"}
 };
 
@@ -129,7 +131,7 @@ int main(int ac, char **av)
 			/*
 			 * call the system call with the TEST() macro
 			 */
-			TEST(sched_setparam(test_cases[ind].pid,
+			TEST(sched_setparam(*(test_cases[ind].pid),
 					    test_cases[ind].p));
 
 			if ((TEST_RETURN == -1) &&
@@ -157,6 +159,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
index c840ce4..a3816d1 100644
--- a/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
+++ b/testcases/kernel/syscalls/sched_setscheduler/sched_setscheduler01.c
@@ -59,7 +59,6 @@
 #include "usctest.h"
 
 #define SCHED_INVALID	99
-#define INVALID_PID	999999
 
 char *TCID = "sched_setscheduler01";
 
@@ -70,27 +69,31 @@ int exp_enos[] = { ESRCH, EINVAL, EFAULT, 0 };
 void setup(void);
 void cleanup(void);
 
+static pid_t unused_pid;
+static pid_t init_pid = 1;
+static pid_t zero_pid;
+
 struct test_case_t {
-	pid_t pid;
+	pid_t *pid;
 	int policy;
 	struct sched_param *p;
 	int error;
 } TC[] = {
 	/* The pid is invalid - ESRCH */
 	{
-	INVALID_PID, SCHED_OTHER, &param, ESRCH},
+	&unused_pid, SCHED_OTHER, &param, ESRCH},
 	    /* The policy is invalid - EINVAL */
 	{
-	1, SCHED_INVALID, &param, EINVAL},
+	&init_pid, SCHED_INVALID, &param, EINVAL},
 #ifndef UCLINUX
 	    /* Skip since uClinux does not implement memory protection */
 	    /* The param address is invalid - EFAULT */
 	{
-	1, SCHED_OTHER, (struct sched_param *)-1, EFAULT},
+	&init_pid, SCHED_OTHER, (struct sched_param *)-1, EFAULT},
 #endif
 	    /* The priority value in param invalid - EINVAL */
 	{
-	0, SCHED_OTHER, &param1, EINVAL}
+	&zero_pid, SCHED_OTHER, &param1, EINVAL}
 };
 
 int TST_TOTAL = sizeof(TC) / sizeof(*TC);
@@ -118,7 +121,7 @@ int main(int ac, char **av)
 		/* loop through the test cases */
 		for (i = 0; i < TST_TOTAL; i++) {
 
-			TEST(sched_setscheduler(TC[i].pid, TC[i].policy,
+			TEST(sched_setscheduler(*(TC[i].pid), TC[i].policy,
 						TC[i].p));
 
 			if (TEST_RETURN != -1) {
@@ -150,6 +153,7 @@ int main(int ac, char **av)
  */
 void setup(void)
 {
+	unused_pid = tst_get_unused_pid(cleanup);
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 404c798..40180a2 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -55,16 +55,17 @@
 #include "test.h"
 #include "usctest.h"
 
-void setup();
-void cleanup();
+static void setup();
+static void cleanup();
 
 char *TCID = "setpgid02";
 int TST_TOTAL = 3;
 
-pid_t pgid, pid;
-pid_t bad_pid = -1;
-pid_t zero_pid = 0;
-pid_t inval_pid = 99999;
+static pid_t pgid, pid;
+static pid_t bad_pid = -1;
+static pid_t zero_pid;
+static pid_t unused_pid;
+static pid_t inval_pid = 99999;
 
 int exp_enos[] = { EINVAL, ESRCH, EPERM, 0 };
 
@@ -78,7 +79,7 @@ struct test_case_t {
 	&pid, &bad_pid, EINVAL},
 	    /* pid doesn't match any process - ESRCH */
 	{
-	&bad_pid, &pgid, ESRCH},
+	&unused_pid, &pgid, ESRCH},
 	    /* pgid doesn't exist - EPERM */
 	{
 	&zero_pid, &inval_pid, EPERM}
@@ -135,7 +136,7 @@ int main(int ac, char **av)
 /*
  * setup - performs all ONE TIME setup for this test
  */
-void setup(void)
+static void setup(void)
 {
 
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
@@ -144,13 +145,15 @@ void setup(void)
 
 	pgid = getpgrp();
 	pid = getpid();
+
+	unused_pid = tst_get_unused_pid(cleanup);
 }
 
 /*
  * cleanup - Performs all ONE TIME cleanup for this test at completion or
  * 	     premature exit
  */
-void cleanup(void)
+static void cleanup(void)
 {
 	/*
 	 * print timing status if that option was specified
diff --git a/testcases/kernel/syscalls/setpriority/setpriority04.c b/testcases/kernel/syscalls/setpriority/setpriority04.c
index 34175ec..b3ec9ff 100644
--- a/testcases/kernel/syscalls/setpriority/setpriority04.c
+++ b/testcases/kernel/syscalls/setpriority/setpriority04.c
@@ -66,31 +66,12 @@ int TST_TOTAL = 1;
 
 int exp_enos[] = { ESRCH, 0 };
 
-/* Get the max number of message queues allowed on system */
-static long get_pid_max(void)
-{
-	FILE *fp;
-	char buff[512];
-
-	/* Get the max number of message queues allowed on system */
-	fp = fopen("/proc/sys/kernel/pid_max", "r");
-	if (fp == NULL)
-		tst_brkm(TBROK, cleanup,
-			 "Could not open /proc/sys/kernel/pid_max");
-	if (!fgets(buff, sizeof(buff), fp))
-		tst_brkm(TBROK, cleanup,
-			 "Could not read /proc/sys/kernel/pid_max");
-	fclose(fp);
-
-	return atol(buff);
-}
-
 int main(int ac, char **av)
 {
 	int lc;
 	const char *msg;
 	int new_val = 2;
-	int pid_max = get_pid_max();
+	pid_t unused_pid;
 
 	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
@@ -98,6 +79,8 @@ int main(int ac, char **av)
 
 	setup();		/* global setup */
 
+	unused_pid = tst_get_unused_pid(cleanup);
+
 	/* The following loop checks looping state if -i option given */
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
@@ -110,7 +93,7 @@ int main(int ac, char **av)
 		 */
 
 		/* call the system call with the TEST() macro */
-		TEST(setpriority(PRIO_PROCESS, pid_max + 1, new_val));
+		TEST(setpriority(PRIO_PROCESS, unused_pid, new_val));
 
 		if (TEST_RETURN == 0) {
 			tst_resm(TFAIL, "call failed to produce expected error "
diff --git a/testcases/kernel/syscalls/tkill/tkill02.c b/testcases/kernel/syscalls/tkill/tkill02.c
index 7082881..a5d98cc 100644
--- a/testcases/kernel/syscalls/tkill/tkill02.c
+++ b/testcases/kernel/syscalls/tkill/tkill02.c
@@ -52,6 +52,10 @@
 char *TCID = "tkill02";
 int testno;
 
+static pid_t inval_tid = -1;
+static pid_t unused_tid;
+
+
 /* Extern Global Functions */
 /******************************************************************************/
 /*									    */
@@ -101,15 +105,17 @@ void setup(void)
 	/* Create temporary directories */
 	TEST_PAUSE;
 	tst_tmpdir();
+
+	unused_tid = tst_get_unused_pid(cleanup);
 }
 
 struct test_case_t {
-	int tid;
+	int *tid;
 	int exp_errno;
 } test_cases[] = {
 	{
-	-1, EINVAL}, {
-	99999, ESRCH}
+	&inval_tid, EINVAL}, {
+	&unused_tid, ESRCH}
 };
 
 int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
@@ -122,22 +128,22 @@ int main(int ac, char **av)
 
 	for (i = 0; i < TST_TOTAL; i++) {
 
-		TEST(ltp_syscall(__NR_tkill, test_cases[i].tid, SIGUSR1));
+		TEST(ltp_syscall(__NR_tkill, *(test_cases[i].tid), SIGUSR1));
 
 		if (TEST_RETURN == -1) {
 			if (TEST_ERRNO == test_cases[i].exp_errno) {
 				tst_resm(TPASS | TTERRNO,
 					 "tkill(%d, SIGUSR1) failed as expected",
-					 test_cases[i].tid);
+					 *(test_cases[i].tid));
 			} else {
 				tst_brkm(TFAIL | TTERRNO, cleanup,
 					 "tkill(%d, SIGUSR1) failed unexpectedly",
-					 test_cases[i].tid);
+					 *(test_cases[i].tid));
 			}
 		} else {
 			tst_brkm(TFAIL, cleanup,
 				 "tkill(%d) succeeded unexpectedly",
-				 test_cases[i].tid);
+				 *(test_cases[i].tid));
 		}
 	}
 	cleanup();
-- 
1.7.1


------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
