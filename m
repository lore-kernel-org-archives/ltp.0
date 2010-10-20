Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1P8O9o-0006pF-Os
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 02:12:00 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P8O9n-000444-Ey
	for ltp-list@lists.sourceforge.net; Wed, 20 Oct 2010 02:12:00 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o9K2BrnR022400
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Oct 2010 22:11:53 -0400
Date: Tue, 19 Oct 2010 22:11:53 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1605030489.949971287540713741.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] functional testing for Kernel Samepage Merging
	(KSM)
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Basic tests were to start several programs with same and different
memory contents and ensure only to merge the ones with the same
contents. When changed the content of one of merged pages in a
process and to the mode "unmerging", it should discard all merged
pages there. Also tested it is possible to disable KSM. There are
also command-line options to specify the memory allocation size, and
number of processes have same memory contents so it is possible to
test more advanced things like KSM + OOM etc. KSM statistics numbers
look like hard to predict, so only check the ranges.


Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: fixed stupid mistakes about memory content assignment.

 testcases/kernel/mem/ksm/Makefile |   22 ++
 testcases/kernel/mem/ksm/ksm01.c  |  435 +++++++++++++++++++++++++++++++++++++
 2 files changed, 457 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/ksm/Makefile
 create mode 100644 testcases/kernel/mem/ksm/ksm01.c

diff --git a/testcases/kernel/mem/ksm/Makefile b/testcases/kernel/mem/ksm/Makefile
new file mode 100644
index 0000000..d3eb6ef
--- /dev/null
+++ b/testcases/kernel/mem/ksm/Makefile
@@ -0,0 +1,22 @@
+#
+#  Copyright (c) International Business Machines  Corp., 2001
+#
+#  This program is free software;  you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or
+#  (at your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+#  the GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program;  if not, write to the Free Software
+#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
new file mode 100644
index 0000000..82c1cd6
--- /dev/null
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -0,0 +1,435 @@
+/*
+ * functional testing for Kernel Samepage Merging (KSM)
+ *
+ * Basic tests were to start several programs with same and different
+ * memory contents and ensure only to merge the ones with the same
+ * contents. When changed the content of one of merged pages in a
+ * process and to the mode "unmerging", it should discard all merged
+ * pages there. Also tested it is possible to disable KSM. There are
+ * also command-line options to specify the memory allocation size, and
+ * number of processes have same memory contents so it is possible to
+ * test more advanced things like KSM + OOM etc. KSM statistics numbers
+ * look like hard to predict, so only check the ranges.
+ *
+ * Prerequisites:
+ *
+ * 1) ksm and ksmtuned daemons need to be disabled. Otherwise, it could
+ *    distrub the testing as they also change some ksm tunables depends
+ *    on current workloads.
+ *
+ * The test steps are:
+ * 01) check ksm feature and backup current run setting.
+ * 02) change run setting to 1 - merging.
+ * 03) 3 memory allocation programs have the memory contents that 2 of
+ *     them are all 'a' and one is all 'b'.
+ * 04) check ksm statistics.
+ * 05) 1 program changes the memory content from all 'a' to all 'b'.
+ * 06) check ksm statistics.
+ * 07) all programs change the memory content to all 'd'.
+ * 08) check ksm statistics.
+ * 09) change run setting to 2 - unmerging.
+ * 10) check ksm statistics.
+ * 11) change run setting to 0 - stop.
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
+
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <errno.h>
+#include "test.h"
+#include "usctest.h"
+
+#define _PATH_KSM	"/sys/kernel/mm/ksm/"
+#define MB		(1024 * 1024)
+
+char *TCID = "ksm01";
+int TST_TOTAL = 1;
+extern int Tst_count;
+static int opt_num, opt_size;
+static char *opt_numstr, *opt_sizestr;
+static char ***memory;
+
+/* main setup function of test */
+void setup(void);
+/* cleanup function for the test */
+void cleanup(void);
+int ksmtest(void);
+void help(void);
+void check(char *path, long int value);
+
+static option_t options[] = {
+	{ "n:", &opt_num,	&opt_numstr},
+	{ "s:", &opt_size,	&opt_sizestr},
+	{ NULL, NULL,		NULL}
+};
+
+int main(int argc, char *argv[])
+{
+	/* loop counter */
+	int lc;
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, help);
+	if (msg != (char *)NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
+	/* Perform global setup for test */
+	setup();
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		TEST(ksmtest());
+
+		if (TEST_RETURN != 0)
+			tst_resm(TFAIL, "ksmtest() failed with %ld.",
+				TEST_RETURN);
+		else
+			tst_resm(TPASS, "ksmtest() completed "
+				"successfully.");
+	}
+	cleanup();
+	return 0;
+}
+
+int ksmtest(void)
+{
+	char buf[BUFSIZ], buf2[BUFSIZ];
+	int i, j, status, k, fd, *child;
+	int size = 128;
+	int num = 3;
+
+	if (opt_size) {
+		size = atoi(opt_sizestr);
+		if (size < 1)
+			tst_brkm(TBROK, cleanup,
+				"size cannot be less than 1.");
+	}
+	if (opt_num) {
+		num = atoi(opt_numstr);
+		if (num < 3)
+			tst_brkm(TBROK, cleanup,
+				"process number cannot be less 3.");
+	}
+	child = malloc(num);
+	if (child == NULL)
+		tst_brkm(TBROK, cleanup, "malloc");
+
+	memory = malloc(num * sizeof(**memory));
+	if (memory == NULL)
+		tst_brkm(TBROK, cleanup, "malloc");
+
+	if ((child[0] = fork()) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	else if (child[0] == 0) {
+		/* Avoid THP allocation which can't ksm ATM. */
+		tst_resm(TINFO,
+			"child 0 allocates %d MB filled with 'c'.",
+			size);
+
+		memory[0] = malloc(size * sizeof(*memory));
+		if (memory[0] == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+		for (j = 0; j < size; j++) {
+			memory[0][j] = malloc(MB);
+			if (memory[0][j] == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"malloc");
+
+			madvise((char *)(((long)memory[0][j]>>12)<<12),
+				MB, MADV_MERGEABLE);
+			for (i = 0; i < MB; i++)
+				memory[0][j][i] = 'a';
+		}
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill");
+
+		tst_resm(TINFO, "child 0 continues...");
+		tst_resm(TINFO, "child 0 changes memory content to 'd'.");
+
+		for (j = 0; j < size; j++) {
+			for (i = 0; i < MB; i++)
+				memory[0][j][i] = 'd';
+		}
+		exit(1);
+	}
+	if ((child[1] = fork()) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	else if (child[1] == 0) {
+		tst_resm(TINFO,
+			"child 1 allocates %d MB filled with 'a'.",
+			size);
+
+		memory[1] = malloc(size * sizeof(*memory));
+		if (memory[1] == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+		for (j = 0; j < size; j++) {
+			memory[1][j] = malloc(MB);
+			if (memory[1][j] == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"malloc");
+
+			madvise((char *)(((long)memory[1][j]>>12)<<12),
+				MB, MADV_MERGEABLE);
+			for (i = 0; i < MB; i++)
+				memory[1][j][i] = 'a';
+		}
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill");
+
+		tst_resm(TINFO, "child 1 continues...");
+		tst_resm(TINFO, "child 1 changes memory content to 'b'.");
+
+		for (j = 0; j < size; j++) {
+			for (i = 0; i < MB; i++)
+				memory[1][j][i] = 'b';
+		}
+		if (raise(SIGSTOP) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "kill");
+
+		tst_resm(TINFO, "child 1 continues...");
+		tst_resm(TINFO, "child 1 changes memory content to 'd'");
+
+		for (j = 0; j < size; j++) {
+			for (i = 0; i < MB; i++)
+				memory[1][j][i] = 'd';
+		}
+		exit(1);
+	}
+
+	for (k = 2; k < num; k++) {
+		if ((child[k] = fork()) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		else if (child[k] == 0) {
+			tst_resm(TINFO,
+				"child %d allocates %d MB filled with "
+				"'a'.", k, size);
+
+			memory[k] = malloc(size * sizeof(*memory));
+			if (memory[k] == NULL)
+				tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+			for (j = 0; j < size; j++) {
+				memory[k][j] = malloc(MB);
+				if (memory[k][j] == NULL)
+					tst_brkm(TBROK|TERRNO, cleanup,
+						"malloc");
+
+				madvise((char *)(((long)memory[k][j]>>12)<<12),
+					MB, MADV_MERGEABLE);
+				for (i = 0; i < MB; i++)
+					memory[k][j][i] = 'a';
+			}
+			if (raise(SIGSTOP) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "kill");
+
+			tst_resm(TINFO, "child %d continues...", k);
+			tst_resm(TINFO, "child %d changes memory "
+				"content to 'd'", k);
+
+			for (j = 0; j < size; j++) {
+				for (i = 0; i < MB; i++)
+					memory[k][j][i] = 'd';
+			}
+			exit(1);
+		}
+	}
+	tst_resm(TINFO, "KSM merging...");
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "pages_to_scan");
+	snprintf(buf2, BUFSIZ, "%d", size * 256 * num);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, buf2, strlen(buf2)) != strlen(buf2))
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "sleep_millisecs");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	sleep(5);
+	tst_resm(TINFO, "check!");
+	check("run", 1);
+	check("pages_shared", size * 256);
+	check("pages_sharing", size * (num - 2) * 256);
+	/* One child has different memory content. */
+	check("pages_unshared", size * 256);
+
+	for (k = 0; k < num; k++) {
+		if (waitpid(child[k], &status, WUNTRACED) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFSTOPPED(status))
+			tst_brkm(TBROK, cleanup,
+				"child was not stopped.");
+	}
+	if (kill(child[1], SIGCONT) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "kill");
+
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "1", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	sleep(5);
+	tst_resm(TINFO, "check!");
+	check("run", 1);
+	check("pages_shared", 0);
+	check("pages_sharing", 0);
+	check("pages_unshared", size * num * 256);
+
+	for (k = 0; k < num; k++) {
+		if (kill(child[k], SIGCONT) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup,
+				"kill child[%d]", k);
+	}
+	sleep(5);
+	tst_resm(TINFO, "check!");
+	check("run", 1);
+	check("pages_shared", size * 256);
+	check("pages_sharing", size * (num - 1) * 256);
+	check("pages_unshared", 0);
+
+	tst_resm(TINFO, "KSM unmerging...");
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, "2", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+
+	sleep(5);
+	tst_resm(TINFO, "check!");
+	check("run", 2);
+	check("pages_shared", 0);
+	check("pages_sharing", 0);
+	check("pages_unshared", 0);
+
+	tst_resm(TINFO, "stop KSM.");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	sleep(5);
+	tst_resm(TINFO, "check!");
+	check("run", 0);
+	check("pages_shared", 0);
+	check("pages_sharing", 0);
+	check("pages_unshared", 0);
+
+	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
+		if (WEXITSTATUS(status) != 0)
+			return 1;
+	}
+	return 0;
+}
+
+void cleanup(void)
+{
+	/*
+	 * remove the tmp directory and exit
+	 */
+	TEST_CLEANUP;
+	tst_rmdir();
+	tst_exit();
+}
+
+void setup(void)
+{
+	char buf[BUFSIZ];
+	struct stat new;
+
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, "run");
+	if (stat(buf, &new) == -1) {
+		if (errno == ENOENT)
+			tst_brkm(TCONF, NULL, "no KSM.");
+		else
+			tst_brkm(TBROK, NULL, "stat");
+	}
+
+	/*
+	 * setup a default signal hander and a
+	 * temporary working directory.
+	 */
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	tst_tmpdir();
+}
+
+void help(void)
+{
+	printf("  -n      Number of process has same "
+		"memory content\n");
+	printf("  -s      Memory allocation size in MB\n");
+}
+
+void check(char *path, long int value)
+{
+	FILE *fp;
+	char buf[BUFSIZ];
+
+	snprintf(buf, BUFSIZ, "%s%s", _PATH_KSM, path);
+	fp = fopen(buf, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(buf, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+
+	tst_resm(TINFO, "%s is %ld.", path, atol(buf));
+
+	if ((atol(buf) != value))
+		tst_resm(TFAIL, "%s is not %ld.", path, value);
+}
-- 
1.7.1

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
