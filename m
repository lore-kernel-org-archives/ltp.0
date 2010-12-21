Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PUsIb-0003nS-20
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:50:01 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PUsIZ-0007Po-Rz
	for ltp-list@lists.sourceforge.net; Tue, 21 Dec 2010 02:50:01 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id oBL2nrAC012535
	for <ltp-list@lists.sourceforge.net>; Mon, 20 Dec 2010 21:49:53 -0500
Date: Mon, 20 Dec 2010 21:49:53 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <482156687.24713.1292899793949.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <632747622.24710.1292899791514.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24712_512782414.1292899793949"
Subject: [LTP] [PATCH v2 5/5] mm/runtest: add oom tests
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
To: ltp-list <ltp-list@lists.sourceforge.net>

------=_Part_24712_512782414.1292899793949
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 8be3025..9e514e7 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -72,3 +72,8 @@ mmap10_4 mmap10 -a -s -c 60
 ksm01 ksm01
 
 cpuset01 cpuset01 -I 3600
+
+oom01 oom01
+oom02 oom02
+oom03 oom03
+oom04 oom04
-- 
1.7.3.2
------=_Part_24712_512782414.1292899793949
Content-Type: text/x-patch; name=0005-mm-runtest-add-oom-tests.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0005-mm-runtest-add-oom-tests.patch

RnJvbSAyNWI2ZDcwZjcwZTk3ZTMwOWY2ZTE3YmFhZDAyZDY5OTRmNThmM2NhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDIxIERlYyAyMDEwIDEwOjM1OjUzICswODAwClN1YmplY3Q6IFtQQVRDSCB2MiA1LzVdIG1t
L3J1bnRlc3Q6IGFkZCBvb20gdGVzdHMKCgpTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2FpcWlh
bkByZWRoYXQuY29tPgotLS0KIHJ1bnRlc3QvbW0gfCAgICA1ICsrKysrCiAxIGZpbGVzIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9ydW50ZXN0
L21tIGIvcnVudGVzdC9tbQppbmRleCA4YmUzMDI1Li45ZTUxNGU3IDEwMDY0NAotLS0gYS9ydW50
ZXN0L21tCisrKyBiL3J1bnRlc3QvbW0KQEAgLTcyLDMgKzcyLDggQEAgbW1hcDEwXzQgbW1hcDEw
IC1hIC1zIC1jIDYwCiBrc20wMSBrc20wMQogCiBjcHVzZXQwMSBjcHVzZXQwMSAtSSAzNjAwCisK
K29vbTAxIG9vbTAxCitvb20wMiBvb20wMgorb29tMDMgb29tMDMKK29vbTA0IG9vbTA0Ci0tIAox
LjcuMy4yCgo=
------=_Part_24712_512782414.1292899793949
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
http://p.sf.net/sfu/lotusphere-d2d
------=_Part_24712_512782414.1292899793949
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24712_512782414.1292899793949--

