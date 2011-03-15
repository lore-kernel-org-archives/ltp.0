Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PzSCJ-0007R3-Nl
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 11:13:55 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PzSCI-0004RR-Ek
	for ltp-list@lists.sourceforge.net; Tue, 15 Mar 2011 11:13:55 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2FBDmKf012781
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Mar 2011 07:13:48 -0400
Message-ID: <4D7F49DF.9010801@redhat.com>
Date: Tue, 15 Mar 2011 19:13:35 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070708010609010505000909"
Subject: [LTP] [PATCH] syscalls: mmap10: fix broken testcase
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

This is a multi-part message in MIME format.
--------------070708010609010505000909
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

current mmap10 testcase in git couldn't reproduce the upstream bug as
expected, also it is completely broken on ppc64 system since the page
size in ppc64 is not 4KB but 64KB. This patch fixes these issues.

Some extra fix and cleaning:

. if a system without MADV_MERGEABLE, it should still be able to run all
the other mmap10 tests if only -s option not given.

. Reduce the duplicated useless output to one.

This patch is tested on RHEL6.0 and mmap10 now works as expected.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 runtest/mm                              |    2 +-
 testcases/kernel/syscalls/mmap/mmap10.c |   68
+++++++++++++++++++------------
 2 files changed, 43 insertions(+), 27 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 1296e59..0633e14 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -58,7 +58,7 @@ mmap10 mmap10
 mmap10_1 mmap10 -a
 mmap10_2 mmap10 -s
 mmap10_3 mmap10 -a -s
-mmap10_4 mmap10 -a -s -c 60
+mmap10_4 mmap10 -a -s -i 60

 ksm01 ksm01
 ksm01_1 ksm01 -u 128
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c
b/testcases/kernel/syscalls/mmap/mmap10.c
index cc17766..b735f5b 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -68,8 +68,9 @@
 char *TCID = "mmap10";
 int TST_TOTAL = 1;

-#ifdef HAVE_MADV_MERGEABLE
-static int fd, opt_anon, opt_ksm;
+static int  fd, opt_anon, opt_ksm;
+static long ps;
+static char *x;

 void setup(void);
 void cleanup(void);
@@ -90,73 +91,92 @@ int main(int argc, char *argv[])
 	msg = parse_opts(argc, argv, options, help);
 	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	if (opt_ksm)
+	{
+#ifdef HAVE_MADV_MERGEABLE
+		tst_resm(TINFO, "add to KSM regions.");
+#else
+		tst_brkm(TCONF, NULL, "MADV_MERGEABLE missing in sys/mman.h");
+#endif
+	}
+	if (opt_anon)
+		tst_resm(TINFO, "use anonymous pages.");
+	else
+		tst_resm(TINFO, "use /dev/zero.");
+
 	setup();
+
+	tst_resm(TINFO, "start tests.");
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		Tst_count = 0;
-		tst_resm(TINFO, "start tests.");
 		mmapzero();
 	}
+
 	cleanup();
 	tst_exit();
 }

 void mmapzero(void)
 {
-	char *x;
 	int n;

 	if (opt_anon) {
-		tst_resm(TINFO, "use anonymous pages.");
-		x = mmap(NULL, SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
+		x = mmap(NULL, SIZE+SIZE-ps, PROT_READ|PROT_WRITE,
 			MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
 	} else {
-		tst_resm(TINFO, "use /dev/zero.");
 		if ((fd = open("/dev/zero", O_RDWR, 0666)) < 0)
 			tst_brkm(TBROK|TERRNO, cleanup, "open");
-		x = mmap(NULL, SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
+		x = mmap(NULL, SIZE+SIZE-ps, PROT_READ|PROT_WRITE,
 			MAP_PRIVATE, fd, 0);
 	}
 	if (x == MAP_FAILED)
-		tst_brkm(TBROK|TERRNO, cleanup, "mmap");
+		tst_brkm(TFAIL|TERRNO, cleanup, "mmap");
+#ifdef HAVE_MADV_MERGEABLE
 	if (opt_ksm) {
-		tst_resm(TINFO, "add to KSM regions.");
-		if (madvise(x, SIZE+SIZE-4096, MADV_MERGEABLE) == -1)
+		if (madvise(x, SIZE+SIZE-ps, MADV_MERGEABLE) == -1)
 			tst_brkm(TBROK|TERRNO, cleanup, "madvise");
 	}
+#endif
 	x[SIZE] = 0;

 	switch(n = fork()) {
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork");
 	case 0:
-		if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+		if (munmap(x+SIZE+ps, SIZE-ps-ps) == -1)
+			tst_brkm(TFAIL|TERRNO, cleanup, "munmap");
 		exit(0);
 	default:
 		break;
 	}
+
 	switch(n = fork()) {
 	case -1:
 		tst_brkm(TBROK|TERRNO, cleanup, "fork");
 	case 0:
-		if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
-			tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+		if (munmap(x+SIZE+ps, SIZE-ps-ps) == -1)
+			tst_brkm(TFAIL|TERRNO, cleanup,
+					"subsequent munmap #1");
 		exit(0);
 	default:
 		switch (n = fork()) {
 		case -1:
 			tst_brkm(TBROK|TERRNO, cleanup, "fork");
 		case 0:
-			if (munmap(x + SIZE+4096, SIZE-4096*2) == -1)
-				tst_brkm(TBROK|TERRNO, cleanup, "munmap");
+			if (munmap(x+SIZE+ps, SIZE-ps-ps) == -1)
+				tst_brkm(TFAIL|TERRNO, cleanup,
+						"subsequent munmap #2");
 			exit(0);
 		default:
 			break;
 		}
 		break;
 	}
-	if (munmap(x, SIZE+SIZE-4096) == -1)
-		tst_resm(TFAIL|TERRNO, "munmap");
+
+	if (munmap(x, SIZE+SIZE-ps) == -1)
+		tst_resm(TFAIL|TERRNO, "munmap all");
+
 	while (waitpid(-1, &n, WUNTRACED | WCONTINUED) > 0)
 		if (WEXITSTATUS(n) != 0)
 			tst_resm(TFAIL, "child exit status is %d",
@@ -174,6 +194,9 @@ void setup(void)

 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
+
+	if ((ps = sysconf(_SC_PAGESIZE)) == -1)
+		tst_brkm(TBROK|TERRNO, cleanup, "sysconf(_SC_PAGESIZE)");
 }

 void help(void)
@@ -181,10 +204,3 @@ void help(void)
 	printf("  -a      Test anonymous pages\n");
 	printf("  -s      Add to KSM regions\n");
 }
-#else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, "MADV_MERGEABLE missing in sys/mman.h");
-	tst_exit();
-}
-#endif
-- 
1.7.4.1


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------070708010609010505000909
Content-Type: text/plain; name="0001-syscalls-mmap10-fix-broken-testcase.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-syscalls-mmap10-fix-broken-testcase.patch"

Y3VycmVudCBtbWFwMTAgdGVzdGNhc2UgaW4gZ2l0IGNvdWxkbid0IHJlcHJvZHVjZSB0aGUg
dXBzdHJlYW0gYnVnIGFzCmV4cGVjdGVkLCBhbHNvIGl0IGlzIGNvbXBsZXRlbHkgYnJva2Vu
IG9uIHBwYzY0IHN5c3RlbSBzaW5jZSB0aGUgcGFnZQpzaXplIGluIHBwYzY0IGlzIG5vdCA0
S0IgYnV0IDY0S0IuIFRoaXMgcGF0Y2ggZml4ZXMgdGhlc2UgaXNzdWVzLgoKU29tZSBleHRy
YSBmaXggYW5kIGNsZWFuaW5nOgoKLiBpZiBhIHN5c3RlbSB3aXRob3V0IE1BRFZfTUVSR0VB
QkxFLCBpdCBzaG91bGQgc3RpbGwgYmUgYWJsZSB0byBydW4gYWxsCnRoZSBvdGhlciBtbWFw
MTAgdGVzdHMgaWYgb25seSAtcyBvcHRpb24gbm90IGdpdmVuLgoKLiBSZWR1Y2UgdGhlIGR1
cGxpY2F0ZWQgdXNlbGVzcyBvdXRwdXQgdG8gb25lLgoKVGhpcyBwYXRjaCBpcyB0ZXN0ZWQg
b24gUkhFTDYuMCBhbmQgbW1hcDEwIG5vdyB3b3JrcyBhcyBleHBlY3RlZC4KClNpZ25lZC1v
ZmYtYnk6IENhc3BhciBaaGFuZyA8Y3poYW5nQHJlZGhhdC5jb20+Ci0tLQogcnVudGVzdC9t
bSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMiArLQogdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tbWFwL21tYXAxMC5jIHwgICA2OCArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDQzIGluc2VydGlvbnMoKyksIDI3IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3J1bnRlc3QvbW0gYi9ydW50ZXN0L21tCmluZGV4
IDEyOTZlNTkuLjA2MzNlMTQgMTAwNjQ0Ci0tLSBhL3J1bnRlc3QvbW0KKysrIGIvcnVudGVz
dC9tbQpAQCAtNTgsNyArNTgsNyBAQCBtbWFwMTAgbW1hcDEwCiBtbWFwMTBfMSBtbWFwMTAg
LWEKIG1tYXAxMF8yIG1tYXAxMCAtcwogbW1hcDEwXzMgbW1hcDEwIC1hIC1zCi1tbWFwMTBf
NCBtbWFwMTAgLWEgLXMgLWMgNjAKK21tYXAxMF80IG1tYXAxMCAtYSAtcyAtaSA2MAogCiBr
c20wMSBrc20wMQoga3NtMDFfMSBrc20wMSAtdSAxMjgKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTAuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbW1hcC9tbWFwMTAuYwppbmRleCBjYzE3NzY2Li5iNzM1ZjViIDEwMDY0NAotLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDEwLmMKKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxMC5jCkBAIC02OCw4ICs2OCw5IEBACiBj
aGFyICpUQ0lEID0gIm1tYXAxMCI7CiBpbnQgVFNUX1RPVEFMID0gMTsKIAotI2lmZGVmIEhB
VkVfTUFEVl9NRVJHRUFCTEUKLXN0YXRpYyBpbnQgZmQsIG9wdF9hbm9uLCBvcHRfa3NtOwor
c3RhdGljIGludCAgZmQsIG9wdF9hbm9uLCBvcHRfa3NtOworc3RhdGljIGxvbmcgcHM7Citz
dGF0aWMgY2hhciAqeDsKIAogdm9pZCBzZXR1cCh2b2lkKTsKIHZvaWQgY2xlYW51cCh2b2lk
KTsKQEAgLTkwLDczICs5MSw5MiBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltd
KQogCW1zZyA9IHBhcnNlX29wdHMoYXJnYywgYXJndiwgb3B0aW9ucywgaGVscCk7CiAJaWYg
KG1zZyAhPSBOVUxMKQogCQl0c3RfYnJrbShUQlJPSywgTlVMTCwgIk9QVElPTiBQQVJTSU5H
IEVSUk9SIC0gJXMiLCBtc2cpOworCisJaWYgKG9wdF9rc20pCisJeworI2lmZGVmIEhBVkVf
TUFEVl9NRVJHRUFCTEUKKwkJdHN0X3Jlc20oVElORk8sICJhZGQgdG8gS1NNIHJlZ2lvbnMu
Iik7CisjZWxzZQorCQl0c3RfYnJrbShUQ09ORiwgTlVMTCwgIk1BRFZfTUVSR0VBQkxFIG1p
c3NpbmcgaW4gc3lzL21tYW4uaCIpOworI2VuZGlmCisJfQorCWlmIChvcHRfYW5vbikKKwkJ
dHN0X3Jlc20oVElORk8sICJ1c2UgYW5vbnltb3VzIHBhZ2VzLiIpOworCWVsc2UKKwkJdHN0
X3Jlc20oVElORk8sICJ1c2UgL2Rldi96ZXJvLiIpOworCiAJc2V0dXAoKTsKKworCXRzdF9y
ZXNtKFRJTkZPLCAic3RhcnQgdGVzdHMuIik7CiAJZm9yIChsYyA9IDA7IFRFU1RfTE9PUElO
RyhsYyk7IGxjKyspIHsKIAkJVHN0X2NvdW50ID0gMDsKLQkJdHN0X3Jlc20oVElORk8sICJz
dGFydCB0ZXN0cy4iKTsKIAkJbW1hcHplcm8oKTsKIAl9CisKIAljbGVhbnVwKCk7CiAJdHN0
X2V4aXQoKTsKIH0KIAogdm9pZCBtbWFwemVybyh2b2lkKQogewotCWNoYXIgKng7CiAJaW50
IG47CiAKIAlpZiAob3B0X2Fub24pIHsKLQkJdHN0X3Jlc20oVElORk8sICJ1c2UgYW5vbnlt
b3VzIHBhZ2VzLiIpOwotCQl4ID0gbW1hcChOVUxMLCBTSVpFK1NJWkUtNDA5NiwgUFJPVF9S
RUFEfFBST1RfV1JJVEUsCisJCXggPSBtbWFwKE5VTEwsIFNJWkUrU0laRS1wcywgUFJPVF9S
RUFEfFBST1RfV1JJVEUsCiAJCQlNQVBfUFJJVkFURXxNQVBfQU5PTllNT1VTLCAtMSwgMCk7
CiAJfSBlbHNlIHsKLQkJdHN0X3Jlc20oVElORk8sICJ1c2UgL2Rldi96ZXJvLiIpOwogCQlp
ZiAoKGZkID0gb3BlbigiL2Rldi96ZXJvIiwgT19SRFdSLCAwNjY2KSkgPCAwKQogCQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAib3BlbiIpOwotCQl4ID0gbW1hcChOVUxM
LCBTSVpFK1NJWkUtNDA5NiwgUFJPVF9SRUFEfFBST1RfV1JJVEUsCisJCXggPSBtbWFwKE5V
TEwsIFNJWkUrU0laRS1wcywgUFJPVF9SRUFEfFBST1RfV1JJVEUsCiAJCQlNQVBfUFJJVkFU
RSwgZmQsIDApOwogCX0KIAlpZiAoeCA9PSBNQVBfRkFJTEVEKQotCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJtbWFwIik7CisJCXRzdF9icmttKFRGQUlMfFRFUlJOTywg
Y2xlYW51cCwgIm1tYXAiKTsKKyNpZmRlZiBIQVZFX01BRFZfTUVSR0VBQkxFCiAJaWYgKG9w
dF9rc20pIHsKLQkJdHN0X3Jlc20oVElORk8sICJhZGQgdG8gS1NNIHJlZ2lvbnMuIik7Ci0J
CWlmIChtYWR2aXNlKHgsIFNJWkUrU0laRS00MDk2LCBNQURWX01FUkdFQUJMRSkgPT0gLTEp
CisJCWlmIChtYWR2aXNlKHgsIFNJWkUrU0laRS1wcywgTUFEVl9NRVJHRUFCTEUpID09IC0x
KQogCQkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibWFkdmlzZSIpOwogCX0K
KyNlbmRpZgogCXhbU0laRV0gPSAwOwogCiAJc3dpdGNoKG4gPSBmb3JrKCkpIHsKIAljYXNl
IC0xOgogCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJmb3JrIik7CiAJY2Fz
ZSAwOgotCQlpZiAobXVubWFwKHggKyBTSVpFKzQwOTYsIFNJWkUtNDA5NioyKSA9PSAtMSkK
LQkJCXRzdF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgIm11bm1hcCIpOworCQlpZiAo
bXVubWFwKHgrU0laRStwcywgU0laRS1wcy1wcykgPT0gLTEpCisJCQl0c3RfYnJrbShURkFJ
THxURVJSTk8sIGNsZWFudXAsICJtdW5tYXAiKTsKIAkJZXhpdCgwKTsKIAlkZWZhdWx0Ogog
CQlicmVhazsKIAl9CisKIAlzd2l0Y2gobiA9IGZvcmsoKSkgewogCWNhc2UgLTE6CiAJCXRz
dF9icmttKFRCUk9LfFRFUlJOTywgY2xlYW51cCwgImZvcmsiKTsKIAljYXNlIDA6Ci0JCWlm
IChtdW5tYXAoeCArIFNJWkUrNDA5NiwgU0laRS00MDk2KjIpID09IC0xKQotCQkJdHN0X2Jy
a20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAibXVubWFwIik7CisJCWlmIChtdW5tYXAoeCtT
SVpFK3BzLCBTSVpFLXBzLXBzKSA9PSAtMSkKKwkJCXRzdF9icmttKFRGQUlMfFRFUlJOTywg
Y2xlYW51cCwgCisJCQkJCSJzdWJzZXF1ZW50IG11bm1hcCAjMSIpOwogCQlleGl0KDApOwog
CWRlZmF1bHQ6CiAJCXN3aXRjaCAobiA9IGZvcmsoKSkgewogCQljYXNlIC0xOgogCQkJdHN0
X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiZm9yayIpOwogCQljYXNlIDA6Ci0JCQlp
ZiAobXVubWFwKHggKyBTSVpFKzQwOTYsIFNJWkUtNDA5NioyKSA9PSAtMSkKLQkJCQl0c3Rf
YnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJtdW5tYXAiKTsKKwkJCWlmIChtdW5tYXAo
eCtTSVpFK3BzLCBTSVpFLXBzLXBzKSA9PSAtMSkKKwkJCQl0c3RfYnJrbShURkFJTHxURVJS
Tk8sIGNsZWFudXAsIAorCQkJCQkJInN1YnNlcXVlbnQgbXVubWFwICMyIik7CiAJCQlleGl0
KDApOwogCQlkZWZhdWx0OgogCQkJYnJlYWs7CiAJCX0KIAkJYnJlYWs7CiAJfQotCWlmICht
dW5tYXAoeCwgU0laRStTSVpFLTQwOTYpID09IC0xKQotCQl0c3RfcmVzbShURkFJTHxURVJS
Tk8sICJtdW5tYXAiKTsKKworCWlmIChtdW5tYXAoeCwgU0laRStTSVpFLXBzKSA9PSAtMSkK
KwkJdHN0X3Jlc20oVEZBSUx8VEVSUk5PLCAibXVubWFwIGFsbCIpOworCiAJd2hpbGUgKHdh
aXRwaWQoLTEsICZuLCBXVU5UUkFDRUQgfCBXQ09OVElOVUVEKSA+IDApCiAJCWlmIChXRVhJ
VFNUQVRVUyhuKSAhPSAwKQogCQkJdHN0X3Jlc20oVEZBSUwsICJjaGlsZCBleGl0IHN0YXR1
cyBpcyAlZCIsCkBAIC0xNzQsNiArMTk0LDkgQEAgdm9pZCBzZXR1cCh2b2lkKQogCiAJdHN0
X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CiAJVEVTVF9QQVVTRTsKKworCWlm
ICgocHMgPSBzeXNjb25mKF9TQ19QQUdFU0laRSkpID09IC0xKQorCQl0c3RfYnJrbShUQlJP
S3xURVJSTk8sIGNsZWFudXAsICJzeXNjb25mKF9TQ19QQUdFU0laRSkiKTsKIH0KIAogdm9p
ZCBoZWxwKHZvaWQpCkBAIC0xODEsMTAgKzIwNCwzIEBAIHZvaWQgaGVscCh2b2lkKQogCXBy
aW50ZigiICAtYSAgICAgIFRlc3QgYW5vbnltb3VzIHBhZ2VzXG4iKTsKIAlwcmludGYoIiAg
LXMgICAgICBBZGQgdG8gS1NNIHJlZ2lvbnNcbiIpOwogfQotI2Vsc2UKLWludCBtYWluKHZv
aWQpCi17Ci0JdHN0X2Jya20oVENPTkYsIE5VTEwsICJNQURWX01FUkdFQUJMRSBtaXNzaW5n
IGluIHN5cy9tbWFuLmgiKTsKLQl0c3RfZXhpdCgpOwotfQotI2VuZGlmCi0tIAoxLjcuNC4x
Cgo=
--------------070708010609010505000909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
--------------070708010609010505000909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070708010609010505000909--

