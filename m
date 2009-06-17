Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1eE-0000NL-Ub
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:22:18 +0000
Received: from mail-yx0-f192.google.com ([209.85.210.192])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1eD-0002lc-K0
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:22:18 +0000
Received: by mail-yx0-f192.google.com with SMTP id 30so756404yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:22:17 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:52:17 +0530
Message-ID: <f5a7b3810906171322n22ce8ed5qfeff5aaaab6c4ddc@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=00151750dd8c301364046c910cf9
Subject: [LTP] [FIX PATCH] ltp-tkill
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

--00151750dd8c301364046c910cf9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed following failures and fixed.
1. tkill01.c
2. tkill02.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/tkill/tkill01.c
b/testcases/kernel/syscalls/tkill/tkill01.c
--- a/testcases/kernel/syscalls/tkill/tkill01.c	2009-05-22
00:15:51.000000000 +0530
+++ b/testcases/kernel/syscalls/tkill/tkill01.c	2009-06-17
23:03:45.000000000 +0530
@@ -140,13 +140,13 @@
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
                      TEST(signal(SIGUSR1, &sig_action));
-                     TEST(tid = syscall(224));
+                     TEST(tid = syscall( __NR_gettid));
 		     if(TEST_RETURN == -1) {
                  	   tst_resm(TFAIL, "%s failed - errno = %d : %s",
TCID, TEST_ERRNO, strerror(TEST_ERRNO));
 			   cleanup();
 			   tst_exit();
                      }
-                     TEST(syscall(238,tid, SIGUSR1));
+                     TEST(syscall(__NR_tkill,tid, SIGUSR1));
 		     if(TEST_RETURN == 0) {
 				if(!sig_count);
         			tst_resm(TPASS, "tkill call succeeded");
diff -Naurb a/testcases/kernel/syscalls/tkill/tkill02.c
b/testcases/kernel/syscalls/tkill/tkill02.c
--- a/testcases/kernel/syscalls/tkill/tkill02.c	2009-05-22
00:17:14.000000000 +0530
+++ b/testcases/kernel/syscalls/tkill/tkill02.c	2009-06-17
23:37:21.000000000 +0530
@@ -139,7 +139,7 @@
                 for (testno = 0; testno < TST_TOTAL; ++testno) {

 			for(i=0; i<2; i++){
-		                TEST(syscall(238, test_cases[i].tid, SIGUSR1));
+		                TEST(syscall(__NR_tkill, test_cases[i].tid, SIGUSR1));
 		     		if(TEST_RETURN == -1) {
 			            	if(TEST_ERRNO == test_cases[i].exp_errno){
 						tst_resm(TINFO, "%s() call with tid:%d got expected errno:%d",
TCID, test_cases[i].tid,TEST_ERRNO);

--00151750dd8c301364046c910cf9
Content-Type: application/octet-stream; name="ltp-fix-tkill.patch"
Content-Disposition: attachment; filename="ltp-fix-tkill.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2h4i9k0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3RraWxsL3RraWxsMDEuYyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdGtpbGwvdGtpbGwwMS5jCi0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvdGtpbGwvdGtpbGwwMS5jCTIwMDktMDUtMjIgMDA6MTU6NTEuMDAw
MDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdGtpbGwvdGtpbGww
MS5jCTIwMDktMDYtMTcgMjM6MDM6NDUuMDAwMDAwMDAwICswNTMwCkBAIC0xNDAsMTMgKzE0MCwx
MyBAQAogICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7CiAgICAgICAgICAgICAgICAgZm9y
ICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7CiAgICAgICAgICAg
ICAgICAgICAgICBURVNUKHNpZ25hbChTSUdVU1IxLCAmc2lnX2FjdGlvbikpOyAgICAgCi0gICAg
ICAgICAgICAgICAgICAgICBURVNUKHRpZCA9IHN5c2NhbGwoMjI0KSk7ICAgICAKKyAgICAgICAg
ICAgICAgICAgICAgIFRFU1QodGlkID0gc3lzY2FsbCggX19OUl9nZXR0aWQpKTsgICAgIAogCQkg
ICAgIGlmKFRFU1RfUkVUVVJOID09IC0xKSB7CiAgICAgICAgICAgICAgICAgIAkgICB0c3RfcmVz
bShURkFJTCwgIiVzIGZhaWxlZCAtIGVycm5vID0gJWQgOiAlcyIsIFRDSUQsIFRFU1RfRVJSTk8s
IHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKIAkJCSAgIGNsZWFudXAoKTsKIAkJCSAgIHRzdF9leGl0
KCk7CiAgICAgICAgICAgICAgICAgICAgICB9Ci0gICAgICAgICAgICAgICAgICAgICBURVNUKHN5
c2NhbGwoMjM4LHRpZCwgU0lHVVNSMSkpOyAgICAgCisgICAgICAgICAgICAgICAgICAgICBURVNU
KHN5c2NhbGwoX19OUl90a2lsbCx0aWQsIFNJR1VTUjEpKTsgICAgIAogCQkgICAgIGlmKFRFU1Rf
UkVUVVJOID09IDApIHsKIAkJCQlpZighc2lnX2NvdW50KTsKICAgICAgICAgCQkJdHN0X3Jlc20o
VFBBU1MsICJ0a2lsbCBjYWxsIHN1Y2NlZWRlZCIpOwpkaWZmIC1OYXVyYiBhL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvdGtpbGwvdGtpbGwwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy90a2lsbC90a2lsbDAyLmMKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy90a2lsbC90
a2lsbDAyLmMJMjAwOS0wNS0yMiAwMDoxNzoxNC4wMDAwMDAwMDAgKzA1MzAKKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy90a2lsbC90a2lsbDAyLmMJMjAwOS0wNi0xNyAyMzozNzoyMS4w
MDAwMDAwMDAgKzA1MzAKQEAgLTEzOSw3ICsxMzksNyBAQAogICAgICAgICAgICAgICAgIGZvciAo
dGVzdG5vID0gMDsgdGVzdG5vIDwgVFNUX1RPVEFMOyArK3Rlc3RubykgewogCiAJCQlmb3IoaT0w
OyBpPDI7IGkrKyl7Ci0JCSAgICAgICAgICAgICAgICBURVNUKHN5c2NhbGwoMjM4LCB0ZXN0X2Nh
c2VzW2ldLnRpZCwgU0lHVVNSMSkpOworCQkgICAgICAgICAgICAgICAgVEVTVChzeXNjYWxsKF9f
TlJfdGtpbGwsIHRlc3RfY2FzZXNbaV0udGlkLCBTSUdVU1IxKSk7CiAJCSAgICAgCQlpZihURVNU
X1JFVFVSTiA9PSAtMSkgewogCQkJICAgICAgICAgICAgCWlmKFRFU1RfRVJSTk8gPT0gdGVzdF9j
YXNlc1tpXS5leHBfZXJybm8pewogCQkJCQkJdHN0X3Jlc20oVElORk8sICIlcygpIGNhbGwgd2l0
aCB0aWQ6JWQgZ290IGV4cGVjdGVkIGVycm5vOiVkIiwgVENJRCwgdGVzdF9jYXNlc1tpXS50aWQs
VEVTVF9FUlJOTyk7Cg==
--00151750dd8c301364046c910cf9
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
--00151750dd8c301364046c910cf9
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00151750dd8c301364046c910cf9--

