Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoS-0000O8-BA
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:20 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoR-0008Uv-A8
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:20 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271940dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:19 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:39 +0800
Message-Id: <1331614605-30347-6-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 05/11] hugetlb/hugeshmdt: cleanup codes
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
 testcases/kernel/mem/hugetlb/hugeshmdt/Makefile    |    2 +-
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |  153 +++++++-------------
 2 files changed, 52 insertions(+), 103 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch; name="0005-hugetlb-hugeshmdt-cleanup-codes.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0005-hugetlb-hugeshmdt-cleanup-codes.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
index cea6939..812b7f2 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/Makefile
@@ -20,7 +20,7 @@
 # Garrett Cooper, July 2009
 #
 
-top_srcdir              ?= ../../../../..
+top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 include $(abs_srcdir)/../Makefile.inc
diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index f8764b3..402aaa1 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -35,7 +35,7 @@
  *		attempt to write a value to the large shared memory address
  *		this should generate a SIGSEGV which will be caught in
  *		    the signal handler
- *	  	if correct,
+ *		if correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
@@ -63,84 +63,62 @@
 
 char *TCID = "hugeshmdt01";
 int TST_TOTAL = 1;
-unsigned long huge_pages_shm_to_be_allocated;
 
-void sighandler(int);
+static size_t shm_size;
+static int shm_id_1 = -1;
 struct shmid_ds buf;
+static int *shared;
+static int pass;
+static sigjmp_buf env;
 
-int shm_id_1 = -1;
-int *shared;		/* variable to use for shared memory attach */
-int new;
-int pass = 0;
-sigjmp_buf env;
+static void check_functionality(void);
+static void sighandler(int sig);
 
 int main(int ac, char **av)
 {
-	int lc;				/* loop counter */
-	char *msg;			/* message returned from parse_opts */
-	void check_functionality(void);
+	int lc;
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
 
-		/*
-		 * Use TEST macro to make the shmdt() call
-		 */
-
-		TEST(shmdt((const void *)shared));
-
-		if (TEST_RETURN == -1) {
-			tst_resm(TFAIL, "%s call failed - errno = %d : %s",
-				 TCID, TEST_ERRNO, strerror(TEST_ERRNO));
+		if (shmdt(shared) == -1) {
+			tst_resm(TFAIL|TERRNO, "shmdt");
 		} else {
-			if (STD_FUNCTIONAL_TEST) {
+			if (STD_FUNCTIONAL_TEST)
 				check_functionality();
-			} else {
+			else
 				tst_resm(TPASS, "call succeeded");
-			}
 		}
 
 		/* reattach the shared memory segment in case we are looping */
-		shared = (int*)shmat(shm_id_1, 0, 0);
-
-		if (*shared == -1) {
-			tst_brkm(TBROK, cleanup, "memory reattach failed");
-		}
+		shared = shmat(shm_id_1, 0, 0);
+		if (shared == (void *)-1)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmat #2: reattach");
 
 		/* also reset pass */
 		pass = 0;
 	}
-
 	cleanup();
-
 	tst_exit();
 }
 
-/*
- * check_functionality() - make sure the memory is detached correctly
- */
-void
-check_functionality()
+static void check_functionality(void)
 {
 	/* stat the shared memory segment */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
-		tst_resm(TINFO, "error = %d : %s\n", errno, strerror(errno));
-		tst_brkm(TBROK, cleanup, "could not stat in signal handler");
-	}
+	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmctl");
 
 	if (buf.shm_nattch != 0) {
 		tst_resm(TFAIL, "# of attaches is incorrect");
@@ -161,87 +139,58 @@ check_functionality()
 	 * of the signal handler and another SIGSEGV will be generated.
 	 */
 
-	if (sigsetjmp(env, 1) == 0) {
+	if (sigsetjmp(env, 1) == 0)
 		*shared = 2;
-	}
 
-	if (pass) {
+	if (pass)
 		tst_resm(TPASS, "huge shared memory detached correctly");
-	} else {
-		tst_resm(TFAIL, "huge shared memory was not detached correctly");
-	}
+	else
+		tst_resm(TFAIL, "huge shared memory was not detached "
+				"correctly");
 }
 
-/*
- * sighandler()
- */
-void
-sighandler(sig)
+static void sighandler(int sig)
 {
 	/* if we have received a SIGSEGV, we are almost done */
 	if (sig == SIGSEGV) {
 		/* set the global variable and jump back */
 		pass = 1;
 		siglongjmp(env, 1);
-	} else
-		tst_brkm(TBROK, cleanup, "received an unexpected signal");
+	} else {
+		tst_brkm(TBROK, cleanup, "unexpected signal received: %d",
+			    sig);
+	}
 }
 
-/*
- * setup() - performs all the ONE TIME setup for this test.
- */
-void
-setup(void)
+void setup(void)
 {
-
 	tst_sig(NOFORK, sighandler, cleanup);
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
-	if ((shm_id_1 = shmget(shmkey, huge_pages_shm_to_be_allocated, SHM_HUGETLB | SHM_RW | IPC_CREAT |
-	     IPC_EXCL)) == -1) {
-		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
-			 "resource in setup()");
-	}
+	shm_id_1 = shmget(shmkey, shm_size,
+		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
+	if (shm_id_1 == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmget");
 
 	/* attach the shared memory segment */
-	shared = (int*)shmat(shm_id_1, 0, 0);
-
-	if (*shared == -1) {
-		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
-	}
+	shared = shmat(shm_id_1, 0, 0);
+	if (shared == (void *)-1)
+		tst_brkm(TBROK|TERRNO, cleanup, "shmat #1");
 
 	/* give a value to the shared memory integer */
 	*shared = 4;
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
-	/* if it exists, delete the shared memory resource */
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



