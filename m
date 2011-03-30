Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <zliu@redhat.com>) id 1Q4t7x-00039d-BJ
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 10:59:53 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q4t7v-0001Um-LQ
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 10:59:53 +0000
Date: Wed, 30 Mar 2011 06:59:44 -0400 (EDT)
From: Zhouping Liu <zliu@redhat.com>
Message-ID: <1119407155.670083.1301482784916.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <437944141.670068.1301482679509.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_670082_1241449760.1301482784913"
Subject: [LTP]  [PATCH 1/2] add a vm nr_hugepages tunable test
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
To: ltp-list@lists.sourceforge.net, yanegomi@gmail.com

------=_Part_670082_1241449760.1301482784913
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, Cooper,
please review the new test case.

 * The program is designed to test /proc/sys/vm/nr_hugepages tunable.
 * As we know, we can tune /proc/sys/vm/nr_hugepages to change the 
 * minimum size of the hugepage pool. /proc/sys/vm/nr_hugepages indicates 
 * the current number of "persistent" huge pages in the kernel's huge 
 * page pool.  "Persistent" huge pages will be returned to the huge page 
 * pool when freed by a task.  A user with root privileges can dynamically 
 * allocate more or free some persistent huge pages by increasing or 
 * decreasing the value of 'nr_hugepages'. We can confirm this change by 
 * checking /proc/meminfo: HugePages_Total value.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 testcases/kernel/mem/vmtunable/Makefile       |   31 +++
 testcases/kernel/mem/vmtunable/nr_hugepages.c |  277 +++++++++++++++++++++++++
 2 files changed, 308 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/mem/vmtunable/Makefile
 create mode 100644 testcases/kernel/mem/vmtunable/nr_hugepages.c

diff --git a/testcases/kernel/mem/vmtunable/Makefile b/testcases/kernel/mem/vmtunable/Makefile
new file mode 100644
index 0000000..3e7f888
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/Makefile
@@ -0,0 +1,31 @@
+#
+# Copyright (C) 2010  Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of version 2 of the GNU General Public
+# License as published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+#
+# Further, this software is distributed without any warranty that it
+# is free of the rightful claim of any third person regarding
+# infringement or the like.  Any license provided herein, whether
+# implied or otherwise, applies only to this software file.  Patent
+# licenses, if any, provided herein do not apply to combinations of
+# this program with other software, or any other product whatsoever.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+# 02110-1301, USA.
+#
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
+
+include $(top_srcdir)/include/mk/testcases.mk
diff --git a/testcases/kernel/mem/vmtunable/nr_hugepages.c b/testcases/kernel/mem/vmtunable/nr_hugepages.c
new file mode 100644
index 0000000..769c51e
--- /dev/null
+++ b/testcases/kernel/mem/vmtunable/nr_hugepages.c
@@ -0,0 +1,277 @@
+/* 
+ * vm nr_hugepages tunable test
+ *
+ * ********************************************************************
+ * Copyright (C) 2011 Red Hat, Inc.
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
+ * File Name: nr_hugepage.c
+ * Author: Zhouping Liu <zliu@redhat.com>
+ * Description:  
+ * The program is designed to test /proc/sys/vm/nr_hugepages tunable.
+ * As we know, we can tune /proc/sys/vm/nr_hugepages to change the 
+ * minimum size of the hugepage pool. /proc/sys/vm/nr_hugepages indicates 
+ * the current number of "persistent" huge pages in the kernel's huge 
+ * page pool.  "Persistent" huge pages will be returned to the huge page 
+ * pool when freed by a task.  A user with root privileges can dynamically 
+ * allocate more or free some persistent huge pages by increasing or 
+ * decreasing the value of 'nr_hugepages'. We can confirm this change by 
+ * checking /proc/meminfo: HugePages_Total option's value.
+ *
+ */
+
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
+char *TCID="nr_hugepages"; 
+#define BUFFER_SIZE 256
+
+
+#define NR_HUGEPAGES 30 /* the value set to /proc/sys/vm/nr_hugepages */
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
+int TST_TOTAL=1;
+
+/* check whether the /proc/sys/vm/nr_hugepages file exist
+ * if not, then the test can't run continue.
+ */
+int check_system();
+
+/* We're not sure one hugepag size is 2048kb or not, we can confirm
+ * it by catting /proc/meminfo: Hugepagesize
+ */
+unsigned long get_one_hugepage_size();
+
+/* set hugepages value */
+int set_hugepages(int nr_hugepages);
+
+/* get the total of hugepages */ 
+int get_hugepages(int *nr_hugepages);
+
+/* try to alloc nr_hugepages hugepages */
+int alloc_hugepages(int nr_hugepages);
+
+/* make some cleanning work. */
+void cleanup();
+
+int old_hugepages = 0; /* save the old nr_hugepages value */
+
+int main(int argc, char *argv[])
+{
+	int lc = 0; /* loop counter */
+	char *msg; /* message returned from parse_opts */
+	int hugepages = 0;
+	
+	/* if check_system() return zero, 
+ 	 * the system can't support this test. 
+ 	 */
+	if (check_system() == 0) {
+		tst_resm(TFAIL, "Can't test nr_hugepages and \
+				nr_overcommit_hugepages,no such files");
+		tst_exit();
+	}
+
+	if ( (msg = parse_opts(argc, argv, NULL, NULL)) != NULL ) {
+		tst_brkm(TBROK, cleanup, "OPTION PARSING ERROR -%s ", msg);
+	}
+	
+	get_hugepages(&old_hugepages); /* save the current value to old_hugepags */
+	tst_resm(TINFO, "the old nr_hugepages is %d\n",old_hugepages);
+	
+	for ( lc = 0; TEST_LOOPING(lc); lc++ ) {		
+		set_hugepages(NR_HUGEPAGES);
+		tst_resm(TINFO, "set nr_hugepages %d", NR_HUGEPAGES);
+		get_hugepages(&hugepages);
+		if (hugepages != NR_HUGEPAGES) {
+			set_hugepages(old_hugepages); /* recover the original value */
+			tst_brkm(TFAIL, cleanup, "nr_hugepages error");
+		}
+		sleep(1);
+		
+		/* try to alloc appropriate hugepages, it should PASS */
+		if(alloc_hugepages(NR_HUGEPAGES) == 0) {
+			tst_resm(TINFO, "try to alloc appropriate hugepages pass");		
+		} else {
+			tst_brkm(TFAIL, cleanup, "nr_hugepages error");		
+		}
+
+		/* try to alloc overcommit hugepages, it should FAIL */
+		if(alloc_hugepages(NR_HUGEPAGES + 1) == -1) {
+			tst_resm(TINFO, "test overcommit hugepages pass");		
+		} else {
+			tst_brkm(TFAIL, cleanup, "nr_hugepages error");
+		}
+	}
+	
+	set_hugepages(old_hugepages); /* recover the primary value */
+	tst_resm(TPASS, "nr_hugepages");
+	cleanup();
+
+	return 0;
+}
+
+int check_system()
+{
+	int flag = -1;
+
+	flag = access("/proc/sys/vm/nr_hugepages", F_OK);
+	if (flag == 0) {
+		return 1;
+	} else {
+		return 0;
+	}
+}
+
+int get_hugepages(int *nr_hugepages) 
+{
+	FILE *f;
+	int retcode = 0;
+	char buff[BUFFER_SIZE];
+
+	f = fopen("/proc/meminfo", "r");
+	if (f == NULL) {
+		tst_brkm(TFAIL, cleanup, "Please run the test using root user.");
+	}
+
+	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
+		if((retcode = sscanf(buff, "HugePages_Total: %d ", nr_hugepages)) == 1)
+			break;
+	}
+	fclose(f);
+
+	return 0;
+}
+
+int set_hugepages(int nr_hugepages)
+{
+	FILE *f;
+
+	f = fopen("/proc/sys/vm/nr_hugepages", "w");
+	if (f == NULL) {
+		tst_brkm(TFAIL, NULL, "No permission, using root user.");
+		tst_exit();
+	}
+
+	/* write nr_hugepages value to /proc/sys/vm/nr_hugepages */
+	fprintf(f, "%d", nr_hugepages);
+	fclose(f);
+
+	return 0;
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
+		tst_brkm(TFAIL, cleanup, "Can't open /proc/meminfo");
+	}
+
+	while (fgets(buff,BUFFER_SIZE, f) != NULL) {
+		if((retcode = sscanf(buff, "Hugepagesize: %lu kB", &one_hugepage_size)) == 1)
+			break;
+	}
+	tst_resm(TINFO, "one hugepagesize is %lu", one_hugepage_size);
+	fclose(f);
+	
+	if(one_hugepage_size == 0) {
+		tst_brkm(TFAIL, cleanup, "Can't read one hugepage size");
+	}
+	
+	return one_hugepage_size * 1024UL;
+}
+
+/* try to alloc nr_hugepages hugepages */
+int alloc_hugepages(int nr_hugepages)
+{
+	char *addr;
+	int fd;
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
+	length = nr_hugepages * one_hugepage_size;
+	addr = (char *)mmap(ADDR, length, PROTECTION, FLAGS, fd, 0);
+	if (addr == MAP_FAILED) {
+		tst_resm(TINFO, "mmap() Failed on %s, errno=%d : %s", \
+				FILE_NAME, errno, strerror(errno));
+		munmap(addr, length);
+		close(fd);
+		unlink(FILE_NAME);
+		return -1;
+	}
+
+	tst_resm(TINFO, "Returned address is %p", addr);
+	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
+
+	munmap(addr, length);
+	close(fd);
+	unlink(FILE_NAME);
+	
+	return 0;
+
+}
+
+void cleanup(void)
+{
+	set_hugepages(old_hugepages);
+	tst_exit();
+
+	return;
+}
-- 
1.7.3.4

------=_Part_670082_1241449760.1301482784913
Content-Type: text/x-patch; name=0001-add-a-vm-nr_hugepages-tunable-test.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-add-a-vm-nr_hugepages-tunable-test.patch

RnJvbSBiZTUxMDYyODc2MzJiNDQ0NmI3MDJjNDc1ZWY1ODc5ZDFkZjVkYmY1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBaaG91cGluZyBMaXUgPHpsaXVAcmVkaGF0LmNvbT4KRGF0ZTog
V2VkLCAzMCBNYXIgMjAxMSAxNDoxNDo1NyArMDgwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBhZGQg
YSB2bSBucl9odWdlcGFnZXMgdHVuYWJsZSB0ZXN0CgoKU2lnbmVkLW9mZi1ieTogWmhvdXBpbmcg
TGl1IDx6bGl1QHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vdm10dW5hYmxl
L01ha2VmaWxlICAgICAgIHwgICAzMSArKysKIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3ZtdHVuYWJs
ZS9ucl9odWdlcGFnZXMuYyB8ICAyNzcgKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxl
cyBjaGFuZ2VkLCAzMDggaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS92bXR1bmFibGUvTWFrZWZpbGUKIGNyZWF0ZSBt
b2RlIDEwMDY0NCB0ZXN0Y2FzZXMva2VybmVsL21lbS92bXR1bmFibGUvbnJfaHVnZXBhZ2VzLmMK
CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS92bXR1bmFibGUvTWFrZWZpbGUgYi90
ZXN0Y2FzZXMva2VybmVsL21lbS92bXR1bmFibGUvTWFrZWZpbGUKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKaW5kZXggMDAwMDAwMC4uM2U3Zjg4OAotLS0gL2Rldi9udWxsCisrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvbWVtL3ZtdHVuYWJsZS9NYWtlZmlsZQpAQCAtMCwwICsxLDMxIEBACisjCisjIENvcHly
aWdodCAoQykgMjAxMCAgUmVkIEhhdCwgSW5jLgorIworIyBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yCisjIG1vZGlmeSBpdCB1bmRl
ciB0aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMKKyMgTGlj
ZW5zZSBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KKyMKKyMg
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd291bGQgYmUg
dXNlZnVsLAorIyBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1w
bGllZCB3YXJyYW50eSBvZgorIyBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuCisjCisjIEZ1cnRoZXIsIHRoaXMgc29mdHdhcmUgaXMgZGlzdHJpYnV0
ZWQgd2l0aG91dCBhbnkgd2FycmFudHkgdGhhdCBpdAorIyBpcyBmcmVlIG9mIHRoZSByaWdodGZ1
bCBjbGFpbSBvZiBhbnkgdGhpcmQgcGVyc29uIHJlZ2FyZGluZworIyBpbmZyaW5nZW1lbnQgb3Ig
dGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4sIHdoZXRoZXIKKyMgaW1wbGll
ZCBvciBvdGhlcndpc2UsIGFwcGxpZXMgb25seSB0byB0aGlzIHNvZnR3YXJlIGZpbGUuICBQYXRl
bnQKKyMgbGljZW5zZXMsIGlmIGFueSwgcHJvdmlkZWQgaGVyZWluIGRvIG5vdCBhcHBseSB0byBj
b21iaW5hdGlvbnMgb2YKKyMgdGhpcyBwcm9ncmFtIHdpdGggb3RoZXIgc29mdHdhcmUsIG9yIGFu
eSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCisjCisjIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZl
ZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCisjIGFsb25nIHdpdGgg
dGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRoZSBGcmVlIFNvZnR3YXJlCisjIEZvdW5kYXRp
b24sIEluYy4sIDUxIEZyYW5rbGluIFN0cmVldCwgRmlmdGggRmxvb3IsIEJvc3RvbiwgTUEKKyMg
MDIxMTAtMTMwMSwgVVNBLgorIworCit0b3Bfc3JjZGlyCQk/PSAuLi8uLi8uLi8uLgorCitpbmNs
dWRlICQodG9wX3NyY2RpcikvaW5jbHVkZS9tay9lbnZfcHJlLm1rCisKK2luY2x1ZGUgJCh0b3Bf
c3JjZGlyKS9pbmNsdWRlL21rL2dlbmVyaWNfdHJ1bmtfdGFyZ2V0Lm1rCisKK2luY2x1ZGUgJCh0
b3Bfc3JjZGlyKS9pbmNsdWRlL21rL3Rlc3RjYXNlcy5tawpkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vdm10dW5hYmxlL25yX2h1Z2VwYWdlcy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vdm10dW5hYmxlL25yX2h1Z2VwYWdlcy5jCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAw
MDAwMDAuLjc2OWM1MWUKLS0tIC9kZXYvbnVsbAorKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS92
bXR1bmFibGUvbnJfaHVnZXBhZ2VzLmMKQEAgLTAsMCArMSwyNzcgQEAKKy8qIAorICogdm0gbnJf
aHVnZXBhZ2VzIHR1bmFibGUgdGVzdAorICoKKyAqICoqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqCisgKiBDb3B5cmlnaHQg
KEMpIDIwMTEgUmVkIEhhdCwgSW5jLgorICoKKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3
YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IKKyAqIG1vZGlmeSBpdCB1bmRlciB0
aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMKKyAqIExpY2Vu
c2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgKgorICog
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd291bGQgYmUg
dXNlZnVsLAorICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW4gdGhlIGlt
cGxpZWQgd2FycmFudHkgb2YKKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBB
UlRJQ1VMQVIgUFVSUE9TRS4KKyAqCisgKiBGdXJ0aGVyLCB0aGlzIHNvZnR3YXJlIGlzIGRpc3Ry
aWJ1dGVkIHdpdGhvdXQgYW55IHdhcnJhbnR5IHRoYXQgaXQKKyAqIGlzIGZyZWUgb2YgdGhlIHJp
Z2h0ZnVsIGNsYWltIG9mIGFueSB0aGlyZCBwZXJzb24gcmVnYXJkaW5nCisgKiBpbmZyaW5nZW1l
bnQgb3IgdGhlIGxpa2UuICBBbnkgbGljZW5zZSBwcm92aWRlZCBoZXJlaW4sIHdoZXRoZXIKKyAq
IGltcGxpZWQgb3Igb3RoZXJ3aXNlLCBhcHBsaWVzIG9ubHkgdG8gdGhpcyBzb2Z0d2FyZSBmaWxl
LiAgUGF0ZW50CisgKiBsaWNlbnNlcywgaWYgYW55LCBwcm92aWRlZCBoZXJlaW4gZG8gbm90IGFw
cGx5IHRvIGNvbWJpbmF0aW9ucyBvZgorICogdGhpcyBwcm9ncmFtIHdpdGggb3RoZXIgc29mdHdh
cmUsIG9yIGFueSBvdGhlciBwcm9kdWN0IHdoYXRzb2V2ZXIuCisgKgorICogWW91IHNob3VsZCBo
YXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UKKyAq
IGFsb25nIHdpdGggdGhpcyBwcm9ncmFtOyBpZiBub3QsIHdyaXRlIHRoZSBGcmVlIFNvZnR3YXJl
CisgKiBGb3VuZGF0aW9uLCBJbmMuLCA1MSBGcmFua2xpbiBTdHJlZXQsIEZpZnRoIEZsb29yLCBC
b3N0b24sIE1BCisgKiAwMjExMC0xMzAxLCBVU0EuCisgKgorICogKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioKKyAqCisg
KiBGaWxlIE5hbWU6IG5yX2h1Z2VwYWdlLmMKKyAqIEF1dGhvcjogWmhvdXBpbmcgTGl1IDx6bGl1
QHJlZGhhdC5jb20+CisgKiBEZXNjcmlwdGlvbjogIAorICogVGhlIHByb2dyYW0gaXMgZGVzaWdu
ZWQgdG8gdGVzdCAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzIHR1bmFibGUuCisgKiBBcyB3ZSBr
bm93LCB3ZSBjYW4gdHVuZSAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzIHRvIGNoYW5nZSB0aGUg
CisgKiBtaW5pbXVtIHNpemUgb2YgdGhlIGh1Z2VwYWdlIHBvb2wuIC9wcm9jL3N5cy92bS9ucl9o
dWdlcGFnZXMgaW5kaWNhdGVzIAorICogdGhlIGN1cnJlbnQgbnVtYmVyIG9mICJwZXJzaXN0ZW50
IiBodWdlIHBhZ2VzIGluIHRoZSBrZXJuZWwncyBodWdlIAorICogcGFnZSBwb29sLiAgIlBlcnNp
c3RlbnQiIGh1Z2UgcGFnZXMgd2lsbCBiZSByZXR1cm5lZCB0byB0aGUgaHVnZSBwYWdlIAorICog
cG9vbCB3aGVuIGZyZWVkIGJ5IGEgdGFzay4gIEEgdXNlciB3aXRoIHJvb3QgcHJpdmlsZWdlcyBj
YW4gZHluYW1pY2FsbHkgCisgKiBhbGxvY2F0ZSBtb3JlIG9yIGZyZWUgc29tZSBwZXJzaXN0ZW50
IGh1Z2UgcGFnZXMgYnkgaW5jcmVhc2luZyBvciAKKyAqIGRlY3JlYXNpbmcgdGhlIHZhbHVlIG9m
ICducl9odWdlcGFnZXMnLiBXZSBjYW4gY29uZmlybSB0aGlzIGNoYW5nZSBieSAKKyAqIGNoZWNr
aW5nIC9wcm9jL21lbWluZm86IEh1Z2VQYWdlc19Ub3RhbCBvcHRpb24ncyB2YWx1ZS4KKyAqCisg
Ki8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkbGliLmg+CisjaW5jbHVkZSA8
ZXJybm8uaD4KKyNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxmY250bC5oPgorI2luY2x1
ZGUgPHN0ZGludC5oPgorI2luY2x1ZGUgPHN5cy9zdGF0Lmg+CisjaW5jbHVkZSA8c3lzL21tYW4u
aD4KKyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKworI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRl
ICJ1c2N0ZXN0LmgiCitjaGFyICpUQ0lEPSJucl9odWdlcGFnZXMiOyAKKyNkZWZpbmUgQlVGRkVS
X1NJWkUgMjU2CisKKworI2RlZmluZSBOUl9IVUdFUEFHRVMgMzAgLyogdGhlIHZhbHVlIHNldCB0
byAvcHJvYy9zeXMvdm0vbnJfaHVnZXBhZ2VzICovCisjZGVmaW5lIEJVRkZFUl9TSVpFIDI1NiAK
KyNkZWZpbmUgRklMRV9OQU1FICIvbW50L2h1Z2VwYWdlZmlsZSIKKyNkZWZpbmUgUFJPVEVDVElP
TiAoUFJPVF9SRUFEIHwgUFJPVF9XUklURSkgLyogbW1hcCBtb2RlICovCisKKy8qIE9ubHkgaWE2
NCByZXF1aXJlcyB0aGlzICovCisjaWZkZWYgX19pYTY0X18KKyNkZWZpbmUgQUREUiAodm9pZCAq
KSgweDgwMDAwMDAwMDAwMDAwMDBVTCkKKyNkZWZpbmUgRkxBR1MgKE1BUF9TSEFSRUQgfCBNQVBf
RklYRUQpCisjZWxzZQorI2RlZmluZSBBRERSICh2b2lkICopKDB4MFVMKQorI2RlZmluZSBGTEFH
UyAoTUFQX1NIQVJFRCkKKyNlbmRpZgorCitpbnQgVFNUX1RPVEFMPTE7CisKKy8qIGNoZWNrIHdo
ZXRoZXIgdGhlIC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMgZmlsZSBleGlzdAorICogaWYgbm90
LCB0aGVuIHRoZSB0ZXN0IGNhbid0IHJ1biBjb250aW51ZS4KKyAqLworaW50IGNoZWNrX3N5c3Rl
bSgpOworCisvKiBXZSdyZSBub3Qgc3VyZSBvbmUgaHVnZXBhZyBzaXplIGlzIDIwNDhrYiBvciBu
b3QsIHdlIGNhbiBjb25maXJtCisgKiBpdCBieSBjYXR0aW5nIC9wcm9jL21lbWluZm86IEh1Z2Vw
YWdlc2l6ZQorICovCit1bnNpZ25lZCBsb25nIGdldF9vbmVfaHVnZXBhZ2Vfc2l6ZSgpOworCisv
KiBzZXQgaHVnZXBhZ2VzIHZhbHVlICovCitpbnQgc2V0X2h1Z2VwYWdlcyhpbnQgbnJfaHVnZXBh
Z2VzKTsKKworLyogZ2V0IHRoZSB0b3RhbCBvZiBodWdlcGFnZXMgKi8gCitpbnQgZ2V0X2h1Z2Vw
YWdlcyhpbnQgKm5yX2h1Z2VwYWdlcyk7CisKKy8qIHRyeSB0byBhbGxvYyBucl9odWdlcGFnZXMg
aHVnZXBhZ2VzICovCitpbnQgYWxsb2NfaHVnZXBhZ2VzKGludCBucl9odWdlcGFnZXMpOworCisv
KiBtYWtlIHNvbWUgY2xlYW5uaW5nIHdvcmsuICovCit2b2lkIGNsZWFudXAoKTsKKworaW50IG9s
ZF9odWdlcGFnZXMgPSAwOyAvKiBzYXZlIHRoZSBvbGQgbnJfaHVnZXBhZ2VzIHZhbHVlICovCisK
K2ludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCit7CisJaW50IGxjID0gMDsgLyogbG9v
cCBjb3VudGVyICovCisJY2hhciAqbXNnOyAvKiBtZXNzYWdlIHJldHVybmVkIGZyb20gcGFyc2Vf
b3B0cyAqLworCWludCBodWdlcGFnZXMgPSAwOworCQorCS8qIGlmIGNoZWNrX3N5c3RlbSgpIHJl
dHVybiB6ZXJvLCAKKyAJICogdGhlIHN5c3RlbSBjYW4ndCBzdXBwb3J0IHRoaXMgdGVzdC4gCisg
CSAqLworCWlmIChjaGVja19zeXN0ZW0oKSA9PSAwKSB7CisJCXRzdF9yZXNtKFRGQUlMLCAiQ2Fu
J3QgdGVzdCBucl9odWdlcGFnZXMgYW5kIFwKKwkJCQlucl9vdmVyY29tbWl0X2h1Z2VwYWdlcyxu
byBzdWNoIGZpbGVzIik7CisJCXRzdF9leGl0KCk7CisJfQorCisJaWYgKCAobXNnID0gcGFyc2Vf
b3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKSkgIT0gTlVMTCApIHsKKwkJdHN0X2Jya20oVEJS
T0ssIGNsZWFudXAsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtJXMgIiwgbXNnKTsKKwl9CisJCisJ
Z2V0X2h1Z2VwYWdlcygmb2xkX2h1Z2VwYWdlcyk7IC8qIHNhdmUgdGhlIGN1cnJlbnQgdmFsdWUg
dG8gb2xkX2h1Z2VwYWdzICovCisJdHN0X3Jlc20oVElORk8sICJ0aGUgb2xkIG5yX2h1Z2VwYWdl
cyBpcyAlZFxuIixvbGRfaHVnZXBhZ2VzKTsKKwkKKwlmb3IgKCBsYyA9IDA7IFRFU1RfTE9PUElO
RyhsYyk7IGxjKysgKSB7CQkKKwkJc2V0X2h1Z2VwYWdlcyhOUl9IVUdFUEFHRVMpOworCQl0c3Rf
cmVzbShUSU5GTywgInNldCBucl9odWdlcGFnZXMgJWQiLCBOUl9IVUdFUEFHRVMpOworCQlnZXRf
aHVnZXBhZ2VzKCZodWdlcGFnZXMpOworCQlpZiAoaHVnZXBhZ2VzICE9IE5SX0hVR0VQQUdFUykg
eworCQkJc2V0X2h1Z2VwYWdlcyhvbGRfaHVnZXBhZ2VzKTsgLyogcmVjb3ZlciB0aGUgb3JpZ2lu
YWwgdmFsdWUgKi8KKwkJCXRzdF9icmttKFRGQUlMLCBjbGVhbnVwLCAibnJfaHVnZXBhZ2VzIGVy
cm9yIik7CisJCX0KKwkJc2xlZXAoMSk7CisJCQorCQkvKiB0cnkgdG8gYWxsb2MgYXBwcm9wcmlh
dGUgaHVnZXBhZ2VzLCBpdCBzaG91bGQgUEFTUyAqLworCQlpZihhbGxvY19odWdlcGFnZXMoTlJf
SFVHRVBBR0VTKSA9PSAwKSB7CisJCQl0c3RfcmVzbShUSU5GTywgInRyeSB0byBhbGxvYyBhcHBy
b3ByaWF0ZSBodWdlcGFnZXMgcGFzcyIpOwkJCisJCX0gZWxzZSB7CisJCQl0c3RfYnJrbShURkFJ
TCwgY2xlYW51cCwgIm5yX2h1Z2VwYWdlcyBlcnJvciIpOwkJCisJCX0KKworCQkvKiB0cnkgdG8g
YWxsb2Mgb3ZlcmNvbW1pdCBodWdlcGFnZXMsIGl0IHNob3VsZCBGQUlMICovCisJCWlmKGFsbG9j
X2h1Z2VwYWdlcyhOUl9IVUdFUEFHRVMgKyAxKSA9PSAtMSkgeworCQkJdHN0X3Jlc20oVElORk8s
ICJ0ZXN0IG92ZXJjb21taXQgaHVnZXBhZ2VzIHBhc3MiKTsJCQorCQl9IGVsc2UgeworCQkJdHN0
X2Jya20oVEZBSUwsIGNsZWFudXAsICJucl9odWdlcGFnZXMgZXJyb3IiKTsKKwkJfQorCX0KKwkK
KwlzZXRfaHVnZXBhZ2VzKG9sZF9odWdlcGFnZXMpOyAvKiByZWNvdmVyIHRoZSBwcmltYXJ5IHZh
bHVlICovCisJdHN0X3Jlc20oVFBBU1MsICJucl9odWdlcGFnZXMiKTsKKwljbGVhbnVwKCk7CisK
KwlyZXR1cm4gMDsKK30KKworaW50IGNoZWNrX3N5c3RlbSgpCit7CisJaW50IGZsYWcgPSAtMTsK
KworCWZsYWcgPSBhY2Nlc3MoIi9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiLCBGX09LKTsKKwlp
ZiAoZmxhZyA9PSAwKSB7CisJCXJldHVybiAxOworCX0gZWxzZSB7CisJCXJldHVybiAwOworCX0K
K30KKworaW50IGdldF9odWdlcGFnZXMoaW50ICpucl9odWdlcGFnZXMpIAoreworCUZJTEUgKmY7
CisJaW50IHJldGNvZGUgPSAwOworCWNoYXIgYnVmZltCVUZGRVJfU0laRV07CisKKwlmID0gZm9w
ZW4oIi9wcm9jL21lbWluZm8iLCAiciIpOworCWlmIChmID09IE5VTEwpIHsKKwkJdHN0X2Jya20o
VEZBSUwsIGNsZWFudXAsICJQbGVhc2UgcnVuIHRoZSB0ZXN0IHVzaW5nIHJvb3QgdXNlci4iKTsK
Kwl9CisKKwl3aGlsZSAoZmdldHMoYnVmZixCVUZGRVJfU0laRSwgZikgIT0gTlVMTCkgeworCQlp
ZigocmV0Y29kZSA9IHNzY2FuZihidWZmLCAiSHVnZVBhZ2VzX1RvdGFsOiAlZCAiLCBucl9odWdl
cGFnZXMpKSA9PSAxKQorCQkJYnJlYWs7CisJfQorCWZjbG9zZShmKTsKKworCXJldHVybiAwOwor
fQorCitpbnQgc2V0X2h1Z2VwYWdlcyhpbnQgbnJfaHVnZXBhZ2VzKQoreworCUZJTEUgKmY7CisK
KwlmID0gZm9wZW4oIi9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiLCAidyIpOworCWlmIChmID09
IE5VTEwpIHsKKwkJdHN0X2Jya20oVEZBSUwsIE5VTEwsICJObyBwZXJtaXNzaW9uLCB1c2luZyBy
b290IHVzZXIuIik7CisJCXRzdF9leGl0KCk7CisJfQorCisJLyogd3JpdGUgbnJfaHVnZXBhZ2Vz
IHZhbHVlIHRvIC9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMgKi8KKwlmcHJpbnRmKGYsICIlZCIs
IG5yX2h1Z2VwYWdlcyk7CisJZmNsb3NlKGYpOworCisJcmV0dXJuIDA7Cit9CisKK3Vuc2lnbmVk
IGxvbmcgZ2V0X29uZV9odWdlcGFnZV9zaXplKCkKK3sKKwlGSUxFICpmOworCWludCByZXRjb2Rl
ID0gMDsKKwljaGFyIGJ1ZmZbQlVGRkVSX1NJWkVdOworCXVuc2lnbmVkIGxvbmcgb25lX2h1Z2Vw
YWdlX3NpemUgPSAwOworCisJZiA9IGZvcGVuKCIvcHJvYy9tZW1pbmZvIiwgInIiKTsKKwlpZiAo
ZiA9PSBOVUxMKSB7CisJCXRzdF9icmttKFRGQUlMLCBjbGVhbnVwLCAiQ2FuJ3Qgb3BlbiAvcHJv
Yy9tZW1pbmZvIik7CisJfQorCisJd2hpbGUgKGZnZXRzKGJ1ZmYsQlVGRkVSX1NJWkUsIGYpICE9
IE5VTEwpIHsKKwkJaWYoKHJldGNvZGUgPSBzc2NhbmYoYnVmZiwgIkh1Z2VwYWdlc2l6ZTogJWx1
IGtCIiwgJm9uZV9odWdlcGFnZV9zaXplKSkgPT0gMSkKKwkJCWJyZWFrOworCX0KKwl0c3RfcmVz
bShUSU5GTywgIm9uZSBodWdlcGFnZXNpemUgaXMgJWx1Iiwgb25lX2h1Z2VwYWdlX3NpemUpOwor
CWZjbG9zZShmKTsKKwkKKwlpZihvbmVfaHVnZXBhZ2Vfc2l6ZSA9PSAwKSB7CisJCXRzdF9icmtt
KFRGQUlMLCBjbGVhbnVwLCAiQ2FuJ3QgcmVhZCBvbmUgaHVnZXBhZ2Ugc2l6ZSIpOworCX0KKwkK
KwlyZXR1cm4gb25lX2h1Z2VwYWdlX3NpemUgKiAxMDI0VUw7Cit9CisKKy8qIHRyeSB0byBhbGxv
YyBucl9odWdlcGFnZXMgaHVnZXBhZ2VzICovCitpbnQgYWxsb2NfaHVnZXBhZ2VzKGludCBucl9o
dWdlcGFnZXMpCit7CisJY2hhciAqYWRkcjsKKwlpbnQgZmQ7CisJdW5zaWduZWQgbG9uZyBsZW5n
dGggPSAwOworCXVuc2lnbmVkIGxvbmcgb25lX2h1Z2VwYWdlX3NpemUgPSAwOworCisJLyogbW91
bnQgaHVnZXRsYmZzICovCisJaWYgKHN5c3RlbSgibW91bnQgLXQgaHVnZXRsYmZzIG5vZGV2IC9t
bnQiKSAhPSAwKSB7CisJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAiQ2FuJ3QgbW91bnQgaHVn
ZXRsYmZzIik7CisJfQorCisJZmQgPSBvcGVuKEZJTEVfTkFNRSwgT19DUkVBVCB8IE9fUkRXUiwg
MDc1NSk7CisJaWYgKGZkIDwgMCkgeworCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgIk9QRU4g
RmlsZSAlcyBlcnJvciIsIEZJTEVfTkFNRSk7CisJCXRzdF9leGl0KCk7CisJfQorCQorCW9uZV9o
dWdlcGFnZV9zaXplID0gZ2V0X29uZV9odWdlcGFnZV9zaXplKCk7CisJbGVuZ3RoID0gbnJfaHVn
ZXBhZ2VzICogb25lX2h1Z2VwYWdlX3NpemU7CisJYWRkciA9IChjaGFyICopbW1hcChBRERSLCBs
ZW5ndGgsIFBST1RFQ1RJT04sIEZMQUdTLCBmZCwgMCk7CisJaWYgKGFkZHIgPT0gTUFQX0ZBSUxF
RCkgeworCQl0c3RfcmVzbShUSU5GTywgIm1tYXAoKSBGYWlsZWQgb24gJXMsIGVycm5vPSVkIDog
JXMiLCBcCisJCQkJRklMRV9OQU1FLCBlcnJubywgc3RyZXJyb3IoZXJybm8pKTsKKwkJbXVubWFw
KGFkZHIsIGxlbmd0aCk7CisJCWNsb3NlKGZkKTsKKwkJdW5saW5rKEZJTEVfTkFNRSk7CisJCXJl
dHVybiAtMTsKKwl9CisKKwl0c3RfcmVzbShUSU5GTywgIlJldHVybmVkIGFkZHJlc3MgaXMgJXAi
LCBhZGRyKTsKKwl0c3RfcmVzbShUSU5GTywgIkZpcnN0IGhleCBpcyAleCIsICooKHVuc2lnbmVk
IGludCAqKWFkZHIpKTsKKworCW11bm1hcChhZGRyLCBsZW5ndGgpOworCWNsb3NlKGZkKTsKKwl1
bmxpbmsoRklMRV9OQU1FKTsKKwkKKwlyZXR1cm4gMDsKKworfQorCit2b2lkIGNsZWFudXAodm9p
ZCkKK3sKKwlzZXRfaHVnZXBhZ2VzKG9sZF9odWdlcGFnZXMpOworCXRzdF9leGl0KCk7CisKKwly
ZXR1cm47Cit9Ci0tIAoxLjcuMy40Cgo=
------=_Part_670082_1241449760.1301482784913
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
------=_Part_670082_1241449760.1301482784913
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_670082_1241449760.1301482784913--

