Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1cD-0005bE-Id
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:20:13 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1cC-00008u-OG
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:20:13 +0000
Received: by gxk3 with SMTP id 3so2189097gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:20:12 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:50:12 +0530
Message-ID: <f5a7b3810906171320p432db48l92fc6a42cddfa6df@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd348b8b7aa22046c91047a
Subject: [LTP] [FIX PATCH] ltp-rt_sigprocmask
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

--000e0cd348b8b7aa22046c91047a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed following failures and fixed.
1. rt_sigprocmask01.c
2. rt_sigprocmask02.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c	2009-05-21
23:53:00.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask01.c	2009-06-17
23:06:24.000000000 +0530
@@ -163,14 +163,14 @@
 			
 			/* call rt_sigaction() */
 			act.sa_handler = sig_handler;
-                        TEST(syscall(174, 33, &act, &oact, 8));
+                        TEST(syscall(__NR_tkill, 33, &act, &oact, 8));
 			if(TEST_RETURN != 0){
 				tst_resm(TFAIL,"Call to rt_sigaction() Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();
 				tst_exit();
 			}
 			/* call rt_sigprocmask() to block signal#33 */
-                        TEST(syscall(175, SIG_BLOCK, &set, &oset, 8));
+                        TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK,
&set, &oset, 8));
 			if(TEST_RETURN == -1){
 				tst_resm(TFAIL,"Call to rt_sigprocmask()**** Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();
@@ -192,7 +192,7 @@
 				}
 				else {
 					/* call rt_sigpending() */
-					TEST(syscall(176, &oset, 8));
+					TEST(syscall(__NR_rt_sigpending, &oset, 8));
 					if(TEST_RETURN == -1){
 						tst_resm(TFAIL,"call rt_sigpending() failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
                         			cleanup();
@@ -205,7 +205,7 @@
 						tst_exit();
 					}
 					/* call rt_sigprocmask() to unblock signal#33 */
-					TEST(syscall(175, SIG_UNBLOCK, &set, &oset, 8));
+					TEST(syscall(__NR_rt_sigprocmask, SIG_UNBLOCK, &set, &oset, 8));
 					if(TEST_RETURN == -1){
 						tst_resm(TFAIL,"Call to rt_sigprocmask() Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
                         			cleanup();
diff -Naurb a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c
--- a/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c	2009-05-21
23:54:15.000000000 +0530
+++ b/testcases/kernel/syscalls/rt_sigprocmask/rt_sigprocmask02.c	2009-06-17
23:30:42.000000000 +0530
@@ -176,7 +176,7 @@

 			for(i=0; i<test_count; i++)
 		        {
-				TEST(syscall(175, SIG_BLOCK, &s, test_cases[i].ss, test_cases[i].sssize));
+				TEST(syscall(__NR_rt_sigprocmask, SIG_BLOCK, &s,
test_cases[i].ss, test_cases[i].sssize));
 				if(TEST_RETURN == 0){
 					tst_resm(TFAIL,"Call to rt_sigprocmask()succeeded,but should
failed, errno=%d : %s",TEST_ERRNO, strerror(TEST_ERRNO));
 					fail++;

--000e0cd348b8b7aa22046c91047a
Content-Type: application/octet-stream; name="ltp-fix-rt_sigprocmask.patch"
Content-Disposition: attachment; filename="ltp-fix-rt_sigprocmask.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2grq5x0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNrL3J0
X3NpZ3Byb2NtYXNrMDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lncHJvY21h
c2svcnRfc2lncHJvY21hc2swMS5jCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRf
c2lncHJvY21hc2svcnRfc2lncHJvY21hc2swMS5jCTIwMDktMDUtMjEgMjM6NTM6MDAuMDAwMDAw
MDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcnRfc2lncHJvY21hc2sv
cnRfc2lncHJvY21hc2swMS5jCTIwMDktMDYtMTcgMjM6MDY6MjQuMDAwMDAwMDAwICswNTMwCkBA
IC0xNjMsMTQgKzE2MywxNCBAQAogCQkJCiAJCQkvKiBjYWxsIHJ0X3NpZ2FjdGlvbigpICovCiAJ
CQlhY3Quc2FfaGFuZGxlciA9IHNpZ19oYW5kbGVyOwotICAgICAgICAgICAgICAgICAgICAgICAg
VEVTVChzeXNjYWxsKDE3NCwgMzMsICZhY3QsICZvYWN0LCA4KSk7CisgICAgICAgICAgICAgICAg
ICAgICAgICBURVNUKHN5c2NhbGwoX19OUl90a2lsbCwgMzMsICZhY3QsICZvYWN0LCA4KSk7CiAJ
CQlpZihURVNUX1JFVFVSTiAhPSAwKXsKIAkJCQl0c3RfcmVzbShURkFJTCwiQ2FsbCB0byBydF9z
aWdhY3Rpb24oKSBGYWlsZWQsIGVycm5vPSVkIDogJXMiLFRFU1RfRVJSTk8sIHN0cmVycm9yKFRF
U1RfRVJSTk8pKTsKICAgICAgICAgICAgICAgICAgICAgICAgIAljbGVhbnVwKCk7CiAJCQkJdHN0
X2V4aXQoKTsKIAkJCX0KIAkJCS8qIGNhbGwgcnRfc2lncHJvY21hc2soKSB0byBibG9jayBzaWdu
YWwjMzMgKi8KLSAgICAgICAgICAgICAgICAgICAgICAgIFRFU1Qoc3lzY2FsbCgxNzUsIFNJR19C
TE9DSywgJnNldCwgJm9zZXQsIDgpKTsKKyAgICAgICAgICAgICAgICAgICAgICAgIFRFU1Qoc3lz
Y2FsbChfX05SX3J0X3NpZ3Byb2NtYXNrLCBTSUdfQkxPQ0ssICZzZXQsICZvc2V0LCA4KSk7CiAJ
CQlpZihURVNUX1JFVFVSTiA9PSAtMSl7CiAJCQkJdHN0X3Jlc20oVEZBSUwsIkNhbGwgdG8gcnRf
c2lncHJvY21hc2soKSoqKiogRmFpbGVkLCBlcnJubz0lZCA6ICVzIixURVNUX0VSUk5PLCBzdHJl
cnJvcihURVNUX0VSUk5PKSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAJY2xlYW51cCgpOwpA
QCAtMTkyLDcgKzE5Miw3IEBACiAJCQkJfQogCQkJCWVsc2UgewogCQkJCQkvKiBjYWxsIHJ0X3Np
Z3BlbmRpbmcoKSAqLwotCQkJCQlURVNUKHN5c2NhbGwoMTc2LCAmb3NldCwgOCkpOworCQkJCQlU
RVNUKHN5c2NhbGwoX19OUl9ydF9zaWdwZW5kaW5nLCAmb3NldCwgOCkpOwogCQkJCQlpZihURVNU
X1JFVFVSTiA9PSAtMSl7CiAJCQkJCQl0c3RfcmVzbShURkFJTCwiY2FsbCBydF9zaWdwZW5kaW5n
KCkgZmFpbGVkLCBlcnJubz0lZCA6ICVzIixURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5P
KSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAJCQljbGVhbnVwKCk7CkBAIC0yMDUsNyArMjA1
LDcgQEAKIAkJCQkJCXRzdF9leGl0KCk7CiAJCQkJCX0KIAkJCQkJLyogY2FsbCBydF9zaWdwcm9j
bWFzaygpIHRvIHVuYmxvY2sgc2lnbmFsIzMzICovCi0JCQkJCVRFU1Qoc3lzY2FsbCgxNzUsIFNJ
R19VTkJMT0NLLCAmc2V0LCAmb3NldCwgOCkpOworCQkJCQlURVNUKHN5c2NhbGwoX19OUl9ydF9z
aWdwcm9jbWFzaywgU0lHX1VOQkxPQ0ssICZzZXQsICZvc2V0LCA4KSk7CiAJCQkJCWlmKFRFU1Rf
UkVUVVJOID09IC0xKXsKIAkJCQkJCXRzdF9yZXNtKFRGQUlMLCJDYWxsIHRvIHJ0X3NpZ3Byb2Nt
YXNrKCkgRmFpbGVkLCBlcnJubz0lZCA6ICVzIixURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VS
Uk5PKSk7CiAgICAgICAgICAgICAgICAgICAgICAgICAJCQljbGVhbnVwKCk7CmRpZmYgLU5hdXJi
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ydF9zaWdwcm9jbWFzay9ydF9zaWdwcm9jbWFz
azAyLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNrL3J0X3NpZ3By
b2NtYXNrMDIuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNr
L3J0X3NpZ3Byb2NtYXNrMDIuYwkyMDA5LTA1LTIxIDIzOjU0OjE1LjAwMDAwMDAwMCArMDUzMAor
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3J0X3NpZ3Byb2NtYXNrL3J0X3NpZ3Byb2Nt
YXNrMDIuYwkyMDA5LTA2LTE3IDIzOjMwOjQyLjAwMDAwMDAwMCArMDUzMApAQCAtMTc2LDcgKzE3
Niw3IEBACiAKIAkJCWZvcihpPTA7IGk8dGVzdF9jb3VudDsgaSsrKQogCQkgICAgICAgIHsKLQkJ
CQlURVNUKHN5c2NhbGwoMTc1LCBTSUdfQkxPQ0ssICZzLCB0ZXN0X2Nhc2VzW2ldLnNzLCB0ZXN0
X2Nhc2VzW2ldLnNzc2l6ZSkpOworCQkJCVRFU1Qoc3lzY2FsbChfX05SX3J0X3NpZ3Byb2NtYXNr
LCBTSUdfQkxPQ0ssICZzLCB0ZXN0X2Nhc2VzW2ldLnNzLCB0ZXN0X2Nhc2VzW2ldLnNzc2l6ZSkp
OwogCQkJCWlmKFRFU1RfUkVUVVJOID09IDApewogCQkJCQl0c3RfcmVzbShURkFJTCwiQ2FsbCB0
byBydF9zaWdwcm9jbWFzaygpc3VjY2VlZGVkLGJ1dCBzaG91bGQgZmFpbGVkLCBlcnJubz0lZCA6
ICVzIixURVNUX0VSUk5PLCBzdHJlcnJvcihURVNUX0VSUk5PKSk7CiAJCQkJCWZhaWwrKzsK
--000e0cd348b8b7aa22046c91047a
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
--000e0cd348b8b7aa22046c91047a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd348b8b7aa22046c91047a--

