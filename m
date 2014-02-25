Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1WIL2s-0001C4-HI
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 16:39:50 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WIL2r-0007Ar-43
	for ltp-list@lists.sourceforge.net; Tue, 25 Feb 2014 16:39:50 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s1PGdgP9029485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Feb 2014 11:39:42 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s1PGdfbW019982
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Feb 2014 11:39:41 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Feb 2014 17:39:38 +0100
Message-Id: <4c7b16f6fd58cb2bc21fb73df14694ec8c51fa40.1393346308.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] move_pages: print errno if move_pages fail
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
 .../kernel/syscalls/move_pages/move_pages06.c      |    5 ++---
 .../kernel/syscalls/move_pages/move_pages07.c      |    5 ++---
 .../kernel/syscalls/move_pages/move_pages08.c      |    5 ++---
 .../kernel/syscalls/move_pages/move_pages09.c      |    4 ++--
 .../kernel/syscalls/move_pages/move_pages10.c      |    5 ++---
 .../kernel/syscalls/move_pages/move_pages11.c      |    5 ++---
 11 files changed, 15 insertions(+), 26 deletions(-)

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
index 54c4387..9d9e13f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages06.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages06.c
@@ -109,13 +109,12 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == ENODEV)
 			tst_resm(TPASS, "move_pages failed with "
 				 "ENODEV as expected");
 		else
-			tst_resm(TFAIL, "move pages did not fail "
-				 "with ENODEV");
+			tst_resm(TFAIL|TERRNO, "move pages did not fail "
+				 "with ENODEV ret: %d", ret);
 
 		free_pages(pages, TEST_PAGES);
 	}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages07.c b/testcases/kernel/syscalls/move_pages/move_pages07.c
index cb0772e..57c4f07 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages07.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages07.c
@@ -119,13 +119,12 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(ipid, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == ESRCH)
 			tst_resm(TPASS, "move_pages failed with "
 				 "ESRCH as expected");
 		else
-			tst_resm(TFAIL, "move pages did not fail "
-				 "with ESRCH");
+			tst_resm(TFAIL|TERRNO, "move pages did not fail "
+				 "with ESRCH ret: %d", ret);
 
 err_free_pages:
 		free_pages(pages, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index 159a6ea..d0c2719 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -106,13 +106,12 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, ULONG_MAX, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == E2BIG)
 			tst_resm(TPASS, "move_pages failed with "
 				 "E2BIG as expected");
 		else
-			tst_resm(TFAIL, "move pages did not fail "
-				 "with E2BIG");
+			tst_resm(TFAIL|TERRNO, "move pages did not fail "
+				 "with E2BIG ret: %d", ret);
 
 		free_pages(pages, TEST_PAGES);
 	}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 53d2189..7d4e662 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -105,7 +105,6 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
-		TEST_ERRNO = errno;
 
 		/*
 		 * commit e78bbfa8262424417a29349a8064a535053912b9
@@ -123,7 +122,8 @@ int main(int argc, char **argv)
 				tst_resm(TPASS, "move_pages failed with "
 					 "ENOENT as expected");
 			else
-				tst_resm(TFAIL | TERRNO, "move_pages");
+				tst_resm(TFAIL | TERRNO, "move_pages did not "
+					"fail with ENOENT ret: %d", ret);
 		}
 
 		free_pages(pages, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages10.c b/testcases/kernel/syscalls/move_pages/move_pages10.c
index 7880ae9..130957d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages10.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages10.c
@@ -108,13 +108,12 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_STRICT);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == EINVAL)
 			tst_resm(TPASS, "move_pages failed with "
 				 "EINVAL as expected");
 		else
-			tst_resm(TFAIL, "move_pages did not fail "
-				 "with EINVAL");
+			tst_resm(TFAIL|TERRNO, "move_pages did not fail "
+				 "with EINVAL ret: %d", ret);
 
 		free_pages(pages, TEST_PAGES);
 	}
diff --git a/testcases/kernel/syscalls/move_pages/move_pages11.c b/testcases/kernel/syscalls/move_pages/move_pages11.c
index 094d548..a42f46b 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages11.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages11.c
@@ -173,13 +173,12 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE_ALL);
-		TEST_ERRNO = errno;
 		if (ret == -1 && errno == EPERM)
 			tst_resm(TPASS, "move_pages failed with "
 				 "EPERM as expected");
 		else
-			tst_resm(TFAIL, "move_pages did not fail "
-				 "with EPERM");
+			tst_resm(TFAIL|TERRNO, "move_pages did not fail "
+				 "with EPERM ret: %d", ret);
 
 		/* Test done. Ask child to terminate. */
 		if (sem_post(&sem[SEM_PARENT_TEST]) == -1)
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
