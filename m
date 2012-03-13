Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoY-0007m7-B8
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:26 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoX-0008Uq-18
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:26 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271895dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:24 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:41 +0800
Message-Id: <1331614605-30347-8-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 07/11] hugetlb/hugeshmget: cleanup codes
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
 testcases/kernel/mem/hugetlb/hugeshmget/Makefile   |    2 +-
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |  108 +++++---------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |  152 ++++++-------------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |  136 ++++++------------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |  154 ++++++--------------
 5 files changed, 179 insertions(+), 373 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0007-hugetlb-hugeshmget-cleanup-codes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0007-hugetlb-hugeshmget-cleanup-codes.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
index 54b5709..266bc4d 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/Makefile
@@ -16,7 +16,7 @@
 #  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
-top_srcdir              ?= ../../../../..
+top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index d8160ea..9bdf029 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -22,7 +22,8 @@
  *	hugeshmget01.c
  *
  * DESCRIPTION
- *	hugeshmget01 - test that shmget() correctly creates a large shared memory segment
+ *	hugeshmget01 - test that shmget() correctly creates a large
+ *			shared memory segment
  *
  * ALGORITHM
  *	loop if that option was specified
@@ -33,7 +34,7 @@
  *	  if doing functionality testing
  *		stat the shared memory resource
  *		check the size, creator pid and mode
- *	  	if correct,
+ *		if correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
@@ -63,61 +64,52 @@
 char *TCID = "hugeshmget01";
 int TST_TOTAL = 1;
 
-int shm_id_1 = -1;
+static int shm_id_1 = -1;
 
 int main(int ac, char **av)
 {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
+	int lc;
+	char *msg;
 	struct shmid_ds buf;
-        unsigned long huge_pages_shm_to_be_allocated;
+	size_t shm_size;
 
-	huge_pages_shm_to_be_allocated = 0;
+	shm_size = 0;
 
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	/* The following loop checks looping state if -i option given */
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-        else
-              huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
 
-	setup();			/* global setup */
+	setup();
 
-        for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
 
-		/*
-		 * Use TEST macro to make the call
-		 */
-
-                TEST(shmget(shmkey, huge_pages_shm_to_be_allocated, (SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW)));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+		shm_id_1 = shmget(shmkey, shm_size,
+			    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
+		if (shm_id_1 == -1) {
+			tst_resm(TFAIL|TERRNO, "shmget");
 		} else {
-			shm_id_1 = TEST_RETURN;
 			if (STD_FUNCTIONAL_TEST) {
 				/* do a STAT and check some info */
 				if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-					tst_resm(TBROK, "shmctl failed in "
-						 "functional test");
+					tst_resm(TBROK|TERRNO, "shmctl");
 					continue;
 				}
 				/* check the seqment size */
-				if (buf.shm_segsz != huge_pages_shm_to_be_allocated) {
+				if (buf.shm_segsz != shm_size) {
 					tst_resm(TFAIL, "seqment size is not "
-						 "correct");
+							"correct");
 					continue;
 				}
 				/* check the pid of the creator */
 				if (buf.shm_cpid != getpid()) {
 					tst_resm(TFAIL, "creator pid is not "
-						 "correct");
+							"correct");
 					continue;
 				}
 				/*
@@ -125,9 +117,9 @@ int main(int ac, char **av)
 				 * mask out all but the lower 9 bits
 				 */
 				if ((buf.shm_perm.mode & MODE_MASK) !=
-				    ((SHM_RW) & MODE_MASK)) {
+					    ((SHM_RW) & MODE_MASK)) {
 					tst_resm(TFAIL, "segment mode is not "
-						 "correct");
+							"correct");
 					continue;
 				}
 				/* if we get here, everything looks good */
@@ -140,56 +132,30 @@ int main(int ac, char **av)
 		/*
 		 * clean up things in case we are looping
 		 */
-		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1) {
-			tst_resm(TBROK, "couldn't remove shared memory");
-		} else {
+		if (shmctl(shm_id_1, IPC_RMID, NULL) == -1)
+			tst_resm(TBROK|TERRNO, "shmctl");
+		else
 			shm_id_1 = -1;
-		}
 	}
-
 	cleanup();
-
-      tst_exit();
+	tst_exit();
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
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index 67f62b7..a2f3a51 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -56,138 +56,82 @@
 
 char *TCID = "hugeshmget02";
 int TST_TOTAL = 4;
-unsigned long huge_pages_shm_to_be_allocated;
 
-int exp_enos[] = {ENOENT, EEXIST, EINVAL, 0};	/* 0 terminated list of */
-						/* expected errnos 	*/
-
-int shm_id_1 = -1;
-int shm_id_2 = -1;
-int shmkey2;
+static size_t shm_size;
+static int shm_id_1 = -1;
+static int shm_id_2 = -1;
+static key_t shmkey2;
 
 struct test_case_t {
 	int *skey;
-	int size;
+	int size_coe;
 	int flags;
 	int error;
+} TC[] = {
+	/* EINVAL - size is 0 */
+	{ &shmkey2,  0, SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW,	EINVAL },
+	/* EINVAL - size is larger than created segment */
+	{ &shmkey,   2, SHM_HUGETLB|SHM_RW,			EINVAL },
+	/* EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given */
+	{ &shmkey,   1, SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW,	EEXIST },
+	/* ENOENT - no segment exists for the key and IPC_CREAT is not given */
+	/* use shm_id_2 (-1) as the key */
+	{ &shm_id_2, 1, SHM_HUGETLB|SHM_RW,			ENOENT }
 };
 
-int main(int ac, char **av) {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
-	int i;
-
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
-
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
-
-        struct test_case_t TC[] = {
-         /* EINVAL - size is 0 */
-         {&shmkey2, 0, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
-         /* EINVAL - size is negative */
-         //{&shmkey2, -1, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EINVAL},
-         /* EINVAL - size is larger than created segment */
-         {&shmkey, huge_pages_shm_to_be_allocated * 2, SHM_HUGETLB | SHM_RW, EINVAL},
-         /* EEXIST - the segment exists and IPC_CREAT | IPC_EXCL is given */
-         {&shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW, EEXIST},
-         /* ENOENT - no segment exists for the key and IPC_CREAT is not given */
-         /* use shm_id_2 (-1) as the key */
-         {&shm_id_2, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW, ENOENT}
-        };
-
-	setup();			/* global setup */
-
-	/* The following loop checks looping state if -i option given */
+int main(int ac, char **av)
+{
+	int lc, i;
+	char *msg;
+
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/* loop through the test cases */
-		for (i=0; i<TST_TOTAL; i++) {
-			/*
-			 * Look for a failure ...
-			 */
-
-			TEST(shmget(*(TC[i].skey), TC[i].size, TC[i].flags));
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
+		for (i = 0; i < TST_TOTAL; i++) {
+			TEST(shmget(*(TC[i].skey), TC[i].size_coe*shm_size,
+				    TC[i].flags));
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
-
 	shmkey2 = shmkey + 1;
+	shm_id_1 = shmget(shmkey, shm_size, IPC_CREAT|IPC_EXCL|SHM_RW);
+	if (shm_id_1 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget #1");
 
-	if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, IPC_CREAT | IPC_EXCL | SHM_RW)) == -1) {
-		tst_brkm(TBROK, cleanup, "couldn't create shared memory segment in setup()");
-	}
-
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
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 9b572fa..dfaecc5 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -25,7 +25,8 @@
  *	hugeshmget03 - test for ENOSPC error
  *
  * ALGORITHM
- *	create large shared memory segments in a loop until reaching the system limit
+ *	create large shared memory segments in a loop until reaching
+ *		the system limit
  *	loop if that option was specified
  *	  attempt to create yet another shared memory segment
  *	  check the errno value
@@ -57,139 +58,94 @@
 char *TCID = "hugeshmget03";
 int TST_TOTAL = 1;
 
-int exp_enos[] = {ENOSPC, 0};	/* 0 terminated list of expected errnos */
-void setup2(unsigned long huge_pages_shm_to_be_allocated);
 /*
  * The MAXIDS value is somewhat arbitrary and may need to be increased
  * depending on the system being tested.
  */
 #define MAXIDS	8192
 
-int shm_id_1 = -1;
-int num_shms = 0;
+static int shm_id_1 = -1;
+static int num_shms;
+static int shm_id_arr[MAXIDS];
 
-int shm_id_arr[MAXIDS];
+static void setup2(size_t shm_size);
 
 int main(int ac, char **av)
 {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
-        unsigned long huge_pages_shm_to_be_allocated;
+	int lc;
+	char *msg;
+	size_t shm_size;
 
-	huge_pages_shm_to_be_allocated = 0;
+	shm_size = 0;
 
-	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL)
-		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-	/* The following loop checks looping state if -i option given */
-        if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-             tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-        else
-             huge_pages_shm_to_be_allocated = ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;
+	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
+		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
+	else
+		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
 
-	setup2(huge_pages_shm_to_be_allocated);			/* local  setup */
+	setup2(shm_size);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
-		/*
-		 * use the TEST() macro to make the call
-		 */
-
-		TEST(shmget(IPC_PRIVATE, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT | IPC_EXCL | SHM_RW));
-
+		TEST(shmget(IPC_PRIVATE, shm_size,
+			    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW));
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
+			tst_resm(TFAIL, "unexpected success");
 			continue;
 		}
-
-		TEST_ERROR_LOG(TEST_ERRNO);
-
-		switch(TEST_ERRNO) {
-		case ENOSPC:
-			tst_resm(TPASS, "expected failure - errno = "
-				 "%d : %s", TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		default:
-			tst_resm(TFAIL, "call failed with an "
-				 "unexpected error - %d : %s",
-				 TEST_ERRNO, strerror(TEST_ERRNO));
-			break;
-		}
+		if (TEST_ERRNO == ENOSPC)
+			tst_resm(TPASS|TERRNO, "expected failure");
+		else
+			tst_resm(TFAIL|TTERRNO, "unexpect failure "
+					"- expect errno %d, got", ENOSPC);
 	}
-
 	cleanup();
-
 	tst_exit();
 }
 
-/*
- * setup2() - performs all the ONE TIME setup for this test.
- */
-void setup2(unsigned long huge_pages_shm_to_be_allocated) {
-
+static void setup2(size_t shm_size)
+{
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
 
 	/*
 	 * Use a while loop to create the maximum number of memory segments.
 	 * If the loop exceeds MAXIDS, then break the test and cleanup.
 	 */
-	while ((shm_id_1 = shmget(IPC_PRIVATE, huge_pages_shm_to_be_allocated, SHM_HUGETLB | IPC_CREAT |
-	     IPC_EXCL | SHM_RW)) != -1) {
+	num_shms = 0;
+	shm_id_1 = shmget(IPC_PRIVATE, shm_size,
+			SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
+	while (shm_id_1 != -1) {
 		shm_id_arr[num_shms++] = shm_id_1;
-		if (num_shms == MAXIDS) {
-			tst_brkm(TBROK, cleanup, "The maximum number of shared "
-				 "memory ID's has been\n\t reached.  Please "
-				 "increase the MAXIDS value in the test.");
-		}
+		if (num_shms == MAXIDS)
+			tst_brkm(TBROK, cleanup, "The maximum number of "
+				    "shared memory ID's has been reached. "
+				    "Please increase the MAXIDS value in "
+				    "the test.");
+		shm_id_1 = shmget(IPC_PRIVATE, shm_size,
+			    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
 	}
+	if (errno != ENOSPC)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget #1");
 
-	/*
-	 * If the errno is other than ENOSPC, then something else is wrong.
-	 */
-	if (errno != ENOSPC) {
-		tst_resm(TINFO, "errno = %d : %s", errno, strerror(errno));
-		tst_brkm(TBROK, cleanup, "Didn't get ENOSPC in test setup");
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
 	int i;
 
-	/* remove the shared memory resources that were created */
-	for (i=0; i<num_shms; i++) {
+	TEST_CLEANUP;
+
+	for (i = 0; i < num_shms; i++)
 		rm_shm(shm_id_arr[i]);
-	}
 
 	tst_rmdir();
-
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
-	TEST_CLEANUP;
-
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index ff98e1d..9242a34 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -25,7 +25,8 @@
  *	hugeshmget05 - test for EACCES error
  *
  * ALGORITHM
- *	create a large shared memory segment with root only read & write permissions
+ *	create a large shared memory segment with root only read & write
+ *		permissions
  *	fork a child process
  *	if child
  *	  set the ID of the child process to that of "nobody"
@@ -57,160 +58,99 @@
  *	test must be run at root
  */
 
-#include "ipcshm.h"
 #include <sys/types.h>
 #include <sys/wait.h>
+#include "ipcshm.h"
 #include "system_specific_hugepages_info.h"
 
 char *TCID = "hugeshmget05";
 int TST_TOTAL = 1;
-unsigned long huge_pages_shm_to_be_allocated;
-
-int exp_enos[] = {EACCES, 0};	/* 0 terminated list of expected errnos */
 
-int shm_id_1 = -1;
+static size_t shm_size;
+static int shm_id_1 = -1;
+static uid_t ltp_uid;
+static char *ltp_user = "nobody";
 
-uid_t ltp_uid;
-char *ltp_user = "nobody";
+static void do_child(void);
 
 int main(int ac, char **av)
 {
-	char *msg;			/* message returned from parse_opts */
+	char *msg;
 	pid_t pid;
 	int status;
-	void do_child(void);
 
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
-
-	if ((pid = fork()) == -1) {
-		tst_brkm(TBROK, cleanup, "could not fork");
-	}
+	setup();
 
-	if (pid == 0) {		/* child */
+	switch (pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
 		/* set the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1) {
-			tst_resm(TBROK, "setuid() failed");
-			exit(1);
-		}
-
+		if (setuid(ltp_uid) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "setuid");
 		do_child();
-
 		tst_exit();
-
-	} else {		/* parent */
+	default:
 		/* wait for the child to return */
-		if (waitpid(pid, &status, 0) == -1) {
-			tst_resm(TBROK, "waitpid failed");
-		}
-		else if (status != 0) {
-			tst_resm(TFAIL,	"child process failed to exit cleanly "
-				"(exit status = %d)", status);
-		}
+		if (waitpid(pid, &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
 	}
-
 	cleanup();
-
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
-		 * Look for a failure ...
-		 */
-
-		TEST(shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW));
-
+		TEST(shmget(shmkey, shm_size, SHM_HUGETLB|SHM_RW));
 		if (TEST_RETURN != -1) {
-			tst_resm(TFAIL, "call succeeded when error expected");
+			tst_resm(TFAIL, "unexpected success");
 			continue;
 		}
-
-		TEST_ERROR_LOG(TEST_ERRNO);
-
-		switch(TEST_ERRNO) {
-		case EACCES:
+		if (TEST_ERRNO == EACCES)
 			tst_resm(TPASS|TTERRNO, "expected failure");
-			break;
-		default:
-			tst_resm(TFAIL|TTERRNO, "call failed with an "
-				 "unexpected error");
-			break;
-		}
+		else
+			tst_resm(TFAIL|TTERRNO, "unexpect failure "
+					"- expect errno %d, got", EACCES);
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
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget #1");
 
-	/* create a shared memory segment with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW | IPC_CREAT | IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "segment in setup");
-	}
-
-	/* get the userid for a non root user */
+	/* get the userid for a non-root user */
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
-	/* if it exists, remove the shared memory resource */
-	rm_shm(shm_id_1);
-
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



