Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WIJjT-0006bI-Ve
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 15:15:44 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIJjS-0003jW-Fo
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 15:15:43 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s1PFFaId003161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Feb 2014 10:15:36 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id s1PFFZI2026260
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Feb 2014 10:15:35 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Feb 2014 16:15:31 +0100
Message-Id: <8fcc00aaf04977590c7ffe20ce94d91b795869d8.1393341171.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] move_pages: print errno if move_pages fail
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Also remove lines which set TEST_ERRNO, since TTERRNO is never used.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages01.c      |    4 +---
 .../kernel/syscalls/move_pages/move_pages02.c      |    3 +--
 .../kernel/syscalls/move_pages/move_pages03.c      |    3 +--
 .../kernel/syscalls/move_pages/move_pages04.c      |    1 -
 .../kernel/syscalls/move_pages/move_pages05.c      |    1 -
 .../kernel/syscalls/move_pages/move_pages06.c      |    3 +--
 .../kernel/syscalls/move_pages/move_pages07.c      |    3 +--
 .../kernel/syscalls/move_pages/move_pages08.c      |    3 +--
 .../kernel/syscalls/move_pages/move_pages09.c      |    1 -
 .../kernel/syscalls/move_pages/move_pages10.c      |    3 +--
 .../kernel/syscalls/move_pages/move_pages11.c      |    3 +--
 11 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index df4ec70..211a174 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -95,10 +95,8 @@ int main(int argc, char **argv)
 			continue;
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, NULL, status, 0);
-		TEST_ERRNO = errno;
-
 		if (ret != 0) {
-			tst_resm(TFAIL, "retrieving NUMA nodes failed");
+			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			free_pages(pages, TEST_PAGES);
 			continue;
 		}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index ddd0e38..9ce4bd7 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -109,9 +109,8 @@ int main(int argc, char **argv)
 		ret =
 		    numa_move_pages(0, TEST_PAGES, pages, nodes, status,
 				    MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret != 0) {
-			tst_resm(TFAIL, "retrieving NUMA nodes failed");
+			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			free_pages(pages, TEST_PAGES);
 			continue;
 		}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index 5c26748..f2b2088 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -171,9 +171,8 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE_ALL);
-		TEST_ERRNO = errno;
 		if (ret != 0) {
-			tst_resm(TFAIL, "retrieving NUMA nodes failed");
+			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			goto err_kill_child;
 		}
 
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 4ceca0d..03f9feb 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -123,7 +123,6 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1) {
 			tst_resm(TFAIL | TERRNO,
 				 "move_pages unexpectedly failed");
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 11c0bc1..7be9219 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -178,7 +178,6 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, N_TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1) {
 			tst_resm(TFAIL | TERRNO,
 				 "move_pages unexpectedly failed");
diff --git a/testcases/kernel/syscalls/move_pages/move_pages06.c b/testcases/kernel/syscalls/move_pages/move_pages06.c
index 54c4387..fd86317 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -109,12 +109,11 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == ENODEV)
 			tst_resm(TPASS, "move_pages failed with "
 				 "ENODEV as expected");
 		else
-			tst_resm(TFAIL, "move pages did not fail "
+			tst_resm(TFAIL|TERRNO, "move pages did not fail "
 				 "with ENODEV");
 
 		free_pages(pages, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index cb0772e..822121e 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -119,12 +119,11 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(ipid, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == ESRCH)
 			tst_resm(TPASS, "move_pages failed with "
 				 "ESRCH as expected");
 		else
-			tst_resm(TFAIL, "move pages did not fail "
+			tst_resm(TFAIL|TERRNO, "move pages did not fail "
 				 "with ESRCH");
 
 err_free_pages:
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 159a6ea..6974b6c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -106,12 +106,11 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, ULONG_MAX, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == E2BIG)
 			tst_resm(TPASS, "move_pages failed with "
 				 "E2BIG as expected");
 		else
-			tst_resm(TFAIL, "move pages did not fail "
+			tst_resm(TFAIL|TERRNO, "move pages did not fail "
 				 "with E2BIG");
 
 		free_pages(pages, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 53d2189..ff55621 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -105,7 +105,6 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 
 		/*
 		 * commit e78bbfa8262424417a29349a8064a535053912b9
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index 7880ae9..e825b87 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -108,12 +108,11 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_STRICT);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == EINVAL)
 			tst_resm(TPASS, "move_pages failed with "
 				 "EINVAL as expected");
 		else
-			tst_resm(TFAIL, "move_pages did not fail "
+			tst_resm(TFAIL|TERRNO, "move_pages did not fail "
 				 "with EINVAL");
 
 		free_pages(pages, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 094d548..eb01572 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -173,12 +173,11 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE_ALL);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == EPERM)
 			tst_resm(TPASS, "move_pages failed with "
 				 "EPERM as expected");
 		else
-			tst_resm(TFAIL, "move_pages did not fail "
+			tst_resm(TFAIL|TERRNO, "move_pages did not fail "
 				 "with EPERM");
 
 		/* Test done. Ask child to terminate. */
-- 
1.7.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
