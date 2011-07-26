Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <czhang@redhat.com>) id 1Qlf0V-0000kW-4s
	for ltp-list@lists.sourceforge.net; Tue, 26 Jul 2011 10:36:59 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Qlf0U-0001Uw-1u
	for ltp-list@lists.sourceforge.net; Tue, 26 Jul 2011 10:36:59 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p6QAaqi8023061
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 26 Jul 2011 06:36:52 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Tue, 26 Jul 2011 18:36:32 +0800
Message-Id: <145b91763d3c2670cd736cc7fa3072c9a6db219a.1311676572.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.6"
Subject: [LTP] [PATCH] [syscalls] getrusage04: new testcase
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
--------------1.7.6
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


getrusage04 - accuracy of getrusage() with RUSAGE_THREAD

This program is used for testing the following upstream commit:
761b1d26df542fd5eb348837351e4d2f3bc7bffe.

getrusage() returns cpu resource usage with accuracy of 10000us
when RUSAGE_THREAD is specified to the argument who. Meanwhile,
accuracy is 1000us when RUSAGE_SELF is specified. This bad
accuracy of getrusage() caused a big impact on some application
which is critical to accuracy of cpu usage. The upstream fix
removed casts to clock_t in task_u/stime(), to keep granularity
of cputime_t over the calculation.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/syscalls                                  |   11 +-
 testcases/kernel/syscalls/getrusage/getrusage04.c |  122 +++++++++++++++++++++
 2 files changed, 128 insertions(+), 5 deletions(-)
 create mode 100644 testcases/kernel/syscalls/getrusage/getrusage04.c


--------------1.7.6
Content-Type: text/x-patch; name="0001-syscalls-getrusage04-new-testcase.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-syscalls-getrusage04-new-testcase.patch"

diff --git a/runtest/syscalls b/runtest/syscalls
index 7989764..62d4760 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -400,6 +400,7 @@ get_robust_list01 get_robust_list01
 getrusage01 getrusage01
 getrusage02 getrusage02
 getrusage03 getrusage03
+getrusage04 getrusage04
 
 getsid01 getsid01
 getsid02 getsid02
@@ -574,7 +575,7 @@ mount1234 test_mount
 
 move_pages01 move_pages.sh 01
 move_pages02 move_pages.sh 02
-move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod 04755 move_pages03 && move_pages.sh 03 
+move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod 04755 move_pages03 && move_pages.sh 03
 move_pages04 move_pages.sh 04
 move_pages05 move_pages.sh 05
 move_pages06 move_pages.sh 06
@@ -676,7 +677,7 @@ open10 open10
 openat01 openat01
 
 mincore01 mincore01
-mincore02 mincore02 
+mincore02 mincore02
 
 madvise01 madvise01
 madvise02 madvise02
@@ -690,8 +691,8 @@ pause01 pause01
 pause02 pause02
 pause03 pause03
 
-#  The personality() system call is poorly documented 
-#  and difficult to figure out how to use by looking 
+#  The personality() system call is poorly documented
+#  and difficult to figure out how to use by looking
 #  at the different architecture specific kernel files.
 #personality01 personality01
 #personality02 personality02
@@ -1201,7 +1202,7 @@ truncate04_64 truncate04_64
 # This syscall is obsolete.  The latest glibc does not even
 # include the ulimit.h file anymore.  The test will fail
 # because the error handling has been simplified.
-# 
+#
 ulimit01 ulimit01
 
 umask01 umask01
diff --git a/testcases/kernel/syscalls/getrusage/getrusage04.c b/testcases/kernel/syscalls/getrusage/getrusage04.c
new file mode 100644
index 0000000..092a557
--- /dev/null
+++ b/testcases/kernel/syscalls/getrusage/getrusage04.c
@@ -0,0 +1,122 @@
+/*
+ * getrusage04 - accuracy of getrusage() with RUSAGE_THREAD
+ *
+ * This program is used for testing the following upstream commit:
+ * 761b1d26df542fd5eb348837351e4d2f3bc7bffe.
+ *
+ * getrusage() returns cpu resource usage with accuracy of 10000us
+ * when RUSAGE_THREAD is specified to the argument who. Meanwhile,
+ * accuracy is 1000us when RUSAGE_SELF is specified. This bad
+ * accuracy of getrusage() caused a big impact on some application
+ * which is critical to accuracy of cpu usage. The upstream fix
+ * removed casts to clock_t in task_u/stime(), to keep granularity
+ * of cputime_t over the calculation.
+ *
+ * Copyright (C) 2011  Red Hat, Inc.
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+#include <sys/types.h>
+#include <sys/resource.h>
+#include <sys/time.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+
+char *TCID = "getrusage04";
+int TST_TOTAL = 1;
+
+#define BIAS_MAX      1000
+#define RECORD_MAX    20
+#define RUSAGE_THREAD 1
+
+static void busyloop(int wait);
+static void setup(void);
+static void cleanup(void);
+
+int main(int argc, char *argv[])
+{
+	struct rusage usage;
+	unsigned long ulast, udelta, slast, sdelta;
+	int i, lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0; i = 0;
+		ulast = 0, slast = 0;
+		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
+		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
+			usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
+		while (i < RECORD_MAX) {
+			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
+			udelta = usage.ru_utime.tv_usec - ulast;
+			sdelta = usage.ru_stime.tv_usec - slast;
+			if (udelta > 0 || sdelta > 0) {
+				i++;
+				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
+					    usage.ru_utime.tv_usec,
+					    usage.ru_stime.tv_usec);
+				if (udelta > 1000+BIAS_MAX)
+					tst_brkm(TFAIL, cleanup,
+						    "utime increased > 1000us:"
+						    " delta = %luus", udelta);
+				if (sdelta > 1000+BIAS_MAX)
+					tst_brkm(TFAIL, cleanup,
+						    "stime increased > 1000us:"
+						    " delta = %luus", sdelta);
+			}
+			ulast = usage.ru_utime.tv_usec;
+			slast = usage.ru_stime.tv_usec;
+			busyloop(100000);
+		}
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void busyloop(int wait)
+{
+	int i, j = 0;
+
+	for (i = 0; i < wait; i++)
+		j = j * 3 + 11;
+}
+
+static void setup(void)
+{
+	tst_sig(NOFORK, DEF_HANDLER, cleanup);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	TEST_CLEANUP;
+}

--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Magic Quadrant for Content-Aware Data Loss Prevention
Research study explores the data loss prevention market. Includes in-depth
analysis on the changes within the DLP market, and the criteria used to
evaluate the strengths and weaknesses of these DLP solutions.
http://www.accelacomm.com/jaw/sfnl/114/51385063/
--------------1.7.6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.6--



