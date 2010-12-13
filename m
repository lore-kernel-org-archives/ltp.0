Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PS0m0-0002TB-QP
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 05:16:32 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PS0lz-0008Nv-3t
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 05:16:32 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBD5GPOo003067
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Dec 2010 00:16:25 -0500
Date: Mon, 13 Dec 2010 00:16:19 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <224013166.819151292217379224.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1615822844.819121292217239826.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_47495_1270206399.1292217379223"
Subject: [LTP] [PATCH v2] fork13: a race in pid generation
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_47495_1270206399.1292217379223
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:

A program that repeatedly forks and waits is susceptible to having the
same pid repeated, especially when it competes with another instance of
the same program.  This is really bad for bash implementation.
Furthermore, many shell scripts assume that pid numbers will not be used
for some length of time.

Race Description:

A                                B

// pid == offset == n            // pid == offset == n + 1
test_and_set_bit(offset, map->page)
                                 test_and_set_bit(offset, map->page);
                                 pid_ns->last_pid = pid;
pid_ns->last_pid = pid;
                                 // pid == n + 1 is freed (wait())

                                 // Next fork()...
                                 last = pid_ns->last_pid; // == n
                                 pid = last + 1;

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: backup/restore pid_max and remove probably artificial PID distance
    assertion.

 runtest/syscalls                        |    1 +
 testcases/kernel/syscalls/fork/fork13.c |  179 +++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fork/fork13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2071ed3..119d582 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -274,6 +274,7 @@ fork08 fork08
 fork09 fork09
 fork10 fork10
 fork11 fork11
+fork13 fork13 -c 2 -i 10000000
 
 fpathconf01 fpathconf01
 
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
new file mode 100644
index 0000000..2d81d98
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -0,0 +1,179 @@
+/*
+ * a race in pid generation that causes pids to be reused immediately
+ *
+ * From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
+ * 
+ * A program that repeatedly forks and waits is susceptible to having
+ * the same pid repeated, especially when it competes with another
+ * instance of the same program.  This is really bad for bash
+ * implementation.  Furthermore, many shell scripts assume that pid
+ * numbers will not be used for some length of time.
+ * 
+ * Race Description:
+ *
+ * A                                B
+ *
+ * // pid == offset == n            // pid == offset == n + 1
+ * test_and_set_bit(offset, map->page)
+ *                                  test_and_set_bit(offset, map->page);
+ *                                  pid_ns->last_pid = pid;
+ * pid_ns->last_pid = pid;
+ *                                  // pid == n + 1 is freed (wait())
+ *
+ *                                  // Next fork()...
+ *                                  last = pid_ns->last_pid; // == n
+ *                                  pid = last + 1;
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
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork13";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static char pid_max[BUFSIZ];
+
+#define PATH	"/proc/sys/kernel/pid_max"
+#define PIDMAX	32768
+#define RETURN	256
+
+static void setup(void);
+static int pid_distance(pid_t first, pid_t second);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void check(void);
+
+int main(int argc, char* argv[])
+{
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s",
+			msg);
+	setup();
+	check();
+	cleanup();
+}
+
+void check(void)
+{
+	int lc;
+	pid_t last_pid = 0;
+	pid_t pid;
+	int child_exit_code, distance, reaped, status;
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		if (lc % PIDMAX == 0)
+			tst_resm(TINFO, "Iter: %d", lc/PIDMAX);
+		child_exit_code = lc % RETURN;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			exit(child_exit_code);
+		default:
+			if (lc > 0) {
+				tst_resm(TINFO, "last_pid = %d pid = %d",
+					last_pid, pid);
+				distance = pid_distance(last_pid, pid);
+				if (distance == 0)
+					tst_resm(TFAIL,
+						"Unexpected pid sequence: "
+						"previous fork: pid=%d, "
+						"current fork: pid=%d for "
+						"iteration=%d.", last_pid, pid,
+						lc);
+			}
+			last_pid = pid;
+
+			reaped = wait(&status);
+			if (reaped != pid)
+				tst_resm(TFAIL,
+					"Wait return value: expected pid=%d, "
+					"got %d, iteration %d.", pid, reaped,
+					lc);
+			else if (WEXITSTATUS(status) != child_exit_code)
+				tst_resm(TFAIL, "Unexpected exit status %x, "
+					"iteration %d.", WEXITSTATUS(status),
+					lc);
+		}
+	}
+}
+
+void setup(void)
+{
+	FILE *fp;
+	int fd;
+	char buf[BUFSIZ];
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	/* Backup pid_max value. */
+	fp = fopen(PATH, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(pid_max, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+
+	fd = open(PATH, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TBROK|TERRNO, "open");
+	sprintf(buf, "%d", PIDMAX);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_resm(TBROK|TERRNO, "write");
+	close(fd);
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(PATH, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	if (write(fd, pid_max, strlen(pid_max)) != strlen(pid_max))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+/* The distance mod PIDMAX between two pids, where the first pid is
+   expected to be smaller than the second. */
+int pid_distance(pid_t first, pid_t second)
+{
+	return (second + PIDMAX - first) % PIDMAX;
+}
-- 
1.7.3.2
------=_Part_47495_1270206399.1292217379223
Content-Type: text/x-patch; name=0001-fork13-a-race-in-pid-generation.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-fork13-a-race-in-pid-generation.patch

From 4681ff1796c0d9a9fa143b0c4b1452fe95303537 Mon Sep 17 00:00:00 2001
From: CAI Qian <caiqian@redhat.com>
Date: Mon, 13 Dec 2010 13:08:37 +0800
Subject: [PATCH] fork13: a race in pid generation

From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:

A program that repeatedly forks and waits is susceptible to having the
same pid repeated, especially when it competes with another instance of
the same program.  This is really bad for bash implementation.
Furthermore, many shell scripts assume that pid numbers will not be used
for some length of time.

Race Description:

A                                B

// pid == offset == n            // pid == offset == n + 1
test_and_set_bit(offset, map->page)
                                 test_and_set_bit(offset, map->page);
                                 pid_ns->last_pid = pid;
pid_ns->last_pid = pid;
                                 // pid == n + 1 is freed (wait())

                                 // Next fork()...
                                 last = pid_ns->last_pid; // == n
                                 pid = last + 1;

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/syscalls                        |    1 +
 testcases/kernel/syscalls/fork/fork13.c |  179 +++++++++++++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fork/fork13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2071ed3..119d582 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -274,6 +274,7 @@ fork08 fork08
 fork09 fork09
 fork10 fork10
 fork11 fork11
+fork13 fork13 -c 2 -i 10000000
 
 fpathconf01 fpathconf01
 
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
new file mode 100644
index 0000000..2d81d98
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -0,0 +1,179 @@
+/*
+ * a race in pid generation that causes pids to be reused immediately
+ *
+ * From the mainline commit 5fdee8c4a5e1800489ce61963208f8cc55e42ea1:
+ * 
+ * A program that repeatedly forks and waits is susceptible to having
+ * the same pid repeated, especially when it competes with another
+ * instance of the same program.  This is really bad for bash
+ * implementation.  Furthermore, many shell scripts assume that pid
+ * numbers will not be used for some length of time.
+ * 
+ * Race Description:
+ *
+ * A                                B
+ *
+ * // pid == offset == n            // pid == offset == n + 1
+ * test_and_set_bit(offset, map->page)
+ *                                  test_and_set_bit(offset, map->page);
+ *                                  pid_ns->last_pid = pid;
+ * pid_ns->last_pid = pid;
+ *                                  // pid == n + 1 is freed (wait())
+ *
+ *                                  // Next fork()...
+ *                                  last = pid_ns->last_pid; // == n
+ *                                  pid = last + 1;
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
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork13";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static char pid_max[BUFSIZ];
+
+#define PATH	"/proc/sys/kernel/pid_max"
+#define PIDMAX	32768
+#define RETURN	256
+
+static void setup(void);
+static int pid_distance(pid_t first, pid_t second);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void check(void);
+
+int main(int argc, char* argv[])
+{
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s",
+			msg);
+	setup();
+	check();
+	cleanup();
+}
+
+void check(void)
+{
+	int lc;
+	pid_t last_pid = 0;
+	pid_t pid;
+	int child_exit_code, distance, reaped, status;
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		if (lc % PIDMAX == 0)
+			tst_resm(TINFO, "Iter: %d", lc/PIDMAX);
+		child_exit_code = lc % RETURN;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		case 0:
+			exit(child_exit_code);
+		default:
+			if (lc > 0) {
+				tst_resm(TINFO, "last_pid = %d pid = %d",
+					last_pid, pid);
+				distance = pid_distance(last_pid, pid);
+				if (distance == 0)
+					tst_resm(TFAIL,
+						"Unexpected pid sequence: "
+						"previous fork: pid=%d, "
+						"current fork: pid=%d for "
+						"iteration=%d.", last_pid, pid,
+						lc);
+			}
+			last_pid = pid;
+
+			reaped = wait(&status);
+			if (reaped != pid)
+				tst_resm(TFAIL,
+					"Wait return value: expected pid=%d, "
+					"got %d, iteration %d.", pid, reaped,
+					lc);
+			else if (WEXITSTATUS(status) != child_exit_code)
+				tst_resm(TFAIL, "Unexpected exit status %x, "
+					"iteration %d.", WEXITSTATUS(status),
+					lc);
+		}
+	}
+}
+
+void setup(void)
+{
+	FILE *fp;
+	int fd;
+	char buf[BUFSIZ];
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	/* Backup pid_max value. */
+	fp = fopen(PATH, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(pid_max, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+
+	fd = open(PATH, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TBROK|TERRNO, "open");
+	sprintf(buf, "%d", PIDMAX);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_resm(TBROK|TERRNO, "write");
+	close(fd);
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(PATH, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	if (write(fd, pid_max, strlen(pid_max)) != strlen(pid_max))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+/* The distance mod PIDMAX between two pids, where the first pid is
+   expected to be smaller than the second. */
+int pid_distance(pid_t first, pid_t second)
+{
+	return (second + PIDMAX - first) % PIDMAX;
+}
-- 
1.7.3.2


------=_Part_47495_1270206399.1292217379223
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_47495_1270206399.1292217379223
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_47495_1270206399.1292217379223--

