Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YqGUF-0000GD-0X
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 07:44:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqGUC-0006l7-3M
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 07:44:50 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t477hMDk003343
	for <ltp-list@lists.sourceforge.net>; Thu, 7 May 2015 15:43:22 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 7 May 2015 15:35:51 +0800
Message-ID: <1430984152-1661-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/2] kernel/mem/zram: move zram01 to
	kernel/device-drivers/zram/ and rename it to zram03
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/mm                                    |   2 -
 testcases/kernel/device-drivers/zram/zram03.c | 225 ++++++++++++++++++++++++++
 testcases/kernel/mem/zram/Makefile            |  22 ---
 testcases/kernel/mem/zram/zram01.c            | 225 --------------------------
 4 files changed, 225 insertions(+), 249 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/zram/zram03.c
 delete mode 100644 testcases/kernel/mem/zram/Makefile
 delete mode 100644 testcases/kernel/mem/zram/zram01.c

diff --git a/runtest/mm b/runtest/mm
index 031d766..c7eafa8 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -96,8 +96,6 @@ vma02 vma02
 vma03 vma03
 vma04 vma04
 
-zram01 zram01
-
 overcommit_memory01 overcommit_memory
 overcommit_memory02 overcommit_memory -R 0
 overcommit_memory03 overcommit_memory -R 30
diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
new file mode 100644
index 0000000..a5abb38
--- /dev/null
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -0,0 +1,225 @@
+/*
+ * zram: generic RAM based compressed R/W block devices
+ * http://lkml.org/lkml/2010/8/9/227
+ *
+ * Copyright (C) 2010  Red Hat, Inc.
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
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include "test.h"
+
+char *TCID = "zram01";
+int TST_TOTAL = 1;
+
+#define PATH_ZRAM	"/sys/block/zram0"
+#define SIZE		(512 * 1024 * 1024L)
+#define DEVICE		"/dev/zram0"
+
+static int modprobe;
+
+static void set_disksize(void);
+static void write_device(void);
+static void verify_device(void);
+static void reset(void);
+static void setup(void);
+static void cleanup(void);
+static void print(char *string);
+static void dump_info(void);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		set_disksize();
+
+		write_device();
+		dump_info();
+		verify_device();
+
+		reset();
+		dump_info();
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void set_disksize(void)
+{
+	int fd;
+	char size[BUFSIZ];
+
+	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
+	fd = open(PATH_ZRAM "/disksize", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
+			 PATH_ZRAM "/disksize");
+	sprintf(size, "%ld", SIZE);
+	if (write(fd, size, strlen(size)) != strlen(size))
+		tst_brkm(TBROK | TERRNO, cleanup, "write %s to %s", size,
+			 PATH_ZRAM "/disksize");
+	close(fd);
+}
+
+static void write_device(void)
+{
+	int fd;
+	char *s;
+
+	tst_resm(TINFO, "map it into memory.");
+	fd = open(DEVICE, O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open %s", DEVICE);
+	s = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (s == MAP_FAILED)
+		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+
+	tst_resm(TINFO, "write all the memory.");
+	memset(s, 'a', SIZE - 1);
+	s[SIZE - 1] = '\0';
+
+	if (munmap(s, SIZE) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
+
+	close(fd);
+}
+
+static void verify_device(void)
+{
+	int fd;
+	long i, fail;
+	char *s;
+
+	tst_resm(TINFO, "verify contents from device.");
+	fd = open(DEVICE, O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open %s", DEVICE);
+	s = mmap(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (s == MAP_FAILED)
+		tst_brkm(TBROK | TERRNO, cleanup, "2nd mmap");
+
+	i = 0;
+	fail = 0;
+	while (s[i] && i < SIZE - 1) {
+		if (s[i] != 'a')
+			fail++;
+		i++;
+	}
+	if (i != SIZE - 1)
+		tst_resm(TFAIL, "expect size: %ld, actual size: %ld.",
+			 SIZE - 1, i);
+	else if (s[i] != '\0')
+		tst_resm(TFAIL, "zram device seems not null terminated");
+	if (fail)
+		tst_resm(TFAIL, "%ld failed bytes found.", fail);
+	if (munmap(s, SIZE) == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "2nd munmap");
+
+	close(fd);
+}
+
+static void reset(void)
+{
+	int fd;
+
+	tst_resm(TINFO, "reset it.");
+	fd = open(PATH_ZRAM "/reset", O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
+			 PATH_ZRAM "/reset");
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK | TERRNO, cleanup, "write 1 to %s",
+			 PATH_ZRAM "/reset");
+	close(fd);
+}
+
+static void setup(void)
+{
+	int retried = 0;
+
+	tst_require_root(NULL);
+
+retry:
+	if (access(PATH_ZRAM, R_OK | W_OK | X_OK) == -1) {
+		if (errno == ENOENT) {
+			if (retried)
+				tst_brkm(TCONF, NULL,
+					 "system has no zram device.");
+			system("modprobe zram");
+			modprobe = 1;
+			retried = 1;
+			goto retry;
+		} else
+			tst_brkm(TBROK | TERRNO, NULL, "access");
+	}
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	if (modprobe == 1)
+		system("rmmod zram");
+}
+
+static void print(char *string)
+{
+	FILE *fp;
+	char buf[BUFSIZ], value[BUFSIZ];
+
+	sprintf(buf, "%s/%s", PATH_ZRAM, string);
+	fp = fopen(buf, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", buf);
+
+	if (fgets(value, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK | TERRNO, cleanup, "fgets %s", buf);
+	value[strlen(value) - 1] = '\0';
+	fclose(fp);
+
+	tst_resm(TINFO, "%s is %s", buf, value);
+}
+
+static void dump_info(void)
+{
+	print("initstate");
+	print("compr_data_size");
+	print("orig_data_size");
+	print("disksize");
+	print("mem_used_total");
+	print("num_reads");
+	print("num_writes");
+	print("zero_pages");
+}
diff --git a/testcases/kernel/mem/zram/Makefile b/testcases/kernel/mem/zram/Makefile
deleted file mode 100644
index fb4818f..0000000
--- a/testcases/kernel/mem/zram/Makefile
+++ /dev/null
@@ -1,22 +0,0 @@
-#
-#  Copyright (C) 2010  Red Hat, Inc.
-#
-#  This program is free software;  you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-#  the GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program;  if not, write to the Free Software
-#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-#
-
-top_srcdir              ?= ../../../..
-
-include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/zram/zram01.c b/testcases/kernel/mem/zram/zram01.c
deleted file mode 100644
index a5abb38..0000000
--- a/testcases/kernel/mem/zram/zram01.c
+++ /dev/null
@@ -1,225 +0,0 @@
-/*
- * zram: generic RAM based compressed R/W block devices
- * http://lkml.org/lkml/2010/8/9/227
- *
- * Copyright (C) 2010  Red Hat, Inc.
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
- */
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/mman.h>
-#include <errno.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include "test.h"
-
-char *TCID = "zram01";
-int TST_TOTAL = 1;
-
-#define PATH_ZRAM	"/sys/block/zram0"
-#define SIZE		(512 * 1024 * 1024L)
-#define DEVICE		"/dev/zram0"
-
-static int modprobe;
-
-static void set_disksize(void);
-static void write_device(void);
-static void verify_device(void);
-static void reset(void);
-static void setup(void);
-static void cleanup(void);
-static void print(char *string);
-static void dump_info(void);
-
-int main(int argc, char *argv[])
-{
-	int lc;
-
-	tst_parse_opts(argc, argv, NULL, NULL);
-
-	setup();
-
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-
-		set_disksize();
-
-		write_device();
-		dump_info();
-		verify_device();
-
-		reset();
-		dump_info();
-	}
-	cleanup();
-	tst_exit();
-}
-
-static void set_disksize(void)
-{
-	int fd;
-	char size[BUFSIZ];
-
-	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
-	fd = open(PATH_ZRAM "/disksize", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
-			 PATH_ZRAM "/disksize");
-	sprintf(size, "%ld", SIZE);
-	if (write(fd, size, strlen(size)) != strlen(size))
-		tst_brkm(TBROK | TERRNO, cleanup, "write %s to %s", size,
-			 PATH_ZRAM "/disksize");
-	close(fd);
-}
-
-static void write_device(void)
-{
-	int fd;
-	char *s;
-
-	tst_resm(TINFO, "map it into memory.");
-	fd = open(DEVICE, O_RDWR);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s", DEVICE);
-	s = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (s == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
-
-	tst_resm(TINFO, "write all the memory.");
-	memset(s, 'a', SIZE - 1);
-	s[SIZE - 1] = '\0';
-
-	if (munmap(s, SIZE) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
-
-	close(fd);
-}
-
-static void verify_device(void)
-{
-	int fd;
-	long i, fail;
-	char *s;
-
-	tst_resm(TINFO, "verify contents from device.");
-	fd = open(DEVICE, O_RDONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s", DEVICE);
-	s = mmap(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (s == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "2nd mmap");
-
-	i = 0;
-	fail = 0;
-	while (s[i] && i < SIZE - 1) {
-		if (s[i] != 'a')
-			fail++;
-		i++;
-	}
-	if (i != SIZE - 1)
-		tst_resm(TFAIL, "expect size: %ld, actual size: %ld.",
-			 SIZE - 1, i);
-	else if (s[i] != '\0')
-		tst_resm(TFAIL, "zram device seems not null terminated");
-	if (fail)
-		tst_resm(TFAIL, "%ld failed bytes found.", fail);
-	if (munmap(s, SIZE) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "2nd munmap");
-
-	close(fd);
-}
-
-static void reset(void)
-{
-	int fd;
-
-	tst_resm(TINFO, "reset it.");
-	fd = open(PATH_ZRAM "/reset", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
-			 PATH_ZRAM "/reset");
-	if (write(fd, "1", 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write 1 to %s",
-			 PATH_ZRAM "/reset");
-	close(fd);
-}
-
-static void setup(void)
-{
-	int retried = 0;
-
-	tst_require_root(NULL);
-
-retry:
-	if (access(PATH_ZRAM, R_OK | W_OK | X_OK) == -1) {
-		if (errno == ENOENT) {
-			if (retried)
-				tst_brkm(TCONF, NULL,
-					 "system has no zram device.");
-			system("modprobe zram");
-			modprobe = 1;
-			retried = 1;
-			goto retry;
-		} else
-			tst_brkm(TBROK | TERRNO, NULL, "access");
-	}
-
-	tst_sig(FORK, DEF_HANDLER, cleanup);
-	TEST_PAUSE;
-}
-
-static void cleanup(void)
-{
-	if (modprobe == 1)
-		system("rmmod zram");
-}
-
-static void print(char *string)
-{
-	FILE *fp;
-	char buf[BUFSIZ], value[BUFSIZ];
-
-	sprintf(buf, "%s/%s", PATH_ZRAM, string);
-	fp = fopen(buf, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", buf);
-
-	if (fgets(value, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fgets %s", buf);
-	value[strlen(value) - 1] = '\0';
-	fclose(fp);
-
-	tst_resm(TINFO, "%s is %s", buf, value);
-}
-
-static void dump_info(void)
-{
-	print("initstate");
-	print("compr_data_size");
-	print("orig_data_size");
-	print("disksize");
-	print("mem_used_total");
-	print("num_reads");
-	print("num_writes");
-	print("zero_pages");
-}
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
