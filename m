Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pca29-0007Bv-WF
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:56:54 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pca29-0007PI-55
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:56:53 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8ulfo027861
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:56:47 -0500
Date: Tue, 11 Jan 2011 03:56:47 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <970121974.43007.1294736207630.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <935942858.43004.1294736204283.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43006_1614982801.1294736207630"
Subject: [LTP] [PATCH 12/13] oom03: check root
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

------=_Part_43006_1614982801.1294736207630
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom03.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 12c2063..8cdff78 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -102,6 +102,8 @@ void setup(void)
 {
 	int fd;
 
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-- 
1.7.3.2
------=_Part_43006_1614982801.1294736207630
Content-Type: text/x-patch; name=0012-oom03-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0012-oom03-check-root.patch

RnJvbSBmNGYzMWFlMTJhZmFiYTU4NTk3YzQxMGMyM2M2MGFkYmE4YjM5OTI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQzOjUzICswODAwClN1YmplY3Q6IFtQQVRDSCAxMi8xM10gb29t
MDM6IGNoZWNrIHJvb3QKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQu
Y29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5jIHwgICAgMiArKwogMSBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL21l
bS9vb20vb29tMDMuYwppbmRleCAxMmMyMDYzLi44Y2RmZjc4IDEwMDY0NAotLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9vb20vb29tMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20v
b29tMDMuYwpAQCAtMTAyLDYgKzEwMiw4IEBAIHZvaWQgc2V0dXAodm9pZCkKIHsKIAlpbnQgZmQ7
CiAKKwl0c3RfcmVxdWlyZV9yb290KHRzdF9leGl0KTsKKwogCXRzdF9zaWcoRk9SSywgREVGX0hB
TkRMRVIsIGNsZWFudXApOwogCVRFU1RfUEFVU0U7CiAKLS0gCjEuNy4zLjIKCg==
------=_Part_43006_1614982801.1294736207630
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
------=_Part_43006_1614982801.1294736207630
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_43006_1614982801.1294736207630--

