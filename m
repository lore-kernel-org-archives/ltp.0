Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PzZ10-00039I-1w
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 18:30:42 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PzZ0y-0003nW-FM
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 18:30:41 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2FIUYAP014303
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Mar 2011 14:30:34 -0400
Message-ID: <4D7FB02B.2040904@redhat.com>
Date: Wed, 16 Mar 2011 02:30:03 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010506070303000301070106"
Subject: [LTP] [PATCH] mm: hugemmap05: fix hardcoded hugepagesize
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
To: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010506070303000301070106
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

1. Hugepagesize differs from platforms, thus the directory
/sys/kernel/mm/hugepages/hugepages-<hugepagesize>kB/ cannot be simply
defined as "2M", this patch uses functions instead. The sysfs tunable
files are declared as global variables and definied within the function.

2. Still the hugepagesize problem, the test wanted to allocate nr=
"length/2" pages, however since pagesizes are different, the macro "MB"
is not correct either. Using "hugepagesize / 2" instead.

Applied this patch hugemmap05 can PASS all 4 subtests in my RHEL6
system.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |  105
++++++++++++++------
 1 files changed, 74 insertions(+), 31 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 910b75c..0b1f399 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -1,7 +1,7 @@
 /*
- * overcommit libhugetlbfs and check the statistics.
+ * overcommit hugetlbfs and check the statistics.
  *
- * libhugetlbfs allows to overcommit hugepages and there are tunables in
+ * hugetlbfs allows to overcommit hugepages and there are tunables in
  * sysfs and procfs. The test here want to ensure it is possible to
  * overcommit by either mmap or shared memory. Also ensure those
  * reservation can be read/write, and several statistics work correctly.
@@ -52,18 +52,18 @@

 #define PROTECTION		(PROT_READ | PROT_WRITE)
 #define PATH_MEMINFO		"/proc/meminfo"
-#define PATH_SYS_HUGE		"/sys/kernel/mm/hugepages"
-#define PATH_SYS_2M		PATH_SYS_HUGE "/hugepages-2048kB/"
-#define PATH_SYS_2M_OVER	PATH_SYS_2M "nr_overcommit_hugepages"
-#define PATH_SYS_2M_FREE	PATH_SYS_2M "free_hugepages"
-#define PATH_SYS_2M_RESV	PATH_SYS_2M "resv_hugepages"
-#define PATH_SYS_2M_SURP	PATH_SYS_2M "surplus_hugepages"
-#define PATH_SYS_2M_HUGE	PATH_SYS_2M "nr_hugepages"
+
+char path_sys_sz[BUFSIZ];
+char path_sys_sz_over[BUFSIZ];
+char path_sys_sz_free[BUFSIZ];
+char path_sys_sz_resv[BUFSIZ];
+char path_sys_sz_surp[BUFSIZ];
+char path_sys_sz_huge[BUFSIZ];
+
 #define PATH_PROC_VM		"/proc/sys/vm/"
 #define PATH_PROC_OVER		PATH_PROC_VM "nr_overcommit_hugepages"
 #define PATH_PROC_HUGE		PATH_PROC_VM "nr_hugepages"
 #define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
-#define MB			(1024 * 1024)

 /* Only ia64 requires this */
 #ifdef __ia64__
@@ -86,6 +86,7 @@ static char nr_hugepages[BUFSIZ],
nr_overcommit_hugepages[BUFSIZ];
 static char buf[BUFSIZ], line[BUFSIZ], path[BUFSIZ], pathover[BUFSIZ];
 static char shmmax[BUFSIZ];
 static char *opt_allocstr;
+static int hugepagesize; /* in Byte */
 static int opt_sysfs, opt_alloc;
 static int shmid = -1;
 static int restore_shmmax = 0;
@@ -105,20 +106,25 @@ static int lookup (char *line, char *pattern);
 static void usage(void);
 static int checkproc(FILE *fp, char *string, int value);
 static int checksys(char *path, char *pattern, int value);
+static void get_hugepagesize(void);
+static void get_sys_sz_paths(void);

 int main(int argc, char *argv[])
 {
 	int lc;
 	char *msg;

+	get_hugepagesize();
+	get_sys_sz_paths();
+
 	msg = parse_opts(argc, argv, options, usage);
 	if (msg != NULL)
 		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 	if (opt_sysfs) {
-		strncpy(path, PATH_SYS_2M_HUGE,
-			strlen(PATH_SYS_2M_HUGE) + 1);
-		strncpy(pathover, PATH_SYS_2M_OVER,
-			strlen(PATH_SYS_2M_OVER) + 1);
+		strncpy(path, path_sys_sz_huge,
+			strlen(path_sys_sz_huge) + 1);
+		strncpy(pathover, path_sys_sz_over,
+			strlen(path_sys_sz_over) + 1);
 	} else {
 		strncpy(path, PATH_PROC_HUGE,
 			strlen(PATH_PROC_HUGE) + 1);
@@ -150,7 +156,7 @@ static void overcommit(void)
 		key = ftok(PATH_MEMINFO, strlen(PATH_MEMINFO));
 		if (key == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "ftok");
-		shmid = shmget(key, (long)(length * MB),
+		shmid = shmget(key, (long)(length / 2 * hugepagesize),
 			SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W);
 		if (shmid == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "shmget");
@@ -160,24 +166,24 @@ static void overcommit(void)
 		fd = open(s, O_CREAT | O_RDWR, 0755);
 		if (fd == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "open");
-		addr = mmap(ADDR, (long)(length * MB), PROTECTION, FLAGS, fd,
-			0);
+		addr = mmap(ADDR, (long)(length / 2 * hugepagesize), PROTECTION,
+				FLAGS, fd, 0);
 		if (addr == MAP_FAILED)
 			tst_brkm(TBROK|TERRNO, cleanup, "mmap");
 	}

 	if (opt_sysfs) {
 		tst_resm(TINFO, "check sysfs before allocation.");
-		if (checksys(PATH_SYS_2M_HUGE, "HugePages_Total",
+		if (checksys(path_sys_sz_huge, "HugePages_Total",
 				length / 2) != 0)
 			return;
-		if (checksys(PATH_SYS_2M_FREE, "HugePages_Free",
+		if (checksys(path_sys_sz_free, "HugePages_Free",
 				length / 2) != 0)
 			return;
-		if (checksys(PATH_SYS_2M_SURP, "HugePages_Surp",
+		if (checksys(path_sys_sz_surp, "HugePages_Surp",
 				length / 2 - size) != 0)
 			return;
-		if (checksys(PATH_SYS_2M_RESV, "HugePages_Rsvd",
+		if (checksys(path_sys_sz_resv, "HugePages_Rsvd",
 				length / 2) != 0)
 			return;
 	} else {
@@ -209,16 +215,16 @@ static void overcommit(void)
 	}
 	if (opt_sysfs) {
 		tst_resm(TINFO, "check sysfs.");
-		if (checksys(PATH_SYS_2M_HUGE, "HugePages_Total",
+		if (checksys(path_sys_sz_huge, "HugePages_Total",
 				length / 2) != 0)
 			return;
-		if (checksys(PATH_SYS_2M_FREE, "HugePages_Free", 0)
+		if (checksys(path_sys_sz_free, "HugePages_Free", 0)
 			!= 0)
 			return;
-		if (checksys(PATH_SYS_2M_SURP, "HugePages_Surp",
+		if (checksys(path_sys_sz_surp, "HugePages_Surp",
 				length / 2 - size) != 0)
 			return;
-		if (checksys(PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
+		if (checksys(path_sys_sz_resv, "HugePages_Rsvd", 0)
 			!= 0)
 			return;
 	} else {
@@ -240,7 +246,7 @@ static void overcommit(void)
 		if (shmdt(shmaddr) != 0)
 			tst_brkm(TBROK|TERRNO, cleanup, "shmdt");
 	} else {
-		munmap(addr, (long)(length * MB));
+		munmap(addr, (long)(length / 2 * hugepagesize));
 		close(fd);
 		unlink(s);
 	}
@@ -282,7 +288,7 @@ static void cleanup(void)
 	if (umount(buf) == -1)
 		tst_resm(TWARN|TERRNO, "umount");
 	if (shmid != -1) {
-		tst_resm(TINFO|TERRNO, "shmdt");
+		tst_resm(TINFO, "shmdt cleaning");
 		shmctl(shmid, IPC_RMID, NULL);
 	}
 	TEST_CLEANUP;
@@ -307,12 +313,12 @@ static void setup(void)
 			tst_brkm(TBROK|TERRNO, cleanup, "fgets");
 		fclose(fp);

-		if (atol(shmmax) < (long)(length * MB)) {
+		if (atol(shmmax) < (long)(length / 2 * hugepagesize)) {
 			restore_shmmax = 1;
 			fd = open(PATH_SHMMAX, O_RDWR);
 			if (fd == -1)
 				tst_brkm(TBROK|TERRNO, cleanup, "open");
-			snprintf(buf, BUFSIZ, "%ld", (long)(length * MB));
+			snprintf(buf, BUFSIZ, "%ld", (long)(length / 2 * hugepagesize));
 			if (write(fd, buf, strlen(buf)) != strlen(buf))
 				tst_brkm(TBROK|TERRNO, cleanup,
 					"failed to change shmmax.");
@@ -378,7 +384,7 @@ static void write_bytes(void *addr)
 {
 	long i;

-	for (i = 0; i < (long)(length * MB); i++)
+	for (i = 0; i < (long)(length / 2 * hugepagesize); i++)
 		((char *)addr)[i] = '\a';
 }

@@ -387,7 +393,7 @@ static void read_bytes(void *addr)
 	long i;

 	tst_resm(TINFO, "First hex is %x", *((unsigned int *)addr));
-	for (i = 0; i < (long)(length * MB); i++) {
+	for (i = 0; i < (long)(length / 2 * hugepagesize); i++) {
 		if (((char *)addr)[i] != '\a') {
 			tst_resm(TFAIL, "mismatch at %ld", i);
 			break;
@@ -453,3 +459,40 @@ static int checkproc(FILE *fp, char *pattern, int
value)
 	}
 	return 0;
 }
+
+static void get_hugepagesize(void)
+{
+	FILE *fp;
+
+	memset(buf, -1, BUFSIZ);
+	if ((fp = fopen(PATH_MEMINFO, "r")) == NULL)
+		tst_brkm(TBROK, NULL, "can't open %s", PATH_MEMINFO);
+	while (fgets(line, BUFSIZ, fp) != NULL) {
+		if (lookup(line, "Hugepagesize")) {
+			tst_resm(TINFO, "Hugepagesize is %d kB", atoi(buf));
+			hugepagesize = atoi(buf) * 1024;
+			return;
+		}
+	}
+	tst_brkm(TBROK, NULL, "get Hugepagesize failed.");
+}
+
+/*
+ * It's not easy to #define tunable file paths via sysfs,
+ * use function get_hugepagesize and global variable instead.
+ */
+static void get_sys_sz_paths(void)
+{
+	sprintf(path_sys_sz, "/sys/kernel/mm/hugepages/hugepages-%dkB",
+			hugepagesize / 1024);
+	sprintf(path_sys_sz_over, "%s/nr_overcommit_hugepages",
+			path_sys_sz);
+	sprintf(path_sys_sz_free, "%s/free_hugepages",
+			path_sys_sz);
+	sprintf(path_sys_sz_resv, "%s/resv_hugepages",
+			path_sys_sz);
+	sprintf(path_sys_sz_surp, "%s/surplus_hugepages",
+			path_sys_sz);
+	sprintf(path_sys_sz_huge, "%s/nr_hugepages",
+			path_sys_sz);
+}
-- 
1.7.4.1


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------010506070303000301070106
Content-Type: text/plain;
	name="0001-mm-hugemmap05-fix-hardcoded-hugepagesize.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-mm-hugemmap05-fix-hardcoded-hugepagesize.patch"

MS4gSHVnZXBhZ2VzaXplIGRpZmZlcnMgZnJvbSBwbGF0Zm9ybXMsIHRodXMgdGhlIGRpcmVj
dG9yeQovc3lzL2tlcm5lbC9tbS9odWdlcGFnZXMvaHVnZXBhZ2VzLTxodWdlcGFnZXNpemU+
a0IvIGNhbm5vdCBiZSBzaW1wbHkKZGVmaW5lZCBhcyAiMk0iLCB0aGlzIHBhdGNoIHVzZXMg
ZnVuY3Rpb25zIGluc3RlYWQuIFRoZSBzeXNmcyB0dW5hYmxlCmZpbGVzIGFyZSBkZWNsYXJl
ZCBhcyBnbG9iYWwgdmFyaWFibGVzIGFuZCBkZWZpbmllZCB3aXRoaW4gdGhlIGZ1bmN0aW9u
LgoKMi4gU3RpbGwgdGhlIGh1Z2VwYWdlc2l6ZSBwcm9ibGVtLCB0aGUgdGVzdCB3YW50ZWQg
dG8gYWxsb2NhdGUgbnI9CiJsZW5ndGgvMiIgcGFnZXMsIGhvd2V2ZXIgc2luY2UgcGFnZXNp
emVzIGFyZSBkaWZmZXJlbnQsIHRoZSBtYWNybyAiTUIiCmlzIG5vdCBjb3JyZWN0IGVpdGhl
ci4gVXNpbmcgImh1Z2VwYWdlc2l6ZSAvIDIiIGluc3RlYWQuCgpBcHBsaWVkIHRoaXMgcGF0
Y2ggaHVnZW1tYXAwNSBjYW4gUEFTUyBhbGwgNCBzdWJ0ZXN0cyBpbiBteSBSSEVMNgpzeXN0
ZW0uCgpTaWduZWQtb2ZmLWJ5OiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29tPgot
LS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAwNS5j
IHwgIDEwNSArKysrKysrKysrKysrKy0tLS0tLQogMSBmaWxlcyBjaGFuZ2VkLCA3NCBpbnNl
cnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMDUuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAwNS5jCmluZGV4IDkxMGI3NWMuLjBi
MWYzOTkgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1t
YXAvaHVnZW1tYXAwNS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZW1tYXAvaHVnZW1tYXAwNS5jCkBAIC0xLDcgKzEsNyBAQAogLyoKLSAqIG92ZXJjb21taXQg
bGliaHVnZXRsYmZzIGFuZCBjaGVjayB0aGUgc3RhdGlzdGljcy4KKyAqIG92ZXJjb21taXQg
aHVnZXRsYmZzIGFuZCBjaGVjayB0aGUgc3RhdGlzdGljcy4KICAqCi0gKiBsaWJodWdldGxi
ZnMgYWxsb3dzIHRvIG92ZXJjb21taXQgaHVnZXBhZ2VzIGFuZCB0aGVyZSBhcmUgdHVuYWJs
ZXMgaW4KKyAqIGh1Z2V0bGJmcyBhbGxvd3MgdG8gb3ZlcmNvbW1pdCBodWdlcGFnZXMgYW5k
IHRoZXJlIGFyZSB0dW5hYmxlcyBpbgogICogc3lzZnMgYW5kIHByb2Nmcy4gVGhlIHRlc3Qg
aGVyZSB3YW50IHRvIGVuc3VyZSBpdCBpcyBwb3NzaWJsZSB0bwogICogb3ZlcmNvbW1pdCBi
eSBlaXRoZXIgbW1hcCBvciBzaGFyZWQgbWVtb3J5LiBBbHNvIGVuc3VyZSB0aG9zZQogICog
cmVzZXJ2YXRpb24gY2FuIGJlIHJlYWQvd3JpdGUsIGFuZCBzZXZlcmFsIHN0YXRpc3RpY3Mg
d29yayBjb3JyZWN0bHkuCkBAIC01MiwxOCArNTIsMTggQEAKIAogI2RlZmluZSBQUk9URUNU
SU9OCQkoUFJPVF9SRUFEIHwgUFJPVF9XUklURSkKICNkZWZpbmUgUEFUSF9NRU1JTkZPCQki
L3Byb2MvbWVtaW5mbyIKLSNkZWZpbmUgUEFUSF9TWVNfSFVHRQkJIi9zeXMva2VybmVsL21t
L2h1Z2VwYWdlcyIKLSNkZWZpbmUgUEFUSF9TWVNfMk0JCVBBVEhfU1lTX0hVR0UgIi9odWdl
cGFnZXMtMjA0OGtCLyIKLSNkZWZpbmUgUEFUSF9TWVNfMk1fT1ZFUglQQVRIX1NZU18yTSAi
bnJfb3ZlcmNvbW1pdF9odWdlcGFnZXMiCi0jZGVmaW5lIFBBVEhfU1lTXzJNX0ZSRUUJUEFU
SF9TWVNfMk0gImZyZWVfaHVnZXBhZ2VzIgotI2RlZmluZSBQQVRIX1NZU18yTV9SRVNWCVBB
VEhfU1lTXzJNICJyZXN2X2h1Z2VwYWdlcyIKLSNkZWZpbmUgUEFUSF9TWVNfMk1fU1VSUAlQ
QVRIX1NZU18yTSAic3VycGx1c19odWdlcGFnZXMiCi0jZGVmaW5lIFBBVEhfU1lTXzJNX0hV
R0UJUEFUSF9TWVNfMk0gIm5yX2h1Z2VwYWdlcyIKKworY2hhciBwYXRoX3N5c19zeltCVUZT
SVpdOworY2hhciBwYXRoX3N5c19zel9vdmVyW0JVRlNJWl07CitjaGFyIHBhdGhfc3lzX3N6
X2ZyZWVbQlVGU0laXTsKK2NoYXIgcGF0aF9zeXNfc3pfcmVzdltCVUZTSVpdOworY2hhciBw
YXRoX3N5c19zel9zdXJwW0JVRlNJWl07CitjaGFyIHBhdGhfc3lzX3N6X2h1Z2VbQlVGU0la
XTsKKwogI2RlZmluZSBQQVRIX1BST0NfVk0JCSIvcHJvYy9zeXMvdm0vIgogI2RlZmluZSBQ
QVRIX1BST0NfT1ZFUgkJUEFUSF9QUk9DX1ZNICJucl9vdmVyY29tbWl0X2h1Z2VwYWdlcyIK
ICNkZWZpbmUgUEFUSF9QUk9DX0hVR0UJCVBBVEhfUFJPQ19WTSAibnJfaHVnZXBhZ2VzIgog
I2RlZmluZSBQQVRIX1NITU1BWAkJIi9wcm9jL3N5cy9rZXJuZWwvc2htbWF4IgotI2RlZmlu
ZSBNQgkJCSgxMDI0ICogMTAyNCkKIAogLyogT25seSBpYTY0IHJlcXVpcmVzIHRoaXMgKi8K
ICNpZmRlZiBfX2lhNjRfXwpAQCAtODYsNiArODYsNyBAQCBzdGF0aWMgY2hhciBucl9odWdl
cGFnZXNbQlVGU0laXSwgbnJfb3ZlcmNvbW1pdF9odWdlcGFnZXNbQlVGU0laXTsKIHN0YXRp
YyBjaGFyIGJ1ZltCVUZTSVpdLCBsaW5lW0JVRlNJWl0sIHBhdGhbQlVGU0laXSwgcGF0aG92
ZXJbQlVGU0laXTsKIHN0YXRpYyBjaGFyIHNobW1heFtCVUZTSVpdOwogc3RhdGljIGNoYXIg
Km9wdF9hbGxvY3N0cjsKK3N0YXRpYyBpbnQgaHVnZXBhZ2VzaXplOyAvKiBpbiBCeXRlICov
CiBzdGF0aWMgaW50IG9wdF9zeXNmcywgb3B0X2FsbG9jOwogc3RhdGljIGludCBzaG1pZCA9
IC0xOwogc3RhdGljIGludCByZXN0b3JlX3NobW1heCA9IDA7CkBAIC0xMDUsMjAgKzEwNiwy
NSBAQCBzdGF0aWMgaW50IGxvb2t1cCAoY2hhciAqbGluZSwgY2hhciAqcGF0dGVybik7CiBz
dGF0aWMgdm9pZCB1c2FnZSh2b2lkKTsKIHN0YXRpYyBpbnQgY2hlY2twcm9jKEZJTEUgKmZw
LCBjaGFyICpzdHJpbmcsIGludCB2YWx1ZSk7CiBzdGF0aWMgaW50IGNoZWNrc3lzKGNoYXIg
KnBhdGgsIGNoYXIgKnBhdHRlcm4sIGludCB2YWx1ZSk7CitzdGF0aWMgdm9pZCBnZXRfaHVn
ZXBhZ2VzaXplKHZvaWQpOworc3RhdGljIHZvaWQgZ2V0X3N5c19zel9wYXRocyh2b2lkKTsK
IAogaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsKIAlpbnQgbGM7CiAJY2hh
ciAqbXNnOwogCisJZ2V0X2h1Z2VwYWdlc2l6ZSgpOworCWdldF9zeXNfc3pfcGF0aHMoKTsK
KwogCW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgb3B0aW9ucywgdXNhZ2UpOwogCWlm
IChtc2cgIT0gTlVMTCkKIAkJdHN0X2Jya20oVEJST0ssIHRzdF9leGl0LCAiT1BUSU9OIFBB
UlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CiAJaWYgKG9wdF9zeXNmcykgewotCQlzdHJuY3B5
KHBhdGgsIFBBVEhfU1lTXzJNX0hVR0UsCi0JCQlzdHJsZW4oUEFUSF9TWVNfMk1fSFVHRSkg
KyAxKTsKLQkJc3RybmNweShwYXRob3ZlciwgUEFUSF9TWVNfMk1fT1ZFUiwKLQkJCXN0cmxl
bihQQVRIX1NZU18yTV9PVkVSKSArIDEpOworCQlzdHJuY3B5KHBhdGgsIHBhdGhfc3lzX3N6
X2h1Z2UsCisJCQlzdHJsZW4ocGF0aF9zeXNfc3pfaHVnZSkgKyAxKTsKKwkJc3RybmNweShw
YXRob3ZlciwgcGF0aF9zeXNfc3pfb3ZlciwKKwkJCXN0cmxlbihwYXRoX3N5c19zel9vdmVy
KSArIDEpOwogCX0gZWxzZSB7CiAJCXN0cm5jcHkocGF0aCwgUEFUSF9QUk9DX0hVR0UsCiAJ
CQlzdHJsZW4oUEFUSF9QUk9DX0hVR0UpICsgMSk7CkBAIC0xNTAsNyArMTU2LDcgQEAgc3Rh
dGljIHZvaWQgb3ZlcmNvbW1pdCh2b2lkKQogCQlrZXkgPSBmdG9rKFBBVEhfTUVNSU5GTywg
c3RybGVuKFBBVEhfTUVNSU5GTykpOwogCQlpZiAoa2V5ID09IC0xKQogCQkJdHN0X2Jya20o
VEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiZnRvayIpOwotCQlzaG1pZCA9IHNobWdldChrZXks
IChsb25nKShsZW5ndGggKiBNQiksCisJCXNobWlkID0gc2htZ2V0KGtleSwgKGxvbmcpKGxl
bmd0aCAvIDIgKiBodWdlcGFnZXNpemUpLAogCQkJU0hNX0hVR0VUTEIgfCBJUENfQ1JFQVQg
fCBTSE1fUiB8IFNITV9XKTsKIAkJaWYgKHNobWlkID09IC0xKQogCQkJdHN0X2Jya20oVEJS
T0t8VEVSUk5PLCBjbGVhbnVwLCAic2htZ2V0Iik7CkBAIC0xNjAsMjQgKzE2NiwyNCBAQCBz
dGF0aWMgdm9pZCBvdmVyY29tbWl0KHZvaWQpCiAJCWZkID0gb3BlbihzLCBPX0NSRUFUIHwg
T19SRFdSLCAwNzU1KTsKIAkJaWYgKGZkID09IC0xKQogCQkJdHN0X2Jya20oVEJST0t8VEVS
Uk5PLCBjbGVhbnVwLCAib3BlbiIpOwotCQlhZGRyID0gbW1hcChBRERSLCAobG9uZykobGVu
Z3RoICogTUIpLCBQUk9URUNUSU9OLCBGTEFHUywgZmQsCi0JCQkwKTsKKwkJYWRkciA9IG1t
YXAoQUREUiwgKGxvbmcpKGxlbmd0aCAvIDIgKiBodWdlcGFnZXNpemUpLCBQUk9URUNUSU9O
LAorCQkJCUZMQUdTLCBmZCwgMCk7CiAJCWlmIChhZGRyID09IE1BUF9GQUlMRUQpCiAJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJtbWFwIik7CiAJfQogCiAJaWYgKG9w
dF9zeXNmcykgewogCQl0c3RfcmVzbShUSU5GTywgImNoZWNrIHN5c2ZzIGJlZm9yZSBhbGxv
Y2F0aW9uLiIpOwotCQlpZiAoY2hlY2tzeXMoUEFUSF9TWVNfMk1fSFVHRSwgIkh1Z2VQYWdl
c19Ub3RhbCIsCisJCWlmIChjaGVja3N5cyhwYXRoX3N5c19zel9odWdlLCAiSHVnZVBhZ2Vz
X1RvdGFsIiwKIAkJCQlsZW5ndGggLyAyKSAhPSAwKQogCQkJcmV0dXJuOwotCQlpZiAoY2hl
Y2tzeXMoUEFUSF9TWVNfMk1fRlJFRSwgIkh1Z2VQYWdlc19GcmVlIiwKKwkJaWYgKGNoZWNr
c3lzKHBhdGhfc3lzX3N6X2ZyZWUsICJIdWdlUGFnZXNfRnJlZSIsCiAJCQkJbGVuZ3RoIC8g
MikgIT0gMCkKIAkJCXJldHVybjsKLQkJaWYgKGNoZWNrc3lzKFBBVEhfU1lTXzJNX1NVUlAs
ICJIdWdlUGFnZXNfU3VycCIsCisJCWlmIChjaGVja3N5cyhwYXRoX3N5c19zel9zdXJwLCAi
SHVnZVBhZ2VzX1N1cnAiLAogCQkJCWxlbmd0aCAvIDIgLSBzaXplKSAhPSAwKQogCQkJcmV0
dXJuOwotCQlpZiAoY2hlY2tzeXMoUEFUSF9TWVNfMk1fUkVTViwgIkh1Z2VQYWdlc19Sc3Zk
IiwKKwkJaWYgKGNoZWNrc3lzKHBhdGhfc3lzX3N6X3Jlc3YsICJIdWdlUGFnZXNfUnN2ZCIs
CiAJCQkJbGVuZ3RoIC8gMikgIT0gMCkKIAkJCXJldHVybjsKIAl9IGVsc2UgewpAQCAtMjA5
LDE2ICsyMTUsMTYgQEAgc3RhdGljIHZvaWQgb3ZlcmNvbW1pdCh2b2lkKQogCX0KIAlpZiAo
b3B0X3N5c2ZzKSB7CiAJCXRzdF9yZXNtKFRJTkZPLCAiY2hlY2sgc3lzZnMuIik7Ci0JCWlm
IChjaGVja3N5cyhQQVRIX1NZU18yTV9IVUdFLCAiSHVnZVBhZ2VzX1RvdGFsIiwKKwkJaWYg
KGNoZWNrc3lzKHBhdGhfc3lzX3N6X2h1Z2UsICJIdWdlUGFnZXNfVG90YWwiLAogCQkJCWxl
bmd0aCAvIDIpICE9IDApCiAJCQlyZXR1cm47Ci0JCWlmIChjaGVja3N5cyhQQVRIX1NZU18y
TV9GUkVFLCAiSHVnZVBhZ2VzX0ZyZWUiLCAwKQorCQlpZiAoY2hlY2tzeXMocGF0aF9zeXNf
c3pfZnJlZSwgIkh1Z2VQYWdlc19GcmVlIiwgMCkKIAkJCSE9IDApCiAJCQlyZXR1cm47Ci0J
CWlmIChjaGVja3N5cyhQQVRIX1NZU18yTV9TVVJQLCAiSHVnZVBhZ2VzX1N1cnAiLAorCQlp
ZiAoY2hlY2tzeXMocGF0aF9zeXNfc3pfc3VycCwgIkh1Z2VQYWdlc19TdXJwIiwKIAkJCQls
ZW5ndGggLyAyIC0gc2l6ZSkgIT0gMCkKIAkJCXJldHVybjsKLQkJaWYgKGNoZWNrc3lzKFBB
VEhfU1lTXzJNX1JFU1YsICJIdWdlUGFnZXNfUnN2ZCIsIDApCisJCWlmIChjaGVja3N5cyhw
YXRoX3N5c19zel9yZXN2LCAiSHVnZVBhZ2VzX1JzdmQiLCAwKQogCQkJIT0gMCkKIAkJCXJl
dHVybjsKIAl9IGVsc2UgewpAQCAtMjQwLDcgKzI0Niw3IEBAIHN0YXRpYyB2b2lkIG92ZXJj
b21taXQodm9pZCkKIAkJaWYgKHNobWR0KHNobWFkZHIpICE9IDApCiAJCQl0c3RfYnJrbShU
QlJPS3xURVJSTk8sIGNsZWFudXAsICJzaG1kdCIpOwogCX0gZWxzZSB7Ci0JCW11bm1hcChh
ZGRyLCAobG9uZykobGVuZ3RoICogTUIpKTsKKwkJbXVubWFwKGFkZHIsIChsb25nKShsZW5n
dGggLyAyICogaHVnZXBhZ2VzaXplKSk7CiAJCWNsb3NlKGZkKTsKIAkJdW5saW5rKHMpOwog
CX0KQEAgLTI4Miw3ICsyODgsNyBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCiAJaWYg
KHVtb3VudChidWYpID09IC0xKQogCQl0c3RfcmVzbShUV0FSTnxURVJSTk8sICJ1bW91bnQi
KTsKIAlpZiAoc2htaWQgIT0gLTEpIHsKLQkJdHN0X3Jlc20oVElORk98VEVSUk5PLCAic2ht
ZHQiKTsKKwkJdHN0X3Jlc20oVElORk8sICJzaG1kdCBjbGVhbmluZyIpOwogCQlzaG1jdGwo
c2htaWQsIElQQ19STUlELCBOVUxMKTsKIAl9CiAJVEVTVF9DTEVBTlVQOwpAQCAtMzA3LDEy
ICszMTMsMTIgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKIAkJCXRzdF9icmttKFRCUk9L
fFRFUlJOTywgY2xlYW51cCwgImZnZXRzIik7CiAJCWZjbG9zZShmcCk7CiAKLQkJaWYgKGF0
b2woc2htbWF4KSA8IChsb25nKShsZW5ndGggKiBNQikpIHsKKwkJaWYgKGF0b2woc2htbWF4
KSA8IChsb25nKShsZW5ndGggLyAyICogaHVnZXBhZ2VzaXplKSkgewogCQkJcmVzdG9yZV9z
aG1tYXggPSAxOwogCQkJZmQgPSBvcGVuKFBBVEhfU0hNTUFYLCBPX1JEV1IpOwogCQkJaWYg
KGZkID09IC0xKQogCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm9wZW4i
KTsKLQkJCXNucHJpbnRmKGJ1ZiwgQlVGU0laLCAiJWxkIiwgKGxvbmcpKGxlbmd0aCAqIE1C
KSk7CisJCQlzbnByaW50ZihidWYsIEJVRlNJWiwgIiVsZCIsIChsb25nKShsZW5ndGggLyAy
ICogaHVnZXBhZ2VzaXplKSk7CiAJCQlpZiAod3JpdGUoZmQsIGJ1Ziwgc3RybGVuKGJ1Zikp
ICE9IHN0cmxlbihidWYpKQogCQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwK
IAkJCQkJImZhaWxlZCB0byBjaGFuZ2Ugc2htbWF4LiIpOwpAQCAtMzc4LDcgKzM4NCw3IEBA
IHN0YXRpYyB2b2lkIHdyaXRlX2J5dGVzKHZvaWQgKmFkZHIpCiB7CiAJbG9uZyBpOwogCi0J
Zm9yIChpID0gMDsgaSA8IChsb25nKShsZW5ndGggKiBNQik7IGkrKykKKwlmb3IgKGkgPSAw
OyBpIDwgKGxvbmcpKGxlbmd0aCAvIDIgKiBodWdlcGFnZXNpemUpOyBpKyspCiAJCSgoY2hh
ciAqKWFkZHIpW2ldID0gJ1xhJzsKIH0KIApAQCAtMzg3LDcgKzM5Myw3IEBAIHN0YXRpYyB2
b2lkIHJlYWRfYnl0ZXModm9pZCAqYWRkcikKIAlsb25nIGk7CiAKIAl0c3RfcmVzbShUSU5G
TywgIkZpcnN0IGhleCBpcyAleCIsICooKHVuc2lnbmVkIGludCAqKWFkZHIpKTsKLQlmb3Ig
KGkgPSAwOyBpIDwgKGxvbmcpKGxlbmd0aCAqIE1CKTsgaSsrKSB7CisJZm9yIChpID0gMDsg
aSA8IChsb25nKShsZW5ndGggLyAyICogaHVnZXBhZ2VzaXplKTsgaSsrKSB7CiAJCWlmICgo
KGNoYXIgKilhZGRyKVtpXSAhPSAnXGEnKSB7CiAJCQl0c3RfcmVzbShURkFJTCwgIm1pc21h
dGNoIGF0ICVsZCIsIGkpOwogCQkJYnJlYWs7CkBAIC00NTMsMyArNDU5LDQwIEBAIHN0YXRp
YyBpbnQgY2hlY2twcm9jKEZJTEUgKmZwLCBjaGFyICpwYXR0ZXJuLCBpbnQgdmFsdWUpCiAJ
fQogCXJldHVybiAwOwogfQorCitzdGF0aWMgdm9pZCBnZXRfaHVnZXBhZ2VzaXplKHZvaWQp
Cit7CisJRklMRSAqZnA7CisKKwltZW1zZXQoYnVmLCAtMSwgQlVGU0laKTsKKwlpZiAoKGZw
ID0gZm9wZW4oUEFUSF9NRU1JTkZPLCAiciIpKSA9PSBOVUxMKQorCQl0c3RfYnJrbShUQlJP
SywgTlVMTCwgImNhbid0IG9wZW4gJXMiLCBQQVRIX01FTUlORk8pOworCXdoaWxlIChmZ2V0
cyhsaW5lLCBCVUZTSVosIGZwKSAhPSBOVUxMKSB7CisJCWlmIChsb29rdXAobGluZSwgIkh1
Z2VwYWdlc2l6ZSIpKSB7CisJCQl0c3RfcmVzbShUSU5GTywgIkh1Z2VwYWdlc2l6ZSBpcyAl
ZCBrQiIsIGF0b2koYnVmKSk7CisJCQlodWdlcGFnZXNpemUgPSBhdG9pKGJ1ZikgKiAxMDI0
OworCQkJcmV0dXJuOworCQl9CisJfQorCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiZ2V0IEh1
Z2VwYWdlc2l6ZSBmYWlsZWQuIik7Cit9CisKKy8qIAorICogSXQncyBub3QgZWFzeSB0byAj
ZGVmaW5lIHR1bmFibGUgZmlsZSBwYXRocyB2aWEgc3lzZnMsCisgKiB1c2UgZnVuY3Rpb24g
Z2V0X2h1Z2VwYWdlc2l6ZSBhbmQgZ2xvYmFsIHZhcmlhYmxlIGluc3RlYWQuIAorICovCitz
dGF0aWMgdm9pZCBnZXRfc3lzX3N6X3BhdGhzKHZvaWQpCit7CisJc3ByaW50ZihwYXRoX3N5
c19zeiwgIi9zeXMva2VybmVsL21tL2h1Z2VwYWdlcy9odWdlcGFnZXMtJWRrQiIsCisJCQlo
dWdlcGFnZXNpemUgLyAxMDI0KTsKKwlzcHJpbnRmKHBhdGhfc3lzX3N6X292ZXIsICIlcy9u
cl9vdmVyY29tbWl0X2h1Z2VwYWdlcyIsIAorCQkJcGF0aF9zeXNfc3opOworCXNwcmludGYo
cGF0aF9zeXNfc3pfZnJlZSwgIiVzL2ZyZWVfaHVnZXBhZ2VzIiwgCisJCQlwYXRoX3N5c19z
eik7CisJc3ByaW50ZihwYXRoX3N5c19zel9yZXN2LCAiJXMvcmVzdl9odWdlcGFnZXMiLCAK
KwkJCXBhdGhfc3lzX3N6KTsKKwlzcHJpbnRmKHBhdGhfc3lzX3N6X3N1cnAsICIlcy9zdXJw
bHVzX2h1Z2VwYWdlcyIsIAorCQkJcGF0aF9zeXNfc3opOworCXNwcmludGYocGF0aF9zeXNf
c3pfaHVnZSwgIiVzL25yX2h1Z2VwYWdlcyIsIAorCQkJcGF0aF9zeXNfc3opOworfQotLSAK
MS43LjQuMQoK
--------------010506070303000301070106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
--------------010506070303000301070106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010506070303000301070106--

