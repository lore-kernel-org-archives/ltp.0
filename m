Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfTG8-0008QZ-7j
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:19:16 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfTG7-0007ne-44
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:19:16 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J8J9au005321
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:19:09 -0500
Date: Wed, 19 Jan 2011 03:19:09 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1888387986.56398.1295425149445.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <2016271853.56395.1295425143879.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56397_1356209227.1295425149445"
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

------=_Part_56397_1356209227.1295425149445
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 runtest/mm |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 9e514e7..f097256 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -55,24 +55,31 @@ mmapstress09 mmapstress09 -p 20 -t 0.2
 mmapstress10 mmapstress10 -p 20 -t 0.2
 
 mmap10 mmap10
-
-mlock03 mlock03 -i 20
-
-mbind01 mbind01
-
-hugemmap05 hugemmap05
-hugemmap05_1 hugemmap05 -m
-hugemmap05_2 hugemmap05 -s
-hugemmap05_3 hugemmap05 -s -m
 mmap10_1 mmap10 -a
 mmap10_2 mmap10 -s
 mmap10_3 mmap10 -a -s
 mmap10_4 mmap10 -a -s -c 60
 
 ksm01 ksm01
+ksm01_1 ksm01 -u 128
+ksm02 ksm02
+ksm02_1 ksm02 -u 128
+ksm03 ksm03
+ksm03_1 ksm03 -u 128
+ksm04 ksm04
+ksm04_1 ksm04 -u 128
+
+hugemmap05 hugemmap05
+hugemmap05_1 hugemmap05 -m
+hugemmap05_2 hugemmap05 -s
+hugemmap05_3 hugemmap05 -s -m
 
 cpuset01 cpuset01 -I 3600
 
+mlock03 mlock03 -i 20
+
+mbind01 mbind01
+
 oom01 oom01
 oom02 oom02
 oom03 oom03
-- 
1.7.3.2
------=_Part_56397_1356209227.1295425149445
Content-Type: text/x-patch; name=0004-ksm-add-new-tests-to-runtest-mm.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0004-ksm-add-new-tests-to-runtest-mm.patch

RnJvbSAxMmQ1ZTAxOTQ0MzM4NGNjM2ZhNmEyNTA0OTEwMjRiMzUxOTk2N2YwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjUxOjU2ICswODAwClN1YmplY3Q6IFtQQVRDSCA0LzRdIGtzbTog
YWRkIG5ldyB0ZXN0cyB0byBydW50ZXN0L21tCgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNh
aXFpYW5AcmVkaGF0LmNvbT4KLS0tCiBydW50ZXN0L21tIHwgICAyNSArKysrKysrKysrKysrKysr
LS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25z
KC0pCgpkaWZmIC0tZ2l0IGEvcnVudGVzdC9tbSBiL3J1bnRlc3QvbW0KaW5kZXggOWU1MTRlNy4u
ZjA5NzI1NiAxMDA2NDQKLS0tIGEvcnVudGVzdC9tbQorKysgYi9ydW50ZXN0L21tCkBAIC01NSwy
NCArNTUsMzEgQEAgbW1hcHN0cmVzczA5IG1tYXBzdHJlc3MwOSAtcCAyMCAtdCAwLjIKIG1tYXBz
dHJlc3MxMCBtbWFwc3RyZXNzMTAgLXAgMjAgLXQgMC4yCiAKIG1tYXAxMCBtbWFwMTAKLQotbWxv
Y2swMyBtbG9jazAzIC1pIDIwCi0KLW1iaW5kMDEgbWJpbmQwMQotCi1odWdlbW1hcDA1IGh1Z2Vt
bWFwMDUKLWh1Z2VtbWFwMDVfMSBodWdlbW1hcDA1IC1tCi1odWdlbW1hcDA1XzIgaHVnZW1tYXAw
NSAtcwotaHVnZW1tYXAwNV8zIGh1Z2VtbWFwMDUgLXMgLW0KIG1tYXAxMF8xIG1tYXAxMCAtYQog
bW1hcDEwXzIgbW1hcDEwIC1zCiBtbWFwMTBfMyBtbWFwMTAgLWEgLXMKIG1tYXAxMF80IG1tYXAx
MCAtYSAtcyAtYyA2MAogCiBrc20wMSBrc20wMQora3NtMDFfMSBrc20wMSAtdSAxMjgKK2tzbTAy
IGtzbTAyCitrc20wMl8xIGtzbTAyIC11IDEyOAora3NtMDMga3NtMDMKK2tzbTAzXzEga3NtMDMg
LXUgMTI4Citrc20wNCBrc20wNAora3NtMDRfMSBrc20wNCAtdSAxMjgKKworaHVnZW1tYXAwNSBo
dWdlbW1hcDA1CitodWdlbW1hcDA1XzEgaHVnZW1tYXAwNSAtbQoraHVnZW1tYXAwNV8yIGh1Z2Vt
bWFwMDUgLXMKK2h1Z2VtbWFwMDVfMyBodWdlbW1hcDA1IC1zIC1tCiAKIGNwdXNldDAxIGNwdXNl
dDAxIC1JIDM2MDAKIAorbWxvY2swMyBtbG9jazAzIC1pIDIwCisKK21iaW5kMDEgbWJpbmQwMQor
CiBvb20wMSBvb20wMQogb29tMDIgb29tMDIKIG9vbTAzIG9vbTAzCi0tIAoxLjcuMy4yCgo=
------=_Part_56397_1356209227.1295425149445
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
------=_Part_56397_1356209227.1295425149445
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56397_1356209227.1295425149445--

