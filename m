Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1PvQlD-0004Ct-SB
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 08:53:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PvQlA-0006Sw-Dz
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 08:53:19 +0000
Message-ID: <4D70A86B.3000800@redhat.com>
Date: Fri, 04 Mar 2011 16:52:59 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
References: <4D6FD1D5.30209@redhat.com>	<4D6FD518.1040503@redhat.com>
	<20110304093711.7c022f74@regolo>
In-Reply-To: <20110304093711.7c022f74@regolo>
Content-Type: multipart/mixed; boundary="------------030102010607070201080209"
Subject: Re: [LTP] [PATCH v2] syscalls: getdents0[234]: add tst_exit()
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
To: Cristian Greco <cristian@regolo.cc>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030102010607070201080209
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2011 04:37 PM, Cristian Greco wrote:
> wouldn't it be better to call tst_resm() with TCONF instead of TINFO,
> for the sake of consistency?

Agree. Updated to v3:

These tests contain x86 asm so that they wouldn't be run on x86_64
machine, but run into a simple main() functions instead. However all of
them are missing tst_exit() which could result in a exit_code=10
failure.

v3: modify TINFO to TCONF

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/getdents/getdents02.c |    6 +++---
 testcases/kernel/syscalls/getdents/getdents03.c |    6 +++---
 testcases/kernel/syscalls/getdents/getdents04.c |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents02.c
b/testcases/kernel/syscalls/getdents/getdents02.c
index 4daae05..ed73b42 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -72,9 +72,9 @@ int exp_enos[] = { EBADF, 0 };	/* 0 terminated list of
expected errnos */
 #ifndef __i386__
 int main()
 {
-	tst_resm(TINFO, "This test includes x86 asm and will not work on "
+	tst_resm(TCONF, "This test includes x86 asm and will not work on "
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
index 95ec278..d4b3b66 100644
--- a/testcases/kernel/syscalls/getdents/getdents03.c
+++ b/testcases/kernel/syscalls/getdents/getdents03.c
@@ -75,9 +75,9 @@ int exp_enos[] = { EINVAL, 0 };	/* 0 terminated list
of expected errnos */
 #ifndef __i386__
 int main()
 {
-	tst_resm(TINFO, "This test includes x86 asm and will not work on "
+	tst_resm(TCONF, "This test includes x86 asm and will not work on "
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
index 88c8e04..6c6faff 100644
--- a/testcases/kernel/syscalls/getdents/getdents04.c
+++ b/testcases/kernel/syscalls/getdents/getdents04.c
@@ -76,9 +76,9 @@ int exp_enos[] = { ENOTDIR, 0 };	/* 0 terminated list
of expected errnos */
 #ifndef __i386__
 int main()
 {
-	tst_resm(TINFO, "This test includes x86 asm and will not work on "
+	tst_resm(TCONF, "This test includes x86 asm and will not work on "
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



-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------030102010607070201080209
Content-Type: text/plain; name="0001-syscalls-getdents0-234-add-tst_exit.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-syscalls-getdents0-234-add-tst_exit.patch"

RnJvbSAxODk5NDg0YTEzZDZhNDBlYjVmOGU4NDViZjk0Y2Q0ZDJiYjdiNzEyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRoYXQuY29t
PgpEYXRlOiBGcmksIDQgTWFyIDIwMTEgMTY6NDk6MDEgKzA4MDAKU3ViamVjdDogW1BBVENI
XSBzeXNjYWxsczogZ2V0ZGVudHMwWzIzNF06IGFkZCB0c3RfZXhpdCgpCgpUaGVzZSB0ZXN0
cyBjb250YWluIHg4NiBhc20gc28gdGhhdCB0aGV5IHdvdWxkbid0IGJlIHJ1biBvbiB4ODZf
NjQKbWFjaGluZSwgYnV0IHJ1biBpbnRvIGEgc2ltcGxlIG1haW4oKSBmdW5jdGlvbnMgaW5z
dGVhZC4gSG93ZXZlciBhbGwgb2YKdGhlbSBhcmUgbWlzc2luZyB0c3RfZXhpdCgpIHdoaWNo
IGNvdWxkIHJlc3VsdCBpbiBhIGV4aXRfY29kZT0xMApmYWlsdXJlLgoKdjM6IG1vZGlmeSBU
SU5GTyB0byBUQ09ORgoKU2lnbmVkLW9mZi1ieTogQ2FzcGFyIFpoYW5nIDxjemhhbmdAcmVk
aGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRl
bnRzMDIuYyB8ICAgIDYgKysrLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRl
bnRzL2dldGRlbnRzMDMuYyB8ICAgIDYgKysrLS0tCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2dldGRlbnRzL2dldGRlbnRzMDQuYyB8ICAgIDYgKysrLS0tCiAzIGZpbGVzIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDIuYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMwMi5jCmluZGV4IDRkYWFlMDUu
LmVkNzNiNDIgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVu
dHMvZ2V0ZGVudHMwMi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVu
dHMvZ2V0ZGVudHMwMi5jCkBAIC03Miw5ICs3Miw5IEBAIGludCBleHBfZW5vc1tdID0geyBF
QkFERiwgMCB9OwkvKiAwIHRlcm1pbmF0ZWQgbGlzdCBvZiBleHBlY3RlZCBlcnJub3MgKi8K
ICNpZm5kZWYgX19pMzg2X18KIGludCBtYWluKCkKIHsKLQl0c3RfcmVzbShUSU5GTywgIlRo
aXMgdGVzdCBpbmNsdWRlcyB4ODYgYXNtIGFuZCB3aWxsIG5vdCB3b3JrIG9uICIKKwl0c3Rf
cmVzbShUQ09ORiwgIlRoaXMgdGVzdCBpbmNsdWRlcyB4ODYgYXNtIGFuZCB3aWxsIG5vdCB3
b3JrIG9uICIKIAkJICJ0aGlzIG1hY2hpbmUiKTsKLQorCXRzdF9leGl0KCk7CiB9CiAjZWxz
ZQogCkBAIC0yMDgsNCArMjA4LDQgQEAgdm9pZCBjbGVhbnVwKHZvaWQpCiAKIH0KIAotI2Vu
ZGlmIC8qIF9faTM4Nl9fICovClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQorI2VuZGlm
IC8qIF9faTM4Nl9fICovCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2dldGRlbnRzL2dldGRlbnRzMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0
ZGVudHMvZ2V0ZGVudHMwMy5jCmluZGV4IDk1ZWMyNzguLmQ0YjNiNjYgMTAwNjQ0Ci0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMwMy5jCisrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0ZGVudHMvZ2V0ZGVudHMwMy5jCkBAIC03
NSw5ICs3NSw5IEBAIGludCBleHBfZW5vc1tdID0geyBFSU5WQUwsIDAgfTsJLyogMCB0ZXJt
aW5hdGVkIGxpc3Qgb2YgZXhwZWN0ZWQgZXJybm9zICovCiAjaWZuZGVmIF9faTM4Nl9fCiBp
bnQgbWFpbigpCiB7Ci0JdHN0X3Jlc20oVElORk8sICJUaGlzIHRlc3QgaW5jbHVkZXMgeDg2
IGFzbSBhbmQgd2lsbCBub3Qgd29yayBvbiAiCisJdHN0X3Jlc20oVENPTkYsICJUaGlzIHRl
c3QgaW5jbHVkZXMgeDg2IGFzbSBhbmQgd2lsbCBub3Qgd29yayBvbiAiCiAJCSAidGhpcyBt
YWNoaW5lIik7Ci0KKwl0c3RfZXhpdCgpOwogfQogI2Vsc2UKIApAQCAtMjE3LDQgKzIxNyw0
IEBAIHZvaWQgY2xlYW51cCh2b2lkKQogCiB9CiAKLSNlbmRpZiAvKiBfX2kzODZfXyAqLwpc
IE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKKyNlbmRpZiAvKiBfX2kzODZfXyAqLwpkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRkZW50cy9nZXRkZW50czA0
LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDQuYwpp
bmRleCA4OGM4ZTA0Li42YzZmYWZmIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDQuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2dldGRlbnRzL2dldGRlbnRzMDQuYwpAQCAtNzYsOSArNzYsOSBAQCBpbnQgZXhw
X2Vub3NbXSA9IHsgRU5PVERJUiwgMCB9OwkvKiAwIHRlcm1pbmF0ZWQgbGlzdCBvZiBleHBl
Y3RlZCBlcnJub3MgKi8KICNpZm5kZWYgX19pMzg2X18KIGludCBtYWluKCkKIHsKLQl0c3Rf
cmVzbShUSU5GTywgIlRoaXMgdGVzdCBpbmNsdWRlcyB4ODYgYXNtIGFuZCB3aWxsIG5vdCB3
b3JrIG9uICIKKwl0c3RfcmVzbShUQ09ORiwgIlRoaXMgdGVzdCBpbmNsdWRlcyB4ODYgYXNt
IGFuZCB3aWxsIG5vdCB3b3JrIG9uICIKIAkJICJ0aGlzIG1hY2hpbmUiKTsKLQorCXRzdF9l
eGl0KCk7CiB9CiAjZWxzZQogCkBAIC0yNDQsNCArMjQ0LDQgQEAgdm9pZCBjbGVhbnVwKHZv
aWQpCiAKIH0KIAotI2VuZGlmIC8qIF9faTM4Nl9fICovClwgTm8gbmV3bGluZSBhdCBlbmQg
b2YgZmlsZQorI2VuZGlmIC8qIF9faTM4Nl9fICovCi0tIAoxLjcuNC4xCgo=
--------------030102010607070201080209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
--------------030102010607070201080209
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030102010607070201080209--

