Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QKDP6-00078w-H4
	for ltp-list@lists.sourceforge.net; Wed, 11 May 2011 17:40:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QKDP5-0003S2-LF
	for ltp-list@lists.sourceforge.net; Wed, 11 May 2011 17:40:56 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4BHemse003913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 11 May 2011 13:40:49 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Thu, 12 May 2011 00:52:37 +0800
Message-Id: <89266008fcb8e9ec4ea36dab80a2430b893dacbd.1305117174.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [mm] ksm: fix pagesize
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
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


ksm test fails on ppc64 systems because of the pagesize on ppc64 is
larger than 4KB, so page_sharing will be a different value. This patch
replace the hard-coded number 256 to a variable: 1MB/pagesize.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)


--------------1.7.1
Content-Type: text/x-patch; name="0001-mm-ksm-fix-pagesize.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-mm-ksm-fix-pagesize.patch"

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 12e61e9..e2a05db 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -358,6 +358,10 @@ void create_same_memory(int size, int num, int unit)
 	int i, j, k;
 	int status, fd;
 	int *child;
+	long ps, pages;
+
+	ps = sysconf(_SC_PAGE_SIZE);
+	pages = 1024 * 1024 / ps;
 
 	child = malloc(num);
 	if (child == NULL)
@@ -558,7 +562,7 @@ void create_same_memory(int size, int num, int unit)
 		tst_brkm(TBROK|TERRNO, cleanup, "write");
 	close(fd);
 	snprintf(buf, BUFSIZ, "%s%s", PATH_KSM, "pages_to_scan");
-	snprintf(buf2, BUFSIZ, "%d", size * 256 * num);
+	snprintf(buf2, BUFSIZ, "%ld", size * pages * num);
 	fd = open(buf, O_WRONLY);
 	if (fd == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "open");
@@ -587,7 +591,7 @@ void create_same_memory(int size, int num, int unit)
 		if (kill(child[k], SIGCONT) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
 	}
-	group_check(1, 2, size * num * 256 - 2, 0, 0, 0, size * 256 * num);
+	group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
 
 	tst_resm(TINFO, "wait for child 1 to stop.");
 	if (waitpid(child[1], &status, WUNTRACED) == -1)
@@ -599,7 +603,7 @@ void create_same_memory(int size, int num, int unit)
 	tst_resm(TINFO, "resume child 1.");
 	if (kill(child[1], SIGCONT) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "kill");
-	group_check(1, 3, size * num * 256 - 3, 0, 0, 0, size * 256 * num);
+	group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
 
 	tst_resm(TINFO, "wait for child 1 to stop.");
 	if (waitpid(child[1], &status, WUNTRACED) == -1)
@@ -613,7 +617,7 @@ void create_same_memory(int size, int num, int unit)
 		if (kill(child[k], SIGCONT) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "kill child[%d]", k);
 	}
-	group_check(1, 1, size * num * 256 - 1, 0, 0, 0, size * 256 * num);
+	group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
 
 	tst_resm(TINFO, "wait for all children to stop.");
 	for (k = 0; k < num; k++) {
@@ -627,7 +631,7 @@ void create_same_memory(int size, int num, int unit)
 	tst_resm(TINFO, "resume child 1.");
 	if (kill(child[1], SIGCONT) == -1)
 		tst_brkm(TBROK|TERRNO, cleanup, "kill");
-	group_check(1, 1, size * num * 256 - 2, 0, 1, 0, size * 256 * num);
+	group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
 
 	tst_resm(TINFO, "wait for child 1 to stop.");
 	if (waitpid(child[1], &status, WUNTRACED) == -1)
@@ -647,7 +651,7 @@ void create_same_memory(int size, int num, int unit)
 		tst_brkm(TBROK|TERRNO, cleanup, "open");
 	if (write(fd, "2", 1) != 1)
 		tst_brkm(TBROK|TERRNO, cleanup, "write");
-	group_check(2, 0, 0, 0, 0, 0, size * 256 * num);
+	group_check(2, 0, 0, 0, 0, 0, size * pages * num);
 
 	tst_resm(TINFO, "wait for all children to stop.");
 	for (k = 0; k < num; k++) {
@@ -668,7 +672,7 @@ void create_same_memory(int size, int num, int unit)
 	if (write(fd, "0", 1) != 1)
 		tst_brkm(TBROK|TERRNO, cleanup, "write");
 	close(fd);
-	group_check(0, 0, 0, 0, 0, 0, size * 256 * num);
+	group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0)
 		if (WEXITSTATUS(status) != 0)
 			tst_resm(TFAIL, "child exit status is %d",

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



