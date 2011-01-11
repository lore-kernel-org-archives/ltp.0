Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pca07-0001zA-Fj
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:54:47 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pca06-0006to-LN
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:54:47 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8sfAi016665
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:54:41 -0500
Date: Tue, 11 Jan 2011 03:54:41 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <463657959.42971.1294736081148.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1139292908.42968.1294736078430.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42970_810109477.1294736081147"
Subject: [LTP] [PATCH 08/13] fork13: check root
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

------=_Part_42970_810109477.1294736081147
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/syscalls/fork/fork13.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 2fe0770..1a40a30 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -137,6 +137,8 @@ void setup(void)
 	int fd;
 	char buf[BUFSIZ];
 
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	/* Backup pid_max value. */
-- 
1.7.3.2
------=_Part_42970_810109477.1294736081147
Content-Type: text/x-patch; name=0008-fork13-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0008-fork13-check-root.patch

RnJvbSBmYWMzODBkNmJmNTMyMTJhZWQ0ZTI5ZTEzODE3MGY3YmI1OTlhYTQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQyOjA3ICswODAwClN1YmplY3Q6IFtQQVRDSCAwOC8xM10gZm9y
azEzOiBjaGVjayByb290CgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazEzLmMgfCAgICAy
ICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazEzLmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZvcmsvZm9yazEzLmMKaW5kZXggMmZlMDc3MC4uMWE0MGEz
MCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mb3JrL2ZvcmsxMy5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZm9yay9mb3JrMTMuYwpAQCAtMTM3LDYgKzEz
Nyw4IEBAIHZvaWQgc2V0dXAodm9pZCkKIAlpbnQgZmQ7CiAJY2hhciBidWZbQlVGU0laXTsKIAor
CXRzdF9yZXF1aXJlX3Jvb3QodHN0X2V4aXQpOworCiAJdHN0X3NpZyhGT1JLLCBERUZfSEFORExF
UiwgY2xlYW51cCk7CiAJVEVTVF9QQVVTRTsKIAkvKiBCYWNrdXAgcGlkX21heCB2YWx1ZS4gKi8K
LS0gCjEuNy4zLjIKCg==
------=_Part_42970_810109477.1294736081147
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
------=_Part_42970_810109477.1294736081147
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42970_810109477.1294736081147--

