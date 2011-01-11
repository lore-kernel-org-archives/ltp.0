Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PcZya-0008PQ-Ek
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:53:12 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PcZyZ-0001rS-Ez
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:53:12 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8r6XH016611
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:53:06 -0500
Date: Tue, 11 Jan 2011 03:53:06 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <600408183.42948.1294735986034.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1721941398.42945.1294735982904.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42947_1141146228.1294735986033"
Subject: [LTP] [PATCH 05/13] mbind01: check root
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

------=_Part_42947_1141146228.1294735986033
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/mbind/mbind01.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/mbind/mbind01.c b/testcases/kernel/mem/mbind/mbind01.c
index 5c9c955..b6a1f68 100644
--- a/testcases/kernel/mem/mbind/mbind01.c
+++ b/testcases/kernel/mem/mbind/mbind01.c
@@ -77,6 +77,8 @@ int main(int argc, char** argv)
 	} else
 		numa_bitmask_setbit(nmask, 0);
 
+	tst_require_root(tst_exit);
+
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
 		addr = mmap(NULL, pagesize*3, PROT_READ|PROT_WRITE,
-- 
1.7.3.2
------=_Part_42947_1141146228.1294735986033
Content-Type: text/x-patch; name=0005-mbind01-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0005-mbind01-check-root.patch

RnJvbSBhNmQ1ZmVkODM5MjcwMGIyNDVmNjM3YzY2YTRhYzFlMTUxZDJlZTFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjM5OjA4ICswODAwClN1YmplY3Q6IFtQQVRDSCAwNS8xM10gbWJp
bmQwMTogY2hlY2sgcm9vdAoKClNpZ25lZC1vZmYtYnk6IENBSSBRaWFuIDxjYWlxaWFuQHJlZGhh
dC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9tZW0vbWJpbmQvbWJpbmQwMS5jIHwgICAgMiAr
KwogMSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbWJpbmQvbWJpbmQwMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vbWJpbmQvbWJpbmQwMS5jCmluZGV4IDVjOWM5NTUuLmI2YTFmNjggMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL21iaW5kL21iaW5kMDEuYworKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL21lbS9tYmluZC9tYmluZDAxLmMKQEAgLTc3LDYgKzc3LDggQEAgaW50IG1haW4o
aW50IGFyZ2MsIGNoYXIqKiBhcmd2KQogCX0gZWxzZQogCQludW1hX2JpdG1hc2tfc2V0Yml0KG5t
YXNrLCAwKTsKIAorCXRzdF9yZXF1aXJlX3Jvb3QodHN0X2V4aXQpOworCiAJZm9yIChsYyA9IDA7
IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKIAkJVHN0X2NvdW50ID0gMDsKIAkJYWRkciA9IG1t
YXAoTlVMTCwgcGFnZXNpemUqMywgUFJPVF9SRUFEfFBST1RfV1JJVEUsCi0tIAoxLjcuMy4yCgo=

------=_Part_42947_1141146228.1294735986033
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
------=_Part_42947_1141146228.1294735986033
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42947_1141146228.1294735986033--

