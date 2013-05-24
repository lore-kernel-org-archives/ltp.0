Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UfkVo-0002Lx-Ho
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 05:25:56 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UfkVm-0002RU-MR
	for ltp-list@lists.sourceforge.net; Fri, 24 May 2013 05:25:56 +0000
Message-ID: <519EF94A.5070506@cn.fujitsu.com>
Date: Fri, 24 May 2013 13:23:22 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <519DD4ED.3090907@cn.fujitsu.com>
In-Reply-To: <519DD4ED.3090907@cn.fujitsu.com>
Subject: [LTP]  [PATCH V2 2/2] shmctl/shmctl01.c: Test features IPC_INFO,
 SHM_STAT, SHM_LOCK and SHM_UNLOCK.
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



Additional tests for features IPC_INFO, SHM_STAT, SHM_LOCK and SHM_UNLOCK.


Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c | 87 ++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 34ff30c..55711a7 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -43,13 +43,18 @@
  *	call cleanup
  */

+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include "ipcshm.h"
 #include "libtestsuite.h"

 char *TCID = "shmctl01";

 static int shm_id_1 = -1;
+static int shm_index;
 static struct shmid_ds buf;
+static struct shminfo info;
 static long save_time;

 #define FIRST	0
@@ -64,12 +69,24 @@ static pid_t pid_arr[N_ATTACH];
 static int sync_pipes[2];

 /* Setup, cleanup and check routines for IPC_STAT */
-static void stat_setup(void), func_stat(void);
+static void stat_setup(void), func_istat(void);
 static void stat_cleanup(void);

 /* Setup and check routines for IPC_SET */
 static void set_setup(void), func_set(void);

+/* Check routine for IPC_INFO */
+static void func_info(void);
+
+/* Check routine for SHM_STAT */
+static void func_sstat(int shmid);
+
+/* Check routine for SHM_LOCK */
+static void func_lock(void);
+
+/* Check routine for SHM_UNLOCK */
+static void func_unlock(void);
+
 /* Check routine for IPC_RMID */
 static void func_rmid(void);

@@ -77,21 +94,27 @@ static void func_rmid(void);
 static void do_child(void);

 static struct test_case_t {
+	int *shmid;
 	int cmd;
+	struct shmid_ds *arg;
 	void (*func_test) ();
 	void (*func_setup) ();
 } TC[] = {
-	{IPC_STAT, func_stat, stat_setup},
+	{&shm_id_1, IPC_STAT, &buf, func_istat, stat_setup},
 #ifndef UCLINUX
 	    /*
 	     * The second test is not applicable to uClinux;
 	     * shared memory segments are detached on exec(),
 	     * so cannot be passed to uClinux children.
 	     */
-	{IPC_STAT, func_stat, stat_setup},
+	{&shm_id_1, IPC_STAT, &buf, func_istat, stat_setup},
 #endif
-	{IPC_SET, func_set, set_setup},
-	{IPC_RMID, func_rmid, NULL},
+	{&shm_id_1, IPC_SET, &buf, func_set, set_setup},
+	{&shm_id_1, IPC_INFO, (struct shmid_ds *) &info, func_info, NULL},
+	{&shm_index, SHM_STAT, &buf, func_sstat, NULL},
+	{&shm_id_1, SHM_LOCK, NULL, func_lock, NULL},
+	{&shm_id_1, SHM_UNLOCK, NULL, func_unlock, NULL},
+	{&shm_id_1, IPC_RMID, NULL, func_rmid, NULL},
 };

 static int TST_TOTAL = ARRAY_SIZE(TC);
@@ -146,7 +169,7 @@ int main(int argc, char *argv[])
 			if (TC[i].func_setup != NULL)
 				(*TC[i].func_setup) ();

-			TEST(shmctl(shm_id_1, TC[i].cmd, &buf));
+			TEST(shmctl(*(TC[i].shmid), TC[i].cmd, TC[i].arg));

 			if (TEST_RETURN == -1) {
 				tst_resm(TFAIL, "%s call failed - errno "
@@ -155,7 +178,10 @@ int main(int argc, char *argv[])
 				continue;
 			}
 			if (STD_FUNCTIONAL_TEST) {
-				(*TC[i].func_test) ();
+				if (TC[i].cmd == SHM_STAT)
+					(*TC[i].func_test) (TEST_RETURN);
+				else
+					(*TC[i].func_test) ();
 			} else {
 				tst_resm(TPASS, "call succeeded");

@@ -294,11 +320,11 @@ void do_child(void)
 }

 /*
- * func_stat() - check the functionality of the IPC_STAT command with shmctl()
+ * func_istat() - check the functionality of the IPC_STAT command with shmctl()
  *		 by looking at the pid of the creator, the segement size,
  *		 the number of attaches and the mode.
  */
-void func_stat(void)
+void func_istat(void)
 {
 	int fail = 0;
 	pid_t pid;
@@ -419,6 +445,49 @@ void func_set(void)
 	tst_resm(TPASS, "new mode and change time are correct");
 }

+static void func_info(void)
+{
+	if (info.shmmin != 1)
+		tst_resm(TFAIL, "value of shmmin is incorrect");
+	else
+		tst_resm(TPASS, "get correct shared memory limits");
+}
+
+static void func_sstat(int shmid)
+{
+	if (shmid >= 0)
+		tst_resm(TPASS, "get correct shared memery id");
+	else
+		tst_resm(TFAIL, "shared memery id is incorrect");
+}
+
+static void func_lock(void)
+{
+	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
+		tst_resm(TBROK, "stat failed in func_lock()");
+		return;
+	}
+
+	if (buf.shm_perm.mode & SHM_LOCKED)
+		tst_resm(TPASS, "SHM_LOCK is set");
+	else
+		tst_resm(TFAIL, "SHM_LOCK is cleared");
+}
+
+static void func_unlock(void)
+{
+	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1) {
+		tst_resm(TBROK, "stat failed in func_unlock()");
+		return;
+	}
+
+	if (buf.shm_perm.mode & SHM_LOCKED)
+		tst_resm(TFAIL, "SHM_LOCK is set");
+	else
+		tst_resm(TPASS, "SHM_LOCK is cleared");
+}
+
+
 /*
  * func_rmid() - check the functionality of the IPC_RMID command with shmctl()
  */
-- 
1.8.1




------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
