Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZwc-0004lw-Mj
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:51:10 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZwb-0006Ly-SB
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:51:10 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8p3p2016518
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:51:03 -0500
Date: Tue, 11 Jan 2011 03:51:03 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <613624795.42903.1294735863857.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <648885156.42900.1294735859467.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42902_147576522.1294735863856"
Subject: [LTP] [PATCH 01/13] hugemmap05: check root
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

------=_Part_42902_147576522.1294735863856
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 8768b69..ec98395 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -295,6 +295,8 @@ static void setup(void)
 	FILE *fp;
 	int fd;
 
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	tst_tmpdir();
-- 
1.7.3.2
------=_Part_42902_147576522.1294735863856
Content-Type: text/x-patch; name=0001-hugemmap05-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-hugemmap05-check-root.patch

RnJvbSBmZmM2ZmE1NzgxYTc3MDMyNzljNWU5Zjc4Njc2YjlmY2Y3NjM0ZTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjMzOjAxICswODAwClN1YmplY3Q6IFtQQVRDSCAwMS8xM10gaHVn
ZW1tYXAwNTogY2hlY2sgcm9vdAoKClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJl
ZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdl
bW1hcDA1LmMgfCAgICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1
Z2VtbWFwL2h1Z2VtbWFwMDUuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1t
YXAvaHVnZW1tYXAwNS5jCmluZGV4IDg3NjhiNjkuLmVjOTgzOTUgMTAwNjQ0Ci0tLSBhL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAwNS5jCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAwNS5jCkBAIC0yOTUsNiAr
Mjk1LDggQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKIAlGSUxFICpmcDsKIAlpbnQgZmQ7CiAK
Kwl0c3RfcmVxdWlyZV9yb290KHRzdF9leGl0KTsKKwogCXRzdF9zaWcoRk9SSywgREVGX0hBTkRM
RVIsIGNsZWFudXApOwogCVRFU1RfUEFVU0U7CiAJdHN0X3RtcGRpcigpOwotLSAKMS43LjMuMgoK

------=_Part_42902_147576522.1294735863856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Gaining the trust of online customers is vital for the success of any company
that requires sensitive data to be transmitted over the Web.   Learn how to 
best implement a security strategy that keeps consumers' information secure 
and instills the confidence they need to proceed with transactions.
http://p.sf.net/sfu/oracle-sfdevnl 
------=_Part_42902_147576522.1294735863856
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42902_147576522.1294735863856--

