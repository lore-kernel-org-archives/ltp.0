Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZzA-0008RD-IV
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:53:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZz9-0001qX-Em
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:53:48 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8rfkl016628
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:53:41 -0500
Date: Tue, 11 Jan 2011 03:53:41 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <202495519.42957.1294736021965.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <506635417.42951.1294736018285.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42956_557869703.1294736021964"
Subject: [LTP] [PATCH 06/13] mlock03: check root
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

------=_Part_42956_557869703.1294736021964
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/syscalls/mlock/mlock03.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
index d11e42d..b8500b4 100644
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -109,6 +109,8 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
-- 
1.7.3.2
------=_Part_42956_557869703.1294736021964
Content-Type: text/x-patch; name=0006-mlock03-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0006-mlock03-check-root.patch

RnJvbSA5ODRhNTBiZjZlYTlmZDZjMTkyYTFhMmRlMTM5N2U2Mjk0NjdkYzJiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQwOjAxICswODAwClN1YmplY3Q6IFtQQVRDSCAwNi8xM10gbWxv
Y2swMzogY2hlY2sgcm9vdAoKClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhh
dC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbG9jay9tbG9jazAzLmMgfCAg
ICAyICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21sb2NrL21sb2NrMDMuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWxvY2svbWxvY2swMy5jCmluZGV4IGQxMWU0MmQu
LmI4NTAwYjQgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWxvY2svbWxv
Y2swMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWxvY2svbWxvY2swMy5jCkBA
IC0xMDksNiArMTA5LDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAogdm9p
ZCBzZXR1cCh2b2lkKQogeworCXRzdF9yZXF1aXJlX3Jvb3QodHN0X2V4aXQpOworCiAJdHN0X3Np
ZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CiAJVEVTVF9QQVVTRTsKIH0KLS0gCjEuNy4z
LjIKCg==
------=_Part_42956_557869703.1294736021964
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
------=_Part_42956_557869703.1294736021964
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42956_557869703.1294736021964--

