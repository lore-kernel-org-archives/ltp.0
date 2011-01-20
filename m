Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfnzK-0000zk-IQ
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 06:27:18 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfnzI-0006Q3-8O
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 06:27:18 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0K6RAv1021843
	for <ltp-list@lists.sourceforge.net>; Thu, 20 Jan 2011 01:27:10 -0500
Date: Thu, 20 Jan 2011 01:27:10 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <108021860.82747.1295504830275.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <549480476.82744.1295504826672.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_82746_306534259.1295504830275"
Subject: [LTP] [PATCH] oom: fix compilation warnings
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

------=_Part_82746_306534259.1295504830275
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

warning: extra tokens at end of #ifdef directive

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/oom/oom01.c |    2 +-
 testcases/kernel/mem/oom/oom02.c |    2 +-
 testcases/kernel/mem/oom/oom03.c |    2 +-
 testcases/kernel/mem/oom/oom04.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index b6c9d83..5698e38 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -51,7 +51,7 @@ int main(int argc, char *argv[])
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-#ifdef __WORDSIZE == 32
+#if __WORDSIZE == 32
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 04c6507..adb4d52 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -53,7 +53,7 @@ int main(int argc, char *argv[])
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-#ifdef __WORDSIZE == 32
+#if __WORDSIZE == 32
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index da01d3e..0199e6b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -49,7 +49,7 @@ int main(int argc, char *argv[])
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-#ifdef __WORDSIZE == 32
+#if __WORDSIZE == 32
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 8eb5c04..1646aba 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -54,7 +54,7 @@ int main(int argc, char *argv[])
 	if ((msg = parse_opts(argc, argv, NULL, NULL)) != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
 
-#ifdef __WORDSIZE == 32
+#if __WORDSIZE == 32
 	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
 #endif
 
-- 
1.7.3.2
------=_Part_82746_306534259.1295504830275
Content-Type: text/x-patch; name=0001-oom-fix-compilation-warnings.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-oom-fix-compilation-warnings.patch

RnJvbSBhMmRkYzI2ODhkOTQxNzcwNWYwOGUzNjFkNTE0YTlkM2Q1ZWJmY2I0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBU
aHUsIDIwIEphbiAyMDExIDE0OjIzOjE5ICswODAwClN1YmplY3Q6IFtQQVRDSF0gb29tOiBmaXgg
Y29tcGlsYXRpb24gd2FybmluZ3MKCndhcm5pbmc6IGV4dHJhIHRva2VucyBhdCBlbmQgb2YgI2lm
ZGVmIGRpcmVjdGl2ZQoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0LmNv
bT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDEuYyB8ICAgIDIgKy0KIHRlc3Rj
YXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMi5jIHwgICAgMiArLQogdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbTAzLmMgfCAgICAyICstCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDQu
YyB8ICAgIDIgKy0KIDQgZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMS5jIGIvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAxLmMKaW5kZXggYjZjOWQ4My4uNTY5OGUzOCAxMDA2
NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTAxLmMKKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vb29tL29vbTAxLmMKQEAgLTUxLDcgKzUxLDcgQEAgaW50IG1haW4oaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKIAlpZiAoKG1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgTlVM
TCwgTlVMTCkpICE9IE5VTEwpCiAJCXRzdF9icmttKFRCUk9LLCBOVUxMLCAiT1BUSU9OIFBBUlNJ
TkcgRVJST1IgLSAlcyIsIG1zZyk7CiAKLSNpZmRlZiBfX1dPUkRTSVpFID09IDMyCisjaWYgX19X
T1JEU0laRSA9PSAzMgogCXRzdF9icmttKFRDT05GLCBOVUxMLCAidGVzdCBpcyBub3QgZGVzaWdu
ZWQgZm9yIDMyLWJpdCBzeXN0ZW0uIik7CiAjZW5kaWYKIApkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vb29tL29vbTAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIu
YwppbmRleCAwNGM2NTA3Li5hZGI0ZDUyIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL21l
bS9vb20vb29tMDIuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDIuYwpAQCAt
NTMsNyArNTMsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQogCWlmICgobXNn
ID0gcGFyc2Vfb3B0cyhhcmdjLCBhcmd2LCBOVUxMLCBOVUxMKSkgIT0gTlVMTCkKIAkJdHN0X2Jy
a20oVEJST0ssIE5VTEwsICJPUFRJT04gUEFSU0lORyBFUlJPUiAtICVzIiwgbXNnKTsKIAotI2lm
ZGVmIF9fV09SRFNJWkUgPT0gMzIKKyNpZiBfX1dPUkRTSVpFID09IDMyCiAJdHN0X2Jya20oVENP
TkYsIE5VTEwsICJ0ZXN0IGlzIG5vdCBkZXNpZ25lZCBmb3IgMzItYml0IHN5c3RlbS4iKTsKICNl
bmRpZgogCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL21lbS9vb20vb29tMDMuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5jCmluZGV4IGRhMDFkM2UuLjAxOTllNmIgMTAw
NjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL29vbS9vb20wMy5jCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL29vbS9vb20wMy5jCkBAIC00OSw3ICs0OSw3IEBAIGludCBtYWluKGludCBh
cmdjLCBjaGFyICphcmd2W10pCiAJaWYgKChtc2cgPSBwYXJzZV9vcHRzKGFyZ2MsIGFyZ3YsIE5V
TEwsIE5VTEwpKSAhPSBOVUxMKQogCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgIk9QVElPTiBQQVJT
SU5HIEVSUk9SIC0gJXMiLCBtc2cpOwogCi0jaWZkZWYgX19XT1JEU0laRSA9PSAzMgorI2lmIF9f
V09SRFNJWkUgPT0gMzIKIAl0c3RfYnJrbShUQ09ORiwgTlVMTCwgInRlc3QgaXMgbm90IGRlc2ln
bmVkIGZvciAzMi1iaXQgc3lzdGVtLiIpOwogI2VuZGlmCiAKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL29vbS9vb20wNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTA0
LmMKaW5kZXggOGViNWMwNC4uMTY0NmFiYSAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vb29tL29vbTA0LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vb29tL29vbTA0LmMKQEAg
LTU0LDcgKzU0LDcgQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAlpZiAoKG1z
ZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgTlVMTCwgTlVMTCkpICE9IE5VTEwpCiAJCXRzdF9i
cmttKFRCUk9LLCBOVUxMLCAiT1BUSU9OIFBBUlNJTkcgRVJST1IgLSAlcyIsIG1zZyk7CiAKLSNp
ZmRlZiBfX1dPUkRTSVpFID09IDMyCisjaWYgX19XT1JEU0laRSA9PSAzMgogCXRzdF9icmttKFRD
T05GLCBOVUxMLCAidGVzdCBpcyBub3QgZGVzaWduZWQgZm9yIDMyLWJpdCBzeXN0ZW0uIik7CiAj
ZW5kaWYKIAotLSAKMS43LjMuMgoK
------=_Part_82746_306534259.1295504830275
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
------=_Part_82746_306534259.1295504830275
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_82746_306534259.1295504830275--

