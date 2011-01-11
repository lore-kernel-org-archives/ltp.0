Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZy5-0005Hz-1q
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:52:41 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZy4-0000XY-4V
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:52:41 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8qYWw027438
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:52:34 -0500
Date: Tue, 11 Jan 2011 03:52:34 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <425541217.42942.1294735954376.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <201445744.42939.1294735950661.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42941_1866755171.1294735954376"
Subject: [LTP] [PATCH 04/13] cpuset01: check root
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

------=_Part_42941_1866755171.1294735954376
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index 27e2d68..6e2f356 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -178,6 +178,8 @@ void testcpuset(void)
 
 void setup(void)
 {
+	tst_require_root(tst_exit);
+
 	if (count_numa() == 1)
 		tst_brkm(TCONF, tst_exit, "required a NUMA system.");
 	tst_sig(FORK, DEF_HANDLER, cleanup);
-- 
1.7.3.2
------=_Part_42941_1866755171.1294735954376
Content-Type: text/x-patch; name=0004-cpuset01-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0004-cpuset01-check-root.patch

RnJvbSBkYTU4OTk0N2NhMDg3Njc3N2Q0Njc0M2E2NzQwZWE3ODU1YWM4ZWVjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjM3OjA2ICswODAwClN1YmplY3Q6IFtQQVRDSCAwNC8xM10gY3B1
c2V0MDE6IGNoZWNrIHJvb3QKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRo
YXQuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvbWVtL2NwdXNldC9jcHVzZXQwMS5jIHwgICAg
MiArKwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vY3B1c2V0L2NwdXNldDAxLmMgYi90ZXN0
Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYwppbmRleCAyN2UyZDY4Li42ZTJmMzU2
IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYworKysg
Yi90ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYwpAQCAtMTc4LDYgKzE3OCw4
IEBAIHZvaWQgdGVzdGNwdXNldCh2b2lkKQogCiB2b2lkIHNldHVwKHZvaWQpCiB7CisJdHN0X3Jl
cXVpcmVfcm9vdCh0c3RfZXhpdCk7CisKIAlpZiAoY291bnRfbnVtYSgpID09IDEpCiAJCXRzdF9i
cmttKFRDT05GLCB0c3RfZXhpdCwgInJlcXVpcmVkIGEgTlVNQSBzeXN0ZW0uIik7CiAJdHN0X3Np
ZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7Ci0tIAoxLjcuMy4yCgo=
------=_Part_42941_1866755171.1294735954376
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
------=_Part_42941_1866755171.1294735954376
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42941_1866755171.1294735954376--

