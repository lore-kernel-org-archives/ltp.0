Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PYccz-0008NT-OQ
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 10:54:33 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PYccx-0004qO-Es
	for ltp-list@lists.sourceforge.net; Fri, 31 Dec 2010 10:54:33 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBVAsP5J021221
	for <ltp-list@lists.sourceforge.net>; Fri, 31 Dec 2010 05:54:25 -0500
Date: Fri, 31 Dec 2010 05:54:25 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1907018828.101390.1293792865515.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1600876791.101387.1293792856780.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_101389_1310299538.1293792865515"
Subject: [LTP] [PATCH] hugemmap05: add missing temp directory creation
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

------=_Part_101389_1310299538.1293792865515
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

This is in order to use *TESTDIR.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 85fee4d..8768b69 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -251,7 +251,6 @@ static void cleanup(void)
 {
 	int fd;
 
-	TEST_CLEANUP;
 	if (restore_shmmax) {
 		fd = open(PATH_SHMMAX, O_WRONLY);
 		if (fd == -1)
@@ -286,6 +285,8 @@ static void cleanup(void)
 		tst_resm(TINFO|TERRNO, "shmdt");
 		shmctl(shmid, IPC_RMID, NULL);
 	}
+	TEST_CLEANUP;
+	tst_rmdir();
 	tst_exit();
 }
 
@@ -296,6 +297,8 @@ static void setup(void)
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
+	tst_tmpdir();
+
 	if (shmid != -1) {
 		fp = fopen(PATH_SHMMAX, "r");
 		if (fp == NULL)
-- 
1.7.3.2
------=_Part_101389_1310299538.1293792865515
Content-Type: text/x-patch;
	name=0001-hugemmap05-add-missing-temp-directory-creation.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-hugemmap05-add-missing-temp-directory-creation.patch

RnJvbSBkZTAzNWJiMWEzOGFmMDQ1MzQ5ZGEzMmFkMTU1ODIxNGExOWY0NTAyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBG
cmksIDMxIERlYyAyMDEwIDE4OjQ1OjI3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gaHVnZW1tYXAw
NTogYWRkIG1pc3NpbmcgdGVtcCBkaXJlY3RvcnkgY3JlYXRpb24KClRoaXMgaXMgaW4gb3JkZXIg
dG8gdXNlICpURVNURElSLgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFw
MDUuYyB8ICAgIDUgKysrKy0KIDEgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZW1tYXAvaHVnZW1tYXAwNS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1h
cC9odWdlbW1hcDA1LmMKaW5kZXggODVmZWU0ZC4uODc2OGI2OSAxMDA2NDQKLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1LmMKKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1LmMKQEAgLTI1MSw3ICsy
NTEsNiBAQCBzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCiB7CiAJaW50IGZkOwogCi0JVEVTVF9D
TEVBTlVQOwogCWlmIChyZXN0b3JlX3NobW1heCkgewogCQlmZCA9IG9wZW4oUEFUSF9TSE1NQVgs
IE9fV1JPTkxZKTsKIAkJaWYgKGZkID09IC0xKQpAQCAtMjg2LDYgKzI4NSw4IEBAIHN0YXRpYyB2
b2lkIGNsZWFudXAodm9pZCkKIAkJdHN0X3Jlc20oVElORk98VEVSUk5PLCAic2htZHQiKTsKIAkJ
c2htY3RsKHNobWlkLCBJUENfUk1JRCwgTlVMTCk7CiAJfQorCVRFU1RfQ0xFQU5VUDsKKwl0c3Rf
cm1kaXIoKTsKIAl0c3RfZXhpdCgpOwogfQogCkBAIC0yOTYsNiArMjk3LDggQEAgc3RhdGljIHZv
aWQgc2V0dXAodm9pZCkKIAogCXRzdF9zaWcoRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOwog
CVRFU1RfUEFVU0U7CisJdHN0X3RtcGRpcigpOworCiAJaWYgKHNobWlkICE9IC0xKSB7CiAJCWZw
ID0gZm9wZW4oUEFUSF9TSE1NQVgsICJyIik7CiAJCWlmIChmcCA9PSBOVUxMKQotLSAKMS43LjMu
MgoK
------=_Part_101389_1310299538.1293792865515
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
------=_Part_101389_1310299538.1293792865515
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_101389_1310299538.1293792865515--

