Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PvCga-0000WZ-QW
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 17:51:36 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvCgZ-0001jw-L3
	for ltp-list@lists.sourceforge.net; Thu, 03 Mar 2011 17:51:36 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p23HpT4S031189
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 3 Mar 2011 12:51:29 -0500
Message-ID: <4D6FD518.1040503@redhat.com>
Date: Fri, 04 Mar 2011 01:51:20 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4D6FD1D5.30209@redhat.com>
In-Reply-To: <4D6FD1D5.30209@redhat.com>
Content-Type: multipart/mixed; boundary="------------090509010106020504090201"
Subject: [LTP] [PATCH v2] syscalls: getdents0[234]: add tst_exit()
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
--------------090509010106020504090201
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Similar to getdents0[34] and getdents0[234]_64, so I updated the patch
to v2.

These tests contain x86 asm so that they wouldn't be run on x86_64
machine, but run into a simple main() functions instead. However all of
them are missing tst_exit() which could result in a exit_code=10
failure.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/getdents/getdents02.c |    4 ++--
 testcases/kernel/syscalls/getdents/getdents03.c |    4 ++--
 testcases/kernel/syscalls/getdents/getdents04.c |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c
b/testcases/kernel/syscalls/getdents/getdents02.c
index 4daae05..2503712 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -74,7 +74,7 @@ int main()
 {
 	tst_resm(TINFO, "This test includes x86 asm and will not work on "
 		 "this machine");
-
+	tst_exit();
 }
 #else

@@ -208,4 +208,4 @@ void cleanup(void)

 }

-#endif /* __i386__ */
\ No newline at end of file
+#endif /* __i386__ */
diff --git a/testcases/kernel/syscalls/getdents/getdents03.c
b/testcases/kernel/syscalls/getdents/getdents03.c
index 95ec278..1fd9dc0 100644
--- a/testcases/kernel/syscalls/getdents/getdents03.c
+++ b/testcases/kernel/syscalls/getdents/getdents03.c
@@ -77,7 +77,7 @@ int main()
 {
 	tst_resm(TINFO, "This test includes x86 asm and will not work on "
 		 "this machine");
-
+	tst_exit();
 }
 #else

@@ -217,4 +217,4 @@ void cleanup(void)

 }

-#endif /* __i386__ */
\ No newline at end of file
+#endif /* __i386__ */
diff --git a/testcases/kernel/syscalls/getdents/getdents04.c
b/testcases/kernel/syscalls/getdents/getdents04.c
index 88c8e04..c858cf2 100644
--- a/testcases/kernel/syscalls/getdents/getdents04.c
+++ b/testcases/kernel/syscalls/getdents/getdents04.c
@@ -78,7 +78,7 @@ int main()
 {
 	tst_resm(TINFO, "This test includes x86 asm and will not work on "
 		 "this machine");
-
+	tst_exit();
 }
 #else

@@ -244,4 +244,4 @@ void cleanup(void)

 }

-#endif /* __i386__ */
\ No newline at end of file
+#endif /* __i386__ */
-- 
1.7.4.1


--------------090509010106020504090201
Content-Type: text/plain;
 name="syscalls-getdents0-234-add-tst_exit.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="syscalls-getdents0-234-add-tst_exit.patch"

VGhlc2UgdGVzdHMgY29udGFpbiB4ODYgYXNtIHNvIHRoYXQgdGhleSB3b3VsZG4ndCBiZSBy
dW4gb24geDg2XzY0Cm1hY2hpbmUsIGJ1dCBydW4gaW50byBhIHNpbXBsZSBtYWluKCkgZnVu
Y3Rpb25zIGluc3RlYWQuIEhvd2V2ZXIgYWxsIG9mCnRoZW0gYXJlIG1pc3NpbmcgdHN0X2V4
aXQoKSB3aGljaCBjb3VsZCByZXN1bHQgaW4gYSBleGl0X2NvZGU9MTAKZmFpbHVyZS4KClNp
Z25lZC1vZmYtYnk6IENhc3BhciBaaGFuZyA8Y3poYW5nQHJlZGhhdC5jb20+Ci0tLQogdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRkZW50cy9nZXRkZW50czAyLmMgfCAgICA0ICsr
LS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMwMy5jIHwg
ICAgNCArKy0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRz
MDQuYyB8ICAgIDQgKystLQogMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDYg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9n
ZXRkZW50cy9nZXRkZW50czAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRl
bnRzL2dldGRlbnRzMDIuYwppbmRleCA0ZGFhZTA1Li4yNTAzNzEyIDEwMDY0NAotLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDIuYworKysgYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDIuYwpAQCAtNzQs
NyArNzQsNyBAQCBpbnQgbWFpbigpCiB7CiAJdHN0X3Jlc20oVElORk8sICJUaGlzIHRlc3Qg
aW5jbHVkZXMgeDg2IGFzbSBhbmQgd2lsbCBub3Qgd29yayBvbiAiCiAJCSAidGhpcyBtYWNo
aW5lIik7Ci0KKwl0c3RfZXhpdCgpOwogfQogI2Vsc2UKIApAQCAtMjA4LDQgKzIwOCw0IEBA
IHZvaWQgY2xlYW51cCh2b2lkKQogCiB9CiAKLSNlbmRpZiAvKiBfX2kzODZfXyAqLwpcIE5v
IG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKKyNlbmRpZiAvKiBfX2kzODZfXyAqLwpkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRkZW50cy9nZXRkZW50czAzLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDMuYwppbmRl
eCA5NWVjMjc4Li4xZmQ5ZGMwIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2dldGRlbnRzL2dldGRlbnRzMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2dldGRlbnRzL2dldGRlbnRzMDMuYwpAQCAtNzcsNyArNzcsNyBAQCBpbnQgbWFpbigp
CiB7CiAJdHN0X3Jlc20oVElORk8sICJUaGlzIHRlc3QgaW5jbHVkZXMgeDg2IGFzbSBhbmQg
d2lsbCBub3Qgd29yayBvbiAiCiAJCSAidGhpcyBtYWNoaW5lIik7Ci0KKwl0c3RfZXhpdCgp
OwogfQogI2Vsc2UKIApAQCAtMjE3LDQgKzIxNyw0IEBAIHZvaWQgY2xlYW51cCh2b2lkKQog
CiB9CiAKLSNlbmRpZiAvKiBfX2kzODZfXyAqLwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZp
bGUKKyNlbmRpZiAvKiBfX2kzODZfXyAqLwpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9nZXRkZW50cy9nZXRkZW50czA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDQuYwppbmRleCA4OGM4ZTA0Li5jODU4Y2YyIDEw
MDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRz
MDQuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRz
MDQuYwpAQCAtNzgsNyArNzgsNyBAQCBpbnQgbWFpbigpCiB7CiAJdHN0X3Jlc20oVElORk8s
ICJUaGlzIHRlc3QgaW5jbHVkZXMgeDg2IGFzbSBhbmQgd2lsbCBub3Qgd29yayBvbiAiCiAJ
CSAidGhpcyBtYWNoaW5lIik7Ci0KKwl0c3RfZXhpdCgpOwogfQogI2Vsc2UKIApAQCAtMjQ0
LDQgKzI0NCw0IEBAIHZvaWQgY2xlYW51cCh2b2lkKQogCiB9CiAKLSNlbmRpZiAvKiBfX2kz
ODZfXyAqLwpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKKyNlbmRpZiAvKiBfX2kzODZf
XyAqLwotLSAKMS43LjQuMQoK
--------------090509010106020504090201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Free Software Download: Index, Search & Analyze Logs and other IT data in 
Real-Time with Splunk. Collect, index and harness all the fast moving IT data 
generated by your applications, servers and devices whether physical, virtual
or in the cloud. Deliver compliance at lower cost and gain new business 
insights. http://p.sf.net/sfu/splunk-dev2dev 
--------------090509010106020504090201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090509010106020504090201--

