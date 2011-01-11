Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZze-00060X-Db
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:54:18 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZzd-0000jF-GG
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:54:18 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8sCJT016644
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:54:12 -0500
Date: Tue, 11 Jan 2011 03:54:11 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <938807313.42965.1294736051956.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <322650391.42962.1294736048718.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42964_85536108.1294736051955"
Subject: [LTP] [PATCH 07/13] mmap11: check root
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

------=_Part_42964_85536108.1294736051955
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap11.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
index 0cd32d4..1929d1a 100644
--- a/testcases/kernel/syscalls/mmap/mmap11.c
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -81,6 +81,8 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	tst_require_root(tst_exit);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
-- 
1.7.3.2
------=_Part_42964_85536108.1294736051955
Content-Type: text/x-patch; name=0007-mmap11-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0007-mmap11-check-root.patch

RnJvbSAzOWZiMTI1NmRiNWMwOGU2ZTRlYmVlNGZlODM5YmY3MmJhZWZkNjZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQwOjU4ICswODAwClN1YmplY3Q6IFtQQVRDSCAwNy8xM10gbW1h
cDExOiBjaGVjayByb290CgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDExLmMgfCAgICAy
ICsrCiAxIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDExLmMgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDExLmMKaW5kZXggMGNkMzJkNC4uMTkyOWQx
YSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxMS5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTEuYwpAQCAtODEsNiArODEs
OCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCiB2b2lkIHNldHVwKHZvaWQp
CiB7CisJdHN0X3JlcXVpcmVfcm9vdCh0c3RfZXhpdCk7CisKIAl0c3Rfc2lnKEZPUkssIERFRl9I
QU5ETEVSLCBjbGVhbnVwKTsKIAlURVNUX1BBVVNFOwogfQotLSAKMS43LjMuMgoK
------=_Part_42964_85536108.1294736051955
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
------=_Part_42964_85536108.1294736051955
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42964_85536108.1294736051955--

