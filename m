Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoM-00052r-KX
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:14 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoL-0008Uv-Ah
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:14 +0000
Received: by dado14 with SMTP id o14so271940dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:07 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:35 +0800
Message-Id: <1331614605-30347-2-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 01/11] hugetlb/hugeshmat: cleanup codes
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
 testcases/kernel/mem/hugetlb/hugeshmat/Makefile    |    2 +-
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat01.c     |  159 ++++++-------------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat02.c     |  151 ++++++-------------
 .../kernel/mem/hugetlb/hugeshmat/hugeshmat03.c     |  167 ++++++-------------
 4 files changed, 149 insertions(+), 330 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0001-hugetlb-hugeshmat-cleanup-codes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-hugetlb-hugeshmat-cleanup-codes.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
index a1ba46e..f51f6b9 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/Makefile
@@ -20,7 +20,7 @@
 # Garrett Cooper, July 2009
 #
 
-top_srcdir              ?= ../../../../..
+top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
index 67bd4b0..b92f6eb 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c
@@ -33,7 +33,7 @@
  *	otherwise,
  *	  if doing functionality testing
  *		check for the correct conditions after the call
- *	  	if correct,
+ *		if correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
@@ -61,12 +61,11 @@
 
 char *TCID = "hugeshmat01";
 int TST_TOTAL = 3;
-unsigned long huge_pages_shm_to_be_allocated;
 
 #define CASE0		10		/* values to write into the shared */
 #define CASE1		20		/* memory location.		   */
 
-#if __WORDSIZE==64
+#if __WORDSIZE == 64
 #if defined(__mips__)
 #define UNALIGNED      0x1000000eee
 #else
@@ -76,85 +75,62 @@ unsigned long huge_pages_shm_to_be_allocated;
 #define UNALIGNED      0x60000eee
 #endif
 
-int shm_id_1 = -1;
-
-void	*addr;				/* for result of shmat-call */
+static size_t shm_size;
+static int    shm_id_1 = -1;
+static void   *addr;
 
 struct test_case_t {
-	int *shmid;
+	int  *shmid;
 	void *addr;
-	int flags;
+	int  flags;
 } TC[] = {
 	/* a straight forward read/write attach */
-	{&shm_id_1, 0, 0},
+	{ &shm_id_1,	0,			0 },
 
-       /* an attach using non aligned memory */
-	{&shm_id_1, (void *)UNALIGNED, SHM_RND},
+	/* an attach using non aligned memory */
+	{ &shm_id_1,	(void *)UNALIGNED,	SHM_RND },
 
 	/* a read only attach */
-	{&shm_id_1, 0, SHM_RDONLY}
+	{ &shm_id_1,	0,			SHM_RDONLY }
 };
 
+static void check_functionality(int i);
+
 int main(int ac, char **av)
 {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
-	int i;
-	void check_functionality(int);
+	int lc, i;
+	char *msg;
 
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
 
-	setup();			/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/* loop through the test cases */
-		for (i=0; i<TST_TOTAL; i++) {
-
-			/*
-			 * Use TEST macro to make the call
-			 */
-			errno = 0;
-			addr = shmat(*(TC[i].shmid), (void *)(TC[i].addr),
-				   TC[i].flags);
-			TEST_ERRNO = errno;
-
+		for (i = 0; i < TST_TOTAL; i++) {
+			addr = shmat(*(TC[i].shmid), TC[i].addr, TC[i].flags);
 			if (addr == (void *)-1) {
-				tst_brkm(TFAIL, cleanup, "%s call failed - "
-					 "errno = %d : %s", TCID, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+				tst_brkm(TFAIL|TERRNO, cleanup, "shmat");
 			} else {
-				if (STD_FUNCTIONAL_TEST) {
+				if (STD_FUNCTIONAL_TEST)
 					check_functionality(i);
-				} else {
-					tst_resm(TPASS, "call succeeded");
-				}
+				else
+					tst_resm(TPASS, "shmat call succeeded");
 			}
 
-			/*
-			 * clean up things in case we are looping - in
-			 * this case, detach the shared memory
-			 */
-			if (shmdt((const void *)addr) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "Couldn't detach shared memory");
-			}
+			if (shmdt(addr) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
 		}
 	}
-
 	cleanup();
-
 	tst_exit();
 }
 
@@ -162,20 +138,17 @@ int main(int ac, char **av)
  * check_functionality - check various conditions to make sure they
  *			 are correct.
  */
-void
-check_functionality(int i)
+static void check_functionality(int i)
 {
 	void *orig_add;
 	int *shared;
-	int fail = 0;
 	struct shmid_ds buf;
 
 	shared = (int *)addr;
 
 	/* stat the shared memory ID */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't stat shared memory");
-	}
+	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmctl");
 
 	/* check the number of attaches */
 	if (buf.shm_nattch != 1) {
@@ -184,13 +157,13 @@ check_functionality(int i)
 	}
 
 	/* check the size of the segment */
-	if (buf.shm_segsz != huge_pages_shm_to_be_allocated) {
+	if (buf.shm_segsz != shm_size) {
 		tst_resm(TFAIL, "segment size is incorrect");
 		return;
 	}
 
 	/* check for specific conditions depending on the type of attach */
-	switch(i) {
+	switch (i) {
 	case 0:
 		/*
 		 * Check the functionality of the first call by simply
@@ -198,7 +171,6 @@ check_functionality(int i)
 		 * If this fails the program will get a SIGSEGV, dump
 		 * core and exit.
 		 */
-
 		*shared = CASE0;
 		break;
 	case 1:
@@ -208,13 +180,12 @@ check_functionality(int i)
 		 * that the original address given was rounded down as
 		 * specified in the man page.
 		 */
-
 		*shared = CASE1;
-		orig_add = addr + ((unsigned long)TC[i].addr%SHMLBA);
+		orig_add = addr + ((unsigned long)TC[i].addr % SHMLBA);
 		if (orig_add != TC[i].addr) {
 			tst_resm(TFAIL, "shared memory address is not "
-				 "correct");
-			fail = 1;
+					"correct");
+			return;
 		}
 		break;
 	case 2:
@@ -223,64 +194,34 @@ check_functionality(int i)
 		 * and check that it is equal to the value set in case #2,
 		 * because shared memory is persistent.
 		 */
-
 		if (*shared != CASE1) {
 			tst_resm(TFAIL, "shared memory value isn't correct");
-			fail = 1;
+			return;
 		}
 		break;
 	}
-
-	if (!fail) {
-		tst_resm(TPASS, "conditions and functionality are correct");
-	}
+	tst_resm(TPASS, "conditions and functionality are correct");
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
-	TEST_PAUSE;
-
-	/*
-	 * Create a temporary directory and cd into it.
-	 * This helps to ensure that a unique msgkey is created.
-	 * See ../lib/libipc.c for more information.
-	 */
 	tst_tmpdir();
 
-	/* Get an IPC resouce key */
 	shmkey = getipckey();
+	shm_id_1 = shmget(shmkey++, shm_size,
+		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
+	if (shm_id_1 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 
-	/* create a shared memory resource with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey++, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW | IPC_CREAT |
-	     IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource 1 in setup()");
-	}
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
-	/* if it exists, remove the shared memory resource */
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
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
index ed0c476..6697436 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c
@@ -50,158 +50,97 @@
  *	Must be ran as root
  */
 
-#include "ipcshm.h"
 #include <pwd.h>
+#include "ipcshm.h"
 #include "system_specific_hugepages_info.h"
 
 char *TCID = "hugeshmat02";
 int TST_TOTAL = 2;
-char nobody_uid[] = "nobody";
-struct passwd *ltpuser;
-unsigned long huge_pages_shm_to_be_allocated;
-
-int exp_enos[] = {EINVAL, EACCES, 0};	/* 0 terminated list of */
-					/* expected errnos      */
-
-int shm_id_1 = -1;
-int shm_id_2 = -1;
-int shm_id_3 = -1;
 
-void	*addr;				/* for result of shmat-call */
-
-#if __WORDSIZE==64
-#define NADDR   0x10000000eef           /* a 64bit non alligned address value */
+#if __WORDSIZE == 64
+#define NADDR	0x10000000eef	/* a 64bit non alligned address value */
 #else
-#define NADDR	0x60000eef		/* a non alligned address value */
+#define NADDR	0x60000eef	/* a non alligned address value */
 #endif
 
+static size_t shm_size;
+static int    shm_id_1 = -1;
+static int    shm_id_2 = -1;
+static void   *addr;
+
 struct test_case_t {
-	int *shmid;
+	int  *shmid;
 	void *addr;
-	int error;
+	int  error;
 } TC[] = {
 	/* EINVAL - the shared memory ID is not valid */
-	{&shm_id_1, 0, EINVAL},
+	{ &shm_id_1,	NULL,		EINVAL },
 
 	/* EINVAL - the address is not page aligned and SHM_RND is not given */
-	{&shm_id_2, (void *)NADDR, EINVAL},
-
+	{ &shm_id_2,	(void *)NADDR,	EINVAL },
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
-			 * make the call using the TEST() macro - attempt
-			 * various invalid shared memory attaches
-			 */
- 			errno = 0;
-                       	addr = shmat(*(TC[i].shmid), (const void *)TC[i].addr, 0);
-                       	TEST_ERRNO = errno;
-
-                      	if (addr != (void *)-1) {
-				tst_resm(TFAIL, "call succeeded unexpectedly");
+		for (i = 0; i < TST_TOTAL; i++) {
+			errno = 0;
+			addr = shmat(*(TC[i].shmid), TC[i].addr, 0);
+			TEST_ERRNO = errno;
+			if (addr != (void *)-1) {
+				tst_resm(TFAIL, "unexpected success");
 				continue;
 			}
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
-
-			}
+			if (TEST_ERRNO == TC[i].error)
+				tst_resm(TPASS|TTERRNO, "expected failure");
+			else
+				tst_resm(TFAIL|TTERRNO, "unexpected failure "
+					    "- expected errno %d, got",
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
 
 	/* create a shared memory resource with read and write permissions */
 	/* also post increment the shmkey for the next shmget call */
-	if ((shm_id_2 = shmget(shmkey++, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW | IPC_CREAT |
-	     IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource #1 in setup()");
-	}
+	shm_id_2 = shmget(shmkey++, shm_size,
+		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
+	if (shm_id_2 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 
-	/* create a shared memory resource without read and write permissions */
-	if ((shm_id_3 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource #2 in setup()");
-	}
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
 	rm_shm(shm_id_2);
-	rm_shm(shm_id_3);
 
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
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index 7aecefe..938ddfa 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -62,153 +62,92 @@
 
 char *TCID = "hugeshmat03";
 int TST_TOTAL = 1;
-unsigned long huge_pages_shm_to_be_allocated;
 
-int exp_enos[] = {EACCES, 0};	/* 0 terminated list of expected errnos */
+static size_t shm_size;
+static int    shm_id_1 = -1;
+static void   *addr;
+static uid_t  ltp_uid;
+static char   *ltp_user = "nobody";
 
-int shm_id_1 = -1;
-
-void	*addr;			/* for result of shmat-call */
-
-uid_t ltp_uid;
-char *ltp_user = "nobody";
+static void do_child(void);
 
 int main(int ac, char **av)
 {
-	char *msg;			/* message returned from parse_opts */
-	int pid;
-	void do_child(void);
-
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
-
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
-
-	setup();			/* global setup */
-
-	if ((pid = fork()) == -1) {
-		tst_brkm(TBROK, cleanup, "could not fork");
-	}
-
-	if (pid == 0) {		/* child */
-		/* set the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1) {
-			tst_resm(TBROK, "setuid() failed");
-			exit(1);
-		}
-
+	char *msg;
+	int status;
+	pid_t pid;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+
+	setup();
+
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		if (setuid(ltp_uid) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "setuid");
 		do_child();
-
-	} else {		/* parent */
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
 	cleanup();
 	tst_exit();
 }
 
-/*
- * do_child - make the TEST call as the child process
- */
-void
-do_child()
+static void do_child(void)
 {
 	int lc;
 
-	/* The following loop checks looping state if -i option given */
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/*
-		 * use TEST macro to make the call
-		 */
 		errno = 0;
-		addr = shmat(shm_id_1, (const void *)0, 0);
+		addr = shmat(shm_id_1, NULL, 0);
 		TEST_ERRNO = errno;
-
-		if (addr != (char *)-1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
+		if (addr != (void *)-1) {
+			tst_resm(TFAIL, "unexpected success");
 			continue;
 		}
-
-		TEST_ERROR_LOG(TEST_ERRNO);
-
-		switch(TEST_ERRNO) {
-		case EACCES:
-			tst_resm(TPASS, "expected failure - errno = "
-				 "%d : %s", TEST_ERRNO,
-				 strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an "
-				 "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
+		if (TEST_ERRNO == EACCES)
+			tst_resm(TPASS|TTERRNO, "expected failure");
+		else
+			tst_resm(TFAIL|TTERRNO, "unexpected failure "
+				    "- expected errno %d, got", EACCES);
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
+	shm_id_1 = shmget(shmkey, shm_size,
+		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
+	if (shm_id_1 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 
-	/* create a shared memory segment with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "segment in setup");
-	}
-
-	/* get the userid for a non root user */
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



