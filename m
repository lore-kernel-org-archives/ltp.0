Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Jin.Li@windriver.com>) id 1Rv1Eg-0007M7-58
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 06:42:34 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Rv1Ef-0003Ks-09
	for ltp-list@lists.sourceforge.net; Wed, 08 Feb 2012 06:42:34 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q186gRsi018798
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 7 Feb 2012 22:42:27 -0800 (PST)
From: Jin Li <jin.li@windriver.com>
Date: Wed, 8 Feb 2012 14:42:25 +0800
Message-ID: <1328683345-13871-1-git-send-email-jin.li@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] code style clean up
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

clean up the code style in ipcshm.h and shmat01.c

Signed-off-by: Jin Li <jin.li@windriver.com>
---
 testcases/kernel/syscalls/ipc/lib/ipcshm.h    |    5 ++-
 testcases/kernel/syscalls/ipc/shmat/shmat01.c |   46 ++++++++++++------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/lib/ipcshm.h b/testcases/kernel/syscalls/ipc/lib/ipcshm.h
index bb49dbd..8a70e85 100644
--- a/testcases/kernel/syscalls/ipc/lib/ipcshm.h
+++ b/testcases/kernel/syscalls/ipc/lib/ipcshm.h
@@ -37,7 +37,7 @@ void setup(void);
 
 #define SHM_RD	0400
 #define SHM_WR	0200
-#define SHM_RW	SHM_RD | SHM_WR
+#define SHM_RW	(SHM_RD | SHM_WR)
 
 #define SHM_SIZE	2048	/* a resonable size for a memory segment */
 #define INT_SIZE	4	/* instead of sizeof(int) */
@@ -51,6 +51,7 @@ void rm_shm(int shm_id);
 void check_root();
 
 int getipckey();
-int getuserid(char*);
+int getuserid(char *);
+void check_functionality(int);
 
 #endif /* ipcshm.h */
diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 7c68459..5cc3321 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -33,7 +33,7 @@
  *	otherwise,
  *	  if doing functionality testing
  *		check for the correct conditions after the call
- *	  	if correct,
+ *		if correct,
  *			issue a PASS message
  *		otherwise
  *			issue a FAIL message
@@ -59,7 +59,6 @@
 
 char *TCID = "shmat01";
 
-void check_functionality(int);
 
 #define CASE0		10	/* values to write into the shared */
 #define CASE1		20	/* memory location.                */
@@ -90,9 +89,9 @@ int main(int ac, char **av)
 	int i;
 
 	/* parse standard options */
-	if ((msg = parse_opts(ac, av, NULL, NULL)) != NULL) {
+	msg = parse_opts(ac, av, NULL, NULL);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-	}
 
 	setup();		/* global setup */
 
@@ -118,11 +117,10 @@ int main(int ac, char **av)
 				tst_brkm(TFAIL|TTERRNO, cleanup,
 					"shmat call failed");
 			} else {
-				if (STD_FUNCTIONAL_TEST) {
+				if (STD_FUNCTIONAL_TEST)
 					check_functionality(i);
-				} else {
+				else
 					tst_resm(TPASS, "call succeeded");
-				}
 			}
 
 			/*
@@ -155,9 +153,8 @@ void check_functionality(int i)
 	shared = (int *)addr;
 
 	/* stat the shared memory ID */
-	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
+	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
 		tst_brkm(TBROK, cleanup, "couldn't stat shared memory");
-	}
 
 	/* check the number of attaches */
 	if (buf.shm_nattch != 1) {
@@ -213,9 +210,8 @@ void check_functionality(int i)
 		break;
 	}
 
-	if (!fail) {
+	if (!fail)
 		tst_resm(TPASS, "conditions and functionality are correct");
-	}
 }
 
 /*
@@ -228,7 +224,8 @@ void setup(void)
 
 	TEST_PAUSE;
 
-	if ((TC = malloc(TST_TOTAL*sizeof(struct test_case_t))) == NULL)
+	TC = malloc(TST_TOTAL*sizeof(struct test_case_t));
+	if (TC == NULL)
 		tst_brkm(TFAIL|TERRNO, cleanup, "failed to allocate memory");
 
 	/* a straight forward read/write attach */
@@ -257,30 +254,33 @@ void setup(void)
 	shmkey = getipckey();
 
 	/* create a shared memory resource with read and write permissions */
-	if ((shm_id_1 = shmget(shmkey++, INT_SIZE, SHM_RW | IPC_CREAT |
-			       IPC_EXCL)) == -1) {
+	shm_id_1 = shmget(shmkey++, INT_SIZE, SHM_RW | IPC_CREAT | IPC_EXCL);
+	if (shm_id_1  == -1) {
 		tst_brkm(TBROK, cleanup, "Failed to create shared memory "
 			 "resource 1 in setup()");
 	}
 
 	/* Probe an available linear address for attachment */
-	if ((base_addr = shmat(shm_id_1, NULL, 0)) == (void *)-1) {
+	base_addr = shmat(shm_id_1, NULL, 0);
+	if (base_addr == (void *)-1)
 		tst_brkm(TBROK, cleanup, "Couldn't attach shared memory");
-	}
-	if (shmdt((const void *)base_addr) == -1) {
+
+	if (shmdt((const void *)base_addr) == -1)
 		tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
-	}
 
-	/* some architectures (e.g. parisc) are strange, so better always align to
-	 * next SHMLBA address. */
+	/* some architectures (e.g. parisc) are strange, so better always align
+	 * to next SHMLBA address.
+	 */
 	base_addr =
 	    (void *)(((unsigned long)(base_addr) + (SHMLBA - 1)) &
 		     ~(SHMLBA - 1));
 }
 
 /*
- * cleanup() - performs all the ONE TIME cleanup for this test at completion
- * 	       or premature exit.
+ * cleanup()
+ *
+ * performs all the ONE TIME cleanup for this test at completion
+ * or premature exit.
  */
 void cleanup(void)
 {
@@ -299,4 +299,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
-}
\ No newline at end of file
+}
-- 
1.6.3.1


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
