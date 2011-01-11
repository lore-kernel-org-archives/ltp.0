Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZxE-0008JV-Aq
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:51:48 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZxD-0001ei-1y
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:51:48 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8pfEG027391
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:51:41 -0500
Date: Tue, 11 Jan 2011 03:51:41 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1641840312.42911.1294735901084.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <665700570.42908.1294735896871.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42910_1990164791.1294735901083"
Subject: [LTP] [PATCH 02/13] mmap10: check root
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

------=_Part_42910_1990164791.1294735901083
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap10.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index fe9d622..58754df 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -168,6 +168,8 @@ void cleanup(void)
 
 void setup(void)
 {
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
-- 
1.7.3.2
------=_Part_42910_1990164791.1294735901083
Content-Type: text/x-patch; name=0002-mmap10-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0002-mmap10-check-root.patch

RnJvbSBkM2ZkMzhkZjNlNjI2ZWUxZGM3MjZiYzhiZjJjNjM5MTQ2NzdlYjFiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjM1OjMwICswODAwClN1YmplY3Q6IFtQQVRDSCAwMi8xM10gbW1h
cDEwOiBjaGVjayByb290CgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDEwLmMgfCAgICAy
ICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDEwLmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDEwLmMKaW5kZXggZmU5ZDYyMi4uNTg3NTRk
ZiAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxMC5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTAuYwpAQCAtMTY4LDYgKzE2
OCw4IEBAIHZvaWQgY2xlYW51cCh2b2lkKQogCiB2b2lkIHNldHVwKHZvaWQpCiB7CisJdHN0X3Jl
cXVpcmVfcm9vdCh0c3RfZXhpdCk7CisKIAl0c3Rfc2lnKEZPUkssIERFRl9IQU5ETEVSLCBjbGVh
bnVwKTsKIAlURVNUX1BBVVNFOwogfQotLSAKMS43LjMuMgoK
------=_Part_42910_1990164791.1294735901083
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
------=_Part_42910_1990164791.1294735901083
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42910_1990164791.1294735901083--

