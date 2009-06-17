Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1bF-00006T-Ij
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:19:13 +0000
Received: from yw-out-1718.google.com ([74.125.46.156])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1bB-000283-0K
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:19:13 +0000
Received: by yw-out-1718.google.com with SMTP id 5so283796ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:19:08 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:49:08 +0530
Message-ID: <f5a7b3810906171319peea6c9dvfc0c79368efefcff@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=00151757081ef31d00046c910029
Subject: [LTP] [FIX PATCH] ltp-keyctl
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
To: ltp-list@lists.sourceforge.net
Cc: maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

--00151757081ef31d00046c910029
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed fail and fixed.
1. keyctl01.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >



diff -Naurb a/testcases/kernel/syscalls/keyctl/keyctl01.c
b/testcases/kernel/syscalls/keyctl/keyctl01.c
--- a/testcases/kernel/syscalls/keyctl/keyctl01.c	2009-05-21
23:47:32.000000000 +0530
+++ b/testcases/kernel/syscalls/keyctl/keyctl01.c	2009-06-17
23:51:46.000000000 +0530
@@ -123,7 +123,7 @@
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-                     TEST(syscall(258, KEYCTL_GET_KEYRING_ID,
KEY_SPEC_USER_SESSION_KEYRING));    //call keyctl() and Ask for a
keyring's ID
+                     TEST(syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
KEY_SPEC_USER_SESSION_KEYRING));    //call keyctl() and Ask for a
keyring's ID
                      if(TEST_RETURN != -1) {
         		tst_resm(TPASS,"KEYCTL_GET_KEYRING_ID succeed");
                      /*   cleanup(); */
@@ -135,7 +135,7 @@
                      }


-		     TEST(syscall(288, KEYCTL_REVOKE, "MyKey"));    //call keyctl()
+		     TEST(syscall(__NR_keyctl, KEYCTL_REVOKE, "MyKey"));    //call keyctl()
                      if(TEST_RETURN != -1) {
                         tst_resm(TFAIL,"KEYTL_REVOKE succeededs, but
should fail");
                         cleanup();

--00151757081ef31d00046c910029
Content-Type: application/octet-stream; name="ltp-fix-keyctl.patch"
Content-Disposition: attachment; filename="ltp-fix-keyctl.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2gifn30

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwwMS5j
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9rZXljdGwva2V5Y3RsMDEuYwotLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2tleWN0bC9rZXljdGwwMS5jCTIwMDktMDUtMjEgMjM6NDc6
MzIuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2V5Y3Rs
L2tleWN0bDAxLmMJMjAwOS0wNi0xNyAyMzo1MTo0Ni4wMDAwMDAwMDAgKzA1MzAKQEAgLTEyMyw3
ICsxMjMsNyBAQAogICAgICAgICBmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgKytsYykg
ewogICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7CiAgICAgICAgICAgICAgICAgZm9yICh0
ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7Ci0gICAgICAgICAgICAg
ICAgICAgICBURVNUKHN5c2NhbGwoMjU4LCBLRVlDVExfR0VUX0tFWVJJTkdfSUQsIEtFWV9TUEVD
X1VTRVJfU0VTU0lPTl9LRVlSSU5HKSk7ICAgIC8vY2FsbCBrZXljdGwoKSBhbmQgQXNrIGZvciBh
IGtleXJpbmcncyBJRAorICAgICAgICAgICAgICAgICAgICAgVEVTVChzeXNjYWxsKF9fTlJfa2V5
Y3RsLCBLRVlDVExfR0VUX0tFWVJJTkdfSUQsIEtFWV9TUEVDX1VTRVJfU0VTU0lPTl9LRVlSSU5H
KSk7ICAgIC8vY2FsbCBrZXljdGwoKSBhbmQgQXNrIGZvciBhIGtleXJpbmcncyBJRAogICAgICAg
ICAgICAgICAgICAgICAgaWYoVEVTVF9SRVRVUk4gIT0gLTEpIHsKICAgICAgICAgCQl0c3RfcmVz
bShUUEFTUywiS0VZQ1RMX0dFVF9LRVlSSU5HX0lEIHN1Y2NlZWQiKTsKICAgICAgICAgICAgICAg
ICAgICAgIC8qICAgY2xlYW51cCgpOyAqLwpAQCAtMTM1LDcgKzEzNSw3IEBACiAgICAgICAgICAg
ICAgICAgICAgICB9CiAKIAotCQkgICAgIFRFU1Qoc3lzY2FsbCgyODgsIEtFWUNUTF9SRVZPS0Us
ICJNeUtleSIpKTsgICAgLy9jYWxsIGtleWN0bCgpCisJCSAgICAgVEVTVChzeXNjYWxsKF9fTlJf
a2V5Y3RsLCBLRVlDVExfUkVWT0tFLCAiTXlLZXkiKSk7ICAgIC8vY2FsbCBrZXljdGwoKQogICAg
ICAgICAgICAgICAgICAgICAgaWYoVEVTVF9SRVRVUk4gIT0gLTEpIHsKICAgICAgICAgICAgICAg
ICAgICAgICAgIHRzdF9yZXNtKFRGQUlMLCJLRVlUTF9SRVZPS0Ugc3VjY2VlZGVkcywgYnV0IHNo
b3VsZCBmYWlsIik7CiAgICAgICAgICAgICAgICAgICAgICAgICBjbGVhbnVwKCk7Cg==
--00151757081ef31d00046c910029
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--00151757081ef31d00046c910029
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00151757081ef31d00046c910029--

