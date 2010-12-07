Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PPs0D-0005dK-BH
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:30:21 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PPs0B-0007oj-KJ
	for ltp-list@lists.sourceforge.net; Tue, 07 Dec 2010 07:30:21 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oB77UEej029570
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Dec 2010 02:30:14 -0500
Date: Tue, 7 Dec 2010 02:30:14 -0500 (EST)
From: caiqian@redhat.com
Message-ID: <672887900.253121291707014153.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1108110757.253081291707011009.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_17380_1859650734.1291707014153"
Subject: [LTP] [PATCH v6] overcommit libhugetlbfs and check the statistics
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

------=_Part_17380_1859650734.1291707014153
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

libhugetlbfs allows to overcommit hugepages and there are tunables in
sysfs and procfs. The test here want to ensure it is possible to
overcommit by either mmap or shared memory. Also ensure those
reservation can be read/write, and several statistics work correctly.

First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
both to a specify value - N, and allocate N + %50 x N hugepages.
Finally, it reads and writes every page. There are command options to
choose either to manage hugepages from sysfs or procfs, and reserve them
by mmap or shmget.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v6: more code cleanup
v5: code cleanup
v4: cleanup from Garrett's feedback.
v3: fix -a option description; fix a nasty bug with tst_exit which skips
    cleanup at the end of the test; add more information to assist test
    debug.
v2: add more explanation and a command-line option to specify memory
    allocation size.
---
 runtest/mm                                         |    5 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |  451 ++++++++++++++++++++
 2 files changed, 456 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c

diff --git a/runtest/mm b/runtest/mm
index 8c65aeb..7abdf98 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -61,3 +61,8 @@ mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -c 60
 
 ksm01 ksm01
+
+hugemmap05 hugemmap05
+hugemmap05_1 hugemmap05 -m
+hugemmap05_2 hugemmap05 -s
+hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
new file mode 100644
index 0000000..bce9fe6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -0,0 +1,451 @@
+/*
+ * overcommit libhugetlbfs and check the statistics.
+ *
+ * libhugetlbfs allows to overcommit hugepages and there are tunables in
+ * sysfs and procfs. The test here want to ensure it is possible to
+ * overcommit by either mmap or shared memory. Also ensure those
+ * reservation can be read/write, and several statistics work correctly.
+ *
+ * First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
+ * both to a specify value - N, and allocate N + %50 x N hugepages.
+ * Finally, it reads and writes every page. There are command options to
+ * choose either to manage hugepages from sysfs or procfs, and reserve
+ * them by mmap or shmget.
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
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/shm.h>
+#include <sys/ipc.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <ctype.h>
+#include "test.h"
+#include "usctest.h"
+
+#define PROTECTION		(PROT_READ | PROT_WRITE)
+#define _PATH_MEMINFO		"/proc/meminfo"
+#define _PATH_SYS_HUGE		"/sys/kernel/mm/hugepages"
+#define _PATH_SYS_2M		_PATH_SYS_HUGE "/hugepages-2048kB/"
+#define _PATH_SYS_2M_OVER	_PATH_SYS_2M "nr_overcommit_hugepages"
+#define _PATH_SYS_2M_FREE	_PATH_SYS_2M "free_hugepages"
+#define _PATH_SYS_2M_RESV	_PATH_SYS_2M "resv_hugepages"
+#define _PATH_SYS_2M_SURP	_PATH_SYS_2M "surplus_hugepages"
+#define _PATH_SYS_2M_HUGE	_PATH_SYS_2M "nr_hugepages"
+#define _PATH_PROC_VM		"/proc/sys/vm/"
+#define _PATH_PROC_OVER		_PATH_PROC_VM "nr_overcommit_hugepages"
+#define _PATH_PROC_HUGE		_PATH_PROC_VM "nr_hugepages"
+#define _PATH_SHMMAX		"/proc/sys/kernel/shmmax"
+#define MB			(1024 * 1024)
+
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define ADDR (void *)(0x8000000000000000UL)
+#define FLAGS (MAP_SHARED | MAP_FIXED)
+#define SHMAT_FLAGS (SHM_RND)
+#else
+#define ADDR (void *)(0x0UL)
+#define FLAGS (MAP_SHARED)
+#define SHMAT_FLAGS (0)
+#endif
+
+#ifndef SHM_HUGETLB
+#define SHM_HUGETLB 04000
+#endif
+
+char *TCID = "hugemmap05";
+char *TESTDIR;
+int TST_TOTAL = 1, Tst_count;
+static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
+static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
+static char shmmax[BUFSIZ];
+static char *opt_allocstr;
+static int opt_sysfs, opt_alloc;
+static int shmid = -1;
+static int restore_shmmax = 0;
+static size_t size = 128, length = 384;
+static option_t options[] = {
+	{ "s", &opt_sysfs,	NULL},
+	{ "m", &shmid,		NULL},
+	{ "a:", &opt_alloc,	&opt_allocstr},
+	{ NULL, NULL,		NULL}
+};
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void overcommit(void);
+static void write_bytes(void *addr);
+static void read_bytes(void *addr);
+static int lookup (char *line, char *pattern);
+static void usage(void);
+static int checkproc(FILE *fp, char *string, int value);
+static int checksys(char *path, char *pattern, int value);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	if (opt_sysfs) {
+		strncpy(path, _PATH_SYS_2M_HUGE,
+			strlen(_PATH_SYS_2M_HUGE) + 1);
+		strncpy(pathover, _PATH_SYS_2M_OVER,
+			strlen(_PATH_SYS_2M_OVER) + 1);
+	} else {
+		strncpy(path, _PATH_PROC_HUGE,
+			strlen(_PATH_PROC_HUGE) + 1);
+		strncpy(pathover, _PATH_PROC_OVER,
+			strlen(_PATH_PROC_OVER) + 1);
+	}
+	if (opt_alloc) {
+		size = atoi(opt_allocstr);
+		length = (int)(size + size * 0.5) * 2;
+	}
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		overcommit();
+	}	
+	cleanup();
+}
+
+static void overcommit(void)
+{
+	void *addr = NULL, *shmaddr = NULL;
+	int fd = -1, key = -1;
+	char s[BUFSIZ];
+	FILE *fp;
+
+	if (shmid != -1) {
+		/* Use /proc/meminfo to generate an IPC key. */
+		key = ftok(_PATH_MEMINFO, strlen(_PATH_MEMINFO));
+		if (key == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "ftok");
+		shmid = shmget(key, (long)(length * MB),
+			SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
+		if (shmid == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmget");
+	} else {
+		snprintf(s, BUFSIZ, "%s/hugemmap05/file", TESTDIR);
+		fd = open(s, O_CREAT | O_RDWR, 0755);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		addr = mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
+			0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	}
+
+	if (opt_sysfs) {
+		tst_resm(TINFO, "check sysfs before allocation.");
+		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+				length / 2) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free",
+				length / 2) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+				length / 2 - size) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd",
+				length / 2) != 0)
+			return;
+	} else {
+		tst_resm(TINFO,
+			"check /proc/meminfo before allocation.");
+		fp = fopen(_PATH_MEMINFO, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Free", length / 2 ) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Surp", length / 2 - size)
+			!= 0)
+			return;
+		if (checkproc(fp, "HugePages_Rsvd", length / 2) != 0)
+			return;
+		fclose(fp);
+	}
+	if (shmid != -1) {
+		tst_resm(TINFO, "shmid: 0x%x", shmid);
+		shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+		if (shmaddr == (void *)-1)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmat");
+		write_bytes(shmaddr);
+		read_bytes(shmaddr);
+        } else {
+		write_bytes(addr);
+		read_bytes(addr);
+	}
+	if (opt_sysfs) {
+		tst_resm(TINFO, "check sysfs.");
+		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+				length / 2) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free", 0)
+			!= 0)
+			return;
+		if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+				length / 2 - size) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
+			!= 0)
+			return;
+	} else {
+		tst_resm(TINFO, "check /proc/meminfo.");
+		fp = fopen(_PATH_MEMINFO, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Free", 0) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Surp", length / 2 - size)
+			!= 0)
+			return;
+		if (checkproc(fp, "HugePages_Rsvd", 0) != 0)
+			return;
+		fclose(fp);
+	}
+	if (shmid != -1) {
+		if (shmdt(shmaddr) != 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
+	} else {
+		munmap(addr, (long)(length * MB));
+		close(fd);
+		unlink(s);
+	}
+}
+
+static void cleanup(void)
+{
+	int fd;
+
+	TEST_CLEANUP;
+	if (restore_shmmax) {
+		fd = open(_PATH_SHMMAX, O_WRONLY);
+		if (fd == -1)
+			tst_resm(TWARN|TERRNO, "open");
+		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
+			tst_resm(TWARN|TERRNO, "write");
+		close(fd);
+	}
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
+	if (write(fd, nr_hugepages,
+			strlen(nr_hugepages)) != strlen(nr_hugepages))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+
+	fd = open(pathover, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
+		nr_overcommit_hugepages);
+	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
+		!= strlen(nr_overcommit_hugepages))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+	
+	snprintf(buf, BUFSIZ, "%s/hugemmap05", TESTDIR);
+	if (umount(buf) == -1)
+		tst_resm(TWARN|TERRNO, "umount");
+	if (shmid != -1) {
+		tst_resm(TINFO|TERRNO, "shmdt");
+		shmctl(shmid, IPC_RMID, NULL);
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	FILE *fp;
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	if (shmid != -1) {
+		fp = fopen(_PATH_SHMMAX, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (fgets(shmmax, BUFSIZ, fp) == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+		fclose(fp);
+
+		if (atol(shmmax) < (long)(length * MB)) {
+			restore_shmmax = 1;
+			fd = open(_PATH_SHMMAX, O_RDWR);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open");
+			snprintf(buf, BUFSIZ, "%ld", (long)(length * MB));
+			if (write(fd, buf, strlen(buf)) != strlen(buf))
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"failed to change shmmax.");
+		}
+	}
+	fp = fopen(path, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(nr_hugepages, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+	/* Remove trialing newline. */
+	nr_hugepages[strlen(nr_hugepages) - 1] = '\0';
+	tst_resm(TINFO, "original nr_hugepages is %s", nr_hugepages);
+
+	fd = open(path, O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	/* Reset. */
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	snprintf(buf, BUFSIZ, "%ld", size);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup,
+			"failed to change nr_hugepages.");
+	close(fd);
+
+	fp = fopen(pathover, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(nr_overcommit_hugepages, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+	nr_overcommit_hugepages[strlen(nr_overcommit_hugepages) - 1] = '\0';
+	tst_resm(TINFO, "original nr_overcommit_hugepages is %s",
+		nr_overcommit_hugepages);
+
+	fd = open(pathover, O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	/* Reset. */
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	snprintf(buf, BUFSIZ, "%ld", size);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup,
+			"failed to change nr_hugepages.");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s/hugemmap05", TESTDIR);
+	if (mkdir(buf, 0700) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount");
+}
+
+static void write_bytes(void *addr)
+{
+	long i;
+
+	for (i = 0; i < (long)(length * MB); i++)
+		((char *)addr)[i] = '\a';
+}
+
+static void read_bytes(void *addr)
+{
+	long i;
+
+	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
+	for (i = 0; i < (long)(length * MB); i++) {
+		if (((char *)addr)[i] != '\a') {
+			tst_resm(TFAIL, "mismatch at %ld", i);
+			break;
+		}
+	}
+}
+
+/* Lookup a pattern and get the value from file*/
+static int lookup (char *line, char *pattern)
+{
+	char buf2[BUFSIZ];
+
+	/* empty line */
+	if (line[0] == '\0')
+		return 0;
+
+	snprintf(buf2, BUFSIZ, "%s: %%s", pattern);
+	if (sscanf(line, buf2, buf) != 1)
+		return 0;
+
+	return 1;
+}
+
+static void usage(void)
+{
+	printf("  -s      Setup hugepages from sysfs\n");
+	printf("  -m      Reserve hugepages by shmget\n");
+	printf("  -a      Number of overcommint hugepages\n");
+}
+
+static int checksys(char *path, char *string, int value)
+{
+	FILE *fp;
+
+	fp = fopen(path, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(buf, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	tst_resm(TINFO, "%s is %d.", string, atoi(buf));
+	if (atoi(buf) != value) {
+		tst_resm(TFAIL, "%s is not %d but %d.", string, value,
+			atoi(buf));
+		return 1;
+	}
+	fclose(fp);
+	return 0;
+}
+
+static int checkproc(FILE *fp, char *pattern, int value)
+{
+	memset(buf, -1, BUFSIZ);
+	rewind(fp);
+	while (fgets(line, BUFSIZ, fp) != NULL)
+		if (lookup(line, pattern))
+			break;
+
+	tst_resm(TINFO, "%s is %d.", pattern, atoi(buf));
+	if (atoi(buf) != value) {
+		tst_resm(TFAIL, "%s is not %d but %d.", pattern, value,
+			atoi(buf));
+		return 1;
+	}
+	return 0;
+}
-- 
1.7.3.2
------=_Part_17380_1859650734.1291707014153
Content-Type: text/x-patch; name=overcommit-libhugetlbfs-and-stat.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=overcommit-libhugetlbfs-and-stat.patch

libhugetlbfs allows to overcommit hugepages and there are tunables in
sysfs and procfs. The test here want to ensure it is possible to
overcommit by either mmap or shared memory. Also ensure those
reservation can be read/write, and several statistics work correctly.

First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
both to a specify value - N, and allocate N + %50 x N hugepages.
Finally, it reads and writes every page. There are command options to
choose either to manage hugepages from sysfs or procfs, and reserve them
by mmap or shmget.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
v6: more code cleanup
v5: code cleanup
v4: cleanup from Garrett's feedback.
v3: fix -a option description; fix a nasty bug with tst_exit which skips
    cleanup at the end of the test; add more information to assist test
    debug.
v2: add more explanation and a command-line option to specify memory
    allocation size.
---
 runtest/mm                                         |    5 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |  451 ++++++++++++++++++++
 2 files changed, 456 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c

diff --git a/runtest/mm b/runtest/mm
index 8c65aeb..7abdf98 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -61,3 +61,8 @@ mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -c 60
 
 ksm01 ksm01
+
+hugemmap05 hugemmap05
+hugemmap05_1 hugemmap05 -m
+hugemmap05_2 hugemmap05 -s
+hugemmap05_3 hugemmap05 -s -m
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
new file mode 100644
index 0000000..bce9fe6
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -0,0 +1,451 @@
+/*
+ * overcommit libhugetlbfs and check the statistics.
+ *
+ * libhugetlbfs allows to overcommit hugepages and there are tunables in
+ * sysfs and procfs. The test here want to ensure it is possible to
+ * overcommit by either mmap or shared memory. Also ensure those
+ * reservation can be read/write, and several statistics work correctly.
+ *
+ * First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
+ * both to a specify value - N, and allocate N + %50 x N hugepages.
+ * Finally, it reads and writes every page. There are command options to
+ * choose either to manage hugepages from sysfs or procfs, and reserve
+ * them by mmap or shmget.
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
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/shm.h>
+#include <sys/ipc.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <string.h>
+#include <ctype.h>
+#include "test.h"
+#include "usctest.h"
+
+#define PROTECTION		(PROT_READ | PROT_WRITE)
+#define _PATH_MEMINFO		"/proc/meminfo"
+#define _PATH_SYS_HUGE		"/sys/kernel/mm/hugepages"
+#define _PATH_SYS_2M		_PATH_SYS_HUGE "/hugepages-2048kB/"
+#define _PATH_SYS_2M_OVER	_PATH_SYS_2M "nr_overcommit_hugepages"
+#define _PATH_SYS_2M_FREE	_PATH_SYS_2M "free_hugepages"
+#define _PATH_SYS_2M_RESV	_PATH_SYS_2M "resv_hugepages"
+#define _PATH_SYS_2M_SURP	_PATH_SYS_2M "surplus_hugepages"
+#define _PATH_SYS_2M_HUGE	_PATH_SYS_2M "nr_hugepages"
+#define _PATH_PROC_VM		"/proc/sys/vm/"
+#define _PATH_PROC_OVER		_PATH_PROC_VM "nr_overcommit_hugepages"
+#define _PATH_PROC_HUGE		_PATH_PROC_VM "nr_hugepages"
+#define _PATH_SHMMAX		"/proc/sys/kernel/shmmax"
+#define MB			(1024 * 1024)
+
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define ADDR (void *)(0x8000000000000000UL)
+#define FLAGS (MAP_SHARED | MAP_FIXED)
+#define SHMAT_FLAGS (SHM_RND)
+#else
+#define ADDR (void *)(0x0UL)
+#define FLAGS (MAP_SHARED)
+#define SHMAT_FLAGS (0)
+#endif
+
+#ifndef SHM_HUGETLB
+#define SHM_HUGETLB 04000
+#endif
+
+char *TCID = "hugemmap05";
+char *TESTDIR;
+int TST_TOTAL = 1, Tst_count;
+static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
+static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
+static char shmmax[BUFSIZ];
+static char *opt_allocstr;
+static int opt_sysfs, opt_alloc;
+static int shmid = -1;
+static int restore_shmmax = 0;
+static size_t size = 128, length = 384;
+static option_t options[] = {
+	{ "s", &opt_sysfs,	NULL},
+	{ "m", &shmid,		NULL},
+	{ "a:", &opt_alloc,	&opt_allocstr},
+	{ NULL, NULL,		NULL}
+};
+static void setup(void);
+static void cleanup(void) LTP_ATTRIBUTE_NORETURN;
+static void overcommit(void);
+static void write_bytes(void *addr);
+static void read_bytes(void *addr);
+static int lookup (char *line, char *pattern);
+static void usage(void);
+static int checkproc(FILE *fp, char *string, int value);
+static int checksys(char *path, char *pattern, int value);
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	if (opt_sysfs) {
+		strncpy(path, _PATH_SYS_2M_HUGE,
+			strlen(_PATH_SYS_2M_HUGE) + 1);
+		strncpy(pathover, _PATH_SYS_2M_OVER,
+			strlen(_PATH_SYS_2M_OVER) + 1);
+	} else {
+		strncpy(path, _PATH_PROC_HUGE,
+			strlen(_PATH_PROC_HUGE) + 1);
+		strncpy(pathover, _PATH_PROC_OVER,
+			strlen(_PATH_PROC_OVER) + 1);
+	}
+	if (opt_alloc) {
+		size = atoi(opt_allocstr);
+		length = (int)(size + size * 0.5) * 2;
+	}
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		overcommit();
+	}	
+	cleanup();
+}
+
+static void overcommit(void)
+{
+	void *addr = NULL, *shmaddr = NULL;
+	int fd = -1, key = -1;
+	char s[BUFSIZ];
+	FILE *fp;
+
+	if (shmid != -1) {
+		/* Use /proc/meminfo to generate an IPC key. */
+		key = ftok(_PATH_MEMINFO, strlen(_PATH_MEMINFO));
+		if (key == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "ftok");
+		shmid = shmget(key, (long)(length * MB),
+			SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
+		if (shmid == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmget");
+	} else {
+		snprintf(s, BUFSIZ, "%s/hugemmap05/file", TESTDIR);
+		fd = open(s, O_CREAT | O_RDWR, 0755);
+		if (fd == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "open");
+		addr = mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
+			0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	}
+
+	if (opt_sysfs) {
+		tst_resm(TINFO, "check sysfs before allocation.");
+		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+				length / 2) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free",
+				length / 2) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+				length / 2 - size) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd",
+				length / 2) != 0)
+			return;
+	} else {
+		tst_resm(TINFO,
+			"check /proc/meminfo before allocation.");
+		fp = fopen(_PATH_MEMINFO, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Free", length / 2 ) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Surp", length / 2 - size)
+			!= 0)
+			return;
+		if (checkproc(fp, "HugePages_Rsvd", length / 2) != 0)
+			return;
+		fclose(fp);
+	}
+	if (shmid != -1) {
+		tst_resm(TINFO, "shmid: 0x%x", shmid);
+		shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+		if (shmaddr == (void *)-1)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmat");
+		write_bytes(shmaddr);
+		read_bytes(shmaddr);
+        } else {
+		write_bytes(addr);
+		read_bytes(addr);
+	}
+	if (opt_sysfs) {
+		tst_resm(TINFO, "check sysfs.");
+		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+				length / 2) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free", 0)
+			!= 0)
+			return;
+		if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+				length / 2 - size) != 0)
+			return;
+		if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
+			!= 0)
+			return;
+	} else {
+		tst_resm(TINFO, "check /proc/meminfo.");
+		fp = fopen(_PATH_MEMINFO, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Free", 0) != 0)
+			return;
+		if (checkproc(fp, "HugePages_Surp", length / 2 - size)
+			!= 0)
+			return;
+		if (checkproc(fp, "HugePages_Rsvd", 0) != 0)
+			return;
+		fclose(fp);
+	}
+	if (shmid != -1) {
+		if (shmdt(shmaddr) != 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
+	} else {
+		munmap(addr, (long)(length * MB));
+		close(fd);
+		unlink(s);
+	}
+}
+
+static void cleanup(void)
+{
+	int fd;
+
+	TEST_CLEANUP;
+	if (restore_shmmax) {
+		fd = open(_PATH_SHMMAX, O_WRONLY);
+		if (fd == -1)
+			tst_resm(TWARN|TERRNO, "open");
+		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
+			tst_resm(TWARN|TERRNO, "write");
+		close(fd);
+	}
+	fd = open(path, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	tst_resm(TINFO, "restore nr_hugepages to %s.", nr_hugepages);
+	if (write(fd, nr_hugepages,
+			strlen(nr_hugepages)) != strlen(nr_hugepages))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+
+	fd = open(pathover, O_WRONLY);
+	if (fd == -1)
+		tst_resm(TWARN|TERRNO, "open");
+	tst_resm(TINFO, "restore nr_overcommit_hugepages to %s.",
+		nr_overcommit_hugepages);
+	if (write(fd, nr_overcommit_hugepages, strlen(nr_overcommit_hugepages))
+		!= strlen(nr_overcommit_hugepages))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+	
+	snprintf(buf, BUFSIZ, "%s/hugemmap05", TESTDIR);
+	if (umount(buf) == -1)
+		tst_resm(TWARN|TERRNO, "umount");
+	if (shmid != -1) {
+		tst_resm(TINFO|TERRNO, "shmdt");
+		shmctl(shmid, IPC_RMID, NULL);
+	}
+	tst_exit();
+}
+
+static void setup(void)
+{
+	FILE *fp;
+	int fd;
+
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	if (shmid != -1) {
+		fp = fopen(_PATH_SHMMAX, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (fgets(shmmax, BUFSIZ, fp) == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+		fclose(fp);
+
+		if (atol(shmmax) < (long)(length * MB)) {
+			restore_shmmax = 1;
+			fd = open(_PATH_SHMMAX, O_RDWR);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open");
+			snprintf(buf, BUFSIZ, "%ld", (long)(length * MB));
+			if (write(fd, buf, strlen(buf)) != strlen(buf))
+				tst_brkm(TBROK|TERRNO, cleanup,
+					"failed to change shmmax.");
+		}
+	}
+	fp = fopen(path, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(nr_hugepages, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+	/* Remove trialing newline. */
+	nr_hugepages[strlen(nr_hugepages) - 1] = '\0';
+	tst_resm(TINFO, "original nr_hugepages is %s", nr_hugepages);
+
+	fd = open(path, O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	/* Reset. */
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	snprintf(buf, BUFSIZ, "%ld", size);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup,
+			"failed to change nr_hugepages.");
+	close(fd);
+
+	fp = fopen(pathover, "r+");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(nr_overcommit_hugepages, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	fclose(fp);
+	nr_overcommit_hugepages[strlen(nr_overcommit_hugepages) - 1] = '\0';
+	tst_resm(TINFO, "original nr_overcommit_hugepages is %s",
+		nr_overcommit_hugepages);
+
+	fd = open(pathover, O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	/* Reset. */
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	snprintf(buf, BUFSIZ, "%ld", size);
+	if (write(fd, buf, strlen(buf)) != strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup,
+			"failed to change nr_hugepages.");
+	close(fd);
+
+	snprintf(buf, BUFSIZ, "%s/hugemmap05", TESTDIR);
+	if (mkdir(buf, 0700) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount");
+}
+
+static void write_bytes(void *addr)
+{
+	long i;
+
+	for (i = 0; i < (long)(length * MB); i++)
+		((char *)addr)[i] = '\a';
+}
+
+static void read_bytes(void *addr)
+{
+	long i;
+
+	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
+	for (i = 0; i < (long)(length * MB); i++) {
+		if (((char *)addr)[i] != '\a') {
+			tst_resm(TFAIL, "mismatch at %ld", i);
+			break;
+		}
+	}
+}
+
+/* Lookup a pattern and get the value from file*/
+static int lookup (char *line, char *pattern)
+{
+	char buf2[BUFSIZ];
+
+	/* empty line */
+	if (line[0] == '\0')
+		return 0;
+
+	snprintf(buf2, BUFSIZ, "%s: %%s", pattern);
+	if (sscanf(line, buf2, buf) != 1)
+		return 0;
+
+	return 1;
+}
+
+static void usage(void)
+{
+	printf("  -s      Setup hugepages from sysfs\n");
+	printf("  -m      Reserve hugepages by shmget\n");
+	printf("  -a      Number of overcommint hugepages\n");
+}
+
+static int checksys(char *path, char *string, int value)
+{
+	FILE *fp;
+
+	fp = fopen(path, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(buf, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	tst_resm(TINFO, "%s is %d.", string, atoi(buf));
+	if (atoi(buf) != value) {
+		tst_resm(TFAIL, "%s is not %d but %d.", string, value,
+			atoi(buf));
+		return 1;
+	}
+	fclose(fp);
+	return 0;
+}
+
+static int checkproc(FILE *fp, char *pattern, int value)
+{
+	memset(buf, -1, BUFSIZ);
+	rewind(fp);
+	while (fgets(line, BUFSIZ, fp) != NULL)
+		if (lookup(line, pattern))
+			break;
+
+	tst_resm(TINFO, "%s is %d.", pattern, atoi(buf));
+	if (atoi(buf) != value) {
+		tst_resm(TFAIL, "%s is not %d but %d.", pattern, value,
+			atoi(buf));
+		return 1;
+	}
+	return 0;
+}
-- 
1.7.3.2


------=_Part_17380_1859650734.1291707014153
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
------=_Part_17380_1859650734.1291707014153
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_17380_1859650734.1291707014153--

