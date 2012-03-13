Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7JoU-0000Of-SH
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:22 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7JoU-0005Lk-4X
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:22 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271995dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:21 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:40 +0800
Message-Id: <1331614605-30347-7-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 06/11] hugetlb/hugeshmdt: set nr_hugepages in tests
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


This patch enables nr_hugepages set/restore in each test of hugeshmdt,
so that we don't need to set the values with external commands.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c     |   28 +++++++++++++++-----
 1 files changed, 21 insertions(+), 7 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0006-hugetlb-hugeshmdt-set-nr_hugepages-in-tests.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0006-hugetlb-hugeshmdt-set-nr_hugepages-in-tests.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
index 402aaa1..c107a76 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.c
@@ -59,7 +59,8 @@
 
 #include <setjmp.h>
 #include "ipcshm.h"
-#include "system_specific_hugepages_info.h"
+#include "safe_macros.h"
+#include "mem.h"
 
 char *TCID = "hugeshmdt01";
 int TST_TOTAL = 1;
@@ -71,6 +72,12 @@ static int *shared;
 static int pass;
 static sigjmp_buf env;
 
+static long hugepages = 128;
+static option_t options[] = {
+	{ "s:",	&sflag,	&nr_opt	},
+	{ NULL,	NULL,	NULL	}
+};
+
 static void check_functionality(void);
 static void sighandler(int sig);
 
@@ -79,14 +86,11 @@ int main(int ac, char **av)
 	int lc;
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
 
@@ -164,9 +168,17 @@ static void sighandler(int sig)
 
 void setup(void)
 {
+	long hpage_size;
+
+	tst_require_root(NULL);
 	tst_sig(NOFORK, sighandler, cleanup);
 	tst_tmpdir();
 
+	orig_hugepages = get_sys_tune("nr_hugepages");
+	set_sys_tune("nr_hugepages", hugepages, 1);
+	hpage_size = read_meminfo("Hugepagesize:") * 1024;
+
+	shm_size = hpage_size * hugepages / 2;
 	shmkey = getipckey();
 
 	/* create a shared memory resource with read and write permissions */
@@ -192,5 +204,7 @@ void cleanup(void)
 
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



