Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PX4tc-0000zC-3B
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:41:20 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PX4ta-0007bn-8V
	for ltp-list@lists.sourceforge.net; Mon, 27 Dec 2010 04:41:20 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBR4fCIE002445
	for <ltp-list@lists.sourceforge.net>; Sun, 26 Dec 2010 23:41:12 -0500
Date: Sun, 26 Dec 2010 23:41:04 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1509621163.85163.1293424864766.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1705393043.85161.1293424700778.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/5] oom01: test OOM
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

The previous version of this can be dropped.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v3: use common functions.
v2: code cleanup and skip 32-bit since there is no guarantee of running out of
    virtual memory address space there.

 testcases/kernel/mem/oom/Makefile     |   42 +++++++
 testcases/kernel/mem/oom/lib/Makefile |   25 ++++
 testcases/kernel/mem/oom/lib/oom.c    |  205 +++++++++++++++++++++++++++++++++
 testcases/kernel/mem/oom/lib/oom.h    |   30 +++++
 testcases/kernel/mem/oom/oom01.c      |  126 ++++++++++++++++++++
 5 files changed, 428 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/Makefile
 create mode 100644 testcases/kernel/mem/oom/lib/Makefile
 create mode 100644 testcases/kernel/mem/oom/lib/oom.c
 create mode 100644 testcases/kernel/mem/oom/lib/oom.h
 create mode 100644 testcases/kernel/mem/oom/oom01.c

diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
new file mode 100644
index 0000000..cfce410
--- /dev/null
+++ b/testcases/kernel/mem/oom/Makefile
@@ -0,0 +1,42 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
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
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LDLIBS			+= $(NUMA_LIBS) -loom
+LIBDIR			:= lib
+LIB			:= $(LIBDIR)/liboom.a
+FILTER_OUT_DIRS		:= $(LIBDIR)
+
+$(LIBDIR):
+	mkdir -p "$@"
+
+$(LIB): $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" all
+
+MAKE_DEPS		:= $(LIB)
+
+trunk-clean:: | lib-clean
+
+lib-clean:: $(LIBDIR)
+	$(MAKE) -C $^ -f "$(abs_srcdir)/$^/Makefile" clean
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
+include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/mem/oom/lib/Makefile b/testcases/kernel/mem/oom/lib/Makefile
new file mode 100644
index 0000000..6e2f83e
--- /dev/null
+++ b/testcases/kernel/mem/oom/lib/Makefile
@@ -0,0 +1,25 @@
+#
+#  Copyright (C) 2010  Red Hat, Inc.
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
+top_srcdir              ?= ../../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+LIB			:= liboom.a
+
+include $(top_srcdir)/include/mk/lib.mk
\ No newline at end of file
diff --git a/testcases/kernel/mem/oom/lib/oom.c b/testcases/kernel/mem/oom/lib/oom.c
new file mode 100644
index 0000000..0c44959
--- /dev/null
+++ b/testcases/kernel/mem/oom/lib/oom.c
@@ -0,0 +1,205 @@
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/stat.h>
+#include <sys/mount.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <string.h>
+#include <numaif.h>
+#include <stdarg.h>
+#include "test.h"
+#include "usctest.h"
+#include "oom.h"
+
+void oom(int testcase, int mempolicy, int lite)
+{
+	pid_t pid;
+	int status;
+	unsigned long nmask = 2;
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
+		if (mempolicy)
+			if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"set_mempolicy");
+		test_alloc(testcase, lite);
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+	if (testcase == OVERCOMMIT) {
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	} else {
+		if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+			tst_resm(TFAIL, "the victim unexpectedly failed: %d",
+				status);
+	}
+}
+
+void testoom(int mempolicy, int lite)
+{
+	int fd;
+	char buf[BUFSIZ] = "";
+	char cpus[BUFSIZ] = "";
+
+	if (!mempolicy) {
+		gather_cpus(cpus);
+		tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
+
+		fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		fd = open(CPATH_NEW "/tasks", O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+	}
+	tst_resm(TINFO, "start normal OOM testing.");
+	oom(NORMAL, mempolicy, lite);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, mempolicy, lite);
+
+	tst_resm(TINFO, "start OOM testing for KSM pages.");
+	oom(KSM, mempolicy, lite);
+}
+
+long count_numa(void)
+{
+	int nnodes = 0;
+
+	while(path_exist(PATH_SYS_SYSTEM "/node/node%d", nnodes))
+		nnodes++;
+
+	return nnodes;
+}
+
+int path_exist(const char *path, ...)
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
+
+void gather_cpus(char *cpus)
+{
+	int ncpus = 0;
+	int i;
+	char buf[BUFSIZ];
+
+	while(path_exist(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++)
+		if (path_exist(PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
+			sprintf(buf, "%d,", i);
+			strcat(cpus, buf);
+		}
+	/* Remove the trailing comma. */
+	cpus[strlen(cpus) - 1] = '\0';
+}
+
+void alloc_mem(long int length, int testcase)
+{
+	void *s;
+
+	tst_resm(TINFO, "allocating %ld bytes.", length);
+	s = mmap(NULL, length, PROT_READ|PROT_WRITE,
+		MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (s == MAP_FAILED) {
+		if (testcase == OVERCOMMIT && errno == ENOMEM)
+			return;
+		else
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	}
+	if (testcase == MLOCK && mlock(s, length) == -1)
+		tst_brkm(TINFO|TERRNO, cleanup, "mlock");
+	if (testcase == KSM
+		&& madvise(s, length, MADV_MERGEABLE) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+	memset(s, '\a', length);
+}
+
+void test_alloc(int testcase, int lite)
+{
+	if (lite)
+		alloc_mem(TESTMEM + MB, testcase);
+	else
+		while(1)
+			alloc_mem(LENGTH, testcase);
+}
+
+void umount_mem(char *path, char *path_new)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	/* Move all processes in task to its parent node. */
+	sprintf(s, "%s/tasks", path);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+
+	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
+	fp = fopen(s_new, "r");
+	if (fp == NULL)
+		tst_resm(TWARN|TERRNO, "fopen %s", s_new);
+	if ((fd != -1) && (fp != NULL)) {
+		while (fgets(value, BUFSIZ, fp) != NULL)
+			if (write(fd, value, strlen(value) - 1)
+				!= strlen(value) - 1)
+				tst_resm(TWARN|TERRNO, "write %s", s);
+	}
+	if (fd != -1)
+		close(fd);
+	if (fp != NULL)
+		fclose(fp);
+	if (rmdir(path_new) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", path_new);
+	if (umount(path) == -1)
+		tst_resm(TWARN|TERRNO, "umount %s", path);
+	if (rmdir(path) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", path);
+}
+
+void mount_mem(char *name, char *fs, char *options, char *path, char *path_new)
+{
+	if (mkdir(path, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", path);
+	if (mount(name, path, fs, 0, options) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", path);
+	if (mkdir(path_new, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", path_new);
+}
diff --git a/testcases/kernel/mem/oom/lib/oom.h b/testcases/kernel/mem/oom/lib/oom.h
new file mode 100644
index 0000000..d40bc89
--- /dev/null
+++ b/testcases/kernel/mem/oom/lib/oom.h
@@ -0,0 +1,30 @@
+#include "test.h"
+#include "usctest.h"
+
+#define LENGTH			(3UL<<30)
+#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
+#define OVERCOMMIT		1
+#define NORMAL			2
+#define MLOCK			3
+#define KSM			4
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		CPATH "/1"
+#define MAXNODES		512
+#define MEMCG_PATH		"/dev/cgroup"
+#define MEMCG_PATH_NEW		MEMCG_PATH "/1"
+#define TESTMEM			(1UL<<30)
+#define MB			(1UL<<20)
+#define PATH_SYS_SYSTEM		"/sys/devices/system"
+
+char overcommit[BUFSIZ];
+
+void oom(int testcase, int mempolicy, int lite);
+void testoom(int mempolicy, int lite);
+long count_numa(void);
+int path_exist(const char *path, ...);
+void alloc_mem(long int length, int testcase);
+void test_alloc(int testcase, int lite);
+void gather_cpus(char *cpus);
+void umount_mem(char *path, char *path_new);
+void mount_mem(char *name, char *fs, char *options, char *path, char *path_new);
+void cleanup(void) LTP_ATTRIBUTE_NORETURN;
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
new file mode 100644
index 0000000..0076ada
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -0,0 +1,126 @@
+/*
+ * Out Of Memory (OOM)
+ *
+ * The program is designed to cope with unpredictable like amount and
+ * system physical memory, swap size and other VMM technology like KSM,
+ * memcg, memory hotplug and so on which may affect the OOM
+ * behaviours. It simply increase the memory consumption 3G each time
+ * until all the available memory is consumed and OOM is triggered.
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
+#include <asm/types.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+#include "lib/oom.h"
+
+char *TCID = "oom01";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+static void setup(void);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+#ifdef __i386__
+	tst_brkm(TCONF, tst_exit,
+		"this test is not designed for 32-bit system.");
+#endif /* __i386__ */
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		tst_resm(TINFO, "start testing overcommit_memory=2.");
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "2", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(OVERCOMMIT, 0, 0);
+
+		tst_resm(TINFO, "start testing overcommit_memory=0.");
+		if (lseek(fd, SEEK_SET, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "0", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(OVERCOMMIT, 0, 0);
+
+		tst_resm(TINFO, "start normal OOM testing.");
+		if (lseek(fd, SEEK_SET, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		oom(NORMAL, 0, 0);
+
+		tst_resm(TINFO, "start OOM testing for mlocked pages.");
+		oom(MLOCK, 0, 0);
+
+		tst_resm(TINFO, "start OOM testing for KSM pages.");
+		oom(KSM, 0, 0);
+	}
+	cleanup();
+}
+
+void setup(void)
+{
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	fd = open(SYSFS_OVER, O_RDONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (read(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "read");
+	close(fd);
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
-- 
1.7.3.2

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
