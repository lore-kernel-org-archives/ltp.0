Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Uz5uj-0003Vq-8h
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 14:07:37 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uz5ug-00058o-Rv
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 14:07:37 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r6GE7RR8020724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jul 2013 14:07:28 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6GE7Rh7027732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jul 2013 14:07:27 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6GE7R1C027714
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jul 2013 14:07:27 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 16 Jul 2013 18:06:51 +0400
Message-Id: <1373983611-10136-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20130625124854.GD31268@rei>
References: <20130625124854.GD31268@rei>
Subject: [LTP] [PATCH V2] syscalls/swapon: fix for variable page size
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

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

lib/tst_fill_file.c: added tst_fill_file function

mkswap refuses files of size < 10*(page size).

On systems with 8192 page size swapon02, swapon03 tests fail because
they try to use files of size 41920 (< 81920).

Modified swapon02, swapon03 so they operate on files of size
10*(page size).

In swapon01 test size of swap file is predefined. For unification
modified this test the same way.

Verified on systems with 4096 and 8192 page sizes.

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 include/test.h                               |   10 ++++
 lib/tst_fill_file.c                          |   66 ++++++++++++++++++++++++
 testcases/kernel/syscalls/swapon/Makefile    |    5 ++
 testcases/kernel/syscalls/swapon/libswapon.c |   54 +++++++++++++++++++
 testcases/kernel/syscalls/swapon/libswapon.h |   34 ++++++++++++
 testcases/kernel/syscalls/swapon/swapon01.c  |   18 +------
 testcases/kernel/syscalls/swapon/swapon02.c  |   62 +---------------------
 testcases/kernel/syscalls/swapon/swapon03.c  |   71 ++------------------------
 8 files changed, 179 insertions(+), 141 deletions(-)
 create mode 100644 lib/tst_fill_file.c
 create mode 100644 testcases/kernel/syscalls/swapon/libswapon.c
 create mode 100644 testcases/kernel/syscalls/swapon/libswapon.h

diff --git a/include/test.h b/include/test.h
index a76fafc..745ea0c 100644
--- a/include/test.h
+++ b/include/test.h
@@ -222,6 +222,16 @@ long tst_ncpus_max(void);
  */
 void tst_run_cmd(void (cleanup_fn)(void), char *const argv[]);
 
+/* lib/tst_fill_file.c
+ *
+ * Creates/ovewrites a file with specified pattern
+ * @path: path to file
+ * @pattern: pattern
+ * @bs: block size
+ * @bcount: blocks amount
+ */
+int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
+
 #ifdef TST_USE_COMPAT16_SYSCALL
 #define TCID_BIT_SUFFIX "_16"
 #elif  TST_USE_NEWER64_SYSCALL
diff --git a/lib/tst_fill_file.c b/lib/tst_fill_file.c
new file mode 100644
index 0000000..b5488c8
--- /dev/null
+++ b/lib/tst_fill_file.c
@@ -0,0 +1,66 @@
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+#include "test.h"
+
+int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount)
+{
+	int fd, counter;
+	char *buf;
+
+	fd = open(path, O_CREAT|O_WRONLY|O_TRUNC, S_IRUSR|S_IWUSR);
+	if (fd < 0)
+        	return -1;
+
+	/* Filling a memory buffer with provided pattern */
+	buf = malloc(bs);
+	if (buf == NULL) { 
+		close(fd);
+
+		return -1;
+	}
+
+	for (counter = 0; counter < bs; counter++)
+		buf[counter] = pattern;
+
+	/* Filling the file */
+	for (counter = 0; counter < bcount; counter++) 
+		if (write(fd, buf, bs) != bs) {
+			free(buf);
+			close(fd);
+
+			return -1;
+		}
+
+
+	free(buf);
+	if (close(fd) < 0)
+		return -1;
+
+	return 0;
+}
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
index 0000000..8add3e6
--- /dev/null
+++ b/testcases/kernel/syscalls/swapon/libswapon.c
@@ -0,0 +1,54 @@
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
+void make_swapfile(void (cleanup)(void), char *swapfile)
+{
+	char cmd_buffer[256];
+
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
+	if (snprintf(cmd_buffer, sizeof(cmd_buffer),
+			"mkswap %s > /dev/null 2>&1", swapfile) < 0) {
+		tst_brkm(TBROK, cleanup, 
+			"snprintf() failed to create mkswap command string");
+	}
+
+	if (system(cmd_buffer) != 0) {
+		tst_brkm(TBROK, cleanup, "Failed to make swapfile %s via command %s",
+			swapfile, cmd_buffer);
+	}
+}
diff --git a/testcases/kernel/syscalls/swapon/libswapon.h b/testcases/kernel/syscalls/swapon/libswapon.h
new file mode 100644
index 0000000..ec810d6
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
+void make_swapfile(void (cleanup)(void), char *swapfile);
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
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
