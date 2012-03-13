Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoN-0000NR-6y
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:15 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoL-0008Uq-K2
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:15 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271895dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:13 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:37 +0800
Message-Id: <1331614605-30347-4-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 03/11] hugetlb/hugeshmctl: cleanup codes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.8.4
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 testcases/kernel/mem/hugetlb/hugeshmctl/Makefile   |    2 +-
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |  311 +++++++-------------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |  136 +++------
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |  173 ++++--------
 4 files changed, 205 insertions(+), 417 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0003-hugetlb-hugeshmctl-cleanup-codes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0003-hugetlb-hugeshmctl-cleanup-codes.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
index 2f5b160..3edcd7b 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/Makefile
@@ -20,7 +20,7 @@
 # Garrett Cooper, July 2009
 #
 
-top_srcdir              ?= ../../../../..
+top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index ae5f3a8..ce8d89a 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -36,7 +36,7 @@
  *	otherwise,
  *	  if doing functionality testing
  *		call the correct test function
- *	  	if the conditions are correct,
+ *		if the conditions are correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
@@ -66,78 +66,57 @@
 
 char *TCID = "hugeshmctl01";
 int TST_TOTAL = 4;
-unsigned long huge_pages_shm_to_be_allocated;
-
-int shm_id_1 = -1;
-struct shmid_ds buf;
-long save_time;
-
-#define FIRST	0
-#define SECOND	1
-int stat_time;		/* set to either FIRST or SECOND for IPC_STAT tests */
-
-void *set_shared;
 
+#define FIRST		0
+#define SECOND		1
 #define N_ATTACH	4
-
-pid_t pid_arr[N_ATTACH];
-
-void sighandler(int);
-
-/*
- * These are the various setup and check functions for the commands
- * that we are checking.
- */
-
-/* Setup, cleanup and check routines for IPC_STAT */
-void stat_setup(void), func_stat(void);
-void stat_cleanup(void);
-
-/* Setup and check routines for IPC_SET */
-void set_setup(void), func_set(void);
-
-/* Check routine for IPC_RMID */
-void func_rmid(void);
+#define NEWMODE		0066
+
+static size_t shm_size;
+static int shm_id_1 = -1;
+static struct shmid_ds buf;
+static time_t save_time;
+static int stat_time;
+static void *set_shared;
+static pid_t pid_arr[N_ATTACH];
+
+static void sighandler(int sig);
+static void stat_setup(void);
+static void stat_cleanup(void);
+static void set_setup(void);
+static void func_stat(void);
+static void func_set(void);
+static void func_rmid(void);
+static void *set_shmat(void);
 
 struct test_case_t {
-	int cmd;		/* the command to test */
-	void (*func_test)();	/* the test function */
-	void (*func_setup)();	/* the setup function if necessary */
+	int  cmd;
+	void (*func_test)(void);
+	void (*func_setup)(void);
 } TC[] = {
-
-	{IPC_STAT, func_stat, stat_setup},
-
-	{IPC_STAT, func_stat, stat_setup},
-
-	{IPC_SET, func_set, set_setup},
-
-	{IPC_RMID, func_rmid, NULL}
+	{ IPC_STAT,	func_stat,	stat_setup },
+	{ IPC_STAT,	func_stat,	stat_setup },
+	{ IPC_SET,	func_set,	set_setup },
+	{ IPC_RMID,	func_rmid,	NULL }
 };
 
-#define NEWMODE	0066
-
 int main(int ac, char **av)
 {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
-	int i;
-	void check_functionality(void);
-
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+	int lc, i;
+	char *msg;
 
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	setup();			/* global setup */
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
 
-	/* The following loop checks looping state if -i option given */
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
 		/* initialize stat_time */
@@ -148,33 +127,21 @@ int main(int ac, char **av)
 		 * permissions.  Do this here instead of in setup()
 		 * so that looping (-i) will work correctly.
 		 */
-		if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL |
-				SHM_RW)) == -1) {
-			tst_brkm(TBROK, cleanup, "couldn't create the shared"
-				 " memory segment");
-		}
-
-		/* loop through the test cases */
-		for (i=0; i<TST_TOTAL; i++) {
+		shm_id_1 = shmget(shmkey, shm_size,
+			    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
+		if (shm_id_1 == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 
+		for (i = 0; i < TST_TOTAL; i++) {
 			/*
 			 * if needed, set up any required conditions by
 			 * calling the appropriate setup function
 			 */
-			if (TC[i].func_setup != NULL) {
+			if (TC[i].func_setup != NULL)
 				(*TC[i].func_setup)();
-			}
 
-			/*
-			 * Use TEST macro to make the call
-			 */
-
-			TEST(shmctl(shm_id_1, TC[i].cmd, &buf));
-
-			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL, "%s call failed - errno "
-					 "= %d : %s", TCID, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+			if (shmctl(shm_id_1, TC[i].cmd, &buf) == -1) {
+				tst_resm(TFAIL|TERRNO, "shmctl");
 				continue;
 			}
 			if (STD_FUNCTIONAL_TEST) {
@@ -183,7 +150,7 @@ int main(int ac, char **av)
 				tst_resm(TPASS, "call succeeded");
 
 				/* now perform command related cleanup */
-				switch(TC[i].cmd) {
+				switch (TC[i].cmd) {
 				case IPC_STAT:
 					stat_cleanup();
 					break;
@@ -194,9 +161,7 @@ int main(int ac, char **av)
 			}
 		}
 	}
-
 	cleanup();
-
 	tst_exit();
 }
 
@@ -205,16 +170,13 @@ int main(int ac, char **av)
  *		 this seperate routine to avoid code duplication in
  *		 stat_setup() below.
  */
-void *
-set_shmat()
+void *set_shmat(void)
 {
 	void *rval;
 
-	/* attach the shared memory */
 	rval = shmat(shm_id_1, 0, 0);
-
 	if (rval == (void *)-1)
-		tst_brkm(TBROK|TERRNO, cleanup, "shmat() failed.");
+		tst_brkm(TBROK|TERRNO, cleanup, "shmat");
 
 	return rval;
 }
@@ -224,11 +186,10 @@ set_shmat()
  *		  Make things interesting by forking some children
  *		  that will either attach or inherit the shared memory.
  */
-void
-stat_setup()
+static void stat_setup(void)
 {
 	int i, rval;
-	void *test, *set_shmat();
+	void *test;
 	pid_t pid;
 	sigset_t newmask, oldmask;
 
@@ -259,20 +220,14 @@ stat_setup()
 	sigemptyset(&newmask);
 	sigaddset(&newmask, SIGUSR1);
 	if (sigprocmask(SIG_BLOCK, &newmask, &oldmask) < 0)
-		tst_brkm(TBROK, cleanup, "block SIGUSR1 error");
-
-	for (i=0; i<N_ATTACH; i++) {
-		if ((pid = fork()) == -1) {
-			tst_brkm(TBROK, cleanup, "could not fork");
-		}
+		tst_brkm(TBROK|TERRNO, cleanup, "block SIGUSR1 error");
 
-		if (pid == 0) {		/* child */
-
-			if (stat_time == FIRST) {
-				test = set_shmat();
-			} else {
-				test = set_shared;
-			}
+	for (i = 0; i < N_ATTACH; i++) {
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			test = (stat_time == FIRST) ? set_shmat() : set_shared;
 
 			/* do an assignement for fun */
 			*(int *)test = i;
@@ -284,20 +239,21 @@ stat_setup()
 			 */
 			rval = sigsuspend(&oldmask);
 			if (rval != -1)
-				tst_brkm(TBROK, cleanup, "sigsuspend error");
+				tst_brkm(TBROK|TERRNO, cleanup, "sigsuspend");
 
-			/* don't have to block SIGUSR1 any more, recover the mask */
+			/*
+			 * don't have to block SIGUSR1 any more,
+			 * recover the mask
+			 */
 			if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-				tst_brkm(TBROK, cleanup, "children setmask error");
+				tst_brkm(TBROK|TERRNO, cleanup,
+					    "child sigprocmask");
 
 			/* now we're back - detach the memory and exit */
-			if (shmdt(test) == -1) {
-				tst_resm(TBROK, "shmdt() failed - %d", errno);
-			}
-
-			tst_exit();
-
-		} else {		/* parent */
+			if (shmdt(test) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
+			exit(0);
+		default:
 			/* save the child's pid for cleanup later */
 			pid_arr[i] = pid;
 		}
@@ -305,9 +261,8 @@ stat_setup()
 
 	/* parent doesn't have to block SIGUSR1, recover the mask */
 	if (sigprocmask(SIG_SETMASK, &oldmask, NULL) < 0)
-		tst_brkm(TBROK, cleanup, "parent setmask error");
+		tst_brkm(TBROK, cleanup, "parent sigprocmask");
 
-	/* sleep briefly to ensure correct execution order */
 	usleep(250000);
 }
 
@@ -316,24 +271,21 @@ stat_setup()
  *		 by looking at the pid of the creator, the segement size,
  *		 the number of attaches and the mode.
  */
-void
-func_stat()
+static void func_stat(void)
 {
-	int fail = 0;
 	pid_t pid;
 
 	/* check perm, pid, nattach and size */
-
 	pid = getpid();
 
 	if (buf.shm_cpid != pid) {
 		tst_resm(TFAIL, "creator pid is incorrect");
-		fail = 1;
+		goto fail;
 	}
 
-	if (!fail && buf.shm_segsz != huge_pages_shm_to_be_allocated) {
+	if (buf.shm_segsz != shm_size) {
 		tst_resm(TFAIL, "segment size is incorrect");
-		fail = 1;
+		goto fail;
 	}
 
 	/*
@@ -342,29 +294,26 @@ func_stat()
 	 * through, the parent attaches the memory and the children inherit
 	 * that memory so the attaches equal N_ATTACH + stat_time (1).
 	 */
-	if (!fail && buf.shm_nattch != N_ATTACH + stat_time) {
+	if (buf.shm_nattch != N_ATTACH + stat_time) {
 		tst_resm(TFAIL, "# of attaches is incorrect - %lu",
 			 (unsigned long)buf.shm_nattch);
-		fail = 1;
+		goto fail;
 	}
 
 	/* use MODE_MASK to make sure we are comparing the last 9 bits */
-	if (!fail && (buf.shm_perm.mode & MODE_MASK) != ((SHM_RW) & MODE_MASK)) {
+	if ((buf.shm_perm.mode & MODE_MASK) != ((SHM_RW) & MODE_MASK)) {
 		tst_resm(TFAIL, "segment mode is incorrect");
-		fail = 1;
+		goto fail;
 	}
 
+	tst_resm(TPASS, "pid, size, # of attaches and mode are correct "
+		 "- pass #%d", stat_time);
+
+fail:
 	stat_cleanup();
 
 	/* save the change time for use in the next test */
 	save_time = buf.shm_ctime;
-
-	if (fail) {
-		return;
-	}
-
-	tst_resm(TPASS, "pid, size, # of attaches and mode are correct "
-		 "- pass #%d", stat_time);
 }
 
 /*
@@ -372,33 +321,26 @@ func_stat()
  *		    have the parent make dessert, er, um, make that remove
  *		    the shared memory that is no longer needed.
  */
-void
-stat_cleanup()
+static void stat_cleanup(void)
 {
 	int i;
 
 	/* wake up the childern so they can detach the memory and exit */
-	for (i=0; i<N_ATTACH; i++) {
-		if (kill(pid_arr[i], SIGUSR1) == -1) {
-			tst_brkm(TBROK, cleanup, "kill failed");
-		}
-	}
+	for (i = 0; i < N_ATTACH; i++)
+		if (kill(pid_arr[i], SIGUSR1) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill with SIGUSR1");
 
 	/* remove the parent's shared memory the second time through */
-	if (stat_time == SECOND) {
-		if (shmdt(set_shared) == -1) {
-			tst_resm(TINFO, "shmdt() failed");
-		}
-	}
-
+	if (stat_time == SECOND)
+		if (shmdt(set_shared) == -1)
+			tst_resm(TBROK|TERRNO, "shmdt");
 	stat_time++;
 }
 
 /*
  * set_setup() - set up for the IPC_SET command with shmctl()
  */
-void
-set_setup()
+static void set_setup(void)
 {
 	/* set up a new mode for the shared memory segment */
 	buf.shm_perm.mode = SHM_RW | NEWMODE;
@@ -410,29 +352,22 @@ set_setup()
 /*
  * func_set() - check the functionality of the IPC_SET command with shmctl()
  */
-void
-func_set()
+static void func_set(void)
 {
-	int fail = 0;
-
 	/* first stat the shared memory to get the new data */
 	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-		tst_resm(TBROK, "stat failed in func_set()");
+		tst_resm(TBROK|TERRNO, "shmctl in func_set()");
 		return;
 	}
 
 	if ((buf.shm_perm.mode & MODE_MASK) !=
 			((SHM_RW | NEWMODE) & MODE_MASK)) {
 		tst_resm(TFAIL, "new mode is incorrect");
-		fail = 1;
+		return;
 	}
 
-	if (!fail && save_time >= buf.shm_ctime) {
+	if (save_time >= buf.shm_ctime) {
 		tst_resm(TFAIL, "change time is incorrect");
-		fail = 1;
-	}
-
-	if (fail) {
 		return;
 	}
 
@@ -442,71 +377,39 @@ func_set()
 /*
  * func_rmid() - check the functionality of the IPC_RMID command with shmctl()
  */
-void
-func_rmid()
+static void func_rmid(void)
 {
 	/* Do another shmctl() - we should get EINVAL */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1) {
+	if (shmctl(shm_id_1, IPC_STAT, &buf) != -1)
 		tst_brkm(TBROK, cleanup, "shmctl succeeded on expected fail");
-	}
-
-	if (errno != EINVAL) {
-		tst_resm(TFAIL, "returned unexpected errno %d", errno);
-	} else {
+	if (errno != EINVAL)
+		tst_resm(TFAIL|TTERRNO, "unexpected errno, expect %d", EINVAL);
+	else
 		tst_resm(TPASS, "shared memory appears to be removed");
-	}
-
 	shm_id_1 = -1;
 }
 
-/*
- * sighandler() - handle signals, in this case SIGUSR1 is the only one expected
- */
-void
-sighandler(sig)
+static void sighandler(int sig)
 {
 	if (sig != SIGUSR1)
-		tst_resm(TINFO, "received unexpected signal %d", sig);
+		tst_resm(TFAIL, "received unexpected signal %d", sig);
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void
-setup(void)
+void setup(void)
 {
-
 	tst_sig(FORK, sighandler, cleanup);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();
 
-	/* get an IPC resource key */
 	shmkey = getipckey();
+
+	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void
-cleanup(void)
+void cleanup(void)
 {
-	/* if it exists, remove the shared memory segment */
+	TEST_CLEANUP;
+
 	rm_shm(shm_id_1);
 
 	tst_rmdir();
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 1193b82..15cadb0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -52,23 +52,18 @@
  *	none
  */
 
-#include "ipcshm.h"
 #include <pwd.h>
+#include "ipcshm.h"
 #include "system_specific_hugepages_info.h"
 
 char *TCID = "hugeshmctl02";
 int TST_TOTAL = 4;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-unsigned long huge_pages_shm_to_be_allocated;
 
-int exp_enos[] = {EPERM, EACCES, EFAULT, EINVAL, 0};  /* 0 terminated list  */
-						      /* of expected errnos */
-int shm_id_1 = -1;
-int shm_id_2 = -1;
-int shm_id_3 = -1;
-
-struct shmid_ds buf;
+static size_t shm_size;
+static int shm_id_1 = -1;
+static int shm_id_2 = -1;
+static int shm_id_3 = -1;
+static struct shmid_ds buf;
 
 struct test_case_t {
 	int *shmid;
@@ -77,127 +72,78 @@ struct test_case_t {
 	int error;
 } TC[] = {
 	/* EFAULT - IPC_SET & buf isn't valid */
-	{&shm_id_2, IPC_SET, (struct shmid_ds *)-1, EFAULT},
+	{ &shm_id_2,	IPC_SET,	(struct shmid_ds *)-1,	EFAULT },
 
 	/* EFAULT - IPC_STAT & buf isn't valid */
-	{&shm_id_2, IPC_STAT, (struct shmid_ds *)-1, EFAULT},
+	{ &shm_id_2,	IPC_STAT,	(struct shmid_ds *)-1,	EFAULT },
 
 	/* EINVAL - the shmid is not valid */
-	{&shm_id_3, IPC_STAT, &buf, EINVAL},
+	{ &shm_id_3,	IPC_STAT,	&buf,			EINVAL },
 
 	/* EINVAL - the command is not valid */
-	{&shm_id_2, -1, &buf, EINVAL},
+	{ &shm_id_2,	-1,		&buf,			EINVAL },
 };
 
 int main(int ac, char **av)
 {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
-	int i;
-
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+	int lc, i;
+	char *msg;
 
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	setup();			/* global setup */
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
 
-	/* The following loop checks looping state if -i option given */
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/* loop through the test cases */
-		for (i=0; i<TST_TOTAL; i++) {
-			/*
-			 * use the TEST() macro to make the call
-			 */
-
+		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
-
-			if ((TEST_RETURN != -1)&&(i < 5)) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
-				 	TEST_ERRNO, strerror(TEST_ERRNO));
-			}
+			if (TEST_ERRNO == TC[i].error)
+				tst_resm(TPASS|TTERRNO, "expected failure");
+			else
+				tst_resm(TFAIL|TTERRNO, "unexpected behavior "
+					    "- expected errno = %d, got",
+					    TC[i].error);
 		}
 	}
-
 	cleanup();
-
 	tst_exit();
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void
-setup(void)
+void setup(void)
 {
-
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
-
-	/* Set up the expected error numbers for -e option */
-	TEST_EXP_ENOS(exp_enos);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();
 
-	/* get an IPC resource key */
 	shmkey = getipckey();
 
 	/* create a shared memory segment without read or write permissions */
-	if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
-			 "segment #1 in setup()");
-	}
+	shm_id_1 = shmget(shmkey, shm_size, SHM_HUGETLB|IPC_CREAT|IPC_EXCL);
+	if (shm_id_1 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget #1");
 
 	/* create a shared memory segment with read and write permissions */
-	if ((shm_id_2 = shmget(shmkey + 1, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
-			 "segment #2 in setup()");
-	}
+	shm_id_2 = shmget(shmkey + 1, shm_size,
+		    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
+	if (shm_id_2 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget #2");
+
+	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void
-cleanup(void)
+void cleanup(void)
 {
-	/* if they exist, remove the shared memory resources */
+	TEST_CLEANUP;
+
 	rm_shm(shm_id_1);
 	rm_shm(shm_id_2);
 
 	tst_rmdir();
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
-
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 689622f..30353b8 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -25,8 +25,8 @@
  *	hugeshmctl03 - check for EACCES, and EPERM errors
  *
  * ALGORITHM
- *	create a large shared memory segment with root only read & write permissions
- *	fork a child process
+ *	create a large shared memory segment with root only read & write
+ *	permissions fork a child process
  *	if child
  *	  set the ID of the child process to that of "ltpuser1"
  *	  call do_child()
@@ -58,23 +58,19 @@
  *	test must be run as root
  */
 
-#include "ipcshm.h"
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "ipcshm.h"
 #include "system_specific_hugepages_info.h"
 
 char *TCID = "hugeshmctl03";
 int TST_TOTAL = 3;
-unsigned long huge_pages_shm_to_be_allocated;
-
-int exp_enos[] = {EACCES, EPERM, 0};	/* 0 terminated list of */
-					/* expected errnos 	*/
-int shm_id_1 = -1;
 
-uid_t ltp_uid;
-char *ltp_user = "nobody";
-
-struct shmid_ds buf;
+static size_t shm_size;
+static int shm_id_1 = -1;
+static struct shmid_ds buf;
+static uid_t ltp_uid;
+static char *ltp_user = "nobody";
 
 struct test_case_t {
 	int *shmid;
@@ -83,150 +79,93 @@ struct test_case_t {
 	int error;
 } TC[] = {
 	/* EACCES - child has no read permission for segment */
-	{&shm_id_1, IPC_STAT, &buf, EACCES},
+	{ &shm_id_1,	IPC_STAT,	&buf,	EACCES },
 
 	/* EPERM - IPC_SET - child doesn't have permission to change segment */
-	{&shm_id_1, IPC_SET, &buf, EPERM},
+	{ &shm_id_1,	IPC_SET,	&buf,	EPERM },
 
 	/* EPERM - IPC_RMID - child can not remove the segment */
-	{&shm_id_1, IPC_RMID, &buf, EPERM},
+	{ &shm_id_1,	IPC_RMID,	&buf,	EPERM },
 };
 
+static void do_child(void);
+
 int main(int ac, char **av)
 {
-	char *msg;			/* message returned from parse_opts */
-	int pid;
-	void do_child(void);
+	char *msg;
+	pid_t pid;
+	int status;
 
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
 
-	setup();			/* global setup */
+	setup();
 
-	if ((pid = fork()) == -1) {
-		tst_brkm(TBROK, cleanup, "could not fork");
-	}
-
-	if (pid == 0) {		/* child */
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
 		/* set  the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1) {
-			tst_resm(TBROK, "setuid() failed");
-			exit(1);
-		}
-
+		if (setuid(ltp_uid) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "setuid");
 		do_child();
-	} else {
-		/* wait for the child to return */
-		if (waitpid(pid, NULL, 0) == -1) {
-			tst_brkm(TBROK, cleanup, "waitpid failed");
-		}
-
-		/* if it exists, remove the shared memory resource */
-		rm_shm(shm_id_1);
-
-		tst_rmdir();
+		tst_exit();
+	default:
+		if (waitpid(pid, &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
 	}
-
-	cleanup ();
+	cleanup();
 	tst_exit();
 }
 
-/*
- * do_child - make the call as the child process
- */
-void
-do_child()
+static void do_child(void)
 {
 	int i, lc;
 
-	/* The following loop checks looping state if -i option given */
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/* loop through the test cases */
-		for (i=0; i<TST_TOTAL; i++) {
-			/*
-			 * use the TEST() macro to make the call
-			 */
-
+		for (i = 0; i < TST_TOTAL; i++) {
 			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].sbuf));
-
-			if (TEST_RETURN != -1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
-				continue;
-			}
-
-			TEST_ERROR_LOG(TEST_ERRNO);
-
-			if (TEST_ERRNO == TC[i].error) {
-				tst_resm(TPASS, "expected failure - errno = "
-					 "%d : %s", TEST_ERRNO,
-					 strerror(TEST_ERRNO));
-			} else {
-				tst_resm(TFAIL, "call failed with an "
-					 "unexpected error - %d : %s",
-					 TEST_ERRNO, strerror(TEST_ERRNO));
-			}
+			if (TEST_ERRNO == TC[i].error)
+				tst_resm(TPASS|TTERRNO, "expected failure");
+			else
+				tst_resm(TFAIL|TTERRNO, "unexpected behavior "
+					    "- expected errno = %d, got",
+					    TC[i].error);
 		}
 	}
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void
-setup(void)
+void setup(void)
 {
-	/* check for root as process owner */
-	check_root();
-
+	tst_require_root(NULL);
 	tst_sig(FORK, DEF_HANDLER, cleanup);
-
-	/* Set up the expected error numbers for -e option */
-	TEST_EXP_ENOS(exp_enos);
-
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();
 
-	/* get an IPC resource key */
 	shmkey = getipckey();
-
-	/* create a shared memory segment with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL |
-	     SHM_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory "
-			 "segment in setup()");
-	}
+	shm_id_1 = shmget(shmkey, shm_size,
+		    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
+	if (shm_id_1 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 
 	/* get the userid for a non root user */
 	ltp_uid = getuserid(ltp_user);
+
+	TEST_PAUSE;
 }
 
-/*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
- */
-void
-cleanup(void)
+void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+	rm_shm(shm_id_1);
+
+	tst_rmdir();
+}

--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--------------1.7.8.4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.8.4--



