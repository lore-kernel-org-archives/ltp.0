Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PYTjq-0000dd-TM
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 01:25:02 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYTjp-00033h-8L
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 01:25:02 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBV1OttV006779
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Dec 2010 20:24:55 -0500
Date: Thu, 30 Dec 2010 20:24:55 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <307686026.100796.1293758695307.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <605627072.100793.1293758674932.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_100795_1232007200.1293758695306"
Subject: [LTP] [PATCH] hugemmap05: fix pathname to remove underscore
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

------=_Part_100795_1232007200.1293758695306
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |   68 ++++++++++----------
 1 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index bce9fe6..85fee4d 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -51,18 +51,18 @@
 #include "usctest.h"
 
 #define PROTECTION		(PROT_READ | PROT_WRITE)
-#define _PATH_MEMINFO		"/proc/meminfo"
-#define _PATH_SYS_HUGE		"/sys/kernel/mm/hugepages"
-#define _PATH_SYS_2M		_PATH_SYS_HUGE "/hugepages-2048kB/"
-#define _PATH_SYS_2M_OVER	_PATH_SYS_2M "nr_overcommit_hugepages"
-#define _PATH_SYS_2M_FREE	_PATH_SYS_2M "free_hugepages"
-#define _PATH_SYS_2M_RESV	_PATH_SYS_2M "resv_hugepages"
-#define _PATH_SYS_2M_SURP	_PATH_SYS_2M "surplus_hugepages"
-#define _PATH_SYS_2M_HUGE	_PATH_SYS_2M "nr_hugepages"
-#define _PATH_PROC_VM		"/proc/sys/vm/"
-#define _PATH_PROC_OVER		_PATH_PROC_VM "nr_overcommit_hugepages"
-#define _PATH_PROC_HUGE		_PATH_PROC_VM "nr_hugepages"
-#define _PATH_SHMMAX		"/proc/sys/kernel/shmmax"
+#define PATH_MEMINFO		"/proc/meminfo"
+#define PATH_SYS_HUGE		"/sys/kernel/mm/hugepages"
+#define PATH_SYS_2M		PATH_SYS_HUGE "/hugepages-2048kB/"
+#define PATH_SYS_2M_OVER	PATH_SYS_2M "nr_overcommit_hugepages"
+#define PATH_SYS_2M_FREE	PATH_SYS_2M "free_hugepages"
+#define PATH_SYS_2M_RESV	PATH_SYS_2M "resv_hugepages"
+#define PATH_SYS_2M_SURP	PATH_SYS_2M "surplus_hugepages"
+#define PATH_SYS_2M_HUGE	PATH_SYS_2M "nr_hugepages"
+#define PATH_PROC_VM		"/proc/sys/vm/"
+#define PATH_PROC_OVER		PATH_PROC_VM "nr_overcommit_hugepages"
+#define PATH_PROC_HUGE		PATH_PROC_VM "nr_hugepages"
+#define PATH_SHMMAX		"/proc/sys/kernel/shmmax"
 #define MB			(1024 * 1024)
 
 /* Only ia64 requires this */
@@ -116,15 +116,15 @@ int main(int argc, char *argv[])
 	if (msg != NULL)
 		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
 	if (opt_sysfs) {
-		strncpy(path, _PATH_SYS_2M_HUGE,
-			strlen(_PATH_SYS_2M_HUGE) + 1);
-		strncpy(pathover, _PATH_SYS_2M_OVER,
-			strlen(_PATH_SYS_2M_OVER) + 1);
+		strncpy(path, PATH_SYS_2M_HUGE,
+			strlen(PATH_SYS_2M_HUGE) + 1);
+		strncpy(pathover, PATH_SYS_2M_OVER,
+			strlen(PATH_SYS_2M_OVER) + 1);
 	} else {
-		strncpy(path, _PATH_PROC_HUGE,
-			strlen(_PATH_PROC_HUGE) + 1);
-		strncpy(pathover, _PATH_PROC_OVER,
-			strlen(_PATH_PROC_OVER) + 1);
+		strncpy(path, PATH_PROC_HUGE,
+			strlen(PATH_PROC_HUGE) + 1);
+		strncpy(pathover, PATH_PROC_OVER,
+			strlen(PATH_PROC_OVER) + 1);
 	}
 	if (opt_alloc) {
 		size = atoi(opt_allocstr);
@@ -147,7 +147,7 @@ static void overcommit(void)
 
 	if (shmid != -1) {
 		/* Use /proc/meminfo to generate an IPC key. */
-		key = ftok(_PATH_MEMINFO, strlen(_PATH_MEMINFO));
+		key = ftok(PATH_MEMINFO, strlen(PATH_MEMINFO));
 		if (key == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "ftok");
 		shmid = shmget(key, (long)(length * MB),
@@ -167,22 +167,22 @@ static void overcommit(void)
 
 	if (opt_sysfs) {
 		tst_resm(TINFO, "check sysfs before allocation.");
-		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+		if (checksys(PATH_SYS_2M_HUGE, "HugePages_Total",
 				length / 2) != 0)
 			return;
-		if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free",
+		if (checksys(PATH_SYS_2M_FREE, "HugePages_Free",
 				length / 2) != 0)
 			return;
-		if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+		if (checksys(PATH_SYS_2M_SURP, "HugePages_Surp",
 				length / 2 - size) != 0)
 			return;
-		if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd",
+		if (checksys(PATH_SYS_2M_RESV, "HugePages_Rsvd",
 				length / 2) != 0)
 			return;
 	} else {
 		tst_resm(TINFO,
 			"check /proc/meminfo before allocation.");
-		fp = fopen(_PATH_MEMINFO, "r");
+		fp = fopen(PATH_MEMINFO, "r");
 		if (fp == NULL)
 			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
 		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
@@ -209,21 +209,21 @@ static void overcommit(void)
 	}
 	if (opt_sysfs) {
 		tst_resm(TINFO, "check sysfs.");
-		if (checksys(_PATH_SYS_2M_HUGE, "HugePages_Total",
+		if (checksys(PATH_SYS_2M_HUGE, "HugePages_Total",
 				length / 2) != 0)
 			return;
-		if (checksys(_PATH_SYS_2M_FREE, "HugePages_Free", 0)
+		if (checksys(PATH_SYS_2M_FREE, "HugePages_Free", 0)
 			!= 0)
 			return;
-		if (checksys(_PATH_SYS_2M_SURP, "HugePages_Surp",
+		if (checksys(PATH_SYS_2M_SURP, "HugePages_Surp",
 				length / 2 - size) != 0)
 			return;
-		if (checksys(_PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
+		if (checksys(PATH_SYS_2M_RESV, "HugePages_Rsvd", 0)
 			!= 0)
 			return;
 	} else {
 		tst_resm(TINFO, "check /proc/meminfo.");
-		fp = fopen(_PATH_MEMINFO, "r");
+		fp = fopen(PATH_MEMINFO, "r");
 		if (fp == NULL)
 			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
 		if (checkproc(fp, "HugePages_Total", length / 2) != 0)
@@ -253,7 +253,7 @@ static void cleanup(void)
 
 	TEST_CLEANUP;
 	if (restore_shmmax) {
-		fd = open(_PATH_SHMMAX, O_WRONLY);
+		fd = open(PATH_SHMMAX, O_WRONLY);
 		if (fd == -1)
 			tst_resm(TWARN|TERRNO, "open");
 		if (write(fd, shmmax, strlen(shmmax)) != strlen(shmmax))
@@ -297,7 +297,7 @@ static void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	if (shmid != -1) {
-		fp = fopen(_PATH_SHMMAX, "r");
+		fp = fopen(PATH_SHMMAX, "r");
 		if (fp == NULL)
 			tst_brkm(TBROK|TERRNO, cleanup, "fopen");
 		if (fgets(shmmax, BUFSIZ, fp) == NULL)
@@ -306,7 +306,7 @@ static void setup(void)
 
 		if (atol(shmmax) < (long)(length * MB)) {
 			restore_shmmax = 1;
-			fd = open(_PATH_SHMMAX, O_RDWR);
+			fd = open(PATH_SHMMAX, O_RDWR);
 			if (fd == -1)
 				tst_brkm(TBROK|TERRNO, cleanup, "open");
 			snprintf(buf, BUFSIZ, "%ld", (long)(length * MB));
-- 
1.7.3.2
------=_Part_100795_1232007200.1293758695306
Content-Type: text/x-patch;
	name=0001-hugemmap05-fix-pathname-to-remove-underscore.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-hugemmap05-fix-pathname-to-remove-underscore.patch

RnJvbSA4YjkwYWIzZTNmYTdlNjhkYzFkYzI1NTg4NmU4ODU5YzQ5YWU5ZTA1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBG
cmksIDMxIERlYyAyMDEwIDA5OjA4OjMwICswODAwClN1YmplY3Q6IFtQQVRDSF0gaHVnZW1tYXAw
NTogZml4IHBhdGhuYW1lIHRvIHJlbW92ZSB1bmRlcnNjb3JlCgoKU2lnbmVkLW9mZi1ieTogQ0FJ
IFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMDUuYyB8ICAgNjggKysrKysrKysrKy0tLS0tLS0tLS0KIDEg
ZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1LmMg
Yi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMDUuYwppbmRl
eCBiY2U5ZmU2Li44NWZlZTRkIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMDUuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdl
dGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMDUuYwpAQCAtNTEsMTggKzUxLDE4IEBACiAjaW5jbHVkZSAi
dXNjdGVzdC5oIgogCiAjZGVmaW5lIFBST1RFQ1RJT04JCShQUk9UX1JFQUQgfCBQUk9UX1dSSVRF
KQotI2RlZmluZSBfUEFUSF9NRU1JTkZPCQkiL3Byb2MvbWVtaW5mbyIKLSNkZWZpbmUgX1BBVEhf
U1lTX0hVR0UJCSIvc3lzL2tlcm5lbC9tbS9odWdlcGFnZXMiCi0jZGVmaW5lIF9QQVRIX1NZU18y
TQkJX1BBVEhfU1lTX0hVR0UgIi9odWdlcGFnZXMtMjA0OGtCLyIKLSNkZWZpbmUgX1BBVEhfU1lT
XzJNX09WRVIJX1BBVEhfU1lTXzJNICJucl9vdmVyY29tbWl0X2h1Z2VwYWdlcyIKLSNkZWZpbmUg
X1BBVEhfU1lTXzJNX0ZSRUUJX1BBVEhfU1lTXzJNICJmcmVlX2h1Z2VwYWdlcyIKLSNkZWZpbmUg
X1BBVEhfU1lTXzJNX1JFU1YJX1BBVEhfU1lTXzJNICJyZXN2X2h1Z2VwYWdlcyIKLSNkZWZpbmUg
X1BBVEhfU1lTXzJNX1NVUlAJX1BBVEhfU1lTXzJNICJzdXJwbHVzX2h1Z2VwYWdlcyIKLSNkZWZp
bmUgX1BBVEhfU1lTXzJNX0hVR0UJX1BBVEhfU1lTXzJNICJucl9odWdlcGFnZXMiCi0jZGVmaW5l
IF9QQVRIX1BST0NfVk0JCSIvcHJvYy9zeXMvdm0vIgotI2RlZmluZSBfUEFUSF9QUk9DX09WRVIJ
CV9QQVRIX1BST0NfVk0gIm5yX292ZXJjb21taXRfaHVnZXBhZ2VzIgotI2RlZmluZSBfUEFUSF9Q
Uk9DX0hVR0UJCV9QQVRIX1BST0NfVk0gIm5yX2h1Z2VwYWdlcyIKLSNkZWZpbmUgX1BBVEhfU0hN
TUFYCQkiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgiCisjZGVmaW5lIFBBVEhfTUVNSU5GTwkJIi9w
cm9jL21lbWluZm8iCisjZGVmaW5lIFBBVEhfU1lTX0hVR0UJCSIvc3lzL2tlcm5lbC9tbS9odWdl
cGFnZXMiCisjZGVmaW5lIFBBVEhfU1lTXzJNCQlQQVRIX1NZU19IVUdFICIvaHVnZXBhZ2VzLTIw
NDhrQi8iCisjZGVmaW5lIFBBVEhfU1lTXzJNX09WRVIJUEFUSF9TWVNfMk0gIm5yX292ZXJjb21t
aXRfaHVnZXBhZ2VzIgorI2RlZmluZSBQQVRIX1NZU18yTV9GUkVFCVBBVEhfU1lTXzJNICJmcmVl
X2h1Z2VwYWdlcyIKKyNkZWZpbmUgUEFUSF9TWVNfMk1fUkVTVglQQVRIX1NZU18yTSAicmVzdl9o
dWdlcGFnZXMiCisjZGVmaW5lIFBBVEhfU1lTXzJNX1NVUlAJUEFUSF9TWVNfMk0gInN1cnBsdXNf
aHVnZXBhZ2VzIgorI2RlZmluZSBQQVRIX1NZU18yTV9IVUdFCVBBVEhfU1lTXzJNICJucl9odWdl
cGFnZXMiCisjZGVmaW5lIFBBVEhfUFJPQ19WTQkJIi9wcm9jL3N5cy92bS8iCisjZGVmaW5lIFBB
VEhfUFJPQ19PVkVSCQlQQVRIX1BST0NfVk0gIm5yX292ZXJjb21taXRfaHVnZXBhZ2VzIgorI2Rl
ZmluZSBQQVRIX1BST0NfSFVHRQkJUEFUSF9QUk9DX1ZNICJucl9odWdlcGFnZXMiCisjZGVmaW5l
IFBBVEhfU0hNTUFYCQkiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgiCiAjZGVmaW5lIE1CCQkJKDEw
MjQgKiAxMDI0KQogCiAvKiBPbmx5IGlhNjQgcmVxdWlyZXMgdGhpcyAqLwpAQCAtMTE2LDE1ICsx
MTYsMTUgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlpZiAobXNnICE9IE5V
TEwpCiAJCXRzdF9icmttKFRCUk9LLCB0c3RfZXhpdCwgIk9QVElPTiBQQVJTSU5HIEVSUk9SIC0g
JXMiLCBtc2cpOwogCWlmIChvcHRfc3lzZnMpIHsKLQkJc3RybmNweShwYXRoLCBfUEFUSF9TWVNf
Mk1fSFVHRSwKLQkJCXN0cmxlbihfUEFUSF9TWVNfMk1fSFVHRSkgKyAxKTsKLQkJc3RybmNweShw
YXRob3ZlciwgX1BBVEhfU1lTXzJNX09WRVIsCi0JCQlzdHJsZW4oX1BBVEhfU1lTXzJNX09WRVIp
ICsgMSk7CisJCXN0cm5jcHkocGF0aCwgUEFUSF9TWVNfMk1fSFVHRSwKKwkJCXN0cmxlbihQQVRI
X1NZU18yTV9IVUdFKSArIDEpOworCQlzdHJuY3B5KHBhdGhvdmVyLCBQQVRIX1NZU18yTV9PVkVS
LAorCQkJc3RybGVuKFBBVEhfU1lTXzJNX09WRVIpICsgMSk7CiAJfSBlbHNlIHsKLQkJc3RybmNw
eShwYXRoLCBfUEFUSF9QUk9DX0hVR0UsCi0JCQlzdHJsZW4oX1BBVEhfUFJPQ19IVUdFKSArIDEp
OwotCQlzdHJuY3B5KHBhdGhvdmVyLCBfUEFUSF9QUk9DX09WRVIsCi0JCQlzdHJsZW4oX1BBVEhf
UFJPQ19PVkVSKSArIDEpOworCQlzdHJuY3B5KHBhdGgsIFBBVEhfUFJPQ19IVUdFLAorCQkJc3Ry
bGVuKFBBVEhfUFJPQ19IVUdFKSArIDEpOworCQlzdHJuY3B5KHBhdGhvdmVyLCBQQVRIX1BST0Nf
T1ZFUiwKKwkJCXN0cmxlbihQQVRIX1BST0NfT1ZFUikgKyAxKTsKIAl9CiAJaWYgKG9wdF9hbGxv
YykgewogCQlzaXplID0gYXRvaShvcHRfYWxsb2NzdHIpOwpAQCAtMTQ3LDcgKzE0Nyw3IEBAIHN0
YXRpYyB2b2lkIG92ZXJjb21taXQodm9pZCkKIAogCWlmIChzaG1pZCAhPSAtMSkgewogCQkvKiBV
c2UgL3Byb2MvbWVtaW5mbyB0byBnZW5lcmF0ZSBhbiBJUEMga2V5LiAqLwotCQlrZXkgPSBmdG9r
KF9QQVRIX01FTUlORk8sIHN0cmxlbihfUEFUSF9NRU1JTkZPKSk7CisJCWtleSA9IGZ0b2soUEFU
SF9NRU1JTkZPLCBzdHJsZW4oUEFUSF9NRU1JTkZPKSk7CiAJCWlmIChrZXkgPT0gLTEpCiAJCQl0
c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmdG9rIik7CiAJCXNobWlkID0gc2htZ2V0
KGtleSwgKGxvbmcpKGxlbmd0aCAqIE1CKSwKQEAgLTE2NywyMiArMTY3LDIyIEBAIHN0YXRpYyB2
b2lkIG92ZXJjb21taXQodm9pZCkKIAogCWlmIChvcHRfc3lzZnMpIHsKIAkJdHN0X3Jlc20oVElO
Rk8sICJjaGVjayBzeXNmcyBiZWZvcmUgYWxsb2NhdGlvbi4iKTsKLQkJaWYgKGNoZWNrc3lzKF9Q
QVRIX1NZU18yTV9IVUdFLCAiSHVnZVBhZ2VzX1RvdGFsIiwKKwkJaWYgKGNoZWNrc3lzKFBBVEhf
U1lTXzJNX0hVR0UsICJIdWdlUGFnZXNfVG90YWwiLAogCQkJCWxlbmd0aCAvIDIpICE9IDApCiAJ
CQlyZXR1cm47Ci0JCWlmIChjaGVja3N5cyhfUEFUSF9TWVNfMk1fRlJFRSwgIkh1Z2VQYWdlc19G
cmVlIiwKKwkJaWYgKGNoZWNrc3lzKFBBVEhfU1lTXzJNX0ZSRUUsICJIdWdlUGFnZXNfRnJlZSIs
CiAJCQkJbGVuZ3RoIC8gMikgIT0gMCkKIAkJCXJldHVybjsKLQkJaWYgKGNoZWNrc3lzKF9QQVRI
X1NZU18yTV9TVVJQLCAiSHVnZVBhZ2VzX1N1cnAiLAorCQlpZiAoY2hlY2tzeXMoUEFUSF9TWVNf
Mk1fU1VSUCwgIkh1Z2VQYWdlc19TdXJwIiwKIAkJCQlsZW5ndGggLyAyIC0gc2l6ZSkgIT0gMCkK
IAkJCXJldHVybjsKLQkJaWYgKGNoZWNrc3lzKF9QQVRIX1NZU18yTV9SRVNWLCAiSHVnZVBhZ2Vz
X1JzdmQiLAorCQlpZiAoY2hlY2tzeXMoUEFUSF9TWVNfMk1fUkVTViwgIkh1Z2VQYWdlc19Sc3Zk
IiwKIAkJCQlsZW5ndGggLyAyKSAhPSAwKQogCQkJcmV0dXJuOwogCX0gZWxzZSB7CiAJCXRzdF9y
ZXNtKFRJTkZPLAogCQkJImNoZWNrIC9wcm9jL21lbWluZm8gYmVmb3JlIGFsbG9jYXRpb24uIik7
Ci0JCWZwID0gZm9wZW4oX1BBVEhfTUVNSU5GTywgInIiKTsKKwkJZnAgPSBmb3BlbihQQVRIX01F
TUlORk8sICJyIik7CiAJCWlmIChmcCA9PSBOVUxMKQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAiZm9wZW4iKTsKIAkJaWYgKGNoZWNrcHJvYyhmcCwgIkh1Z2VQYWdlc19Ub3Rh
bCIsIGxlbmd0aCAvIDIpICE9IDApCkBAIC0yMDksMjEgKzIwOSwyMSBAQCBzdGF0aWMgdm9pZCBv
dmVyY29tbWl0KHZvaWQpCiAJfQogCWlmIChvcHRfc3lzZnMpIHsKIAkJdHN0X3Jlc20oVElORk8s
ICJjaGVjayBzeXNmcy4iKTsKLQkJaWYgKGNoZWNrc3lzKF9QQVRIX1NZU18yTV9IVUdFLCAiSHVn
ZVBhZ2VzX1RvdGFsIiwKKwkJaWYgKGNoZWNrc3lzKFBBVEhfU1lTXzJNX0hVR0UsICJIdWdlUGFn
ZXNfVG90YWwiLAogCQkJCWxlbmd0aCAvIDIpICE9IDApCiAJCQlyZXR1cm47Ci0JCWlmIChjaGVj
a3N5cyhfUEFUSF9TWVNfMk1fRlJFRSwgIkh1Z2VQYWdlc19GcmVlIiwgMCkKKwkJaWYgKGNoZWNr
c3lzKFBBVEhfU1lTXzJNX0ZSRUUsICJIdWdlUGFnZXNfRnJlZSIsIDApCiAJCQkhPSAwKQogCQkJ
cmV0dXJuOwotCQlpZiAoY2hlY2tzeXMoX1BBVEhfU1lTXzJNX1NVUlAsICJIdWdlUGFnZXNfU3Vy
cCIsCisJCWlmIChjaGVja3N5cyhQQVRIX1NZU18yTV9TVVJQLCAiSHVnZVBhZ2VzX1N1cnAiLAog
CQkJCWxlbmd0aCAvIDIgLSBzaXplKSAhPSAwKQogCQkJcmV0dXJuOwotCQlpZiAoY2hlY2tzeXMo
X1BBVEhfU1lTXzJNX1JFU1YsICJIdWdlUGFnZXNfUnN2ZCIsIDApCisJCWlmIChjaGVja3N5cyhQ
QVRIX1NZU18yTV9SRVNWLCAiSHVnZVBhZ2VzX1JzdmQiLCAwKQogCQkJIT0gMCkKIAkJCXJldHVy
bjsKIAl9IGVsc2UgewogCQl0c3RfcmVzbShUSU5GTywgImNoZWNrIC9wcm9jL21lbWluZm8uIik7
Ci0JCWZwID0gZm9wZW4oX1BBVEhfTUVNSU5GTywgInIiKTsKKwkJZnAgPSBmb3BlbihQQVRIX01F
TUlORk8sICJyIik7CiAJCWlmIChmcCA9PSBOVUxMKQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5P
LCBjbGVhbnVwLCAiZm9wZW4iKTsKIAkJaWYgKGNoZWNrcHJvYyhmcCwgIkh1Z2VQYWdlc19Ub3Rh
bCIsIGxlbmd0aCAvIDIpICE9IDApCkBAIC0yNTMsNyArMjUzLDcgQEAgc3RhdGljIHZvaWQgY2xl
YW51cCh2b2lkKQogCiAJVEVTVF9DTEVBTlVQOwogCWlmIChyZXN0b3JlX3NobW1heCkgewotCQlm
ZCA9IG9wZW4oX1BBVEhfU0hNTUFYLCBPX1dST05MWSk7CisJCWZkID0gb3BlbihQQVRIX1NITU1B
WCwgT19XUk9OTFkpOwogCQlpZiAoZmQgPT0gLTEpCiAJCQl0c3RfcmVzbShUV0FSTnxURVJSTk8s
ICJvcGVuIik7CiAJCWlmICh3cml0ZShmZCwgc2htbWF4LCBzdHJsZW4oc2htbWF4KSkgIT0gc3Ry
bGVuKHNobW1heCkpCkBAIC0yOTcsNyArMjk3LDcgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkK
IAl0c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKIAlURVNUX1BBVVNFOwogCWlm
IChzaG1pZCAhPSAtMSkgewotCQlmcCA9IGZvcGVuKF9QQVRIX1NITU1BWCwgInIiKTsKKwkJZnAg
PSBmb3BlbihQQVRIX1NITU1BWCwgInIiKTsKIAkJaWYgKGZwID09IE5VTEwpCiAJCQl0c3RfYnJr
bShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmb3BlbiIpOwogCQlpZiAoZmdldHMoc2htbWF4LCBC
VUZTSVosIGZwKSA9PSBOVUxMKQpAQCAtMzA2LDcgKzMwNiw3IEBAIHN0YXRpYyB2b2lkIHNldHVw
KHZvaWQpCiAKIAkJaWYgKGF0b2woc2htbWF4KSA8IChsb25nKShsZW5ndGggKiBNQikpIHsKIAkJ
CXJlc3RvcmVfc2htbWF4ID0gMTsKLQkJCWZkID0gb3BlbihfUEFUSF9TSE1NQVgsIE9fUkRXUik7
CisJCQlmZCA9IG9wZW4oUEFUSF9TSE1NQVgsIE9fUkRXUik7CiAJCQlpZiAoZmQgPT0gLTEpCiAJ
CQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOwogCQkJc25wcmludGYo
YnVmLCBCVUZTSVosICIlbGQiLCAobG9uZykobGVuZ3RoICogTUIpKTsKLS0gCjEuNy4zLjIKCg==

------=_Part_100795_1232007200.1293758695306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_100795_1232007200.1293758695306
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_100795_1232007200.1293758695306--

