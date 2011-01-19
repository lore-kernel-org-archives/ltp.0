Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <qcai@redhat.com>) id 1PfT6J-00014s-7v
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:09:07 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PfT6H-0002xz-Se
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 08:09:07 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p0J88xnU015438
	for <ltp-list@lists.sourceforge.net>; Wed, 19 Jan 2011 03:08:59 -0500
Date: Wed, 19 Jan 2011 03:08:59 -0500 (EST)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <639439003.56154.1295424539927.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1818642692.56149.1295424534765.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_56153_2137683159.1295424539926"
Subject: [LTP] [PATCH] tests require root users
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

------=_Part_56153_2137683159.1295424539926
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Signed-off-by: CAI Qian <caiqian@redhat.com>
---
 testcases/kernel/mem/cpuset/cpuset01.c             |    3 ++-
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c |    1 +
 testcases/kernel/syscalls/mlock/mlock03.c          |    4 +++-
 testcases/kernel/syscalls/mmap/mmap10.c            |    3 ++-
 testcases/kernel/syscalls/mmap/mmap11.c            |    3 ++-
 5 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/cpuset/cpuset01.c b/testcases/kernel/mem/cpuset/cpuset01.c
index f769156..10ccde7 100644
--- a/testcases/kernel/mem/cpuset/cpuset01.c
+++ b/testcases/kernel/mem/cpuset/cpuset01.c
@@ -177,6 +177,8 @@ void testcpuset(void)
 
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	if (count_numa() == 1)
 		tst_brkm(TCONF, NULL, "required a NUMA system.");
 	tst_sig(FORK, DEF_HANDLER, cleanup);
@@ -223,7 +225,6 @@ void cleanup(void)
 		tst_resm(TWARN|TERRNO, "rmdir");
 
 	TEST_CLEANUP;
-
 }
 
 void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 73c6960..910b75c 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -294,6 +294,7 @@ static void setup(void)
 	FILE *fp;
 	int fd;
 
+	tst_require_root(NULL);
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 	tst_tmpdir();
diff --git a/testcases/kernel/syscalls/mlock/mlock03.c b/testcases/kernel/syscalls/mlock/mlock03.c
index 8ed9378..da469cb 100644
--- a/testcases/kernel/syscalls/mlock/mlock03.c
+++ b/testcases/kernel/syscalls/mlock/mlock03.c
@@ -110,6 +110,8 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
@@ -117,4 +119,4 @@ void setup(void)
 void cleanup(void)
 {
 	TEST_CLEANUP;
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index 7db7148..d3877a3 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -163,11 +163,12 @@ void mmapzero(void)
 void cleanup(void)
 {
 	TEST_CLEANUP;
-
 }
 
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/mmap/mmap11.c b/testcases/kernel/syscalls/mmap/mmap11.c
index 5c141a0..786724b 100644
--- a/testcases/kernel/syscalls/mmap/mmap11.c
+++ b/testcases/kernel/syscalls/mmap/mmap11.c
@@ -81,6 +81,8 @@ int main(int argc, char *argv[])
 
 void setup(void)
 {
+	tst_require_root(NULL);
+
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 	TEST_PAUSE;
 }
@@ -88,7 +90,6 @@ void setup(void)
 void cleanup(void)
 {
 	TEST_CLEANUP;
-
 }
 
 void check(void)
-- 
1.7.3.2
------=_Part_56153_2137683159.1295424539926
Content-Type: text/x-patch; name=0001-tests-require-root-users.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-tests-require-root-users.patch

RnJvbSA1NWZkMTg3YzM2ZDFjNzQ4NGE1NmY3NzhkMjRjOGFjN2NjZWMzNDllIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDQUkgUWlhbiA8Y2FpcWlhbkByZWRoYXQuY29tPgpEYXRlOiBX
ZWQsIDE5IEphbiAyMDExIDE1OjIxOjAyICswODAwClN1YmplY3Q6IFtQQVRDSF0gdGVzdHMgcmVx
dWlyZSByb290IHVzZXJzCgoKU2lnbmVkLW9mZi1ieTogQ0FJIFFpYW4gPGNhaXFpYW5AcmVkaGF0
LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYyAgICAgICAg
ICAgICB8ICAgIDMgKystCiB0ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VtbWFwL2h1
Z2VtbWFwMDUuYyB8ICAgIDEgKwogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbG9jay9tbG9j
azAzLmMgICAgICAgICAgfCAgICA0ICsrKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1h
cC9tbWFwMTAuYyAgICAgICAgICAgIHwgICAgMyArKy0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbW1hcC9tbWFwMTEuYyAgICAgICAgICAgIHwgICAgMyArKy0KIDUgZmlsZXMgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL21lbS9jcHVzZXQvY3B1c2V0MDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2NwdXNl
dC9jcHVzZXQwMS5jCmluZGV4IGY3NjkxNTYuLjEwY2NkZTcgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL2NwdXNldC9jcHVzZXQwMS5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
L2NwdXNldC9jcHVzZXQwMS5jCkBAIC0xNzcsNiArMTc3LDggQEAgdm9pZCB0ZXN0Y3B1c2V0KHZv
aWQpCiAKIHZvaWQgc2V0dXAodm9pZCkKIHsKKwl0c3RfcmVxdWlyZV9yb290KE5VTEwpOworCiAJ
aWYgKGNvdW50X251bWEoKSA9PSAxKQogCQl0c3RfYnJrbShUQ09ORiwgTlVMTCwgInJlcXVpcmVk
IGEgTlVNQSBzeXN0ZW0uIik7CiAJdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7
CkBAIC0yMjMsNyArMjI1LDYgQEAgdm9pZCBjbGVhbnVwKHZvaWQpCiAJCXRzdF9yZXNtKFRXQVJO
fFRFUlJOTywgInJtZGlyIik7CiAKIAlURVNUX0NMRUFOVVA7Ci0KIH0KIAogdm9pZCBzaWdoYW5k
bGVyKGludCBzaWdubyBMVFBfQVRUUklCVVRFX1VOVVNFRCkKZGlmZiAtLWdpdCBhL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAwNS5jIGIvdGVzdGNhc2VzL2tl
cm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDA1LmMKaW5kZXggNzNjNjk2MC4uOTEw
Yjc1YyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9o
dWdlbW1hcDA1LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlbW1hcC9o
dWdlbW1hcDA1LmMKQEAgLTI5NCw2ICsyOTQsNyBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQog
CUZJTEUgKmZwOwogCWludCBmZDsKIAorCXRzdF9yZXF1aXJlX3Jvb3QoTlVMTCk7CiAJdHN0X3Np
ZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CiAJVEVTVF9QQVVTRTsKIAl0c3RfdG1wZGly
KCk7CmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21sb2NrL21sb2NrMDMu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWxvY2svbWxvY2swMy5jCmluZGV4IDhlZDkz
NzguLmRhNDY5Y2IgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWxvY2sv
bWxvY2swMy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbWxvY2svbWxvY2swMy5j
CkBAIC0xMTAsNiArMTEwLDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAog
dm9pZCBzZXR1cCh2b2lkKQogeworCXRzdF9yZXF1aXJlX3Jvb3QoTlVMTCk7CisKIAl0c3Rfc2ln
KEZPUkssIERFRl9IQU5ETEVSLCBjbGVhbnVwKTsKIAlURVNUX1BBVVNFOwogfQpAQCAtMTE3LDQg
KzExOSw0IEBAIHZvaWQgc2V0dXAodm9pZCkKIHZvaWQgY2xlYW51cCh2b2lkKQogewogCVRFU1Rf
Q0xFQU5VUDsKLX0KXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxlCit9CmRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDEwLmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21tYXAvbW1hcDEwLmMKaW5kZXggN2RiNzE0OC4uZDM4NzdhMyAxMDA2NDQKLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxMC5jCisrKyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTAuYwpAQCAtMTYzLDExICsxNjMsMTIgQEAgdm9p
ZCBtbWFwemVybyh2b2lkKQogdm9pZCBjbGVhbnVwKHZvaWQpCiB7CiAJVEVTVF9DTEVBTlVQOwot
CiB9CiAKIHZvaWQgc2V0dXAodm9pZCkKIHsKKwl0c3RfcmVxdWlyZV9yb290KE5VTEwpOworCiAJ
dHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xlYW51cCk7CiAJVEVTVF9QQVVTRTsKIH0KZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTEuYyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMTEuYwppbmRleCA1YzE0MWEwLi43ODY3MjRi
IDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21tYXAvbW1hcDExLmMKKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAxMS5jCkBAIC04MSw2ICs4MSw4
IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAKIHZvaWQgc2V0dXAodm9pZCkK
IHsKKwl0c3RfcmVxdWlyZV9yb290KE5VTEwpOworCiAJdHN0X3NpZyhGT1JLLCBERUZfSEFORExF
UiwgY2xlYW51cCk7CiAJVEVTVF9QQVVTRTsKIH0KQEAgLTg4LDcgKzkwLDYgQEAgdm9pZCBzZXR1
cCh2b2lkKQogdm9pZCBjbGVhbnVwKHZvaWQpCiB7CiAJVEVTVF9DTEVBTlVQOwotCiB9CiAKIHZv
aWQgY2hlY2sodm9pZCkKLS0gCjEuNy4zLjIKCg==
------=_Part_56153_2137683159.1295424539926
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
------=_Part_56153_2137683159.1295424539926
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_56153_2137683159.1295424539926--

