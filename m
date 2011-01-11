Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1Pca0c-0000Ax-K4
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:55:18 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1Pca0b-00024h-J9
	for ltp-list@lists.sourceforge.net; Tue, 11 Jan 2011 08:55:18 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0B8tCfG027730
	for <ltp-list@lists.sourceforge.net>; Tue, 11 Jan 2011 03:55:12 -0500
Date: Tue, 11 Jan 2011 03:55:12 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <85958116.42979.1294736112060.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1781507635.42976.1294736107850.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_42978_1833677859.1294736112059"
Subject: [LTP] [PATCH 09/13] zram01: check root
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

------=_Part_42978_1833677859.1294736112059
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/zram/zram01.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/testcases/kernel/mem/zram/zram01.c b/testcases/kernel/mem/zram/zram01.c
index e63cec4..1f1a5f4 100644
--- a/testcases/kernel/mem/zram/zram01.c
+++ b/testcases/kernel/mem/zram/zram01.c
@@ -106,6 +106,8 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	tst_require_root(tst_exit);
+
 	if (access(PATH_ZRAM, R_OK|W_OK|X_OK) == -1 && errno == ENOENT) {
 		system("modprobe zram");
 		modprobe = 1;
-- 
1.7.3.2
------=_Part_42978_1833677859.1294736112059
Content-Type: text/x-patch; name=0009-zram01-check-root.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0009-zram01-check-root.patch

RnJvbSA2NTU1ZmM4NzE3MjdjZmNhNzI0NDUyYWYwMjQ0NzQ4ZDRkYzJjNmZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDExIEphbiAyMDExIDE2OjQyOjM2ICswODAwClN1YmplY3Q6IFtQQVRDSCAwOS8xM10genJh
bTAxOiBjaGVjayByb290CgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS96cmFtL3pyYW0wMS5jIHwgICAgMiArKwog
MSBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFtMDEuYyBiL3Rlc3RjYXNlcy9rZXJu
ZWwvbWVtL3pyYW0venJhbTAxLmMKaW5kZXggZTYzY2VjNC4uMWYxYTVmNCAxMDA2NDQKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0venJhbS96cmFtMDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVs
L21lbS96cmFtL3pyYW0wMS5jCkBAIC0xMDYsNiArMTA2LDggQEAgaW50IG1haW4oaW50IGFyZ2Ms
IGNoYXIgKmFyZ3ZbXSkKIAogdm9pZCBzZXR1cCh2b2lkKQogeworCXRzdF9yZXF1aXJlX3Jvb3Qo
dHN0X2V4aXQpOworCiAJaWYgKGFjY2VzcyhQQVRIX1pSQU0sIFJfT0t8V19PS3xYX09LKSA9PSAt
MSAmJiBlcnJubyA9PSBFTk9FTlQpIHsKIAkJc3lzdGVtKCJtb2Rwcm9iZSB6cmFtIik7CiAJCW1v
ZHByb2JlID0gMTsKLS0gCjEuNy4zLjIKCg==
------=_Part_42978_1833677859.1294736112059
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
------=_Part_42978_1833677859.1294736112059
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_42978_1833677859.1294736112059--

