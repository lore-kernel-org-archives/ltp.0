Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zliu@redhat.com>) id 1PS1b2-0005IF-HY
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 06:09:16 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PS1b0-0003V5-JV
	for ltp-list@lists.sourceforge.net; Mon, 13 Dec 2010 06:09:16 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBD699BB000606
	for <ltp-list@lists.sourceforge.net>; Mon, 13 Dec 2010 01:09:09 -0500
Date: Mon, 13 Dec 2010 01:09:07 -0500 (EST)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1105744485.821491292220547270.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1041525203.821451292220534911.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_47616_1096742898.1292220547269"
Subject: [LTP] [PATCH v1] a vm tunable testcase that can test
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

------=_Part_47616_1096742898.1292220547269
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

this program is designed to test the vm tunable nr_overcommit_hugepages.
the nr_overcommit_hugepages can change the maximum size of the hugepage pool.


Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 .../kernel/mem/vmtunabe/nr_overcommit_hugepages.c  |  257 ++++++++++++++++++++
 1 files changed, 257 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c

diff --git a/testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c b/testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c
new file mode 100644
index 0000000..7444f5e
--- /dev/null
+++ b/testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c
@@ -0,0 +1,257 @@
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
+char *TCID="nr_overcommit_hugepages"; 
+int TST_TOTAL=1;
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
+int test_overcommit_hugepages();
+
+/* do some clean after test */
+void cleanup();
+
+int old_hugepages;
+int old_overcommit; /* save the original data */
+
+int main(int argc, char *argv[])
+{
+	int lc = 0; /* loop counter */
+	char *msg;
+	
+	/* if check_system() return zero, the system can't support the testing */
+	if (!check_system()) {
+		tst_resm(TFAIL, "Can't test nr_hugepages and \
+				nr_overcommit_hugepages,no such file");
+		tst_exit();
+	}
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s",msg);
+	}
+	get_hugepages(&old_hugepages, &old_overcommit);
+	tst_resm(TINFO, "old nr_hugepages value is %d", old_hugepages);
+	tst_resm(TINFO, "old nr_overcommit hugepages is %d", old_overcommit);
+	
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
+		if (test_overcommit_hugepages()) {
+			set_hugepages(old_hugepages, old_overcommit);
+			tst_resm(TPASS, "succeeded using overcommit hugepages");
+		} else {
+			tst_resm(TFAIL,"FAIL mapping!");
+		}
+		cleanup();
+	}
+	cleanup();
+	/* start to test, and return 1 indicate PASS */
+	tst_exit();
+}
+
+int test_overcommit_hugepages()
+{
+	char *addr;
+	int fd;
+	int hugepages =0;
+	int overcommit = 0;
+	unsigned long i;
+	unsigned long length = 0;
+	/* mount hugetlbfs */
+	if (system("mount -t hugetlbfs nodev /mnt") != 0) {
+		tst_brkm(TBROK, cleanup, "Can't mount hugetlbfs");
+	}
+	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		tst_brkm(TBROK, cleanup, "OPEN File %s error", FILE_NAME);
+		tst_exit();
+	}
+	tst_resm(TINFO, "ONEPAGESIZE is %ld",ONEPAGESIZE);
+	length = NUM * ONEPAGESIZE;
+	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s",\
+				FILE_NAME, errno, strerror(errno));
+		tst_exit();
+	}
+
+	tst_resm(TINFO, "Returned address is %p", addr);
+	tst_resm(TINFO, "First hex is %x",*((unsigned int *)addr));
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		*(addr + i) = (char)i;
+	}
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		if (*(addr + i) != (char)i) {
+			tst_resm(TINFO, "Mismatch at %lu",i);
+			break;
+		}
+	}
+	sleep(1);
+	/* get the hugepages and surplus hugepages after mmap successfully */
+	get_hugepages(&hugepages, &overcommit);
+	
+	munmap(addr, ONEPAGESIZE);
+	close(fd);
+	tst_resm(TINFO,"the current hugepages is %d and overcommit is %d ",hugepages,overcommit);
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
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+	f = fopen("/proc/meminfo", "r");
+	if (!f) {
+		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
+	}
+	while(fgets(buff,BUFFER_SIZE, f) != NULL && flag < 2) {
+		if((retcode = sscanf(buff, "HugePages_Total: %d ",
+			nr_hugepages)) == 1)
+			flag++;
+		if((retcode = sscanf(buff, "HugePages_Surp: %d ", 
+			nr_overcommit_hugepages)) == 1) 
+			flag++;
+	}
+	if (flag != 2) {
+		fclose(f); 
+		tst_brkm(TFAIL, cleanup, "Failed reading size of huge page.");
+	}
+	fclose(f);
+	return 0;
+}
+
+/* set nr_hugepages and nr_overcommit_hugepages values */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
+{
+	FILE *f1, *f2;
+	f1 = fopen("/proc/sys/vm/nr_hugepages","w");
+	if (!f1) {
+		tst_brkm(TFAIL, cleanup, "No permission, using root user.");
+		tst_exit();
+	}
+	f2 = fopen("/proc/sys/vm/nr_overcommit_hugepages","w");
+	if (!f2) {
+		tst_brkm(TFAIL, cleanup, "No permission, using root user");
+		tst_exit();
+	}
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages and 
+	 * nr_overcommit_hugepages to /proc/sys/vm/nr_overcommit_hugepages
+	 */
+	if (fprintf(f1, "%d", nr_hugepages) == 0) {
+		tst_brkm(TFAIL, cleanup, "write date error to nr_hugepages");
+	}
+	if (fprintf(f2, "%d", nr_overcommit_hugepages) ==0 ) {
+		tst_brkm(TFAIL, cleanup, "write date error to nr_overcommit_hugepages");
+	}
+	fclose(f1);
+	fclose(f2);
+	return 0;
+}
+
+int check_system()
+{
+	int flag1 = -1;
+	int flag2 = -1;
+	flag1 = access("/proc/sys/vm/nr_hugepages",F_OK);
+	flag2 = access("/proc/sys/vm/nr_overcommit_hugepages",F_OK);
+	if (flag1 == 0 && flag2 == 0) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+void cleanup()
+{
+	unlink(FILE_NAME);
+	set_hugepages(old_hugepages, old_overcommit);
+	tst_exit();
+	return;
+}
+
-- 
1.7.2.3

------=_Part_47616_1096742898.1292220547269
Content-Type: text/x-patch;
	name=0002-add-a-testcase-nr_overcommit_hugepages-for-vm-tunabl.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=0002-add-a-testcase-nr_overcommit_hugepages-for-vm-tunabl.patch

From a987910448b63815a657e438083d762cb3cd817e Mon Sep 17 00:00:00 2001
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 13 Dec 2010 13:40:36 +0800
Subject: [PATCH 2/2] add a testcase nr_overcommit_hugepages for vm tunable


Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 .../kernel/mem/vmtunabe/nr_overcommit_hugepages.c  |  257 ++++++++++++++++++++
 1 files changed, 257 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c

diff --git a/testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c b/testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c
new file mode 100644
index 0000000..7444f5e
--- /dev/null
+++ b/testcases/kernel/mem/vmtunabe/nr_overcommit_hugepages.c
@@ -0,0 +1,257 @@
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
+char *TCID="nr_overcommit_hugepages"; 
+int TST_TOTAL=1;
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
+int test_overcommit_hugepages();
+
+/* do some clean after test */
+void cleanup();
+
+int old_hugepages;
+int old_overcommit; /* save the original data */
+
+int main(int argc, char *argv[])
+{
+	int lc = 0; /* loop counter */
+	char *msg;
+	
+	/* if check_system() return zero, the system can't support the testing */
+	if (!check_system()) {
+		tst_resm(TFAIL, "Can't test nr_hugepages and \
+				nr_overcommit_hugepages,no such file");
+		tst_exit();
+	}
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s",msg);
+	}
+	get_hugepages(&old_hugepages, &old_overcommit);
+	tst_resm(TINFO, "old nr_hugepages value is %d", old_hugepages);
+	tst_resm(TINFO, "old nr_overcommit hugepages is %d", old_overcommit);
+	
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
+		if (test_overcommit_hugepages()) {
+			set_hugepages(old_hugepages, old_overcommit);
+			tst_resm(TPASS, "succeeded using overcommit hugepages");
+		} else {
+			tst_resm(TFAIL,"FAIL mapping!");
+		}
+		cleanup();
+	}
+	cleanup();
+	/* start to test, and return 1 indicate PASS */
+	tst_exit();
+}
+
+int test_overcommit_hugepages()
+{
+	char *addr;
+	int fd;
+	int hugepages =0;
+	int overcommit = 0;
+	unsigned long i;
+	unsigned long length = 0;
+	/* mount hugetlbfs */
+	if (system("mount -t hugetlbfs nodev /mnt") != 0) {
+		tst_brkm(TBROK, cleanup, "Can't mount hugetlbfs");
+	}
+	fd = open(FILE_NAME, O_CREAT | O_RDWR, 0755);
+	if (fd < 0) {
+		tst_brkm(TBROK, cleanup, "OPEN File %s error", FILE_NAME);
+		tst_exit();
+	}
+	tst_resm(TINFO, "ONEPAGESIZE is %ld",ONEPAGESIZE);
+	length = NUM * ONEPAGESIZE;
+	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s",\
+				FILE_NAME, errno, strerror(errno));
+		tst_exit();
+	}
+
+	tst_resm(TINFO, "Returned address is %p", addr);
+	tst_resm(TINFO, "First hex is %x",*((unsigned int *)addr));
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		*(addr + i) = (char)i;
+	}
+	for (i = 0; i < ONEPAGESIZE; i++) {
+		if (*(addr + i) != (char)i) {
+			tst_resm(TINFO, "Mismatch at %lu",i);
+			break;
+		}
+	}
+	sleep(1);
+	/* get the hugepages and surplus hugepages after mmap successfully */
+	get_hugepages(&hugepages, &overcommit);
+	
+	munmap(addr, ONEPAGESIZE);
+	close(fd);
+	tst_resm(TINFO,"the current hugepages is %d and overcommit is %d ",hugepages,overcommit);
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
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+	f = fopen("/proc/meminfo", "r");
+	if (!f) {
+		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
+	}
+	while(fgets(buff,BUFFER_SIZE, f) != NULL && flag < 2) {
+		if((retcode = sscanf(buff, "HugePages_Total: %d ",
+			nr_hugepages)) == 1)
+			flag++;
+		if((retcode = sscanf(buff, "HugePages_Surp: %d ", 
+			nr_overcommit_hugepages)) == 1) 
+			flag++;
+	}
+	if (flag != 2) {
+		fclose(f); 
+		tst_brkm(TFAIL, cleanup, "Failed reading size of huge page.");
+	}
+	fclose(f);
+	return 0;
+}
+
+/* set nr_hugepages and nr_overcommit_hugepages values */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
+{
+	FILE *f1, *f2;
+	f1 = fopen("/proc/sys/vm/nr_hugepages","w");
+	if (!f1) {
+		tst_brkm(TFAIL, cleanup, "No permission, using root user.");
+		tst_exit();
+	}
+	f2 = fopen("/proc/sys/vm/nr_overcommit_hugepages","w");
+	if (!f2) {
+		tst_brkm(TFAIL, cleanup, "No permission, using root user");
+		tst_exit();
+	}
+	/* write nr_hugepages to /proc/sys/vm/nr_hugepages and 
+	 * nr_overcommit_hugepages to /proc/sys/vm/nr_overcommit_hugepages
+	 */
+	if (fprintf(f1, "%d", nr_hugepages) == 0) {
+		tst_brkm(TFAIL, cleanup, "write date error to nr_hugepages");
+	}
+	if (fprintf(f2, "%d", nr_overcommit_hugepages) ==0 ) {
+		tst_brkm(TFAIL, cleanup, "write date error to nr_overcommit_hugepages");
+	}
+	fclose(f1);
+	fclose(f2);
+	return 0;
+}
+
+int check_system()
+{
+	int flag1 = -1;
+	int flag2 = -1;
+	flag1 = access("/proc/sys/vm/nr_hugepages",F_OK);
+	flag2 = access("/proc/sys/vm/nr_overcommit_hugepages",F_OK);
+	if (flag1 == 0 && flag2 == 0) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+void cleanup()
+{
+	unlink(FILE_NAME);
+	set_hugepages(old_hugepages, old_overcommit);
+	tst_exit();
+	return;
+}
+
-- 
1.7.2.3


------=_Part_47616_1096742898.1292220547269
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Oracle to DB2 Conversion Guide: Learn learn about native support for PL/SQL,
new data types, scalar functions, improved concurrency, built-in packages, 
OCI, SQL*Plus, data movement tools, best practices and more.
http://p.sf.net/sfu/oracle-sfdev2dev 
------=_Part_47616_1096742898.1292220547269
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_47616_1096742898.1292220547269--

