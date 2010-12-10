Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PR7cR-0001wG-OY
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:22:59 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PR7cQ-0000Bl-0C
	for ltp-list@lists.sourceforge.net; Fri, 10 Dec 2010 18:22:59 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBAIMqWh013010
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Dec 2010 13:22:52 -0500
Date: Fri, 10 Dec 2010 13:22:52 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <2094816219.760921292005372092.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <461460491.760901292005368256.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_45020_1360553499.1292005372091"
Subject: [LTP] [PATCH 3/5] oom03: test OOM for memcg
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

------=_Part_45020_1360553499.1292005372091
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom03.c |  248 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom03.c

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
new file mode 100644
index 0000000..afd0f24
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -0,0 +1,248 @@
+/*
+ * Out Of Memory (OOM) for Memory Resource Controller
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
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "oom03";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#define LENGTH		(3UL<<30)
+#define NORMAL		1
+#define MLOCK		2
+#define KSM		3
+#define PATH		"/dev/cgroup"
+#define PATH_NEW	PATH "/1"
+#define TESTMEM		(1UL<<30)
+#define MB		(1UL<<20)
+#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase, int lite);
+static void testoom(int lite);
+static void alloc_mem(long int length, int testcase);
+static void test_alloc(int testcase, int lite);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	char buf[BUFSIZ], mem[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
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
+		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes", PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(1);
+	}
+	cleanup();
+}
+
+void testoom(int lite)
+{
+	tst_resm(TINFO, "start normal OOM testing.");
+	oom(NORMAL, lite);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, lite);
+
+	tst_resm(TINFO, "start OOM testing for KSM pages.");
+	oom(KSM, lite);
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
+	if (mkdir(PATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount("memcg", PATH, "cgroup", 0, "memory") == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", PATH);
+	if (mkdir(PATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", PATH_NEW);
+}
+
+void cleanup(void)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	/* Move all processes in task to its parent memcg node. */
+	snprintf(s, BUFSIZ, "%s/tasks", PATH);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+	snprintf(s_new, BUFSIZ, "%s/tasks", PATH_NEW);
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
+	if (rmdir(PATH_NEW) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", PATH_NEW);
+	if (umount(PATH) == -1)
+		tst_resm(TWARN|TERRNO, "umount %s", PATH);
+	if (rmdir(PATH) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", PATH);
+	
+	TEST_CLEANUP;
+	tst_exit();
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
+void oom(int testcase, int lite)
+{
+	pid_t pid;
+	int status;
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
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
-- 
1.7.3.2
------=_Part_45020_1360553499.1292005372091
Content-Type: text/x-patch; name=0003-oom03-test-OOM-for-memcg.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=0003-oom03-test-OOM-for-memcg.patch

From: CAI Qian <caiqian@redhat.com>
Date: Sat, 11 Dec 2010 02:09:33 +0800
Subject: [PATCH 3/5] oom03: test OOM for memcg

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom03.c |  248 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 248 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom03.c

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
new file mode 100644
index 0000000..afd0f24
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -0,0 +1,248 @@
+/*
+ * Out Of Memory (OOM) for Memory Resource Controller
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
+#include <sys/mount.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <signal.h>
+#include <unistd.h>
+#include "test.h"
+#include "usctest.h"
+
+char *TCID = "oom03";
+int TST_TOTAL = 1;
+extern int Tst_count;
+
+#define LENGTH		(3UL<<30)
+#define NORMAL		1
+#define MLOCK		2
+#define KSM		3
+#define PATH		"/dev/cgroup"
+#define PATH_NEW	PATH "/1"
+#define TESTMEM		(1UL<<30)
+#define MB		(1UL<<20)
+#define SYSFS_OVER	"/proc/sys/vm/overcommit_memory"
+
+static char overcommit[BUFSIZ];
+
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void oom(int testcase, int lite);
+static void testoom(int lite);
+static void alloc_mem(long int length, int testcase);
+static void test_alloc(int testcase, int lite);
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc, fd;
+	char buf[BUFSIZ], mem[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != (char *)NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
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
+		snprintf(buf, BUFSIZ, "%s/memory.limit_in_bytes", PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		sprintf(mem, "%ld", TESTMEM);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+
+		snprintf(buf, BUFSIZ, "%s/tasks", PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		snprintf(buf, BUFSIZ, "%d", getpid());
+		if (write(fd, buf, strlen(buf)) != strlen(buf))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(0);
+
+		snprintf(buf, BUFSIZ, "%s/memory.memsw.limit_in_bytes",
+			PATH_NEW);
+		fd = open(buf, O_WRONLY);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		if (write(fd, mem, strlen(mem)) != strlen(mem))
+			tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
+		close(fd);
+		testoom(1);
+	}
+	cleanup();
+}
+
+void testoom(int lite)
+{
+	tst_resm(TINFO, "start normal OOM testing.");
+	oom(NORMAL, lite);
+
+	tst_resm(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, lite);
+
+	tst_resm(TINFO, "start OOM testing for KSM pages.");
+	oom(KSM, lite);
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
+	if (mkdir(PATH, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount("memcg", PATH, "cgroup", 0, "memory") == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount %s", PATH);
+	if (mkdir(PATH_NEW, 0777) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir %s", PATH_NEW);
+}
+
+void cleanup(void)
+{
+	FILE *fp;
+	int fd;
+	char s_new[BUFSIZ], s[BUFSIZ], value[BUFSIZ];
+
+	fd = open(SYSFS_OVER, O_WRONLY);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	if (write(fd, &overcommit, 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	close(fd);
+
+	/* Move all processes in task to its parent memcg node. */
+	snprintf(s, BUFSIZ, "%s/tasks", PATH);
+	fd = open(s, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open %s", s);
+	snprintf(s_new, BUFSIZ, "%s/tasks", PATH_NEW);
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
+	if (rmdir(PATH_NEW) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", PATH_NEW);
+	if (umount(PATH) == -1)
+		tst_resm(TWARN|TERRNO, "umount %s", PATH);
+	if (rmdir(PATH) == -1)
+		tst_resm(TWARN|TERRNO, "rmdir %s", PATH);
+	
+	TEST_CLEANUP;
+	tst_exit();
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
+void oom(int testcase, int lite)
+{
+	pid_t pid;
+	int status;
+
+	switch(pid = fork()) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+	case 0:
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
-- 
1.7.3.2


------=_Part_45020_1360553499.1292005372091
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_45020_1360553499.1292005372091
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_45020_1360553499.1292005372091--

