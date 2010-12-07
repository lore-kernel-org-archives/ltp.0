Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PPs1I-0005i9-LF
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:31:28 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PPs1G-00014i-2B
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:31:28 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB77VKsO030769
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 02:31:20 -0500
Date: Tue, 7 Dec 2010 02:31:20 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <581834084.253251291707080238.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2097609633.253231291707076583.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17384_1750661011.1291707080237"
Subject: [LTP] [PATCH v4] Out Of Memory when changing cpuset's mems on NUMA
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

------=_Part_17384_1750661011.1291707080237
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
v4: more code cleanup
v3: fix test name and code cleanup.
v2: use LTP_ATTRIBUTE_*; merge a few functions.
---
 runtest/mm                             |    2 +
 testcases/kernel/mem/cpuset/Makefile   |   25 +++
 testcases/kernel/mem/cpuset/cpuset01.c |  334 ++++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/Makefile
 create mode 100644 testcases/kernel/mem/cpuset/cpuset01.c

diff --git a/runtest/mm b/runtest/mm
index 7abdf98..cf16c0e 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -66,3 +66,5 @@ hugemmap05 hugemmap05
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
+
+cpuset01 cpuset01 -I 3600
diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
new file mode 100644
index 0000000..822e783
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
+LDLIBS 			+= $(NUMA_LIBS) -lm
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
new file mode 100644
index 0000000..966e826
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -0,0 +1,334 @@
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
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "cpuset01";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
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
+
+#define MAXNODES		512
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		"/dev/cpuset/1"
+#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+
+static pid_t *pids;
+volatile int end;
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void testcpuset(void);
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
+static int mem_hog(void);
+static long count_numa(void);
+static long count_cpu(void);
+static int path_exist(const char *path, ...);
+static int mem_hog_cpuset(int ntasks);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	testcpuset();
+	cleanup();
+}
+
+void testcpuset(void)
+{
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
+		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+		mem_hog_cpuset(ncpus > 1 ? ncpus : 1);
+		exit(0);
+	}
+	snprintf(buf, BUFSIZ, "%s/mems", CPATH_NEW);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		if (write(fd, "0", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		if (lseek(fd, 0, SEEK_SET) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+	}
+	close(fd);
+
+	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "child exit status is %d", WEXITSTATUS(status));
+}
+
+void setup(void)
+{
+	if (count_numa() == 1)
+		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	if (mkdir(CPATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount("cpuset", CPATH, "cpuset", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount");
+	if (mkdir(CPATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+}
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
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
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
+	if (ntasks <= 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "ntasks is small.");
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "sigemptyset");
+	sa.sa_flags = 0;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "sigaction");
+
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
+		if (WEXITSTATUS(status) != 0) {
+			tst_resm(TFAIL, "child exit status is %d",
+				WEXITSTATUS(status));
+			ret = 1;
+		}
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
+
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.3.2
------=_Part_17384_1750661011.1291707080237
Content-Type: text/x-patch; name=oom-when-changing-cpuset.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=oom-when-changing-cpuset.patch

There was a problem reported upstream that the allocator may see an
empty nodemask when changing cpuset's mems.

http://lkml.org/lkml/2010/5/4/77
http://lkml.org/lkml/2010/5/4/79
http://lkml.org/lkml/2010/5/4/80

This test is based on the reproducers for the above issue.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v4: more code cleanup
v3: fix test name and code cleanup.
v2: use LTP_ATTRIBUTE_*; merge a few functions.
---
 runtest/mm                             |    2 +
 testcases/kernel/mem/cpuset/Makefile   |   25 +++
 testcases/kernel/mem/cpuset/cpuset01.c |  334 ++++++++++++++++++++++++++++++++
 3 files changed, 361 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/cpuset/Makefile
 create mode 100644 testcases/kernel/mem/cpuset/cpuset01.c

diff --git a/runtest/mm b/runtest/mm
index 7abdf98..cf16c0e 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -66,3 +66,5 @@ hugemmap05 hugemmap05
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
+
+cpuset01 cpuset01 -I 3600
diff --git a/testcases/kernel/mem/cpuset/Makefile b/testcases/kernel/mem/cpuset/Makefile
new file mode 100644
index 0000000..822e783
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
+LDLIBS 			+= $(NUMA_LIBS) -lm
diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
new file mode 100644
index 0000000..966e826
--- /dev/null
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -0,0 +1,334 @@
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
+#include "test.h"
+#include "usctest.h"
+#include "config.h"
+
+char *TCID = "cpuset01";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
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
+
+#define MAXNODES		512
+#define CPATH			"/dev/cpuset"
+#define CPATH_NEW		"/dev/cpuset/1"
+#define _PATH_SYS_SYSTEM	"/sys/devices/system"
+
+static pid_t *pids;
+volatile int end;
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void testcpuset(void);
+static void sighandler(int signo LTP_ATTRIBUTE_UNUSED);
+static int mem_hog(void);
+static long count_numa(void);
+static long count_cpu(void);
+static int path_exist(const char *path, ...);
+static int mem_hog_cpuset(int ntasks);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	setup();
+	testcpuset();
+	cleanup();
+}
+
+void testcpuset(void)
+{
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
+		if (set_mempolicy(MPOL_BIND, &nmask, MAXNODES) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "set_mempolicy");
+		mem_hog_cpuset(ncpus > 1 ? ncpus : 1);
+		exit(0);
+	}
+	snprintf(buf, BUFSIZ, "%s/mems", CPATH_NEW);
+	fd = open(buf, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		if (write(fd, "0", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+		if (lseek(fd, 0, SEEK_SET) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+		if (write(fd, "1", 1) != 1)
+			tst_brkm(TBROK|TERRNO, cleanup, "write");
+	}
+	close(fd);
+
+	if (waitpid(child, &status, WUNTRACED | WCONTINUED) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+	if (WEXITSTATUS(status) != 0)
+		tst_resm(TFAIL, "child exit status is %d", WEXITSTATUS(status));
+}
+
+void setup(void)
+{
+	if (count_numa() == 1)
+		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	if (mkdir(CPATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount("cpuset", CPATH, "cpuset", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount");
+	if (mkdir(CPATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+}
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
+	TEST_CLEANUP;
+	tst_exit();
+}
+
+void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
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
+	if (ntasks <= 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "ntasks is small.");
+	sa.sa_handler = sighandler;
+	if (sigemptyset(&sa.sa_mask) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "sigemptyset");
+	sa.sa_flags = 0;
+	if (sigaction(SIGUSR1, &sa, NULL) < 0)
+		tst_brkm(TBROK|TERRNO, cleanup, "sigaction");
+
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
+		if (WEXITSTATUS(status) != 0) {
+			tst_resm(TFAIL, "child exit status is %d",
+				WEXITSTATUS(status));
+			ret = 1;
+		}
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
+
+#else /* no NUMA */
+int main(void) {
+	tst_resm(TCONF, "no NUMA development packages installed.");
+	tst_exit();
+}
+#endif
-- 
1.7.3.2


------=_Part_17384_1750661011.1291707080237
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What happens now with your Lotus Notes apps - do you make another costly 
upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus 
Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
------=_Part_17384_1750661011.1291707080237
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_17384_1750661011.1291707080237--

