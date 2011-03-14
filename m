Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Pz6VF-00034J-K4
	for ltp-list@lists.sourceforge.net; Mon, 14 Mar 2011 12:04:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Pz6VE-00049F-D9
	for ltp-list@lists.sourceforge.net; Mon, 14 Mar 2011 12:04:01 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p2EC3sQC013758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 14 Mar 2011 08:03:54 -0400
Message-ID: <4D7E0425.7090509@redhat.com>
Date: Mon, 14 Mar 2011 20:03:49 +0800
From: Caspar Zhang <czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090609020900070605020508"
Subject: [LTP] [PATCH] fs: fsstress: make test more POSIX compliant
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
--------------090609020900070605020508
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

[PATCH] fs: fsstress: make test more POSIX compliant

in commit bacc849720ec4efda5a0a8a9ea6a0e93a1415541, malloc.h was removed
and stdlib.h got used instead. However, it's not enough. The function
memalign() is also obsolete (via man memalign) and we should use
posix_memalign instead. Also if we keep memalign() function here, the
program would probably hit segfault once it enters dwrite_t and dread_t.

Besides the POSIX compliant fix, I also did a small fix to remove
compling warnings.

I tried to update this program output to tst_resm/tst_brkm style but
failed, I got confused by some printf output.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/fs/fsstress/fsstress.c |   38
++++++++++++++++++------------
 1 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c
b/testcases/kernel/fs/fsstress/fsstress.c
index e3b48ea..0e5fba2 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -1746,7 +1746,7 @@ void
 dread_f(int opno, long r)
 {
 	__int64_t	align;
-	char		*buf;
+	char		*buf=NULL;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
@@ -1799,11 +1799,9 @@ dread_f(int opno, long r)
 		return;
 	}

-	if (no_xfs) {
-		diob.d_miniosz = stb.st_blksize;
-		diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
-		diob.d_mem = stb.st_blksize;
-	}
+	diob.d_miniosz = stb.st_blksize;
+	diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
+	diob.d_mem = stb.st_blksize;
 #ifndef NO_XFS
 	else if (ioctl(fd, XFS_IOC_DIOINFO, &diob) < 0) {
 		if (v)
@@ -1826,7 +1824,13 @@ dread_f(int opno, long r)
 		len = align;
 	else if (len > diob.d_maxiosz)
 		len = diob.d_maxiosz;
-	buf = memalign(diob.d_mem, len);
+	if (posix_memalign((void **)buf, diob.d_mem, len) != 0) {
+		perror("posix_memalign");
+		exit (1);
+	} else if (buf == NULL) {
+		fprintf(stderr, "buf remains NULL unexpectly\n");
+		exit (1);
+	}
 	e = read(fd, buf, len) < 0 ? errno : 0;
 	free(buf);
 	if (v)
@@ -1840,7 +1844,7 @@ void
 dwrite_f(int opno, long r)
 {
 	__int64_t	align;
-	char		*buf;
+	char		*buf=NULL;
 	struct dioattr	diob;
 	int		e;
 	pathname_t	f;
@@ -1882,11 +1886,9 @@ dwrite_f(int opno, long r)
 		close(fd);
 		return;
 	}
-	if (no_xfs) {
-		diob.d_miniosz = stb.st_blksize;
-		diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
-		diob.d_mem = stb.st_blksize;
-	}
+	diob.d_miniosz = stb.st_blksize;
+	diob.d_maxiosz = stb.st_blksize * 256;  /* good number ? */
+	diob.d_mem = stb.st_blksize;
 #ifndef NO_XFS
 	else if (ioctl(fd, XFS_IOC_DIOINFO, &diob) < 0) {
 		if (v)
@@ -1909,7 +1911,13 @@ dwrite_f(int opno, long r)
 		len = align;
 	else if (len > diob.d_maxiosz)
 		len = diob.d_maxiosz;
-	buf = memalign(diob.d_mem, len);
+	if (posix_memalign((void **)buf, diob.d_mem, len) != 0) {
+		perror("posix_memalign");
+		exit (1);
+	} else if (buf == NULL)	{
+		fprintf(stderr, "buf remains NULL unexpectly\n");
+		exit (1);
+	}
 	off %= maxfsize;
 	lseek64(fd, off, SEEK_SET);
 	memset(buf, nameseq & 0xff, len);
@@ -2650,4 +2658,4 @@ write_f(int opno, long r)
 			procid, opno, f.path, (long long)off, (long int)len, e);
 	free_pathname(&f);
 	close(fd);
-}
\ No newline at end of file
+}
-- 
1.7.4.1


-- 
Quality Engineer (Kernel) in
Red Hat Software (Beijing) Co., R&D Branch
http://www.cn.redhat.com/
TEL: +86-10-62608150

--------------090609020900070605020508
Content-Type: text/plain;
	name="0001-fs-fsstress-make-test-more-POSIX-compliant.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-fs-fsstress-make-test-more-POSIX-compliant.patch"

W1BBVENIXSBmczogZnNzdHJlc3M6IG1ha2UgdGVzdCBtb3JlIFBPU0lYIGNvbXBsaWFudAoK
aW4gY29tbWl0IGJhY2M4NDk3MjBlYzRlZmRhNWEwYThhOWVhNmEwZTkzYTE0MTU1NDEsIG1h
bGxvYy5oIHdhcyByZW1vdmVkCmFuZCBzdGRsaWIuaCBnb3QgdXNlZCBpbnN0ZWFkLiBIb3dl
dmVyLCBpdCdzIG5vdCBlbm91Z2guIFRoZSBmdW5jdGlvbgptZW1hbGlnbigpIGlzIGFsc28g
b2Jzb2xldGUgKHZpYSBtYW4gbWVtYWxpZ24pIGFuZCB3ZSBzaG91bGQgdXNlCnBvc2l4X21l
bWFsaWduIGluc3RlYWQuIEFsc28gaWYgd2Uga2VlcCBtZW1hbGlnbigpIGZ1bmN0aW9uIGhl
cmUsIHRoZQpwcm9ncmFtIHdvdWxkIHByb2JhYmx5IGhpdCBzZWdmYXVsdCBvbmNlIGl0IGVu
dGVycyBkd3JpdGVfdCBhbmQgZHJlYWRfdC4KCkJlc2lkZXMgdGhlIFBPU0lYIGNvbXBsaWFu
dCBmaXgsIEkgYWxzbyBkaWQgYSBzbWFsbCBmaXggdG8gcmVtb3ZlCmNvbXBsaW5nIHdhcm5p
bmdzLgoKSSB0cmllZCB0byB1cGRhdGUgdGhpcyBwcm9ncmFtIG91dHB1dCB0byB0c3RfcmVz
bS90c3RfYnJrbSBzdHlsZSBidXQKZmFpbGVkLCBJIGdvdCBjb25mdXNlZCBieSBzb21lIHBy
aW50ZiBvdXRwdXQuCgpTaWduZWQtb2ZmLWJ5OiBDYXNwYXIgWmhhbmcgPGN6aGFuZ0ByZWRo
YXQuY29tPgotLS0KIHRlc3RjYXNlcy9rZXJuZWwvZnMvZnNzdHJlc3MvZnNzdHJlc3MuYyB8
ICAgMzggKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiAxIGZpbGVzIGNoYW5nZWQs
IDIzIGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvZnMvZnNzdHJlc3MvZnNzdHJlc3MuYyBiL3Rlc3RjYXNlcy9rZXJuZWwv
ZnMvZnNzdHJlc3MvZnNzdHJlc3MuYwppbmRleCBlM2I0OGVhLi4wZTVmYmEyIDEwMDY0NAot
LS0gYS90ZXN0Y2FzZXMva2VybmVsL2ZzL2Zzc3RyZXNzL2Zzc3RyZXNzLmMKKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9mcy9mc3N0cmVzcy9mc3N0cmVzcy5jCkBAIC0xNzQ2LDcgKzE3NDYs
NyBAQCB2b2lkCiBkcmVhZF9mKGludCBvcG5vLCBsb25nIHIpCiB7CiAJX19pbnQ2NF90CWFs
aWduOwotCWNoYXIJCSpidWY7CisJY2hhcgkJKmJ1Zj1OVUxMOwogCXN0cnVjdCBkaW9hdHRy
CWRpb2I7CiAJaW50CQllOwogCXBhdGhuYW1lX3QJZjsKQEAgLTE3OTksMTEgKzE3OTksOSBA
QCBkcmVhZF9mKGludCBvcG5vLCBsb25nIHIpCiAJCXJldHVybjsKIAl9CiAKLQlpZiAobm9f
eGZzKSB7Ci0JCWRpb2IuZF9taW5pb3N6ID0gc3RiLnN0X2Jsa3NpemU7Ci0JCWRpb2IuZF9t
YXhpb3N6ID0gc3RiLnN0X2Jsa3NpemUgKiAyNTY7ICAvKiBnb29kIG51bWJlciA/ICovCi0J
CWRpb2IuZF9tZW0gPSBzdGIuc3RfYmxrc2l6ZTsKLQl9CisJZGlvYi5kX21pbmlvc3ogPSBz
dGIuc3RfYmxrc2l6ZTsKKwlkaW9iLmRfbWF4aW9zeiA9IHN0Yi5zdF9ibGtzaXplICogMjU2
OyAgLyogZ29vZCBudW1iZXIgPyAqLworCWRpb2IuZF9tZW0gPSBzdGIuc3RfYmxrc2l6ZTsK
ICNpZm5kZWYgTk9fWEZTCiAJZWxzZSBpZiAoaW9jdGwoZmQsIFhGU19JT0NfRElPSU5GTywg
JmRpb2IpIDwgMCkgewogCQlpZiAodikKQEAgLTE4MjYsNyArMTgyNCwxMyBAQCBkcmVhZF9m
KGludCBvcG5vLCBsb25nIHIpCiAJCWxlbiA9IGFsaWduOwogCWVsc2UgaWYgKGxlbiA+IGRp
b2IuZF9tYXhpb3N6KQogCQlsZW4gPSBkaW9iLmRfbWF4aW9zejsKLQlidWYgPSBtZW1hbGln
bihkaW9iLmRfbWVtLCBsZW4pOworCWlmIChwb3NpeF9tZW1hbGlnbigodm9pZCAqKilidWYs
IGRpb2IuZF9tZW0sIGxlbikgIT0gMCkgeworCQlwZXJyb3IoInBvc2l4X21lbWFsaWduIik7
CisJCWV4aXQgKDEpOworCX0gZWxzZSBpZiAoYnVmID09IE5VTEwpIHsKKwkJZnByaW50Zihz
dGRlcnIsICJidWYgcmVtYWlucyBOVUxMIHVuZXhwZWN0bHlcbiIpOworCQlleGl0ICgxKTsK
Kwl9CiAJZSA9IHJlYWQoZmQsIGJ1ZiwgbGVuKSA8IDAgPyBlcnJubyA6IDA7CiAJZnJlZShi
dWYpOwogCWlmICh2KQpAQCAtMTg0MCw3ICsxODQ0LDcgQEAgdm9pZAogZHdyaXRlX2YoaW50
IG9wbm8sIGxvbmcgcikKIHsKIAlfX2ludDY0X3QJYWxpZ247Ci0JY2hhcgkJKmJ1ZjsKKwlj
aGFyCQkqYnVmPU5VTEw7CiAJc3RydWN0IGRpb2F0dHIJZGlvYjsKIAlpbnQJCWU7CiAJcGF0
aG5hbWVfdAlmOwpAQCAtMTg4MiwxMSArMTg4Niw5IEBAIGR3cml0ZV9mKGludCBvcG5vLCBs
b25nIHIpCiAJCWNsb3NlKGZkKTsKIAkJcmV0dXJuOwogCX0KLQlpZiAobm9feGZzKSB7Ci0J
CWRpb2IuZF9taW5pb3N6ID0gc3RiLnN0X2Jsa3NpemU7Ci0JCWRpb2IuZF9tYXhpb3N6ID0g
c3RiLnN0X2Jsa3NpemUgKiAyNTY7ICAvKiBnb29kIG51bWJlciA/ICovCi0JCWRpb2IuZF9t
ZW0gPSBzdGIuc3RfYmxrc2l6ZTsKLQl9CisJZGlvYi5kX21pbmlvc3ogPSBzdGIuc3RfYmxr
c2l6ZTsKKwlkaW9iLmRfbWF4aW9zeiA9IHN0Yi5zdF9ibGtzaXplICogMjU2OyAgLyogZ29v
ZCBudW1iZXIgPyAqLworCWRpb2IuZF9tZW0gPSBzdGIuc3RfYmxrc2l6ZTsKICNpZm5kZWYg
Tk9fWEZTCiAJZWxzZSBpZiAoaW9jdGwoZmQsIFhGU19JT0NfRElPSU5GTywgJmRpb2IpIDwg
MCkgewogCQlpZiAodikKQEAgLTE5MDksNyArMTkxMSwxMyBAQCBkd3JpdGVfZihpbnQgb3Bu
bywgbG9uZyByKQogCQlsZW4gPSBhbGlnbjsKIAllbHNlIGlmIChsZW4gPiBkaW9iLmRfbWF4
aW9zeikKIAkJbGVuID0gZGlvYi5kX21heGlvc3o7Ci0JYnVmID0gbWVtYWxpZ24oZGlvYi5k
X21lbSwgbGVuKTsKKwlpZiAocG9zaXhfbWVtYWxpZ24oKHZvaWQgKiopYnVmLCBkaW9iLmRf
bWVtLCBsZW4pICE9IDApIHsKKwkJcGVycm9yKCJwb3NpeF9tZW1hbGlnbiIpOworCQlleGl0
ICgxKTsKKwl9IGVsc2UgaWYgKGJ1ZiA9PSBOVUxMKQl7CisJCWZwcmludGYoc3RkZXJyLCAi
YnVmIHJlbWFpbnMgTlVMTCB1bmV4cGVjdGx5XG4iKTsKKwkJZXhpdCAoMSk7CisJfQogCW9m
ZiAlPSBtYXhmc2l6ZTsKIAlsc2VlazY0KGZkLCBvZmYsIFNFRUtfU0VUKTsKIAltZW1zZXQo
YnVmLCBuYW1lc2VxICYgMHhmZiwgbGVuKTsKQEAgLTI2NTAsNCArMjY1OCw0IEBAIHdyaXRl
X2YoaW50IG9wbm8sIGxvbmcgcikKIAkJCXByb2NpZCwgb3BubywgZi5wYXRoLCAobG9uZyBs
b25nKW9mZiwgKGxvbmcgaW50KWxlbiwgZSk7CiAJZnJlZV9wYXRobmFtZSgmZik7CiAJY2xv
c2UoZmQpOwotfQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUKK30KLS0gCjEuNy40LjEK
Cg==
--------------090609020900070605020508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
--------------090609020900070605020508
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090609020900070605020508--

