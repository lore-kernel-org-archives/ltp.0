Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1cY-00036L-Cx
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:20:34 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1cX-00008u-Hf
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:20:34 +0000
Received: by mail-gx0-f207.google.com with SMTP id 3so2189097gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:20:33 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:50:33 +0530
Message-ID: <f5a7b3810906171320q19721247w3bd9f5c2c47fb9a9@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001517570904fc363a046c91057b
Subject: [LTP] [FIX PATCH] ltp-rt_sigsuspend
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

--001517570904fc363a046c91057b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed fail and fixed.
1. rt_sigsuspend01.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
--- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c	2009-05-21
23:58:46.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c	2009-06-17
23:09:40.000000000 +0530
@@ -142,13 +142,13 @@
 			struct sigaction act, oact;
 		        act.sa_handler = sig_handler;
 			
-			TEST(syscall(174, SIGALRM, &act, &oact, 8));
+			TEST(syscall(__NR_rt_sigaction, SIGALRM, &act, &oact, 8));
 			if(TEST_RETURN == -1){
 		        	tst_resm(TFAIL,"rt_sigaction() Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
 				cleanup();
 				tst_exit();
 			}
-			TEST(syscall(175, SIG_UNBLOCK, 0, &set1, 8));
+			TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set1, 8));
 			if(TEST_RETURN == -1){
 		        	tst_resm(TFAIL,"rt_sigprocmask() Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
 				cleanup();
@@ -157,10 +157,10 @@
 			
 			TEST(alarm(5));
 		        int result;
-			TEST(result = syscall(179, &set, 8));
+			TEST(result = syscall(__NR_rt_sigsuspend, &set, 8));
 		        TEST(alarm(0));
 			if((result == -1) && (TEST_ERRNO != EINTR)){
-				TEST(syscall(175, SIG_UNBLOCK, 0, &set2, 8));
+				TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, 0, &set2, 8));
 				if(TEST_RETURN == -1){
 		        		tst_resm(TFAIL,"rt_sigprocmask() Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
 					cleanup();

--001517570904fc363a046c91057b
Content-Type: application/octet-stream; name="ltp-fix-rt_sigsuspend.patch"
Content-Disposition: attachment; filename="ltp-fix-rt_sigsuspend.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2gtzgf0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3N1c3BlbmQvcnRf
c2lnc3VzcGVuZDAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3N1c3BlbmQv
cnRfc2lnc3VzcGVuZDAxLmMKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdz
dXNwZW5kL3J0X3NpZ3N1c3BlbmQwMS5jCTIwMDktMDUtMjEgMjM6NTg6NDYuMDAwMDAwMDAwICsw
NTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lnc3VzcGVuZC9ydF9zaWdz
dXNwZW5kMDEuYwkyMDA5LTA2LTE3IDIzOjA5OjQwLjAwMDAwMDAwMCArMDUzMApAQCAtMTQyLDEz
ICsxNDIsMTMgQEAKIAkJCXN0cnVjdCBzaWdhY3Rpb24gYWN0LCBvYWN0OwogCQkgICAgICAgIGFj
dC5zYV9oYW5kbGVyID0gc2lnX2hhbmRsZXI7CiAJCQkKLQkJCVRFU1Qoc3lzY2FsbCgxNzQsIFNJ
R0FMUk0sICZhY3QsICZvYWN0LCA4KSk7CisJCQlURVNUKHN5c2NhbGwoX19OUl9ydF9zaWdhY3Rp
b24sIFNJR0FMUk0sICZhY3QsICZvYWN0LCA4KSk7CiAJCQlpZihURVNUX1JFVFVSTiA9PSAtMSl7
CiAJCSAgICAgICAgCXRzdF9yZXNtKFRGQUlMLCJydF9zaWdhY3Rpb24oKSBGYWlsZWQsIGVycm5v
PSVkIDogJXMiLFRFU1RfRVJSTk8sIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKIAkJCQljbGVhbnVw
KCk7CiAJCQkJdHN0X2V4aXQoKTsKIAkJCX0KLQkJCVRFU1Qoc3lzY2FsbCgxNzUsIFNJR19VTkJM
T0NLLCAwLCAmc2V0MSwgOCkpOworCQkJVEVTVChzeXNjYWxsKF9fTlJfcnRfc2lncHJvY21hc2ss
IFNJR19VTkJMT0NLLCAwLCAmc2V0MSwgOCkpOwogCQkJaWYoVEVTVF9SRVRVUk4gPT0gLTEpewog
CQkgICAgICAgIAl0c3RfcmVzbShURkFJTCwicnRfc2lncHJvY21hc2soKSBGYWlsZWQsIGVycm5v
PSVkIDogJXMiLFRFU1RfRVJSTk8sIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKIAkJCQljbGVhbnVw
KCk7CkBAIC0xNTcsMTAgKzE1NywxMCBAQAogCQkJCiAJCQlURVNUKGFsYXJtKDUpKTsKIAkJICAg
ICAgICBpbnQgcmVzdWx0OwotCQkJVEVTVChyZXN1bHQgPSBzeXNjYWxsKDE3OSwgJnNldCwgOCkp
OworCQkJVEVTVChyZXN1bHQgPSBzeXNjYWxsKF9fTlJfcnRfc2lnc3VzcGVuZCwgJnNldCwgOCkp
OwogCQkgICAgICAgIFRFU1QoYWxhcm0oMCkpOwogCQkJaWYoKHJlc3VsdCA9PSAtMSkgJiYgKFRF
U1RfRVJSTk8gIT0gRUlOVFIpKXsKLQkJCQlURVNUKHN5c2NhbGwoMTc1LCBTSUdfVU5CTE9DSywg
MCwgJnNldDIsIDgpKTsKKwkJCQlURVNUKHN5c2NhbGwoX19OUl9ydF9zaWdwcm9jbWFzaywgU0lH
X1VOQkxPQ0ssIDAsICZzZXQyLCA4KSk7CiAJCQkJaWYoVEVTVF9SRVRVUk4gPT0gLTEpewogCQkg
ICAgICAgIAkJdHN0X3Jlc20oVEZBSUwsInJ0X3NpZ3Byb2NtYXNrKCkgRmFpbGVkLCBlcnJubz0l
ZCA6ICVzIixURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5PKSk7CiAJCQkJCWNsZWFudXAo
KTsK
--001517570904fc363a046c91057b
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
--001517570904fc363a046c91057b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001517570904fc363a046c91057b--

