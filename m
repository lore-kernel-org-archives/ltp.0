Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PKiwy-00072r-RV
	for ltp-list@lists.sourceforge.net; Tue, 23 Nov 2010 02:49:44 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PKiwx-0004DM-AS
	for ltp-list@lists.sourceforge.net; Tue, 23 Nov 2010 02:49:44 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oAN2nbP7025383
	for <ltp-list@lists.sourceforge.net>; Mon, 22 Nov 2010 21:49:37 -0500
Date: Mon, 22 Nov 2010 21:49:37 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <1599631583.214931290480577282.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <330878919.214911290480554291.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_13136_575284346.1290480577278"
Subject: [LTP] [PATCH v2] Out Of Memory when changing cpuset's mems on NUMA
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

------=_Part_13136_575284346.1290480577278
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

There was a problem reported upstream that the allocator may see an
empty nodemask when changing cpuset's mems.

http://lkml.org/lkml/2010/5/4/77
http://lkml.org/lkml/2010/5/4/79
http://lkml.org/lkml/2010/5/4/80

This test is based on the reproducers for the above issue.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v2: use LTP_ATTRIBUTE_*; merge a few functions.
------=_Part_13136_575284346.1290480577278
Content-Type: text/x-patch;
	name=0001-Out-Of-Memory-when-changing-cpuset-s-mems-on-NUMA.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0001-Out-Of-Memory-when-changing-cpuset-s-mems-on-NUMA.patch

 runtest/mm                             |    3 +
 testcases/kernel/mem/cpuset/Makefile   |   25 +++
 testcases/kernel/mem/cpuset/cpuset01.c |  366 ++++++++++++++++++++++++++++++++
 3 files changed, 394 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/Makefile
 create mode 100644 testcases/kernel/mem/cpuset/cpuset01.c

diff --git a/runtest/mm b/runtest/mm
index 2f3f407..f6cedbd 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -54,3 +54,6 @@ mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
 
+ksm01 ksm01
+
+cpuset01 cpuset01 -I 3600
\ No newline at end of file
diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
new file mode 100644
index 0000000..65d3aab
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License as published by
+#  the Free Software Foundation; either version 2 of the License, or (at
+#  your option) any later version.
+#
+#  This program is distributed in the hope that it will be useful, but
+#  WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program; if not, write to the Free Software
+#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+#  02110-1301, USA.
+#
+
+top_srcdir              ?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+LDLIBS 			+= -lnuma -lm
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
new file mode 100644
index 0000000..6759719
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -0,0 +1,366 @@
+/*
+ * Out Of Memory when changing cpuset's mems on NUMA. There was a
+ * problem reported upstream that the allocator may see an empty
+ * nodemask when changing cpuset's mems.
+ * http://lkml.org/lkml/2010/5/4/77
+ * http://lkml.org/lkml/2010/5/4/79
+ * http://lkml.org/lkml/2010/5/4/80
+ * This test is based on the reproducers for the above issue.
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
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <sys/mount.h>
+#include <numaif.h>
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <fcntl.h>
+#include <ctype.h>
+#include <err.h>
+#include <math.h>
+#include <signal.h>
+#include <stdarg.h>
+#include "test.h"
+#include "usctest.h"
+
+#define MAXNODES		512
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		"/dev/cpuset/1"
+#define UNUSED			__attribute__ ((unused))
+#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+
+char *TCID = "mmap10";
+int TST_TOTAL = 1;
+extern int Tst_count;
+static pid_t *pids;
+volatile int end;
+
+/* main setup function of test */
+static void setup(void);
+/* cleanup function for the test */
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static int testcpuset(void);
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
+static int mem_hog(void);
+static long count_numa(void);
+static long count_cpu(void);
+static int path_exist(const char *path, ...);
+static int mem_hog_cpuset(int ntasks);
+
+int main(int argc, char *argv[])
+{
+	/* message returned from parse_opts */
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
+
+	/* Perform global setup for test */
+	setup();
+
+	TEST(testcpuset());
+
+	if (TEST_RETURN != 0)
+		tst_resm(TFAIL, "testcpuset() failed with %ld.",
+			TEST_RETURN);
+	else
+		tst_resm(TPASS, "testcpuset() completed "
+			"successfully.");
+	cleanup();
+}
+
+int testcpuset(void)
+{
+	/* loop counter */
+	int lc;
+	FILE *fp;
+	char buf[BUFSIZ], value[BUFSIZ];
+	int fd, child, i, status;
+	unsigned long nnodes = 1, nmask = 0, ncpus = 1;
+
+	nnodes = count_numa();
+	ncpus = count_cpu();
+
+	snprintf(buf, BUFSIZ, "%s/cpus", CPATH);
+	fp = fopen(buf, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(value, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+
+	/* Remove the trailing newline. */
+	value[strlen(value) - 1] = '\0';
+	snprintf(buf, BUFSIZ, "%s/cpus", CPATH_NEW);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, value, strlen(value)) != strlen(value))
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s/mems", CPATH);
+	fp = fopen(buf, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(value, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+
+	snprintf(buf, BUFSIZ, "%s/mems", CPATH_NEW);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, value, strlen(value)) != strlen(value))
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s/tasks", CPATH_NEW);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	snprintf(buf, BUFSIZ, "%d", getpid());
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	pids = malloc(nnodes * sizeof(pid_t));
+	if (!pids)
+		tst_brkm(TBROK|TERRNO, cleanup, "malloc");
+
+	switch (child = fork()) {
+        case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+        case 0:
+		for (i = 0; i < nnodes; i++)
+			nmask += exp2f(i); 
+
+		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1) {
+			tst_resm(TBROK|TERRNO, "set_mempolicy");
+			exit(1);
+		}
+		mem_hog_cpuset(ncpus > 1 ? ncpus : 1);
+		exit(0);
+	}
+	snprintf(buf, BUFSIZ, "%s/mems", CPATH_NEW);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		if (write(fd, "0", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+
+		if (lseek(fd, 0, SEEK_SET) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+	}
+	close(fd);
+
+	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (WEXITSTATUS(status) != 0)
+		return 1;
+
+	return 0;
+}
+
+void setup(void)
+{
+	if (count_numa() == 1) {
+		tst_resm(TCONF, "required a NUMA system.");
+		tst_exit();
+	}
+
+	/*
+	 * setup a default signal hander and a
+	 * temporary working directory.
+	 */
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	tst_tmpdir();
+
+	if (mkdir(CPATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount("cpuset", CPATH, "cpuset", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount");
+	if (mkdir(CPATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+}
+
+void cleanup(void)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	/* Move all processes in task to its parent cpuset node. */
+	snprintf(s, BUFSIZ, "%s/tasks", CPATH);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+
+	snprintf(s_new, BUFSIZ, "%s/tasks", CPATH_NEW);
+	fp = fopen(s_new, "r");
+	if (fp == NULL)
+		tst_resm(TWARN|TERRNO, "fopen");
+
+	if ((fd != -1) && (fp != NULL)) {
+		while (fgets(value, BUFSIZ, fp) != NULL)
+			if (write(fd, value, strlen(value) - 1)
+				!= strlen(value) - 1)
+				tst_resm(TWARN|TERRNO, "write");
+	}
+	if (fd != -1)
+		close(fd);
+	if (fp != NULL)
+		fclose(fp);
+	if (rmdir(CPATH_NEW) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir");
+	if (umount(CPATH) == -1)
+		tst_resm(TWARN|TERRNO, "umount");
+	if (rmdir(CPATH) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir");
+
+	/*
+	 * remove the tmp directory and exit
+	 */
+	TEST_CLEANUP;
+	tst_rmdir();
+	tst_exit();
+}
+
+void sighandler(UNUSED int signo)
+{
+	end = 1;
+}
+
+int mem_hog(void)
+{
+	long pagesize;
+	unsigned long *addr;
+	int ret = 0;
+
+	pagesize = getpagesize();
+	while (!end) {
+		addr = mmap(NULL, pagesize * 10, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		if (addr == MAP_FAILED) {
+			ret = 1;
+			tst_resm(TFAIL|TERRNO, "mmap");
+			break;
+		}
+		memset(addr, 0xF7, pagesize * 10);
+		munmap(addr, pagesize * 10);
+	}
+	return ret;
+}
+
+int mem_hog_cpuset(int ntasks)
+{
+	int i, pid, status, ret = 0;
+	struct sigaction sa;
+
+	if (ntasks <= 0) {
+		tst_resm(TBROK|TERRNO, "ntasks is small.");
+		return 1;
+	}
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) < 0) {
+		tst_resm(TBROK|TERRNO, "sigemptyset");
+		return 1;
+	}
+	sa.sa_flags = 0;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0) {
+		tst_resm(TBROK|TERRNO, "sigaction");
+		return 1;
+	}
+	for (i = 0; i < ntasks; i++) {
+		switch (pid = fork()) {
+		case -1:
+			tst_resm(TFAIL|TERRNO, "fork");
+			ret = 1;
+			break;
+		case 0:
+			ret = mem_hog();
+			exit(ret);
+		default:
+			if (kill(pid, SIGUSR1) == -1) {
+				tst_resm(TINFO|TERRNO, "kill");
+				ret = 1;
+			}
+			break;
+		}
+	}
+	while (waitpid(-1, &status, WUNTRACED | WCONTINUED) > 0) {
+		if (WEXITSTATUS(status) != 0)
+			ret = 1;
+	}
+	return ret;
+}
+
+long count_numa(void)
+{
+	int nnodes = 0;
+
+	while(path_exist(_PATH_SYS_SYSTEM "/node/node%d", nnodes))
+		nnodes++;
+
+	return nnodes;
+}
+
+long count_cpu(void)
+{
+	int ncpus = 0;
+
+	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	return ncpus;
+}
+
+static int path_exist(const char *path, ...)
+{
+	va_list ap;
+	char pathbuf[PATH_MAX];
+
+	va_start(ap, path);
+	vsnprintf(pathbuf, sizeof(pathbuf), path, ap);
+	va_end(ap);
+
+	return access(pathbuf, F_OK) == 0;
+}
-- 
1.7.1


------=_Part_13136_575284346.1290480577278
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
------=_Part_13136_575284346.1290480577278
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_13136_575284346.1290480577278--

