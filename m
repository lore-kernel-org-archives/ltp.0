Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pca1d-0006iC-FU
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:56:21 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pca1c-0002RW-Kt
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:56:21 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8uFpl027839
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:56:15 -0500
Date: Tue, 11 Jan 2011 03:56:15 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1814853948.42996.1294736175098.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1406296700.42991.1294736171251.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42995_1519075412.1294736175097"
Subject: [LTP] [PATCH 11/13] oom02: check root
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

------=_Part_42995_1519075412.1294736175097
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom02.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 38533ef..f9060d5 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -90,6 +90,8 @@ void setup(void)
 {
 	int fd;
 
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-- 
1.7.3.2
------=_Part_42995_1519075412.1294736175097
Content-Type: text/x-patch; name=0011-oom02-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0011-oom02-check-root.patch

RnJvbSA3Y2EzYWI2ODRhZGVjNmZlYjUwNDBiYThiYTI0MTg3NTdlMjMyMTEwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQzOjI4ICswODAwClN1YmplY3Q6IFtQQVRDSCAxMS8xM10gb29t
MDI6IGNoZWNrIHJvb3QKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQu
Y29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jIHwgICAgMiArKwogMSBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL21l
bS9vb20vb29tMDIuYwppbmRleCAzODUzM2VmLi5mOTA2MGQ1IDEwMDY0NAotLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9vb20vb29tMDIuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20v
b29tMDIuYwpAQCAtOTAsNiArOTAsOCBAQCB2b2lkIHNldHVwKHZvaWQpCiB7CiAJaW50IGZkOwog
CisJdHN0X3JlcXVpcmVfcm9vdCh0c3RfZXhpdCk7CisKIAl0c3Rfc2lnKEZPUkssIERFRl9IQU5E
TEVSLCBjbGVhbnVwKTsKIAlURVNUX1BBVVNFOwogCi0tIAoxLjcuMy4yCgo=
------=_Part_42995_1519075412.1294736175097
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
------=_Part_42995_1519075412.1294736175097
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42995_1519075412.1294736175097--

