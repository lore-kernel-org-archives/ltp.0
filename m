Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7Joa-00053w-NQ
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:28 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoZ-0008Uv-UB
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:28 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271940dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:27 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:42 +0800
Message-Id: <1331614605-30347-9-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 08/11] hugetlb/hugeshmget: set nr_hugepages in tests
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


This patch enables nr_hugepages set/restore in each test of hugeshmget,
so that we don't need to set the values with external commands.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget01.c   |   32 ++++++++++++-----
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget02.c   |   28 +++++++++++----
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |   36 ++++++++++++-------
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget05.c   |   27 +++++++++++----
 4 files changed, 86 insertions(+), 37 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0008-hugetlb-hugeshmget-set-nr_hugepages-in-tests.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0008-hugetlb-hugeshmget-set-nr_hugepages-in-tests.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
index 9bdf029..36492ef 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c
@@ -59,30 +59,32 @@
  */
 
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmget01";
 int TST_TOTAL = 1;
 
+static size_t shm_size;
 static int shm_id_1 = -1;
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
 	struct shmid_ds buf;
-	size_t shm_size;
-
-	shm_size = 0;
 
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
 
@@ -143,9 +145,17 @@ int main(int ac, char **av)
 
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
 
 	TEST_PAUSE;
@@ -157,5 +167,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_1);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
index a2f3a51..503cef2 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c
@@ -52,7 +52,8 @@
  */
 
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmget02";
 int TST_TOTAL = 4;
@@ -62,6 +63,12 @@ static int shm_id_1 = -1;
 static int shm_id_2 = -1;
 static key_t shmkey2;
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 struct test_case_t {
 	int *skey;
 	int size_coe;
@@ -84,14 +91,11 @@ int main(int ac, char **av)
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
 
@@ -115,9 +119,17 @@ int main(int ac, char **av)
 
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
 	shmkey2 = shmkey + 1;
 	shm_id_1 = shmget(shmkey, shm_size, IPC_CREAT|IPC_EXCL|SHM_RW);
@@ -133,5 +145,7 @@ void cleanup(void)
 
 	rm_shm(shm_id_1);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index dfaecc5..57e80e3 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -53,7 +53,8 @@
  */
 
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmget03";
 int TST_TOTAL = 1;
@@ -64,30 +65,29 @@ int TST_TOTAL = 1;
  */
 #define MAXIDS	8192
 
+static size_t shm_size;
 static int shm_id_1 = -1;
 static int num_shms;
 static int shm_id_arr[MAXIDS];
 
-static void setup2(size_t shm_size);
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
 
 int main(int ac, char **av)
 {
 	int lc;
 	char *msg;
-	size_t shm_size;
 
-	shm_size = 0;
-
-	msg = parse_opts(ac, av, NULL, NULL);
+	msg = parse_opts(ac, av, options, &help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+	if (sflag)
+		hugepages = SAFE_STRTOL(NULL, nr_opt, 0, LONG_MAX);
 
-	if (get_no_of_hugepages() <= 0 || hugepages_size() <= 0)
-		tst_brkm(TCONF, NULL, "Not enough available Hugepages");
-	else
-		shm_size = (get_no_of_hugepages()*hugepages_size()*1024) / 2;
-
-	setup2(shm_size);
+	setup();
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
@@ -108,11 +108,19 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-static void setup2(size_t shm_size)
+void setup(void)
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
 
 	/*
@@ -147,5 +155,7 @@ void cleanup(void)
 	for (i = 0; i < num_shms; i++)
 		rm_shm(shm_id_arr[i]);
 
+	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index 9242a34..7d8afd2 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -61,7 +61,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmget05";
 int TST_TOTAL = 1;
@@ -71,6 +72,12 @@ static int shm_id_1 = -1;
 static uid_t ltp_uid;
 static char *ltp_user = "nobody";
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 static void do_child(void);
 
 int main(int ac, char **av)
@@ -79,14 +86,11 @@ int main(int ac, char **av)
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
 
@@ -130,10 +134,17 @@ static void do_child(void)
 
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
 		    SHM_HUGETLB|SHM_RW|IPC_CREAT|IPC_EXCL);
@@ -152,5 +163,7 @@ void cleanup(void)
 
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



