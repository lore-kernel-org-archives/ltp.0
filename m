Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PSNil-0001xm-61
	for ltp-list@lists.sourceforge.net; Tue, 14 Dec 2010 05:46:43 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PSNij-0001qA-7a
	for ltp-list@lists.sourceforge.net; Tue, 14 Dec 2010 05:46:43 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBE5kZH0000856
	for <ltp-list@lists.sourceforge.net>; Tue, 14 Dec 2010 00:46:35 -0500
Date: Tue, 14 Dec 2010 00:46:35 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <939184772.962261292305595152.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <226698669.962241292305534287.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_55122_1444403780.1292305595151"
Subject: [LTP] [PATCH v2] a vm tunable testcase that can test
 /proc/sys/vm/nr_overcommit_hugepages
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
To: ltp-list@lists.sourceforge.net

------=_Part_55122_1444403780.1292305595151
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

hi, all
this test program is designed to test the vm tunable nr_overcommit_hugepages.
the nr_overcommit_hugepages can change the maximum size of the hugepage pool.
when you set nr_overcommit_hugepages, you can find this change through /proc/meminfo.

v2: fix some code style

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                                         |    1 +
 .../kernel/mem/vmtunable/nr_overcommit_hugepages.c |  275 ++++++++++++++++++++
 2 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c

diff --git a/runtest/mm b/runtest/mm
index 3b5182f..c86aae9 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -75,3 +75,4 @@ cpuset01 cpuset01 -I 3600
 
 # test for vm tunable
 nr_hugepages nr_hugepages -i 5
+nr_overcommit_hugepages nr_overcommit_hugepages -i 10
diff --git a/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
new file mode 100644
index 0000000..f513174
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
@@ -0,0 +1,275 @@
+/*
+ * vm tunable test
+ *
+ * ********************************************************************
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
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
+ *
+ * ********************************************************************
+ *
+ * File Name: nr_overcommit_hugepage.c
+ * Author: Zhouping Liu <zliu@redhat.com>
+ * Description:  
+ * the program is designed to test a vm tunable
+ * /proc/sys/vm/nr_overcommit_hugepages can work normally.
+ * you can change the maximum size of the hugepage pool through
+ * /proc/sys/vm/nr_overcommit_hugepages.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include "test.h"
+#include "usctest.h"
+char *TCID = "nr_overcommit_hugepages"; 
+int TST_TOTAL = 1;
+
+#define NUM 50UL /* the amount of hugepages try to mmap */
+#define HUGEPAGES 30 /* set /proc/sys/vm/nr_hugepages */
+#define OVER_HUGEPAGES 30 /* set /proc/sys/vm/nr_overcommit_hugepages */
+#define BUFFER_SIZE 256 
+#define FILE_NAME "/mnt/hugepagefile"
+#define HUGEPAGESIZE 2048   /* 2KB */
+#define ONEPAGESIZE (1UL*HUGEPAGESIZE*1024) /* one hugepages size */
+#define PROTECTION (PROT_READ | PROT_WRITE) /* mmap mode */
+
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define ADDR (void *)(0x8000000000000000UL)
+#define FLAGS (MAP_SHARED | MAP_FIXED)
+#else
+#define ADDR (void *)(0x0UL)
+#define FLAGS (MAP_SHARED)
+#endif
+
+
+/* set hugepages */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages);
+
+/* get the total of hugepages and surplus hugepages */ 
+int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages);
+
+/* 
+ * /proc/sys/vm/nr_hugepages change the minmum size of the hugepage
+ * pool and /proc/sys/vm/nr_overcommit_hugepages can change the 
+ * maxmum size of the hugepage pool, and the maximum is
+ * nr_hugepages + nr_overcommit_hugepages.
+ * if no the two files, this test can't run conitune. 
+ * and check_system() check whether this two file exist.
+ * 
+ */
+int check_system();
+
+/* try to require overcommit hugepages */
+int test_overcommit_hugepages();
+
+/* do some clean after test */
+void cleanup();
+
+int old_hugepages;
+int old_overcommit; /* the original hugepages data */
+
+int main(int argc, char *argv[])
+{
+	int lc = 0; /* loop counter */
+	char *msg;
+	
+	/* the test need to be run as root */
+	tst_require_root(tst_exit);
+	
+	/* if check_system() return zero, the system can't support the testing */
+	if (!check_system()) {
+		tst_resm(TFAIL, "Can't test %s,no such file", TCID);
+		tst_exit();
+	}
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s", msg);
+	}
+
+	get_hugepages(&old_hugepages, &old_overcommit); /* save the original data */
+	tst_resm(TINFO, "original nr_hugepages value is %d", old_hugepages);
+	tst_resm(TINFO, "original nr_overcommit hugepages is %d", old_overcommit);
+	
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
+		tst_resm(TINFO, "the current nr_hugepages value is %d", HUGEPAGES);
+		tst_resm(TINFO, "the current nr_overcommit hugepages is %d", OVER_HUGEPAGES);
+		
+		if (test_overcommit_hugepages()) {
+			set_hugepages(old_hugepages, old_overcommit);
+			tst_resm(TPASS, "Succeeded using overcommit hugepages");
+		} else {
+			tst_resm(TFAIL, "Fail using overcommit hugepages.");
+		}
+		cleanup();
+	}
+
+	cleanup();
+	return 0;
+}
+
+int test_overcommit_hugepages()
+{
+	char *addr;
+	int fd;
+	int hugepages = 0;
+	int overcommit = 0;
+	unsigned long i;
+	unsigned long length = 0; /*the total size of mmap() */
+	
+	/* mount hugetlbfs */
+	if (system("mount -t hugetlbfs nodev /mnt") != 0) {
+		tst_brkm(TBROK, cleanup, "Can't mount hugetlbfs");
+	}
+
+	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		tst_brkm(TBROK, cleanup, "OPEN File %s error", FILE_NAME);
+		tst_exit();
+	}
+	
+	length = NUM * ONEPAGESIZE;
+	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_resm(TBROK, "mmap() Failed on %s, errno=%d : %s",\
+				FILE_NAME, errno, strerror(errno));
+		tst_exit();
+	}
+
+	tst_resm(TINFO, "Returned address is %p", addr);
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		*(addr + i) = (char)i;
+	}
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		if (*(addr + i) != (char)i) {
+			tst_resm(TINFO, "Mismatch at %lu", i);
+			break;
+		}
+	}
+	sleep(1);
+
+	/* get the hugepages and surplus hugepages after mmap successfully */
+	get_hugepages(&hugepages, &overcommit);
+	
+	/* free addr */
+	munmap(addr, ONEPAGESIZE);
+	close(fd);
+	
+	/* if everything is okay, overcommit should equal (NUM -HUGEPAGES) */
+	if(hugepages == NUM && overcommit == (NUM - HUGEPAGES)) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/* get nr_hugepages and nr_overcommit_hugepages values */
+int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages) 
+{
+	FILE *f;
+	int flag = 0;
+	char buff[BUFFER_SIZE];
+	
+	f = fopen("/proc/meminfo", "r");
+	if (f == NULL) {
+		tst_brkm(TBROK|TERRNO, cleanup, "open /proc/meminfo error.");
+	}
+
+	while (fgets(buff,BUFFER_SIZE, f) != NULL && flag < 2) {
+		if (sscanf(buff, "HugePages_Total: %d ",
+			nr_hugepages) == 1)
+			flag++;
+		if (sscanf(buff, "HugePages_Surp: %d ", 
+			nr_overcommit_hugepages) == 1) 
+			flag++;
+	}
+	/* if flag = 2, that indicates the sscanf have gotten the 
+	 * HugePages_Total and HugePages_Surp.
+	 */
+	if (flag != 2) {
+		fclose(f); 
+		tst_brkm(TBROK|TERRNO, cleanup, "Failed reading size of huge page.");
+	}
+
+	fclose(f);
+	return 0;
+}
+
+/* set nr_hugepages and nr_overcommit_hugepages values */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
+{
+	FILE *f1, *f2;
+	char *fname1 = "/proc/sys/vm/nr_hugepages";
+	char *fname2 = "/proc/sys/vm/nr_overcommit_hugepages";
+	
+	f1 = fopen(fname1, "w");
+	if (f1 == NULL) {
+		tst_brkm(TERRNO|TBROK, cleanup, "open %s file error.", fname1);
+	}
+	f2 = fopen(fname2, "w");
+	if (f2 == NULL) {
+		tst_brkm(TERRNO|TBROK, cleanup, "open %s file error.", fname2);
+	}
+
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages and 
+	 * nr_overcommit_hugepages to /proc/sys/vm/nr_overcommit_hugepages
+	 */
+	if (fprintf(f1, "%d", nr_hugepages) == 0) {
+		tst_brkm(TBROK, cleanup, "write date error to %s", fname1);
+	}
+	if (fprintf(f2, "%d", nr_overcommit_hugepages) == 0) {
+		tst_brkm(TBROK, cleanup, "write date error to %s", fname2);
+	}
+
+	fclose(f1);
+	fclose(f2);
+	return 0;
+}
+
+int check_system()
+{
+	int flag1 = -1;
+	int flag2 = -1;
+
+	flag1 = access("/proc/sys/vm/nr_hugepages", F_OK);
+	flag2 = access("/proc/sys/vm/nr_overcommit_hugepages", F_OK);
+	if (flag1 == 0 && flag2 == 0) {
+		return 1; /* access these two file */
+	} else {
+		return 0;
+	}
+}
+
+void cleanup()
+{
+	unlink(FILE_NAME);
+	set_hugepages(old_hugepages, old_overcommit); /* recover the original data*/
+	tst_exit();
+	return;
+}
-- 
1.7.2.3

------=_Part_55122_1444403780.1292305595151
Content-Type: text/x-patch;
	name=0002-add-a-testcase-nr_overcommit_hugepages-fro-vm-tunabl.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0002-add-a-testcase-nr_overcommit_hugepages-fro-vm-tunabl.patch

From 663a390804b2f0c76fa3523726fbc3f89e8ef2df Mon Sep 17 00:00:00 2001
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 14 Dec 2010 13:36:43 +0800
Subject: [PATCH 2/2] add a testcase nr_overcommit_hugepages fro vm tunable


Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                                         |    1 +
 .../kernel/mem/vmtunable/nr_overcommit_hugepages.c |  275 ++++++++++++++++++++
 2 files changed, 276 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c

diff --git a/runtest/mm b/runtest/mm
index 3b5182f..c86aae9 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -75,3 +75,4 @@ cpuset01 cpuset01 -I 3600
 
 # test for vm tunable
 nr_hugepages nr_hugepages -i 5
+nr_overcommit_hugepages nr_overcommit_hugepages -i 10
diff --git a/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
new file mode 100644
index 0000000..f513174
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
@@ -0,0 +1,275 @@
+/*
+ * vm tunable test
+ *
+ * ********************************************************************
+ * Copyright (C) 2010  Red Hat, Inc.
+ *
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
+ *
+ * ********************************************************************
+ *
+ * File Name: nr_overcommit_hugepage.c
+ * Author: Zhouping Liu <zliu@redhat.com>
+ * Description:  
+ * the program is designed to test a vm tunable
+ * /proc/sys/vm/nr_overcommit_hugepages can work normally.
+ * you can change the maximum size of the hugepage pool through
+ * /proc/sys/vm/nr_overcommit_hugepages.
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sys/stat.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+
+#include "test.h"
+#include "usctest.h"
+char *TCID = "nr_overcommit_hugepages"; 
+int TST_TOTAL = 1;
+
+#define NUM 50UL /* the amount of hugepages try to mmap */
+#define HUGEPAGES 30 /* set /proc/sys/vm/nr_hugepages */
+#define OVER_HUGEPAGES 30 /* set /proc/sys/vm/nr_overcommit_hugepages */
+#define BUFFER_SIZE 256 
+#define FILE_NAME "/mnt/hugepagefile"
+#define HUGEPAGESIZE 2048   /* 2KB */
+#define ONEPAGESIZE (1UL*HUGEPAGESIZE*1024) /* one hugepages size */
+#define PROTECTION (PROT_READ | PROT_WRITE) /* mmap mode */
+
+/* Only ia64 requires this */
+#ifdef __ia64__
+#define ADDR (void *)(0x8000000000000000UL)
+#define FLAGS (MAP_SHARED | MAP_FIXED)
+#else
+#define ADDR (void *)(0x0UL)
+#define FLAGS (MAP_SHARED)
+#endif
+
+
+/* set hugepages */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages);
+
+/* get the total of hugepages and surplus hugepages */ 
+int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages);
+
+/* 
+ * /proc/sys/vm/nr_hugepages change the minmum size of the hugepage
+ * pool and /proc/sys/vm/nr_overcommit_hugepages can change the 
+ * maxmum size of the hugepage pool, and the maximum is
+ * nr_hugepages + nr_overcommit_hugepages.
+ * if no the two files, this test can't run conitune. 
+ * and check_system() check whether this two file exist.
+ * 
+ */
+int check_system();
+
+/* try to require overcommit hugepages */
+int test_overcommit_hugepages();
+
+/* do some clean after test */
+void cleanup();
+
+int old_hugepages;
+int old_overcommit; /* the original hugepages data */
+
+int main(int argc, char *argv[])
+{
+	int lc = 0; /* loop counter */
+	char *msg;
+	
+	/* the test need to be run as root */
+	tst_require_root(tst_exit);
+	
+	/* if check_system() return zero, the system can't support the testing */
+	if (!check_system()) {
+		tst_resm(TFAIL, "Can't test %s,no such file", TCID);
+		tst_exit();
+	}
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s", msg);
+	}
+
+	get_hugepages(&old_hugepages, &old_overcommit); /* save the original data */
+	tst_resm(TINFO, "original nr_hugepages value is %d", old_hugepages);
+	tst_resm(TINFO, "original nr_overcommit hugepages is %d", old_overcommit);
+	
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
+		tst_resm(TINFO, "the current nr_hugepages value is %d", HUGEPAGES);
+		tst_resm(TINFO, "the current nr_overcommit hugepages is %d", OVER_HUGEPAGES);
+		
+		if (test_overcommit_hugepages()) {
+			set_hugepages(old_hugepages, old_overcommit);
+			tst_resm(TPASS, "Succeeded using overcommit hugepages");
+		} else {
+			tst_resm(TFAIL, "Fail using overcommit hugepages.");
+		}
+		cleanup();
+	}
+
+	cleanup();
+	return 0;
+}
+
+int test_overcommit_hugepages()
+{
+	char *addr;
+	int fd;
+	int hugepages = 0;
+	int overcommit = 0;
+	unsigned long i;
+	unsigned long length = 0; /*the total size of mmap() */
+	
+	/* mount hugetlbfs */
+	if (system("mount -t hugetlbfs nodev /mnt") != 0) {
+		tst_brkm(TBROK, cleanup, "Can't mount hugetlbfs");
+	}
+
+	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		tst_brkm(TBROK, cleanup, "OPEN File %s error", FILE_NAME);
+		tst_exit();
+	}
+	
+	length = NUM * ONEPAGESIZE;
+	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_resm(TBROK, "mmap() Failed on %s, errno=%d : %s",\
+				FILE_NAME, errno, strerror(errno));
+		tst_exit();
+	}
+
+	tst_resm(TINFO, "Returned address is %p", addr);
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		*(addr + i) = (char)i;
+	}
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		if (*(addr + i) != (char)i) {
+			tst_resm(TINFO, "Mismatch at %lu", i);
+			break;
+		}
+	}
+	sleep(1);
+
+	/* get the hugepages and surplus hugepages after mmap successfully */
+	get_hugepages(&hugepages, &overcommit);
+	
+	/* free addr */
+	munmap(addr, ONEPAGESIZE);
+	close(fd);
+	
+	/* if everything is okay, overcommit should equal (NUM -HUGEPAGES) */
+	if(hugepages == NUM && overcommit == (NUM - HUGEPAGES)) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+/* get nr_hugepages and nr_overcommit_hugepages values */
+int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages) 
+{
+	FILE *f;
+	int flag = 0;
+	char buff[BUFFER_SIZE];
+	
+	f = fopen("/proc/meminfo", "r");
+	if (f == NULL) {
+		tst_brkm(TBROK|TERRNO, cleanup, "open /proc/meminfo error.");
+	}
+
+	while (fgets(buff,BUFFER_SIZE, f) != NULL && flag < 2) {
+		if (sscanf(buff, "HugePages_Total: %d ",
+			nr_hugepages) == 1)
+			flag++;
+		if (sscanf(buff, "HugePages_Surp: %d ", 
+			nr_overcommit_hugepages) == 1) 
+			flag++;
+	}
+	/* if flag = 2, that indicates the sscanf have gotten the 
+	 * HugePages_Total and HugePages_Surp.
+	 */
+	if (flag != 2) {
+		fclose(f); 
+		tst_brkm(TBROK|TERRNO, cleanup, "Failed reading size of huge page.");
+	}
+
+	fclose(f);
+	return 0;
+}
+
+/* set nr_hugepages and nr_overcommit_hugepages values */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
+{
+	FILE *f1, *f2;
+	char *fname1 = "/proc/sys/vm/nr_hugepages";
+	char *fname2 = "/proc/sys/vm/nr_overcommit_hugepages";
+	
+	f1 = fopen(fname1, "w");
+	if (f1 == NULL) {
+		tst_brkm(TERRNO|TBROK, cleanup, "open %s file error.", fname1);
+	}
+	f2 = fopen(fname2, "w");
+	if (f2 == NULL) {
+		tst_brkm(TERRNO|TBROK, cleanup, "open %s file error.", fname2);
+	}
+
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages and 
+	 * nr_overcommit_hugepages to /proc/sys/vm/nr_overcommit_hugepages
+	 */
+	if (fprintf(f1, "%d", nr_hugepages) == 0) {
+		tst_brkm(TBROK, cleanup, "write date error to %s", fname1);
+	}
+	if (fprintf(f2, "%d", nr_overcommit_hugepages) == 0) {
+		tst_brkm(TBROK, cleanup, "write date error to %s", fname2);
+	}
+
+	fclose(f1);
+	fclose(f2);
+	return 0;
+}
+
+int check_system()
+{
+	int flag1 = -1;
+	int flag2 = -1;
+
+	flag1 = access("/proc/sys/vm/nr_hugepages", F_OK);
+	flag2 = access("/proc/sys/vm/nr_overcommit_hugepages", F_OK);
+	if (flag1 == 0 && flag2 == 0) {
+		return 1; /* access these two file */
+	} else {
+		return 0;
+	}
+}
+
+void cleanup()
+{
+	unlink(FILE_NAME);
+	set_hugepages(old_hugepages, old_overcommit); /* recover the original data*/
+	tst_exit();
+	return;
+}
-- 
1.7.2.3


------=_Part_55122_1444403780.1292305595151
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
------=_Part_55122_1444403780.1292305595151
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_55122_1444403780.1292305595151--

