Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1dl-0000KB-Jx
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:21:49 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1dj-0000Pd-Qt
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:21:49 +0000
Received: by gxk3 with SMTP id 3so2192445gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:21:47 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:51:47 +0530
Message-ID: <f5a7b3810906171321m79953178gd0505c6deb5dc3d3@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd594946844aa046c910aa4
Subject: [LTP] [FIX PATCH] ltp-set_tid_address
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

--000e0cd594946844aa046c910aa4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed fail and fixed.
1. set_tid_address01.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c
--- a/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c	2009-05-22
00:03:24.000000000 +0530
+++ b/testcases/kernel/syscalls/set_tid_address/set_tid_address01.c	2009-06-17
23:18:57.000000000 +0530
@@ -125,7 +125,7 @@
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-                     TEST(result = syscall(258, &newtid));     //call
set_tid_address()
+                     TEST(result = syscall(__NR_set_tid_address,
&newtid));     //call set_tid_address()
                      if(TEST_RETURN == getpid()) {
         		tst_resm(TPASS, "set_tid_address call succeeded: result =
%d (expected %d)",TEST_RETURN, result);
                      }

--000e0cd594946844aa046c910aa4
Content-Type: application/octet-stream; name="ltp-fix-set_tid_address.patch"
Content-Disposition: attachment; filename="ltp-fix-set_tid_address.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2gzo880

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90aWRfYWRkcmVzcy9z
ZXRfdGlkX2FkZHJlc3MwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRfdGlkX2Fk
ZHJlc3Mvc2V0X3RpZF9hZGRyZXNzMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NldF90aWRfYWRkcmVzcy9zZXRfdGlkX2FkZHJlc3MwMS5jCTIwMDktMDUtMjIgMDA6MDM6MjQu
MDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X3RpZF9h
ZGRyZXNzL3NldF90aWRfYWRkcmVzczAxLmMJMjAwOS0wNi0xNyAyMzoxODo1Ny4wMDAwMDAwMDAg
KzA1MzAKQEAgLTEyNSw3ICsxMjUsNyBAQAogICAgICAgICBmb3IgKGxjID0gMDsgVEVTVF9MT09Q
SU5HKGxjKTsgKytsYykgewogICAgICAgICAgICAgICAgIFRzdF9jb3VudCA9IDA7CiAgICAgICAg
ICAgICAgICAgZm9yICh0ZXN0bm8gPSAwOyB0ZXN0bm8gPCBUU1RfVE9UQUw7ICsrdGVzdG5vKSB7
Ci0gICAgICAgICAgICAgICAgICAgICBURVNUKHJlc3VsdCA9IHN5c2NhbGwoMjU4LCAmbmV3dGlk
KSk7ICAgICAvL2NhbGwgc2V0X3RpZF9hZGRyZXNzKCkKKyAgICAgICAgICAgICAgICAgICAgIFRF
U1QocmVzdWx0ID0gc3lzY2FsbChfX05SX3NldF90aWRfYWRkcmVzcywgJm5ld3RpZCkpOyAgICAg
Ly9jYWxsIHNldF90aWRfYWRkcmVzcygpCiAgICAgICAgICAgICAgICAgICAgICBpZihURVNUX1JF
VFVSTiA9PSBnZXRwaWQoKSkgewogICAgICAgICAJCXRzdF9yZXNtKFRQQVNTLCAic2V0X3RpZF9h
ZGRyZXNzIGNhbGwgc3VjY2VlZGVkOiByZXN1bHQgPSAlZCAoZXhwZWN0ZWQgJWQpIixURVNUX1JF
VFVSTiwgcmVzdWx0KTsKICAgICAgICAgICAgICAgICAgICAgIH0K
--000e0cd594946844aa046c910aa4
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
--000e0cd594946844aa046c910aa4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd594946844aa046c910aa4--

