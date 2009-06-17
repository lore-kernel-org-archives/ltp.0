Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1bU-0008S8-KK
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:19:28 +0000
Received: from yw-out-1718.google.com ([74.125.46.156])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1bT-000283-HO
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:19:28 +0000
Received: by yw-out-1718.google.com with SMTP id 5so283796ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:19:27 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:49:26 +0530
Message-ID: <f5a7b3810906171319m249a170dn74f42b831adec33f@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=00151750eed008165f046c9102c4
Subject: [LTP] [FIX PATCH] ltp-newuname01
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

--00151750eed008165f046c9102c4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed fail and fixed.
1. newuname01.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/kernel/syscalls/newuname/newuname01.c
b/testcases/kernel/syscalls/newuname/newuname01.c
--- a/testcases/kernel/syscalls/newuname/newuname01.c	2009-05-21
23:49:16.000000000 +0530
+++ b/testcases/kernel/syscalls/newuname/newuname01.c	2009-06-17
23:01:05.000000000 +0530
@@ -127,7 +127,7 @@
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-                     TEST(syscall(122,&name));     //call newuname()
+                     TEST(syscall(__NR_uname,&name));     //call newuname()
                      if(TEST_RETURN == -1) {
                  	   tst_resm(TFAIL, "%s failed - errno = %d : %s",
TCID, TEST_ERRNO, strerror(TEST_ERRNO));
                            cleanup();

--00151750eed008165f046c9102c4
Content-Type: application/octet-stream; name="ltp-fix-newuname.patch"
Content-Disposition: attachment; filename="ltp-fix-newuname.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2gr9rh0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL25ld3VuYW1lL25ld3VuYW1l
MDEuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmV3dW5hbWUvbmV3dW5hbWUwMS5jCi0t
LSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbmV3dW5hbWUvbmV3dW5hbWUwMS5jCTIwMDkt
MDUtMjEgMjM6NDk6MTYuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbmV3dW5hbWUvbmV3dW5hbWUwMS5jCTIwMDktMDYtMTcgMjM6MDE6MDUuMDAwMDAwMDAw
ICswNTMwCkBAIC0xMjcsNyArMTI3LDcgQEAKICAgICAgICAgZm9yIChsYyA9IDA7IFRFU1RfTE9P
UElORyhsYyk7ICsrbGMpIHsKICAgICAgICAgICAgICAgICBUc3RfY291bnQgPSAwOwogICAgICAg
ICAgICAgICAgIGZvciAodGVzdG5vID0gMDsgdGVzdG5vIDwgVFNUX1RPVEFMOyArK3Rlc3Rubykg
ewotICAgICAgICAgICAgICAgICAgICAgVEVTVChzeXNjYWxsKDEyMiwmbmFtZSkpOyAgICAgLy9j
YWxsIG5ld3VuYW1lKCkKKyAgICAgICAgICAgICAgICAgICAgIFRFU1Qoc3lzY2FsbChfX05SX3Vu
YW1lLCZuYW1lKSk7ICAgICAvL2NhbGwgbmV3dW5hbWUoKQogICAgICAgICAgICAgICAgICAgICAg
aWYoVEVTVF9SRVRVUk4gPT0gLTEpIHsKICAgICAgICAgICAgICAgICAgCSAgIHRzdF9yZXNtKFRG
QUlMLCAiJXMgZmFpbGVkIC0gZXJybm8gPSAlZCA6ICVzIiwgVENJRCwgVEVTVF9FUlJOTywgc3Ry
ZXJyb3IoVEVTVF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAgICAgICAgY2xlYW51cCgp
Owo=
--00151750eed008165f046c9102c4
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
--00151750eed008165f046c9102c4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--00151750eed008165f046c9102c4--

