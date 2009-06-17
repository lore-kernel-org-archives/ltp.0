Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1b0-0008Vv-UP
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:18:58 +0000
Received: from yw-out-1718.google.com ([74.125.46.156])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1ax-000283-SM
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:18:58 +0000
Received: by yw-out-1718.google.com with SMTP id 5so283796ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:18:55 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:48:55 +0530
Message-ID: <f5a7b3810906171318r45b150dbo2c833e34bac0dcfd@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd5949424b121046c91007c
Subject: [LTP] [FIX PATCH] ltp-bdflush
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

--000e0cd5949424b121046c91007c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed fail and fixed.
1. bdflush01.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >



diff -Naurb a/testcases/kernel/syscalls/bdflush/bdflush01.c
b/testcases/kernel/syscalls/bdflush/bdflush01.c
--- a/testcases/kernel/syscalls/bdflush/bdflush01.c	2009-05-21
23:42:51.000000000 +0530
+++ b/testcases/kernel/syscalls/bdflush/bdflush01.c	2009-06-17
22:59:45.000000000 +0530
@@ -187,7 +187,7 @@
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-			TEST(syscall(134,0,data));	//bdflush(0,data);
+			TEST(syscall(__NR_bdflush,0,data));	//bdflush(0,data);
 			if(TEST_RETURN < 0){
 				tst_resm(TFAIL,"Call to bdflush() Failed, errno=%d :
%s",TEST_ERRNO, strerror(TEST_ERRNO));
                         	cleanup();

--000e0cd5949424b121046c91007c
Content-Type: application/octet-stream; name="ltp-fix-bdflush.patch"
Content-Disposition: attachment; filename="ltp-fix-bdflush.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2go2dv0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2JkZmx1c2gvYmRmbHVzaDAx
LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2JkZmx1c2gvYmRmbHVzaDAxLmMKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9iZGZsdXNoL2JkZmx1c2gwMS5jCTIwMDktMDUtMjEg
MjM6NDI6NTEuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
YmRmbHVzaC9iZGZsdXNoMDEuYwkyMDA5LTA2LTE3IDIyOjU5OjQ1LjAwMDAwMDAwMCArMDUzMApA
QCAtMTg3LDcgKzE4Nyw3IEBACiAgICAgICAgIGZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMp
OyArK2xjKSB7CiAgICAgICAgICAgICAgICAgVHN0X2NvdW50ID0gMDsKICAgICAgICAgICAgICAg
ICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKLQkJCVRF
U1Qoc3lzY2FsbCgxMzQsMCxkYXRhKSk7CS8vYmRmbHVzaCgwLGRhdGEpOworCQkJVEVTVChzeXNj
YWxsKF9fTlJfYmRmbHVzaCwwLGRhdGEpKTsJLy9iZGZsdXNoKDAsZGF0YSk7CiAJCQlpZihURVNU
X1JFVFVSTiA8IDApewogCQkJCXRzdF9yZXNtKFRGQUlMLCJDYWxsIHRvIGJkZmx1c2goKSBGYWls
ZWQsIGVycm5vPSVkIDogJXMiLFRFU1RfRVJSTk8sIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKICAg
ICAgICAgICAgICAgICAgICAgICAgIAljbGVhbnVwKCk7Cg==
--000e0cd5949424b121046c91007c
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
--000e0cd5949424b121046c91007c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd5949424b121046c91007c--

