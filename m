Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V9U9k-0002qh-Ep
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 06:02:04 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V9U9j-000584-5f
	for ltp-list@lists.sourceforge.net; Wed, 14 Aug 2013 06:02:04 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7E61vpB027969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 06:01:57 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7E61u8M023598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 06:01:56 GMT
Received: from abhmt115.oracle.com (abhmt115.oracle.com [141.146.116.67])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7E61uqO016829
	for <ltp-list@lists.sourceforge.net>; Wed, 14 Aug 2013 06:01:56 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 14 Aug 2013 10:01:47 +0400
Message-Id: <1376460107-3578-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130717130502.GD25145@rei>
References: <20130717130502.GD25145@rei>
Subject: [LTP] [PATCH V5 2/2] syscalls/swapon: fix for variable page size
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
Cc: vasily.isaenko@oracle.com

mkswap refuses files of size < 10*(page size).

On systems with 8192 page size swapon02, swapon03 tests fail because
they try to use files of size 41920 (< 81920).

Modified swapon1, swapon02, swapon03 so they operate on files of size
10*(page size).

Verified on systems with 4096 and 8192 page sizes.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/swapon/Makefile    |    5 ++
 testcases/kernel/syscalls/swapon/libswapon.c |   48 +++++++++++++++++
 testcases/kernel/syscalls/swapon/libswapon.h |   34 ++++++++++++
 testcases/kernel/syscalls/swapon/swapon01.c  |   18 +------
 testcases/kernel/syscalls/swapon/swapon02.c  |   62 +---------------------
 testcases/kernel/syscalls/swapon/swapon03.c  |   71 ++------------------------
 6 files changed, 97 insertions(+), 141 deletions(-)
 create mode 100644 testcases/kernel/syscalls/swapon/libswapon.c
 create mode 100644 testcases/kernel/syscalls/swapon/libswapon.h

diff --git a/testcases/kernel/syscalls/swapon/Makefile b/testcases/kernel/syscalls/swapon/Makefile
index 7ff50f1..a272224 100644
--- a/testcases/kernel/syscalls/swapon/Makefile
+++ b/testcases/kernel/syscalls/swapon/Makefile
@@ -25,4 +25,9 @@ top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
 
+FILTER_OUT_MAKE_TARGETS         := libswapon
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+$(MAKE_TARGETS): %: %.o libswapon.o
+
diff --git a/testcases/kernel/syscalls/swapon/libswapon.c b/testcases/kernel/syscalls/swapon/libswapon.c
new file mode 100644
index 0000000..8eca7dc
--- /dev/null
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+ *
+ */
+
+#include "test.h"
+#include "libswapon.h"
+
+/*
+ * Make a swap file
+ */
+void make_swapfile(void (cleanup)(void), const char *swapfile)
+{
+	if (!tst_cwd_has_free(sysconf(_SC_PAGESIZE)*10)) {
+		tst_brkm(TBROK, cleanup,
+			"Insufficient disk space to create swap file");
+	}
+
+	/* create file */
+	if (tst_fill_file(swapfile, 0,
+			sysconf(_SC_PAGESIZE), 10) != 0) {
+		tst_brkm(TBROK, cleanup, "Failed to create swapfile");
+	}
+
+	/* make the file swapfile */
+	const char *argv[2 + 1];
+	argv[0] = "mkswap";
+	argv[1] = swapfile;
+	argv[2] = NULL;
+
+	tst_run_cmd(cleanup, argv, "/dev/null", "/dev/null");
+}
diff --git a/testcases/kernel/syscalls/swapon/libswapon.h b/testcases/kernel/syscalls/swapon/libswapon.h
new file mode 100644
index 0000000..7f7211e
--- /dev/null
+++ b/testcases/kernel/syscalls/swapon/libswapon.h
@@ -0,0 +1,34 @@
+/*
+ * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
+ *
+ */
+
+/*
+ * Contains common content for all swapon tests
+ */
+
+#ifndef __LIBSWAPON_H__
+#define __LIBSWAPON_H__
+
+/*
+ * Make a swap file
+ */
+void make_swapfile(void (cleanup)(void), const char *swapfile);
+
+#endif /* __LIBSWAPON_H__ */
diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index 11a49f9..feefc58 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -81,6 +81,7 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 #include "swaponoff.h"
+#include "libswapon.h"
 
 static void setup();
 static void cleanup();
@@ -132,7 +133,6 @@ int main(int ac, char **av)
 /* setup() - performs all ONE TIME setup for this test */
 void setup()
 {
-
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	/* Check whether we are root */
@@ -154,21 +154,7 @@ void setup()
 			 "Cannot do swapon on a file located on a nfs filesystem");
 	}
 
-	if (!tst_cwd_has_free(65536)) {
-		tst_brkm(TBROK, cleanup,
-			 "Insufficient disk space to create swap file");
-	}
-
-	/*create file */
-	if (system("dd if=/dev/zero of=swapfile01 bs=1024 count=65536 >"
-		   " tmpfile 2>&1") != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to create file for swap");
-	}
-
-	/* make above file a swap file */
-	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to make swapfile");
-	}
+	make_swapfile(cleanup, "swapfile01");
 }
 
 /*
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index d44d6c3..fb8f89d 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -99,6 +99,7 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 #include "swaponoff.h"
+#include "libswapon.h"
 
 static void setup();
 static void cleanup();
@@ -217,36 +218,7 @@ int main(int ac, char **av)
  */
 int setup01()
 {
-	int pagesize = getpagesize();
-
-	/*create file */
-	if ((strncmp(kmachine, "ia64", 4)) == 0) {
-		if (system
-		    ("dd if=/dev/zero of=swapfile01 bs=1024  count=65536 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else if (pagesize == 65536) {
-		if (system
-		    ("dd if=/dev/zero of=swapfile01 bs=1048  count=655 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else {
-		if (system
-		    ("dd if=/dev/zero of=swapfile01 bs=1048  count=40 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	}
-
-	/* make above file a swap file */
-	if (system("mkswap swapfile01 > tmpfile 2>&1") != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to make swapfile");
-	}
+	make_swapfile(cleanup, "swapfile01");
 
 	if ((ltpuser = getpwnam(nobody_uid)) == NULL) {
 		tst_resm(TWARN, "\"nobody\" user not present. skipping test");
@@ -293,37 +265,9 @@ int setup02()
  */
 int setup03()
 {
-	int pagesize = getpagesize();
 	int res = 0;
 
-	/*create file */
-	if ((strncmp(kmachine, "ia64", 4)) == 0) {
-		if (system
-		    ("dd if=/dev/zero of=alreadyused bs=1024  count=65536 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else if (pagesize == 65536) {
-		if (system
-		    ("dd if=/dev/zero of=alreadyused bs=1048  count=655 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	} else {
-		if (system
-		    ("dd if=/dev/zero of=alreadyused bs=1048  count=40 > tmpfile"
-		     " 2>&1") != 0) {
-			tst_brkm(TBROK, cleanup,
-				 "Failed to create file for swap");
-		}
-	}
-
-	/* make above file a swap file */
-	if (system("mkswap alreadyused > tmpfile 2>&1") != 0) {
-		tst_brkm(TBROK, cleanup, "Failed to make swapfile");
-	}
+	make_swapfile(cleanup, "alreadyused");
 
 	/* turn on the swap file */
 	res = ltp_syscall(__NR_swapon, "alreadyused", 0);
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 3dbc998..a80e378 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -74,13 +74,13 @@
 #include "config.h"
 #include "linux_syscall_numbers.h"
 #include "swaponoff.h"
+#include "libswapon.h"
 
 void setup();
 void cleanup();
 int setup_swap();
 int clean_swap();
 int check_and_swapoff(char *filename);
-int create_swapfile(char *swapfile, int bs, int count);
 
 char *TCID = "swapon03";
 int TST_TOTAL = 1;
@@ -208,8 +208,7 @@ int setup_swap()
 	pid_t pid;
 	int j, fd;		/*j is loop counter, fd is file descriptor */
 	int status;		/* used for fork */
-	int res = 0, pagesize = getpagesize();
-	int bs, count;
+	int res = 0;
 	char filename[15];	/* array to store new filename */
 	char buf[BUFSIZ + 1];	/* temp buffer for reading /proc/swaps */
 
@@ -254,18 +253,6 @@ int setup_swap()
 		swapfiles = MAX_SWAPFILES;
 	}
 
-	/* args for dd */
-	if ((strncmp(kmachine, "ia64", 4)) == 0) {
-		bs = 1024;
-		count = 1024;
-	} else if (pagesize == 65536) {
-		bs = 1048;
-		count = 655;
-	} else {
-		bs = 1048;
-		count = 40;
-	}
-
 	pid = FORK_OR_VFORK();
 	if (pid == 0) {
 		/*create and turn on remaining swapfiles */
@@ -279,10 +266,7 @@ int setup_swap()
 			}
 
 			/* Create the swapfile */
-			if (create_swapfile(filename, bs, count) < 0) {
-				printf("Failed to create swapfile");
-				exit(1);
-			}
+			make_swapfile(cleanup, filename);
 
 			/* turn on the swap file */
 			res = ltp_syscall(__NR_swapon, filename, 0);
@@ -307,59 +291,14 @@ int setup_swap()
 	}
 
 	/* Create all needed extra swapfiles for testing */
-	for (j = 0; j < testfiles; j++) {
-		if (create_swapfile(swap_testfiles[j].filename, bs, count) < 0) {
-			tst_resm(TWARN,
-				 "Failed to create swapfiles for the test");
-			exit(1);
-		}
-	}
+	for (j = 0; j < testfiles; j++)
+		make_swapfile(cleanup, swap_testfiles[j].filename);
 
 	return 0;
 
 }
 
 /***************************************************************
- * create_swapfile() - Create a swap file
- ***************************************************************/
-int create_swapfile(char *swapfile, int bs, int count)
-{
-	char cmd_buffer[256];
-
-	/* prepare the path string for dd command */
-	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
-		     "dd if=/dev/zero of=%s bs=%d "
-		     "count=%d > tmpfile 2>&1", swapfile, bs, count) < 0) {
-		tst_resm(TWARN,
-			 "sprintf() failed to create the command string");
-
-		return -1;
-	}
-
-	if (system(cmd_buffer) != 0) {
-		tst_resm(TWARN, "dd command failed to create file via "
-			 "command: %s", cmd_buffer);
-		return -1;
-	}
-
-	/* make the file swapfile */
-	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
-		     "mkswap %s > tmpfile 2>&1", swapfile) < 0) {
-		tst_resm(TWARN,
-			 "snprintf() failed to create mkswap command string");
-		return -1;
-	}
-
-	if (system(cmd_buffer) != 0) {
-		tst_resm(TWARN, "failed to make swap file %s via command %s",
-			 swapfile, cmd_buffer);
-		return -1;
-	}
-
-	return 0;
-}
-
-/***************************************************************
  * clean_swap() - clearing all turned on swapfiles
  ***************************************************************/
 int clean_swap()
-- 
1.7.1


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
