Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfD4D-0006Uj-It
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:01:53 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfD4A-0004DF-PR
	for ltp-list@lists.sourceforge.net; Tue, 18 Jan 2011 15:01:51 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0IF1jRt020322
	for <ltp-list@lists.sourceforge.net>; Tue, 18 Jan 2011 10:01:45 -0500
Date: Tue, 18 Jan 2011 10:01:45 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1462795008.37336.1295362905294.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1487881728.37333.1295362901966.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_37335_1429191963.1295362905293"
Subject: [LTP] [PATCH 4/4] ksm: add new tests to runtest/mm
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

------=_Part_37335_1429191963.1295362905293
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 9e514e7..7a5fec4 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -54,23 +54,30 @@ mmapstress08 mmapstress08
 mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
 
-mmap10 mmap10
-
 mlock03 mlock03 -i 20
 
 mbind01 mbind01
 
+ksm01 ksm01
+ksm01_1 ksm01 -u 128
+ksm02 ksm02
+ksm02_1 ksm02 -u 128
+ksm03 ksm03
+ksm03_1 ksm03 -u 128
+ksm04 ksm04
+ksm04_1 ksm04 -u 128
+
 hugemmap05 hugemmap05
 hugemmap05_1 hugemmap05 -m
 hugemmap05_2 hugemmap05 -s
 hugemmap05_3 hugemmap05 -s -m
+
+mmap10 mmap10
 mmap10_1 mmap10 -a
 mmap10_2 mmap10 -s
 mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -c 60
 
-ksm01 ksm01
-
 cpuset01 cpuset01 -I 3600
 
 oom01 oom01
-- 
1.7.3.2
------=_Part_37335_1429191963.1295362905293
Content-Type: text/x-patch; name=0004-ksm-add-new-tests-to-runtest-mm.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0004-ksm-add-new-tests-to-runtest-mm.patch

RnJvbSA1ZGY3M2NmNzc4ZDA1YmMyY2U0NWZhN2NmMTA2ZjM5ZDMzZjZhZjA2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
dWUsIDE4IEphbiAyMDExIDE3OjI5OjA3ICswODAwClN1YmplY3Q6IFtQQVRDSCA0LzRdIGtzbTog
YWRkIG5ldyB0ZXN0cyB0byBydW50ZXN0L21tCgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNh
aXFpYW5AcmVkaGF0LmNvbT4KLS0tCiBydW50ZXN0L21tIHwgICAxNSArKysrKysrKysrKy0tLS0K
IDEgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9ydW50ZXN0L21tIGIvcnVudGVzdC9tbQppbmRleCA5ZTUxNGU3Li43YTVmZWM0IDEw
MDY0NAotLS0gYS9ydW50ZXN0L21tCisrKyBiL3J1bnRlc3QvbW0KQEAgLTU0LDIzICs1NCwzMCBA
QCBtbWFwc3RyZXNzMDggbW1hcHN0cmVzczA4CiBtbWFwc3RyZXNzMDkgbW1hcHN0cmVzczA5IC1w
IDIwIC10IDAuMgogbW1hcHN0cmVzczEwIG1tYXBzdHJlc3MxMCAtcCAyMCAtdCAwLjIKIAotbW1h
cDEwIG1tYXAxMAotCiBtbG9jazAzIG1sb2NrMDMgLWkgMjAKIAogbWJpbmQwMSBtYmluZDAxCiAK
K2tzbTAxIGtzbTAxCitrc20wMV8xIGtzbTAxIC11IDEyOAora3NtMDIga3NtMDIKK2tzbTAyXzEg
a3NtMDIgLXUgMTI4Citrc20wMyBrc20wMwora3NtMDNfMSBrc20wMyAtdSAxMjgKK2tzbTA0IGtz
bTA0Citrc20wNF8xIGtzbTA0IC11IDEyOAorCiBodWdlbW1hcDA1IGh1Z2VtbWFwMDUKIGh1Z2Vt
bWFwMDVfMSBodWdlbW1hcDA1IC1tCiBodWdlbW1hcDA1XzIgaHVnZW1tYXAwNSAtcwogaHVnZW1t
YXAwNV8zIGh1Z2VtbWFwMDUgLXMgLW0KKworbW1hcDEwIG1tYXAxMAogbW1hcDEwXzEgbW1hcDEw
IC1hCiBtbWFwMTBfMiBtbWFwMTAgLXMKIG1tYXAxMF8zIG1tYXAxMCAtYSAtcwogbW1hcDEwXzQg
bW1hcDEwIC1hIC1zIC1jIDYwCiAKLWtzbTAxIGtzbTAxCi0KIGNwdXNldDAxIGNwdXNldDAxIC1J
IDM2MDAKIAogb29tMDEgb29tMDEKLS0gCjEuNy4zLjIKCg==
------=_Part_37335_1429191963.1295362905293
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
------=_Part_37335_1429191963.1295362905293
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_37335_1429191963.1295362905293--

