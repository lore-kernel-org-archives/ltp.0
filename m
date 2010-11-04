Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PDuT8-00027n-Hz
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 07:42:46 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PDuT6-0002He-AZ
	for ltp-list@lists.sourceforge.net; Thu, 04 Nov 2010 07:42:46 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oA47gcxD018897
	for <ltp-list@lists.sourceforge.net>; Thu, 4 Nov 2010 03:42:38 -0400
Date: Thu, 4 Nov 2010 03:42:38 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <47150598.1390531288856558142.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3] overcommit libhugetlbfs and check the statistics
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
v3: fix -a option description; fix a nasty bug with tst_exit which skips
    cleanup at the end of the test; add more information to assist test
    debug.

v2: add more explanation and a command-line option to specify memory
    allocation size.

 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |  487 ++++++++++++++++++++
 1 files changed, 487 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
new file mode 100644
index 0000000..770f664
--- /dev/null
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -0,0 +1,487 @@
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
+
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <sys/shm.h>
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
+#define _PATH_PROC_OVER	_PATH_PROC_VM "nr_overcommit_hugepages"
+#define _PATH_PROC_HUGE	_PATH_PROC_VM "nr_hugepages"
+#define _PATH_SHMMAX		"/proc/sys/kernel/shmmax"
+#define NEED_RESTORE		2
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
+int TST_TOTAL = 1;
+extern int Tst_count;
+extern char *TESTDIR;
+static char nr_hugepages[BUFSIZ], nr_overcommit_hugepages[BUFSIZ];
+static char shmmax[BUFSIZ], *opt_allocstr;
+static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
+static int opt_sysfs, opt_shmget, opt_alloc, size = 128, length = 384;
+
+/* main setup function of test */
+static void setup(void);
+/* cleanup function for the test */
+static void cleanup(void);
+static int overcommit(void);
+static void check_bytes(char *addr);
+static void write_bytes(char *addr);
+static void read_bytes(char *addr);
+static int lookup (char *line, char *pattern);
+static void help(void);
+static void checkproc(FILE *fp, char *string, int value);
+static void checksys(char *path, char *pattern, int value);
+
+static option_t options[] = {
+	{ "s", &opt_sysfs,	NULL},
+	{ "m", &opt_shmget,	NULL},
+	{ "a:", &opt_alloc,	&opt_allocstr},
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
+	if (msg != NULL) {
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+		tst_exit();
+	}
+
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
+
+	/* Perform global setup for test */
+	setup();
+
+	/* Check looping state if -i option given */
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		/* Reset Tst_count in case we are looping. */
+		Tst_count = 0;
+
+		TEST(overcommit());
+
+		if(TEST_RETURN != 0)
+			tst_resm(TFAIL, "overcommit() failed with %ld.",
+				TEST_RETURN);
+		else
+			tst_resm(TPASS, "overcommit() completed "
+				"successfully.");
+	}
+	
+	cleanup();
+	return 0;
+}
+
+int overcommit(void)
+{
+	void *addr = NULL;
+	int fd = -1, shmid = -1;
+	char s[BUFSIZ];
+	FILE *fp;
+        unsigned long i;
+        char *shmaddr = NULL;
+
+	if (opt_shmget) {
+		if ((shmid = shmget(2, (long)(length * 1024 * 1024),
+		     SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W)) < 0)
+			tst_brkm(TBROK|TERRNO, cleanup, "shmget");
+	} else {
+		snprintf(s, strlen(TESTDIR) + 17, "%s/hugemmap05/file",
+			TESTDIR);
+		fd = open(s, O_CREAT | O_RDWR, 0755);
+		if (fd < 0) {
+			tst_resm(TFAIL|TERRNO, "open");
+			return 1;
+		}
+		addr = mmap(ADDR, (long)(length * 1024 * 1024),
+			PROTECTION, FLAGS, fd, 0);
+		if (addr == MAP_FAILED)
+			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+	}
+	if (opt_sysfs) {
+		tst_resm(TINFO, "check sysfs before allocation.");
+		checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+			length / 2);
+		checksys(_PATH_SYS_2M_FREE, "HugePages_Free",
+			length / 2);
+		checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+			length / 2 - size);
+		checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd",
+			length / 2);
+	} else {
+		tst_resm(TINFO,
+			"check /proc/meminfo before allocation.");
+		fp = fopen(_PATH_MEMINFO, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		checkproc(fp, "HugePages_Total", length / 2);
+		checkproc(fp, "HugePages_Free", length / 2 );
+		checkproc(fp, "HugePages_Surp", length / 2 - size);
+		checkproc(fp, "HugePages_Rsvd", length / 2);
+		fclose(fp);
+	}
+
+	if (opt_shmget) {
+		tst_resm(TINFO, "shmid: 0x%x", shmid);
+		shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);
+		if (shmaddr == (char *)-1) {
+			tst_resm(TINFO|TERRNO, "shmat");
+			shmctl(shmid, IPC_RMID, NULL);
+			tst_brkm(TBROK, cleanup,
+				"shared memory attach failure");
+		}
+		tst_resm(TINFO, "shmaddr: %p", shmaddr);
+		tst_resm(TINFO, "starting the writes...");
+		for (i = 0; i < (long)(length * 1024 * 1024); i++)
+			shmaddr[i] = (char)(i);
+
+		tst_resm(TINFO, "starting the check...");
+		for (i = 0; i < (long)(length * 1024 * 1024); i++)
+			if (shmaddr[i] != (char)i)
+				tst_resm(TINFO, "index %lu mismatched",
+					i);
+        } else {
+		tst_resm(TINFO, "returned address is %p.", addr);
+		check_bytes(addr);
+		write_bytes(addr);
+		read_bytes(addr);
+	}
+
+	if (opt_sysfs) {
+		tst_resm(TINFO, "check sysfs.");
+		checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+			length / 2);
+		checksys(_PATH_SYS_2M_FREE, "HugePages_Free", 0);
+		checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+			length / 2 - size);
+		checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd", 0);
+	} else {
+		tst_resm(TINFO, "check /proc/meminfo.");
+		fp = fopen(_PATH_MEMINFO, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		checkproc(fp, "HugePages_Total", length / 2);
+		checkproc(fp, "HugePages_Free", 0);
+		checkproc(fp, "HugePages_Surp", length / 2 - size);
+		checkproc(fp, "HugePages_Rsvd", 0);
+		fclose(fp);
+	}
+
+	if (opt_shmget) {
+		if (shmdt((const void *)shmaddr) != 0) {
+			tst_resm(TINFO|TERRNO, "shmdt");
+			shmctl(shmid, IPC_RMID, NULL);
+			tst_brkm(TFAIL, cleanup, "detach failure");
+		}	       
+		shmctl(shmid, IPC_RMID, NULL);
+	} else {
+		munmap(addr, (long)(length * 1024 * 1024));
+		close(fd);
+		unlink(s);
+	}
+	return 0;
+}
+
+void cleanup(void)
+{
+	int fd;
+
+	/*
+	 * remove the tmp directory and exit
+	 */
+	TEST_CLEANUP;
+
+	if (opt_shmget == NEED_RESTORE) {
+		fd = open(_PATH_SHMMAX, O_WRONLY);
+		if (fd == -1)
+			tst_resm(TWARN|TERRNO, "open");
+		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
+			tst_resm(TWARN|TERRNO, "write");
+		close(fd);
+	}
+
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
+	if (write(fd, nr_overcommit_hugepages, 
+			strlen(nr_overcommit_hugepages))
+		!= strlen(nr_overcommit_hugepages))
+		tst_resm(TWARN|TERRNO, "write");
+	close(fd);
+	
+	snprintf(buf, strlen(TESTDIR) + 12, "%s/hugemmap05", TESTDIR);
+	if (umount(buf) == -1)
+		tst_resm(TWARN|TERRNO, "umount");
+
+	tst_rmdir();
+	tst_exit();
+}
+
+void setup(void)
+{
+	FILE *fp;
+	int fd;
+
+	/*
+	 * setup a default signal hander and a
+	 * temporary working directory.
+	 */
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+	tst_tmpdir();
+
+	if (opt_shmget) {
+		fp = fopen(_PATH_SHMMAX, "r");
+		if (fp == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+		if (fgets(shmmax, BUFSIZ, fp) == NULL)
+			tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+		fclose(fp);
+
+		if (atol(shmmax) < (long)(length * 1024 * 1024)) {
+			opt_shmget = NEED_RESTORE;
+			fd = open(_PATH_SHMMAX, O_RDWR);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open");
+			snprintf(buf, BUFSIZ, "%ld",
+				(long)(length * 1024 * 1024));
+			if (write(fd, buf, strlen(buf))
+				!= strlen(buf))
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
+	tst_resm(TINFO, "original nr_hugepages is %s",
+		nr_hugepages);
+
+	fd = open(path, O_RDWR);
+	if (fd == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "open");
+	/* Reset. */
+	if (write(fd, "0", 1) != 1)
+		tst_brkm(TBROK|TERRNO, cleanup, "write");
+	if (lseek(fd, 0, SEEK_SET) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "lseek");
+	snprintf(buf, BUFSIZ, "%d", size);
+	if (write(fd, buf, strlen(buf))
+		!= strlen(buf))
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
+	nr_overcommit_hugepages[strlen(nr_overcommit_hugepages) - 1] 
+		= '\0';
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
+	snprintf(buf, BUFSIZ, "%d", size);
+	if (write(fd, buf, strlen(buf))
+		!= strlen(buf))
+		tst_brkm(TBROK|TERRNO, cleanup,
+			"failed to change nr_hugepages.");
+	close(fd);
+		
+	snprintf(buf, strlen(TESTDIR) + 12, "%s/hugemmap05", TESTDIR);
+	if (mkdir(buf, 0700) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mkdir");
+	if (mount(NULL, buf, "hugetlbfs", 0, NULL) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "mount");
+}
+
+static void check_bytes(char *addr)
+{
+	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
+}
+
+static void write_bytes(char *addr)
+{
+	unsigned long i;
+
+	for (i = 0; i < (long)(length * 1024 * 1024); i++)
+		*(addr + i) = (char)i;
+}
+
+static void read_bytes(char *addr)
+{
+	unsigned long i;
+
+	check_bytes(addr);
+	for (i = 0; i < (long)(length * 1024 * 1024); i++)
+		if (*(addr + i) != (char)i) {
+			tst_resm(TFAIL, "mismatch at %lu\n", i);
+			break;
+		}
+}
+
+/* Lookup a pattern and get the value from file*/
+int lookup (char *line, char *pattern)
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
+void help(void)
+{
+	printf("  -s      Setup hugepages from sysfs\n");
+	printf("  -m      Reserve hugepages by shmget\n");
+	printf("  -a      Number of overcommint hugepages\n");
+}
+
+void checksys(char *path, char *string, int value)
+{
+	FILE *fp;
+
+	fp = fopen(path, "r");
+	if (fp == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fopen");
+	if (fgets(buf, BUFSIZ, fp) == NULL)
+		tst_brkm(TBROK|TERRNO, cleanup, "fgets");
+	if (atoi(buf) != value)
+		tst_resm(TFAIL, "%s is not %d but %d.", string,
+			value, atoi(buf));
+	fclose(fp);
+}
+
+void checkproc(FILE *fp, char *pattern, int value)
+{
+	memset(buf, -1, BUFSIZ);
+	rewind(fp);
+	while (fgets(line, BUFSIZ, fp) != NULL)
+		if (lookup(line, pattern))
+			break;
+
+	tst_resm(TINFO, "%s is %d.", pattern, value);
+	if (atoi(buf) != value)
+		tst_resm(TFAIL, "%s is not %d but %d.", pattern, value,
+			atoi(buf));
+}
-- 
1.7.1

------------------------------------------------------------------------------
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a 
Billion" shares his insights and actions to help propel your 
business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
