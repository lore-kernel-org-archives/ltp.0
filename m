Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <violetleigh@gmail.com>) id 1PXsRV-00032I-1V
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:37 +0000
Received: from mail-gw0-f47.google.com ([74.125.83.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PXsRT-0004WV-0d
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 09:35:37 +0000
Received: by gwaa12 with SMTP id a12so1779203gwa.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Dec 2010 01:35:29 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 29 Dec 2010 17:35:29 +0800
Message-ID: <AANLkTinxp9Aj7MwPqpR13cZRjAYdLVwMkhCteDM-S7Vi@mail.gmail.com>
From: Vivi <violetleigh@gmail.com>
Subject: [LTP] [Bug Fix] Skip first case in adjtimex02 test by a safer method
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1754314743769024055=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP mailing list <ltp-list@lists.sourceforge.net>

--===============1754314743769024055==
Content-Type: multipart/alternative; boundary=0016e644cf8a35153a0498894a66

--0016e644cf8a35153a0498894a66
Content-Type: text/plain; charset=ISO-8859-1

The method to skip case 1 of adjtimex02 in uclinux platform will make case 3
and 4 fail.

--
root:/> ./adjtimex02
adjtimex02    1  PASS  :  Test Passed, adjtimex() returned -1 with errno: 22
adjtimex02    2  PASS  :  Test Passed, adjtimex() returned -1 with errno: 22
adjtimex02    3  FAIL  :  Test Failed, adjtimex()returned 5, errno = 0 :
Success
adjtimex02    4  FAIL  :  Test Failed, adjtimex()returned 5, errno = 0 :
Success
adjtimex02    5  PASS  :  Test Passed, adjtimex() returned -1 with errno: 1
root:/>
--


--
Index: testcases/kernel/syscalls/adjtimex/adjtimex02.c
===================================================================
--- testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -122,12 +122,7 @@
        void (*cleanup) ();
        int exp_errno;
 } test_cases[] = {
-#ifndef UCLINUX
-       /* Skip since uClinux does not implement memory protection */
-       {
-       (struct timex *)-1, NULL, NULL, EFAULT},
-#endif
-       {
+       { (struct timex *)-1, NULL, NULL, EFAULT},{
        &buff, setup2, NULL, EINVAL}, {
        &buff, setup3, NULL, EINVAL}, {
        &buff, setup4, NULL, EINVAL}, {
@@ -159,7 +154,18 @@
                Tst_count = 0;

                for (i = 0; i < TST_TOTAL; ++i) {
+#ifdef UCLINUX
                        /*
+                        * Skip first case since uClinux does not implement
+                        * memory protection.
+                        */
+                       if (i == 0) {
+                               tst_resm(TCONF, "uClinux does not implement"
+                                               " memory protection.");
+                               continue;
+                       }
+#endif
+                       /*
                         * since Linux 2.6.26, if buf.offset value is
outside
                         * the acceptable range, it is simply normalized
instead
                         * of letting the syscall fail. so just skip this
test
--



Best regards,
Vivi Li

--0016e644cf8a35153a0498894a66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

VGhlIG1ldGhvZCB0byBza2lwIGNhc2UgMSBvZiBhZGp0aW1leDAyIGluIHVjbGludXggcGxhdGZv
cm0gd2lsbCBtYWtlIGNhc2UgMyBhbmQgNCBmYWlsLjxicj48YnI+LS08YnI+cm9vdDovJmd0OyAu
L2FkanRpbWV4MDI8YnI+YWRqdGltZXgwMqCgoCAxoCBQQVNToCA6oCBUZXN0IFBhc3NlZCwgYWRq
dGltZXgoKSByZXR1cm5lZCAtMSB3aXRoIGVycm5vOiAyMjxicj5hZGp0aW1leDAyoKCgIDKgIFBB
U1OgIDqgIFRlc3QgUGFzc2VkLCBhZGp0aW1leCgpIHJldHVybmVkIC0xIHdpdGggZXJybm86IDIy
PGJyPgoKCmFkanRpbWV4MDKgoKAgM6AgRkFJTKAgOqAgVGVzdCBGYWlsZWQsIGFkanRpbWV4KCly
ZXR1cm5lZCA1LCBlcnJubyA9IDAgOiBTdWNjZXNzPGJyPmFkanRpbWV4MDKgoKAgNKAgRkFJTKAg
OqAgVGVzdCBGYWlsZWQsIGFkanRpbWV4KClyZXR1cm5lZCA1LCBlcnJubyA9IDAgOiBTdWNjZXNz
PGJyPmFkanRpbWV4MDKgoKAgNaAgUEFTU6AgOqAgVGVzdCBQYXNzZWQsIGFkanRpbWV4KCkgcmV0
dXJuZWQgLTEgd2l0aCBlcnJubzogMTxicj4KCgpyb290Oi8mZ3Q7PGJyPi0tPGJyPjxicj48YnI+
LS08YnI+SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYWRqdGltZXgvYWRqdGltZXgw
Mi5jPGJyPj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT08YnI+LS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYWRqdGlt
ZXgvYWRqdGltZXgwMi5jPGJyPisrKyB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FkanRpbWV4
L2FkanRpbWV4MDIuYzxicj4KCgoKQEAgLTEyMiwxMiArMTIyLDcgQEA8YnI+oKCgoKCgoCB2b2lk
ICgqY2xlYW51cCkgKCk7PGJyPqCgoKCgoKAgaW50IGV4cF9lcnJubzs8YnI+oH0gdGVzdF9jYXNl
c1tdID0gezxicj4tI2lmbmRlZiBVQ0xJTlVYPGJyPi2goKCgoKAgLyogU2tpcCBzaW5jZSB1Q2xp
bnV4IGRvZXMgbm90IGltcGxlbWVudCBtZW1vcnkgcHJvdGVjdGlvbiAqLzxicj4toKCgoKCgIHs8
YnI+LaCgoKCgoCAoc3RydWN0IHRpbWV4ICopLTEsIE5VTEwsIE5VTEwsIEVGQVVMVH0sPGJyPgoK
CgotI2VuZGlmPGJyPi2goKCgoKAgezxicj4roKCgoKCgIHsgKHN0cnVjdCB0aW1leCAqKS0xLCBO
VUxMLCBOVUxMLCBFRkFVTFR9LHs8YnI+oKCgoKCgoCAmYW1wO2J1ZmYsIHNldHVwMiwgTlVMTCwg
RUlOVkFMfSwgezxicj6goKCgoKCgICZhbXA7YnVmZiwgc2V0dXAzLCBOVUxMLCBFSU5WQUx9LCB7
PGJyPqCgoKCgoKAgJmFtcDtidWZmLCBzZXR1cDQsIE5VTEwsIEVJTlZBTH0sIHs8YnI+CgoKQEAg
LTE1OSw3ICsxNTQsMTggQEA8YnI+CqCgoKCgoKCgoKCgoKCgoCBUc3RfY291bnQgPSAwOzxicj48
YnI+oKCgoKCgoKCgoKCgoKCgIGZvciAoaSA9IDA7IGkgJmx0OyBUU1RfVE9UQUw7ICsraSkgezxi
cj4rI2lmZGVmIFVDTElOVVg8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgLyo8YnI+K6CgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgICogU2tpcCBmaXJzdCBjYXNlIHNpbmNlIHVDbGludXggZG9lcyBu
b3QgaW1wbGVtZW50PGJyPgoKCgoroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgKiBtZW1vcnkgcHJv
dGVjdGlvbi48YnI+K6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgICovPGJyPiugoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIGlmIChpID09IDApIHs8YnI+K6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCB0c3RfcmVzbShUQ09ORiwgJnF1b3Q7dUNsaW51eCBkb2VzIG5vdCBpbXBsZW1lbnQmcXVvdDs8
YnI+K6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgJnF1b3Q7
IG1lbW9yeSBwcm90ZWN0aW9uLiZxdW90Oyk7PGJyPgoKCgoroKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgIGNvbnRpbnVlOzxicj4roKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB9PGJyPisjZW5k
aWY8YnI+K6CgoKCgoKCgoKCgoKCgoKCgoKCgoKAgLyo8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgICogc2luY2UgTGludXggMi42LjI2LCBpZiBidWYub2Zmc2V0IHZhbHVlIGlzIG91dHNpZGU8
YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgICogdGhlIGFjY2VwdGFibGUgcmFuZ2UsIGl0IGlz
IHNpbXBseSBub3JtYWxpemVkIGluc3RlYWQ8YnI+CgoKCqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oCAqIG9mIGxldHRpbmcgdGhlIHN5c2NhbGwgZmFpbC4gc28ganVzdCBza2lwIHRoaXMgdGVzdDxi
cj4tLTxicj48YnI+PGJyPjxicj5CZXN0IHJlZ2FyZHMsPGJyPlZpdmkgTGk8YnI+Cg==
--0016e644cf8a35153a0498894a66--


--===============1754314743769024055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============1754314743769024055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1754314743769024055==--

