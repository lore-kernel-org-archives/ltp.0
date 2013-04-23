Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1UUYPn-0005fQ-8p
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 08:17:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UUYPl-00062e-69
	for ltp-list@lists.sourceforge.net; Tue, 23 Apr 2013 08:17:26 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3N8HJD1021605
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Apr 2013 04:17:19 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id r3N8HH6r011358
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Apr 2013 04:17:18 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 23 Apr 2013 10:17:15 +0200
Message-Id: <8a4fb5929c599b2dec955086713069c20f95c466.1366704928.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] syscalls/cma: add runtime check to setup()
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

__NR_process_vm_readv / __NR_process_vm_writev defined doesn't
guarantee, that kernel supports these syscalls. Add check to setup(),
which uses ltp_syscall(). If syscall isn't supported it will
end the testcase with TCONF.

This also fixes small copy-paste error in process_vm_writev02.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/cma/process_vm.h         |    1 +
 testcases/kernel/syscalls/cma/process_vm01.c       |    2 ++
 testcases/kernel/syscalls/cma/process_vm_readv02.c |    2 ++
 testcases/kernel/syscalls/cma/process_vm_readv03.c |    2 ++
 .../kernel/syscalls/cma/process_vm_writev02.c      |    6 ++++--
 5 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/cma/process_vm.h b/testcases/kernel/syscalls/cma/process_vm.h
index 5241fa1..35086c6 100644
--- a/testcases/kernel/syscalls/cma/process_vm.h
+++ b/testcases/kernel/syscalls/cma/process_vm.h
@@ -31,6 +31,7 @@
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <unistd.h>
+#include "linux_syscall_numbers.h"
 
 union semun {
 	int val;
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 1a91570..bb09855 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -108,6 +108,7 @@ static void setup(char *argv[])
 	else if (rflag) {
 		TCID = TCID_readv;
 #if defined(__NR_process_vm_readv)
+		ltp_syscall(__NR_process_vm_readv, 0, NULL, 0, NULL, 0, 0);
 		cma_test_params = cma_test_params_read;
 #else
 		tst_brkm(TCONF, NULL, "process_vm_readv does not"
@@ -116,6 +117,7 @@ static void setup(char *argv[])
 	} else if (wflag) {
 		TCID = TCID_writev;
 #if defined(__NR_process_vm_writev)
+		ltp_syscall(__NR_process_vm_writev, 0, NULL, 0, NULL, 0, 0);
 		cma_test_params = cma_test_params_write;
 #else
 		tst_brkm(TCONF, NULL, "process_vm_writev does not"
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv02.c b/testcases/kernel/syscalls/cma/process_vm_readv02.c
index dea1bbe..752a513 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv02.c
@@ -159,6 +159,8 @@ static void setup(void)
 #if !defined(__NR_process_vm_readv)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
+#else
+	ltp_syscall(__NR_process_vm_readv, 0, NULL, 0, NULL, 0, 0);
 #endif
 	semid = init_sem(1);
 
diff --git a/testcases/kernel/syscalls/cma/process_vm_readv03.c b/testcases/kernel/syscalls/cma/process_vm_readv03.c
index 7475a64..2a8f631 100644
--- a/testcases/kernel/syscalls/cma/process_vm_readv03.c
+++ b/testcases/kernel/syscalls/cma/process_vm_readv03.c
@@ -261,6 +261,8 @@ static void setup(void)
 #if !defined(__NR_process_vm_readv)
 	tst_brkm(TCONF, NULL, "process_vm_readv does not exist "
 		 "on your system");
+#else
+	ltp_syscall(__NR_process_vm_readv, 0, NULL, 0, NULL, 0, 0);
 #endif
 	semid = init_sem(1);
 	srand(time(NULL));
diff --git a/testcases/kernel/syscalls/cma/process_vm_writev02.c b/testcases/kernel/syscalls/cma/process_vm_writev02.c
index 0ea956d..6fd7aea 100644
--- a/testcases/kernel/syscalls/cma/process_vm_writev02.c
+++ b/testcases/kernel/syscalls/cma/process_vm_writev02.c
@@ -180,7 +180,7 @@ static void child_write(void)
 	tst_resm(TINFO, "child 2: write to the same memory location.");
 	TEST(test_process_vm_writev(pids[0], &local, 1, &remote, 1, 0));
 	if (TEST_RETURN != bufsz)
-		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_readv");
+		tst_brkm(TFAIL | TERRNO, tst_exit, "process_vm_writev");
 }
 
 static void setup(void)
@@ -191,9 +191,11 @@ static void setup(void)
 	    sflag ? SAFE_STRTOL(NULL, sz_opt, 1, LONG_MAX - PADDING_SIZE * 2)
 	    : 100000;
 
-#if !defined(__NR_process_vm_readv)
+#if !defined(__NR_process_vm_writev)
 	tst_brkm(TCONF, NULL, "process_vm_writev does not exist "
 		 "on your system");
+#else
+	ltp_syscall(__NR_process_vm_writev, 0, NULL, 0, NULL, 0, 0);
 #endif
 	semid = init_sem(1);
 
-- 
1.7.1


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
