Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1S7Jog-00054v-Aq
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:34 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1S7Jof-0008Uq-Kd
	for ltp-list@lists.sourceforge.net; Tue, 13 Mar 2012 04:58:34 +0000
Received: by mail-pz0-f47.google.com with SMTP id o14so271895dad.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 12 Mar 2012 21:58:33 -0700 (PDT)
From: Caspar Zhang <caspar@casparzhang.com>
Date: Tue, 13 Mar 2012 12:56:44 +0800
Message-Id: <1331614605-30347-11-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
References: <1331614605-30347-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.8.4"
Subject: [LTP] [PATCH 10/11] hugetlb/hugeshmget03: fix broken testcase
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


hugeshmget03 often returns ENOMEM, so that causes test fails. This patch
fixes the problem by making the following changes:

1) reduce shm_size to minimum (1 hugepage);
2) reduce shmmni to 1/2 * nr_hugepages.

so that when all shmids taken, memory allocated ~=

    1/2 * nr_hugepages * hugepagesize < free memory

Which means there will be no ENOMEM occurs, but ENOSPC as expected.

Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
---
 .../kernel/mem/hugetlb/hugeshmget/hugeshmget03.c   |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)


--------------1.7.8.4
Content-Type: text/x-patch;
	name="0010-hugetlb-hugeshmget03-fix-broken-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0010-hugetlb-hugeshmget03-fix-broken-testcase.patch"

diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 57e80e3..a714032 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -64,6 +64,7 @@ int TST_TOTAL = 1;
  * depending on the system being tested.
  */
 #define MAXIDS	8192
+#define PATH_SHMMNI	"/proc/sys/kernel/shmmni"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -71,6 +72,7 @@ static int num_shms;
 static int shm_id_arr[MAXIDS];
 
 static long hugepages = 128;
+static long orig_shmmni;
 static option_t options[] = {
 	{ "s:",	&sflag,	&nr_opt	},
 	{ NULL,	NULL,	NULL	}
@@ -111,6 +113,7 @@ int main(int ac, char **av)
 void setup(void)
 {
 	long hpage_size;
+	char buf[BUFSIZ];
 
 	tst_require_root(NULL);
 	tst_sig(NOFORK, DEF_HANDLER, cleanup);
@@ -120,8 +123,12 @@ void setup(void)
 	set_sys_tune("nr_hugepages", hugepages, 1);
 	hpage_size = read_meminfo("Hugepagesize:") * 1024;
 
-	shm_size = hpage_size * hugepages / 2;
-	shmkey = getipckey();
+	shm_size = hpage_size;
+
+	read_file(PATH_SHMMNI, buf);
+	orig_shmmni = SAFE_STRTOL(cleanup, buf, 0, LONG_MAX);
+	snprintf(buf, BUFSIZ, "%ld", hugepages / 2);
+	write_file(PATH_SHMMNI, buf);
 
 	/*
 	 * Use a while loop to create the maximum number of memory segments.
@@ -149,12 +156,15 @@ void setup(void)
 void cleanup(void)
 {
 	int i;
+	char buf[BUFSIZ];
 
 	TEST_CLEANUP;
 
 	for (i = 0; i < num_shms; i++)
 		rm_shm(shm_id_arr[i]);
 
+	snprintf(buf, BUFSIZ, "%ld", orig_shmmni);
+	write_file(PATH_SHMMNI, buf);
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
 
 	tst_rmdir();

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



