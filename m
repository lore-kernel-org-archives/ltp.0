Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PgDiy-00046P-CG
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:56:08 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PgDix-0000Oh-56
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 09:56:08 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0L9u1hF001440
	for <ltp-list@lists.sourceforge.net>; Fri, 21 Jan 2011 04:56:01 -0500
Date: Fri, 21 Jan 2011 04:56:01 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <1435824546.101326.1295603761218.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1763194189.101320.1295603751447.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_101325_751136116.1295603761218"
Subject: [LTP] [PATCH] check two possible pathes for cpuset
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

------=_Part_101325_751136116.1295603761218
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

It can be difficult to predict if cpuset files have prefix or not,
so only to fail after checked both.

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/lib/mem.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index 297eedd..72cf319 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -90,15 +90,27 @@ void write_cpusets(void)
 	tst_resm(TINFO, "CPU list for 2nd node is %s.", cpus);
 
 	fd = open(CPATH_NEW "/mems", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			fd = open(CPATH_NEW "/cpuset.mems", O_WRONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		} else
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	}
 	if (write(fd, "1", 1) != 1)
 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 	close(fd);
 
 	fd = open(CPATH_NEW "/cpus", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	if (fd == -1) {
+		if (errno == ENOENT) {
+			fd = open(CPATH_NEW "/cpuset.cpus", O_WRONLY);
+			if (fd == -1)
+				tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+		} else
+			tst_brkm(TBROK|TERRNO, cleanup, "open %s", buf);
+	}
 	if (write(fd, cpus, strlen(cpus)) != strlen(cpus))
 		tst_brkm(TBROK|TERRNO, cleanup, "write %s", buf);
 	close(fd);
-- 
1.7.3.2
------=_Part_101325_751136116.1295603761218
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
------=_Part_101325_751136116.1295603761218
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
------=_Part_101325_751136116.1295603761218
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_101325_751136116.1295603761218--

