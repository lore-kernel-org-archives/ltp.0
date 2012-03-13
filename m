Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoS-00020r-AS
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:20 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoR-0008Uq-FV
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:20 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271895dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:19 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:38 +0800
Message-Id: <1331614605-30347-5-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 04/11] hugetlb/hugeshmctl: set nr_hugepages in tests
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


This patch enables nr_hugepages set/restore in each test of hugeshmctl,
so that we don't need to set the values with external commands.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c   |   28 +++++++++++++++-----
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c   |   28 +++++++++++++++-----
 .../kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c   |   27 ++++++++++++++-----
 3 files changed, 62 insertions(+), 21 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0004-hugetlb-hugeshmctl-set-nr_hugepages-in-tests.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0004-hugetlb-hugeshmctl-set-nr_hugepages-in-tests.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
index ce8d89a..4577c30 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c
@@ -62,7 +62,8 @@
  */
 
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmctl01";
 int TST_TOTAL = 4;
@@ -89,6 +90,12 @@ static void func_set(void);
 static void func_rmid(void);
 static void *set_shmat(void);
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 struct test_case_t {
 	int  cmd;
 	void (*func_test)(void);
@@ -105,14 +112,11 @@ int main(int ac, char **av)
 	int lc, i;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	setup();
 
@@ -397,9 +401,17 @@ static void sighandler(int sig)
 
 void setup(void)
 {
+	long hpage_size;
+
+	tst_require_root(NULL);
 	tst_sig(FORK, sighandler, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 
 	TEST_PAUSE;
@@ -411,5 +423,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_1);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
index 15cadb0..568f790 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c
@@ -54,7 +54,8 @@
 
 #include <pwd.h>
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmctl02";
 int TST_TOTAL = 4;
@@ -65,6 +66,12 @@ static int shm_id_2 = -1;
 static int shm_id_3 = -1;
 static struct shmid_ds buf;
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 struct test_case_t {
 	int *shmid;
 	int cmd;
@@ -89,14 +96,11 @@ int main(int ac, char **av)
 	int lc, i;
 	char *msg;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	setup();
 
@@ -119,9 +123,17 @@ int main(int ac, char **av)
 
 void setup(void)
 {
+	long hpage_size;
+
+	tst_require_root(NULL);
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 
 	/* create a shared memory segment without read or write permissions */
@@ -145,5 +157,7 @@ void cleanup(void)
 	rm_shm(shm_id_1);
 	rm_shm(shm_id_2);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 30353b8..e0e8606 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -61,7 +61,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmctl03";
 int TST_TOTAL = 3;
@@ -72,6 +73,12 @@ static struct shmid_ds buf;
 static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 struct test_case_t {
 	int *shmid;
 	int cmd;
@@ -96,14 +103,11 @@ int main(int ac, char **av)
 	pid_t pid;
 	int status;
 
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
-
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, cleanup, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
 	setup();
 
@@ -145,10 +149,17 @@ static void do_child(void)
 
 void setup(void)
 {
+	long hpage_size;
+
 	tst_require_root(NULL);
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 	shm_id_1 = shmget(shmkey, shm_size,
 		    SHM_HUGETLB|IPC_CREAT|IPC_EXCL|SHM_RW);
@@ -167,5 +178,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_1);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
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



