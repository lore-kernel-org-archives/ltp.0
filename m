Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1e4-0005lE-O1
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:22:08 +0000
Received: from mail-yx0-f192.google.com ([209.85.210.192])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1e3-0002lc-NX
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:22:08 +0000
Received: by yxe30 with SMTP id 30so756404yxe.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:22:07 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:52:06 +0530
Message-ID: <f5a7b3810906171322v64c74820w4b624299ec9079d7@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f12d488932c046c910b7c
Subject: [LTP] [FIX PATCH] ltp-ssetmask
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

--001e680f12d488932c046c910b7c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed fail and fixed.
1. ssetmask01.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/ssetmask/ssetmask01.c
b/testcases/kernel/syscalls/ssetmask/ssetmask01.c
--- a/testcases/kernel/syscalls/ssetmask/ssetmask01.c	2009-05-22
00:09:52.000000000 +0530
+++ b/testcases/kernel/syscalls/ssetmask/ssetmask01.c	2009-06-17
23:21:55.000000000 +0530
@@ -125,14 +125,14 @@
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-		     syscall(69,SIGALRM);
-                     TEST(syscall(68));     //call ssetmask()
+		     syscall(__NR_ssetmask,SIGALRM);
+                     TEST(syscall(__NR_sgetmask));     //call ssetmask()
                      if(TEST_RETURN != SIGALRM) {
                  	   tst_resm(TFAIL, "%s failed - errno = %d : %s",
TCID, TEST_ERRNO, strerror(TEST_ERRNO));
                            cleanup();
 			   tst_exit();
                      }
-                     TEST(syscall(69,SIGUSR1));     //call ssetmask()
+                     TEST(syscall(__NR_ssetmask,SIGUSR1));     //call
ssetmask()
                      if(TEST_RETURN != SIGALRM) {
                  	   tst_resm(TFAIL, "%s failed - errno = %d : %s",
TCID, TEST_ERRNO, strerror(TEST_ERRNO));
                            cleanup();

--001e680f12d488932c046c910b7c
Content-Type: application/octet-stream; name="ltp-fix-ssetmask.patch"
Content-Disposition: attachment; filename="ltp-fix-ssetmask.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2h29ru0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NzZXRtYXNrL3NzZXRtYXNr
MDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3NldG1hc2svc3NldG1hc2swMS5jCi0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3NldG1hc2svc3NldG1hc2swMS5jCTIwMDkt
MDUtMjIgMDA6MDk6NTIuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc3NldG1hc2svc3NldG1hc2swMS5jCTIwMDktMDYtMTcgMjM6MjE6NTUuMDAwMDAwMDAw
ICswNTMwCkBAIC0xMjUsMTQgKzEyNSwxNCBAQAogICAgICAgICBmb3IgKGxjID0gMDsgVEVTVF9M
T09QSU5HKGxjKTsgKytsYykgewogICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7CiAgICAg
ICAgICAgICAgICAgZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5v
KSB7Ci0JCSAgICAgc3lzY2FsbCg2OSxTSUdBTFJNKTsKLSAgICAgICAgICAgICAgICAgICAgIFRF
U1Qoc3lzY2FsbCg2OCkpOyAgICAgLy9jYWxsIHNzZXRtYXNrKCkKKwkJICAgICBzeXNjYWxsKF9f
TlJfc3NldG1hc2ssU0lHQUxSTSk7CisgICAgICAgICAgICAgICAgICAgICBURVNUKHN5c2NhbGwo
X19OUl9zZ2V0bWFzaykpOyAgICAgLy9jYWxsIHNzZXRtYXNrKCkKICAgICAgICAgICAgICAgICAg
ICAgIGlmKFRFU1RfUkVUVVJOICE9IFNJR0FMUk0pIHsKICAgICAgICAgICAgICAgICAgCSAgIHRz
dF9yZXNtKFRGQUlMLCAiJXMgZmFpbGVkIC0gZXJybm8gPSAlZCA6ICVzIiwgVENJRCwgVEVTVF9F
UlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAg
Y2xlYW51cCgpOwogCQkJICAgdHN0X2V4aXQoKTsKICAgICAgICAgICAgICAgICAgICAgIH0KLSAg
ICAgICAgICAgICAgICAgICAgIFRFU1Qoc3lzY2FsbCg2OSxTSUdVU1IxKSk7ICAgICAvL2NhbGwg
c3NldG1hc2soKQorICAgICAgICAgICAgICAgICAgICAgVEVTVChzeXNjYWxsKF9fTlJfc3NldG1h
c2ssU0lHVVNSMSkpOyAgICAgLy9jYWxsIHNzZXRtYXNrKCkKICAgICAgICAgICAgICAgICAgICAg
IGlmKFRFU1RfUkVUVVJOICE9IFNJR0FMUk0pIHsKICAgICAgICAgICAgICAgICAgCSAgIHRzdF9y
ZXNtKFRGQUlMLCAiJXMgZmFpbGVkIC0gZXJybm8gPSAlZCA6ICVzIiwgVENJRCwgVEVTVF9FUlJO
Tywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xl
YW51cCgpOwo=
--001e680f12d488932c046c910b7c
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
--001e680f12d488932c046c910b7c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f12d488932c046c910b7c--

