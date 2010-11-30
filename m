Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PNNRF-0003eS-Oc
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 10:27:57 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PNNRE-00067Z-Hj
	for ltp-list@lists.sourceforge.net; Tue, 30 Nov 2010 10:27:57 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAUARoJo004497
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Nov 2010 05:27:50 -0500
Date: Tue, 30 Nov 2010 05:27:50 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1609599410.757951291112870787.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <456905695.757931291112868201.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43138_1814950863.1291112870786"
Subject: [LTP] [PATCH] a race in pid generation that causes pids to be
 reused immediatelly
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

------=_Part_43138_1814950863.1291112870786
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
 runtest/syscalls                        |    1 +
 testcases/kernel/syscalls/fork/fork13.c |  166 +++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fork/fork13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b2bf144..d8f9b20 100644
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
index 0000000..9c36310
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -0,0 +1,166 @@
+/*
+ * a race in pid generation that causes pids to be reused immediatelly
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
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork13";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static void setup(void);
+static int PidDistance(pid_t first, pid_t second);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static int check(void);
+
+int main(int argc, char* argv[])
+{
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s",
+			msg);
+		tst_exit();
+	}
+	setup();
+	TEST(check());
+	cleanup();
+}
+
+int check(void)
+{
+	/* loop counter */
+	int lc;
+
+	pid_t last_pid = 0;
+	pid_t pid;
+	int child_exit_code, distance, reaped, status;
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		if (lc % 32786 == 0)
+			tst_resm(TINFO, "Iter: %d", lc/32768);
+		child_exit_code = lc % 256;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+			tst_exit();
+		case 0:
+			// Child
+			exit(child_exit_code);
+		default:
+			// Parent
+			if (lc > 0) {
+				printf("last_pid = %d\npid = %d\n", last_pid, pid);
+				distance = PidDistance(last_pid, pid);
+				if (distance == 0 || distance > 30000) {
+					tst_resm(TFAIL,
+						"Unexpected pid "
+						"sequence: previous "
+						"fork: pid=%d, current "
+						"fork: pid=%d for "
+						"iteration=%d.",
+						last_pid, pid, lc);
+				}
+			}
+			last_pid = pid;
+
+			reaped = wait(&status);
+			if (reaped != pid) {
+				tst_resm(TFAIL,
+					"Wait return value: expected "
+					"pid=%d, got %d, iteration %d.",
+					pid, reaped, lc);
+			} else if (WEXITSTATUS(status != child_exit_code)
+				!= child_exit_code) {
+				tst_resm(TFAIL,
+					"Unexpected exit status %x, "
+					"iteration %d.",
+					WEXITSTATUS(status), lc);
+			}
+		}
+	}
+	return 0;
+}
+
+void setup(void)
+{
+	/* capture signals */
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	/* Pause if that option was specified */
+	TEST_PAUSE;
+
+	tst_tmpdir();
+}
+
+void cleanup(void)
+{
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+
+	/* exit with return code appropriate for results */
+	tst_rmdir();
+	tst_exit();
+}
+
+/* The distance mod 32768 between two pids, where the first pid is
+   expected to be smaller than the second. */
+int PidDistance(pid_t first, pid_t second) {
+	return (second + 32768 - first) % 32768;
+}
-- 
1.7.1
------=_Part_43138_1814950863.1291112870786
Content-Type: text/x-patch;
	name=0007-a-race-in-pid-generation-that-causes-pids-to-be-reus.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0007-a-race-in-pid-generation-that-causes-pids-to-be-reus.patch

From: CAI Qian <caiqian@redhat.com>
Date: Tue, 30 Nov 2010 17:59:46 +0800
Subject: [PATCH] a race in pid generation that causes pids to be reused immediatelly

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
 testcases/kernel/syscalls/fork/fork13.c |  166 +++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/fork/fork13.c

diff --git a/runtest/syscalls b/runtest/syscalls
index b2bf144..d8f9b20 100644
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
index 0000000..9c36310
--- /dev/null
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -0,0 +1,166 @@
+/*
+ * a race in pid generation that causes pids to be reused immediatelly
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
+#include <errno.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "fork13";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static void setup(void);
+static int PidDistance(pid_t first, pid_t second);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static int check(void);
+
+int main(int argc, char* argv[])
+{
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s",
+			msg);
+		tst_exit();
+	}
+	setup();
+	TEST(check());
+	cleanup();
+}
+
+int check(void)
+{
+	/* loop counter */
+	int lc;
+
+	pid_t last_pid = 0;
+	pid_t pid;
+	int child_exit_code, distance, reaped, status;
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		if (lc % 32786 == 0)
+			tst_resm(TINFO, "Iter: %d", lc/32768);
+		child_exit_code = lc % 256;
+		switch (pid = fork()) {
+		case -1:
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+			tst_exit();
+		case 0:
+			// Child
+			exit(child_exit_code);
+		default:
+			// Parent
+			if (lc > 0) {
+				printf("last_pid = %d\npid = %d\n", last_pid, pid);
+				distance = PidDistance(last_pid, pid);
+				if (distance == 0 || distance > 30000) {
+					tst_resm(TFAIL,
+						"Unexpected pid "
+						"sequence: previous "
+						"fork: pid=%d, current "
+						"fork: pid=%d for "
+						"iteration=%d.",
+						last_pid, pid, lc);
+				}
+			}
+			last_pid = pid;
+
+			reaped = wait(&status);
+			if (reaped != pid) {
+				tst_resm(TFAIL,
+					"Wait return value: expected "
+					"pid=%d, got %d, iteration %d.",
+					pid, reaped, lc);
+			} else if (WEXITSTATUS(status != child_exit_code)
+				!= child_exit_code) {
+				tst_resm(TFAIL,
+					"Unexpected exit status %x, "
+					"iteration %d.",
+					WEXITSTATUS(status), lc);
+			}
+		}
+	}
+	return 0;
+}
+
+void setup(void)
+{
+	/* capture signals */
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+
+	/* Pause if that option was specified */
+	TEST_PAUSE;
+
+	tst_tmpdir();
+}
+
+void cleanup(void)
+{
+	/*
+	 * print timing stats if that option was specified.
+	 * print errno log if that option was specified.
+	 */
+	TEST_CLEANUP;
+
+	/* exit with return code appropriate for results */
+	tst_rmdir();
+	tst_exit();
+}
+
+/* The distance mod 32768 between two pids, where the first pid is
+   expected to be smaller than the second. */
+int PidDistance(pid_t first, pid_t second) {
+	return (second + 32768 - first) % 32768;
+}
-- 
1.7.1


------=_Part_43138_1814950863.1291112870786
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
------=_Part_43138_1814950863.1291112870786
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_43138_1814950863.1291112870786--

