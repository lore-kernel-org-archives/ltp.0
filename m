Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pca2e-0000IX-TU
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:57:24 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pca2c-0002bD-Im
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:57:24 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8vHV8017050
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:57:17 -0500
Date: Tue, 11 Jan 2011 03:57:17 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1306180210.43013.1294736237011.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1231698803.43010.1294736232761.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_43012_846319413.1294736237011"
Subject: [LTP] [PATCH 13/13] oom04: check root
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

------=_Part_43012_846319413.1294736237011
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom04.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 5b403f4..befb7e9 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -133,6 +133,8 @@ void setup(void)
 {
 	int fd;
 
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 
-- 
1.7.3.2
------=_Part_43012_846319413.1294736237011
Content-Type: text/x-patch; name=0013-oom04-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0013-oom04-check-root.patch

RnJvbSA2Y2Q5YjllN2VkNmRjZmI0NjIzMjcyNDZlYTg4YThiNTM1NjRjNWMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQ0OjI4ICswODAwClN1YmplY3Q6IFtQQVRDSCAxMy8xM10gb29t
MDQ6IGNoZWNrIHJvb3QKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQu
Y29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wNC5jIHwgICAgMiArKwogMSBm
aWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL21l
bS9vb20vb29tMDQuYwppbmRleCA1YjQwM2Y0Li5iZWZiN2U5IDEwMDY0NAotLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9vb20vb29tMDQuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20v
b29tMDQuYwpAQCAtMTMzLDYgKzEzMyw4IEBAIHZvaWQgc2V0dXAodm9pZCkKIHsKIAlpbnQgZmQ7
CiAKKwl0c3RfcmVxdWlyZV9yb290KHRzdF9leGl0KTsKKwogCXRzdF9zaWcoRk9SSywgREVGX0hB
TkRMRVIsIGNsZWFudXApOwogCVRFU1RfUEFVU0U7CiAKLS0gCjEuNy4zLjIKCg==
------=_Part_43012_846319413.1294736237011
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
------=_Part_43012_846319413.1294736237011
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_43012_846319413.1294736237011--

