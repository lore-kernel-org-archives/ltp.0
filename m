Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <zliu@redhat.com>) id 1Q4tD5-0001xJ-Np
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 11:05:11 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q4tD4-0001h2-CY
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 11:05:11 +0000
Date: Wed, 30 Mar 2011 07:05:04 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1472927069.670110.1301483104408.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <708245171.670105.1301483005817.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] add nr_overcommit_hugepages vm tunable test
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
To: ltp-list@lists.sourceforge.net, yanegomi@gmail.com

Hi, Garrett,
Please review the new test case.

 * The program is designed to test /proc/sys/vm/nr_overcommit_hugepages
 * tunable. /proc/sys/vm/nr_overcommit_hugepages specifies how large 
 * the pool of huge pages can grow, if more huge pages than 
 * /proc/sys/vm/nr_hugepages are requested by applications.  
 * Writing any non-zero value into this file indicates that the hugetlb 
 * subsystem is allowed to try to obtain that number of "surplus" huge 
 * pages from the kernel's normal page pool, when the persistent huge 
 * page pool is exhausted. As these surplus huge pages become unused, 
 * they are freed back to the kernel's normal page pool. When applicatons
 * alloc more huge pages, it will overcommit the hugepage pool,  we can 
 * confirmed the correction by /proc/meminfo: HugePages_Surp.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 .../kernel/mem/vmtunable/nr_overcommit_hugepages.c |  300 ++++++++++++++++++++
 1 files changed, 300 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c

diff --git a/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
new file mode 100644
index 0000000..00d4983
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/nr_overcommit_hugepages.c
@@ -0,0 +1,300 @@
+/*
+ * vm tunable test
+ *
+ * ********************************************************************
+ * Copyright (C) 2011  Red Hat, Inc.
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
+ * The program is designed to test /proc/sys/vm/nr_overcommit_hugepages
+ * tunable. /proc/sys/vm/nr_overcommit_hugepages specifies how large 
+ * the pool of huge pages can grow, if more huge pages than 
+ * /proc/sys/vm/nr_hugepages are requested by applications.  
+ * Writing any non-zero value into this file indicates that the hugetlb 
+ * subsystem is allowed to try to obtain that number of "surplus" huge 
+ * pages from the kernel's normal page pool, when the persistent huge 
+ * page pool is exhausted. As these surplus huge pages become unused, 
+ * they are freed back to the kernel's normal page pool. When applicatons
+ * alloc more huge pages, it will overcommit the hugepage pool,  we can 
+ * confirmed the correction by /proc/meminfo: HugePages_Surp.
+ * 
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
+
+char *TCID = "nr_overcommit_hugepages"; 
+int TST_TOTAL = 1;
+
+#define NUM 50UL /* the amount of hugepages try to mmap */
+#define HUGEPAGES 30 /* set /proc/sys/vm/nr_hugepages */
+#define OVER_HUGEPAGES 30 /* set /proc/sys/vm/nr_overcommit_hugepages */
+#define BUFFER_SIZE 256 
+#define FILE_NAME "/mnt/hugepagefile"
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
+/* Check whether there're the two tunable or not */
+int check_system();
+
+/* We're not sure one hugepag size is 2048kb or not, we can confirm
+ * it by catting /proc/meminfo: Hugepagesize
+ */
+unsigned long get_one_hugepage_size();
+
+/* set hugepages */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages);
+
+/* get the total of hugepages and surplus hugepages */ 
+int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages);
+
+/* try to alloc overcommit hugepage */
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
+	if (check_system() == 0) {
+		tst_resm(TFAIL, "Can't test nr_hugepages and \
+				nr_overcommit_hugepages,no such file");
+		tst_exit();
+	}
+
+	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s", msg);
+	}
+	get_hugepages(&old_hugepages, &old_overcommit);
+	tst_resm(TINFO, "old nr_hugepages value is %d", old_hugepages);
+	tst_resm(TINFO, "old nr_overcommit hugepages is %d", old_overcommit);
+	
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		set_hugepages(HUGEPAGES, OVER_HUGEPAGES);
+		if (test_overcommit_hugepages() == 0) {
+			set_hugepages(old_hugepages, old_overcommit);
+			tst_resm(TPASS, "succeeded to overcommit hugepages");
+		} else {
+			tst_resm(TFAIL, "FAIL mapping!");
+		}
+		cleanup();
+	}
+
+	tst_exit();
+	return 0;
+}
+
+/* try to overcommit hugepages */
+int test_overcommit_hugepages()
+{
+	char *addr;
+	int fd;
+	int hugepages = 0;
+	int overcommit = 0;
+	unsigned long i;
+	unsigned long length = 0;
+	unsigned long one_hugepage_size = 0;
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
+	one_hugepage_size = get_one_hugepage_size();
+	length = NUM * one_hugepage_size;
+	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_resm(TFAIL, "mmap() Failed on %s, errno=%d : %s", \
+				FILE_NAME, errno, strerror(errno));
+		munmap(addr, length);
+		close(fd);
+		unlink(FILE_NAME);
+		cleanup();
+		tst_exit();
+	}
+
+	tst_resm(TINFO, "Returned address is %p", addr);
+	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
+	for (i = 0; i < length; i++) {
+		*(addr + i) = (char)i;
+	}
+
+	sleep(1);
+	/* get the hugepages and surplus hugepages after mmap successfully */
+	get_hugepages(&hugepages, &overcommit);
+	
+	munmap(addr, length);
+	close(fd);
+	unlink(FILE_NAME);
+	tst_resm(TINFO, "the current hugepages is %d and overcommit is %d ", hugepages, overcommit);
+	
+	/* if everything is okay, overcommit should equal (NUM - HUGEPAGES) */
+	if(hugepages == NUM && overcommit == (NUM - HUGEPAGES)) {
+		return 0;
+	} else {
+		return -1;
+	}
+}
+
+unsigned long get_one_hugepage_size()
+{
+	FILE *f;
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+	unsigned long one_hugepage_size = 0;
+
+	f = fopen("/proc/meminfo", "r");
+	if (f == NULL) {
+		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
+	}
+	while(fgets(buff,BUFFER_SIZE, f) != NULL) {
+		if((retcode = sscanf(buff, "Hugepagesize: %lu kB",
+			&one_hugepage_size)) == 1)
+			break;
+	}
+	tst_resm(TINFO, "one hugepagesize is %lu", one_hugepage_size);
+	fclose(f);
+	
+	if(one_hugepage_size == 0) {
+		tst_brkm(TFAIL, cleanup, "Can't read out hugepage size");
+	}
+
+	return one_hugepage_size * 1024UL;
+}
+
+/* get nr_hugepages and nr_overcommit_hugepages values */
+int get_hugepages(int *nr_hugepages, int *nr_overcommit_hugepages) 
+{
+	FILE *f;
+	int flag = 0;
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+
+	f = fopen("/proc/meminfo", "r");
+	if (f == NULL) {
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
+
+	if (flag != 2) {
+		fclose(f); 
+		tst_brkm(TFAIL, cleanup, "Failed reading size of huge page.");
+	}
+	fclose(f);
+
+	return 0;
+}
+
+/* set nr_hugepages and nr_overcommit_hugepages values */
+int set_hugepages(int nr_hugepages, int nr_overcommit_hugepages)
+{
+	FILE *f1, *f2;
+
+	f1 = fopen("/proc/sys/vm/nr_hugepages", "w");
+	if (f1 == NULL) {
+		tst_brkm(TFAIL, tst_exit, "No permission, using root user");
+	}
+
+	f2 = fopen("/proc/sys/vm/nr_overcommit_hugepages", "w");
+	if (f2 == NULL) {
+		tst_brkm(TFAIL, tst_exit, "No permission, using root user");
+	}
+
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
+	
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
+
+	if (flag1 == 0 && flag2 == 0) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+void cleanup()
+{
+	set_hugepages(old_hugepages, old_overcommit);
+	tst_exit();
+
+	return;
+}
+
-- 
1.7.3.4


------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
