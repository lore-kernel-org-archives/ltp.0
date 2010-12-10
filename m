Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PR7dM-00065U-0D
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:23:56 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PR7dK-0000NH-2Q
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:23:55 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBAINm31009167
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Dec 2010 13:23:48 -0500
Date: Fri, 10 Dec 2010 13:23:48 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <984095300.761011292005428524.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1898328172.760991292005424122.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_45026_1086897126.1292005428522"
Subject: [LTP] [PATCH 4/5] oom04: test OOM for NUMA with memcg
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

------=_Part_45026_1086897126.1292005428522
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom04.c |  394 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 394 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom04.c

diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
new file mode 100644
index 0000000..7d35b67
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -0,0 +1,394 @@
+/*
+ * Out Of Memory (OOM) for Memory Resource Controller and NUMA
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
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "oom04";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <numaif.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdarg.h>
+
+#define MAXNODES		512
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		CPATH "/1"
+#define MEMCG_PATH		"/dev/cgroup"
+#define MEMCG_PATH_NEW		MEMCG_PATH "/1"
+#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+#define LENGTH			(3UL<<30)
+#define TESTMEM			(1UL<<30)
+#define MB			(1UL<<20)
+#define NORMAL			1
+#define MLOCK			2
+#define KSM			3
+#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase, int mempolicy, int lite);
+static long count_numa(void);
+static int path_exist(const char *path, ...);
+static void testoom(int mempolicy, int lite);
+static void alloc_mem(long int length, int testcase);
+static void test_alloc(int testcase, int lite);
+static void gather_cpus(char *cpus);
+static void umount_mem(char *path, char *path_new);
+static void mount_mem(char *name, char *fs, char *options, char *path,
+		char *path_new);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	unsigned long nnodes = 1;
+	char buf[BUFSIZ], mem[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	nnodes = count_numa();
+	if (count_numa() == 1)
+		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		tst_resm(TINFO, "process mempolicy.");
+		testoom(1, 0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(1, 1);
+
+		tst_resm(TINFO, "process cpuset.");
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, "-1", 2) != 2)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0, 0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0, 1);
+	}
+	cleanup();
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
+		snprintf(buf, BUFSIZ, "%s/cpuset.mems", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/cpuset.cpus", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
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
+
+	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+}
+
+void umount_mem(char *path, char *path_new)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	/* Move all processes in task to its parent node. */
+	snprintf(s, BUFSIZ, "%s/tasks", path);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
+
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
+	umount_mem(CPATH, CPATH_NEW);
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
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
+
+		test_alloc(testcase, lite);
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
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
+	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++)
+		if (path_exist(_PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
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
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.3.2
------=_Part_45026_1086897126.1292005428522
Content-Type: text/x-patch; name=0004-oom04-test-OOM-for-NUMA-with-memcg.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0004-oom04-test-OOM-for-NUMA-with-memcg.patch

From: CAI Qian <caiqian@redhat.com>
Date: Sat, 11 Dec 2010 02:10:14 +0800
Subject: [PATCH 4/5] oom04: test OOM for NUMA with memcg

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom04.c |  394 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 394 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom04.c

diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
new file mode 100644
index 0000000..7d35b67
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -0,0 +1,394 @@
+/*
+ * Out Of Memory (OOM) for Memory Resource Controller and NUMA
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
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "oom04";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <sys/mount.h>
+#include <numaif.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include <stdarg.h>
+
+#define MAXNODES		512
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		CPATH "/1"
+#define MEMCG_PATH		"/dev/cgroup"
+#define MEMCG_PATH_NEW		MEMCG_PATH "/1"
+#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+#define LENGTH			(3UL<<30)
+#define TESTMEM			(1UL<<30)
+#define MB			(1UL<<20)
+#define NORMAL			1
+#define MLOCK			2
+#define KSM			3
+#define SYSFS_OVER		"/proc/sys/vm/overcommit_memory"
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase, int mempolicy, int lite);
+static long count_numa(void);
+static int path_exist(const char *path, ...);
+static void testoom(int mempolicy, int lite);
+static void alloc_mem(long int length, int testcase);
+static void test_alloc(int testcase, int lite);
+static void gather_cpus(char *cpus);
+static void umount_mem(char *path, char *path_new);
+static void mount_mem(char *name, char *fs, char *options, char *path,
+		char *path_new);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	unsigned long nnodes = 1;
+	char buf[BUFSIZ], mem[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+
+	nnodes = count_numa();
+	if (count_numa() == 1)
+		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		fd = open(SYSFS_OVER, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		tst_resm(TINFO, "process mempolicy.");
+		testoom(1, 0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(1, 1);
+
+		tst_resm(TINFO, "process cpuset.");
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, "-1", 2) != 2)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0, 0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			MEMCG_PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0, 1);
+	}
+	cleanup();
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
+		snprintf(buf, BUFSIZ, "%s/cpuset.mems", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/cpuset.cpus", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", CPATH_NEW);
+		fd = open(buf, O_WRONLY);
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
+
+	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+}
+
+void umount_mem(char *path, char *path_new)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	/* Move all processes in task to its parent node. */
+	snprintf(s, BUFSIZ, "%s/tasks", path);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+	snprintf(s_new, BUFSIZ, "%s/tasks", path_new);
+
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
+	umount_mem(CPATH, CPATH_NEW);
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
+
+	TEST_CLEANUP;
+	tst_exit();
+}
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
+
+		test_alloc(testcase, lite);
+		exit(0);
+	default:
+		break;
+	}
+	tst_resm(TINFO, "expected victim is %d.", pid);
+	if (waitpid(-1, &status, 0) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+
+	if (!WIFSIGNALED(status) || WTERMSIG(status) != SIGKILL)
+		tst_resm(TFAIL, "the victim unexpectedly failed: %d", status);
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
+	while(path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
+		ncpus++;
+
+	for (i = 0; i < ncpus; i++)
+		if (path_exist(_PATH_SYS_SYSTEM "/node/node1/cpu%d", i)) {
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
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.3.2


------=_Part_45026_1086897126.1292005428522
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_45026_1086897126.1292005428522
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_45026_1086897126.1292005428522--

