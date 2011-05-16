Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1QLsLl-0002eV-CQ
	for ltp-list@lists.sourceforge.net; Mon, 16 May 2011 07:36:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QLsLk-0000kx-I1
	for ltp-list@lists.sourceforge.net; Mon, 16 May 2011 07:36:21 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4G7aEO2029739
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 16 May 2011 03:36:14 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Mon, 16 May 2011 15:36:09 +0800
Message-Id: <a893e731f5998485ba2b9309e0c909b933c40479.1305519242.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] [syscalls] mmap11: fix broken testcase
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


mmap11 testcase couldn't run correctly as it should be. The purpose of
this test program was that, on some old kernels, program received
SIGABRT unexpected when large amount munmap happens, in new kernels,
this wouldn't happen, despite some ENOMEM/EAGAIN might occur during
testing. So the correct PASS/FAIL criteria is: the test passes when the
program finishes running and exits normally; the test fails when the
program exits abnormally, e.g. a SIGABRT received. My patch fetches the
newest version of reproducer from kernel commit log to make the testcase
work again.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/syscalls                        |    2 +-
 testcases/kernel/syscalls/mmap/mmap11.c |   14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-syscalls-mmap11-fix-broken-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-mmap11-fix-broken-testcase.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 4294d07..930b207 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -554,7 +554,7 @@ mmap06 mmap06
 mmap07 mmap07
 mmap08 mmap08
 mmap09 mmap09
-mmap11 mmap11 -i 30000
+mmap11 mmap11 -i 50000
 
 modify_ldt01 modify_ldt01
 modify_ldt02 modify_ldt02
diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
index 786724b..4cbad58 100644
--- a/testcases/kernel/syscalls/mmap/mmap11.c
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -58,7 +58,7 @@
 char *TCID = "mmap11";
 int TST_TOTAL = 1;
 
-#define MAL_SIZE (100*1024)
+#define MAL_SIZE (8*1024*1024)
 
 static void *wait_thread(void *args);
 static void *wait_thread2(void *args);
@@ -112,13 +112,15 @@ void check(void)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
 		ret = pthread_create(&th, &attr, wait_thread, NULL);
-		if (ret) {
+		if (ret && errno != ENOMEM && errno != EAGAIN) {
 			tst_resm(TINFO, "[%d] ", count);
 			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
 		}
+		if (count % 100 == 0)
+			usleep(10000);
 		count++;
 		ret = pthread_create(&thread[lc], &attr, wait_thread2, NULL);
-		if (ret) {
+		if (ret && errno != ENOMEM && errno != EAGAIN) {
 			tst_resm(TINFO, "[%d] ", count);
 			tst_brkm(TBROK|TERRNO, cleanup, "pthread_create");
 		}
@@ -133,13 +135,13 @@ void *wait_thread(void *args)
 	void *addr;
 
 	addr = malloc(MAL_SIZE);
-	if (addr)
-		memset(addr, 1, MAL_SIZE);
-	sleep(1);
+	sleep(10);
+
 	return NULL;
 }
 
 void *wait_thread2(void *args)
 {
+	sleep(60);
 	return NULL;
 }

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



