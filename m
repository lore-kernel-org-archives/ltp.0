Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1d8-0005er-GU
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:21:10 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1d7-0002Yx-11
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:21:10 +0000
Received: by gxk3 with SMTP id 3so2191194gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:21:08 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:51:08 +0530
Message-ID: <f5a7b3810906171321n33d0ce4dp3252112a9475449d@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f128412d082046c9108ef
Subject: [LTP] [FIX PATCH] ltp-set_thread_area
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

--001e680f128412d082046c9108ef
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed following failures and fixed.
1. set_tid_address01.c
2. set_tid_address02.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c	2009-05-22
00:00:29.000000000 +0530
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c	2009-06-17
23:13:22.000000000 +0530
@@ -145,7 +145,7 @@
          * This call to get_thread_area function should be sucessful.
          */

-                     TEST(result = syscall(244, &u_info));     //call
get_thread_area()
+                     TEST(result = syscall(__NR_get_thread_area,
&u_info));     //call get_thread_area()
                      if(TEST_RETURN == 0) {
         		tst_resm(TPASS, "get_thread_area call succeeded");
                      }
@@ -160,7 +160,7 @@
          * This call to set_thread_area function should be sucessful.
          */

-                     TEST(result = syscall(243, &u_info));     //call
set_thread_area()
+                     TEST(result = syscall(__NR_set_thread_area,
&u_info));     //call set_thread_area()
                      if(TEST_RETURN == 0) {
         		tst_resm(TPASS, "set_thread_area call succeeded");
                      }
diff -Naurb a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-05-22
00:01:38.000000000 +0530
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area02.c	2009-06-17
23:34:04.000000000 +0530
@@ -146,7 +146,7 @@
          * This call to get_thread_area function should be sucessful.
          */

-                     TEST(result = syscall(244, &u_info));     //call
get_thread_area()
+                     TEST(result = syscall(__NR_get_thread_area,
&u_info));     //call get_thread_area()
                      if(TEST_RETURN == -1) {
                  	   tst_resm(TFAIL, "call get_thraed_area() failed
with errno = %d ", TEST_ERRNO, strerror(TEST_ERRNO));
                            cleanup();
@@ -158,7 +158,7 @@
          * This call to set_thread_area function with invalid
entry_number should be FAILED.
          */

-                     TEST(result = syscall(243, &u_info));     //call
set_thread_area()
+                     TEST(result = syscall(__NR_set_thread_area,
&u_info));     //call set_thread_area()
                      if(TEST_RETURN == -1) {
 			if(TEST_ERRNO == EINVAL){
 				tst_resm(TPASS, "Call to set_thread_area call failed with invalid
entry_number result = %d (expected EINVAL)",TEST_ERRNO);
@@ -177,7 +177,7 @@
          * This call to set_thread_area function with an invalid
pointer should be FAILED with EFAULT.
          */

-                     TEST(result = syscall(243,(struct user_desc
*)-9));     //call set_thread_area()
+                     TEST(result =
syscall(__NR_set_thread_area,(struct user_desc *)-9));     //call
set_thread_area()
                      if(TEST_RETURN == -1) {
 			if(TEST_ERRNO == EFAULT){
 				tst_resm(TPASS, "Call to set_thread_area call with invalid
entry_number result = %d (got expected error EFAULT)",TEST_ERRNO);

--001e680f128412d082046c9108ef
Content-Type: application/octet-stream; name="ltp-fix-set_thread_area.patch"
Content-Disposition: attachment; filename="ltp-fix-set_thread_area.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2gwgda0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF90aHJlYWRfYXJlYS9z
ZXRfdGhyZWFkX2FyZWEwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRfdGhyZWFk
X2FyZWEvc2V0X3RocmVhZF9hcmVhMDEuYwotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3NldF90aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMS5jCTIwMDktMDUtMjIgMDA6MDA6Mjku
MDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X3RocmVh
ZF9hcmVhL3NldF90aHJlYWRfYXJlYTAxLmMJMjAwOS0wNi0xNyAyMzoxMzoyMi4wMDAwMDAwMDAg
KzA1MzAKQEAgLTE0NSw3ICsxNDUsNyBAQAogICAgICAgICAgKiBUaGlzIGNhbGwgdG8gZ2V0X3Ro
cmVhZF9hcmVhIGZ1bmN0aW9uIHNob3VsZCBiZSBzdWNlc3NmdWwuCiAgICAgICAgICAqLwogCi0g
ICAgICAgICAgICAgICAgICAgICBURVNUKHJlc3VsdCA9IHN5c2NhbGwoMjQ0LCAmdV9pbmZvKSk7
ICAgICAvL2NhbGwgZ2V0X3RocmVhZF9hcmVhKCkKKyAgICAgICAgICAgICAgICAgICAgIFRFU1Qo
cmVzdWx0ID0gc3lzY2FsbChfX05SX2dldF90aHJlYWRfYXJlYSwgJnVfaW5mbykpOyAgICAgLy9j
YWxsIGdldF90aHJlYWRfYXJlYSgpCiAgICAgICAgICAgICAgICAgICAgICBpZihURVNUX1JFVFVS
TiA9PSAwKSB7CiAgICAgICAgIAkJdHN0X3Jlc20oVFBBU1MsICJnZXRfdGhyZWFkX2FyZWEgY2Fs
bCBzdWNjZWVkZWQiKTsKICAgICAgICAgICAgICAgICAgICAgIH0KQEAgLTE2MCw3ICsxNjAsNyBA
QAogICAgICAgICAgKiBUaGlzIGNhbGwgdG8gc2V0X3RocmVhZF9hcmVhIGZ1bmN0aW9uIHNob3Vs
ZCBiZSBzdWNlc3NmdWwuCiAgICAgICAgICAqLwogCi0gICAgICAgICAgICAgICAgICAgICBURVNU
KHJlc3VsdCA9IHN5c2NhbGwoMjQzLCAmdV9pbmZvKSk7ICAgICAvL2NhbGwgc2V0X3RocmVhZF9h
cmVhKCkKKyAgICAgICAgICAgICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbChfX05SX3Nl
dF90aHJlYWRfYXJlYSwgJnVfaW5mbykpOyAgICAgLy9jYWxsIHNldF90aHJlYWRfYXJlYSgpCiAg
ICAgICAgICAgICAgICAgICAgICBpZihURVNUX1JFVFVSTiA9PSAwKSB7CiAgICAgICAgIAkJdHN0
X3Jlc20oVFBBU1MsICJzZXRfdGhyZWFkX2FyZWEgY2FsbCBzdWNjZWVkZWQiKTsKICAgICAgICAg
ICAgICAgICAgICAgIH0KZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Nl
dF90aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zZXRfdGhyZWFkX2FyZWEvc2V0X3RocmVhZF9hcmVhMDIuYwotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3NldF90aHJlYWRfYXJlYS9zZXRfdGhyZWFkX2FyZWEwMi5jCTIwMDkt
MDUtMjIgMDA6MDE6MzguMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvc2V0X3RocmVhZF9hcmVhL3NldF90aHJlYWRfYXJlYTAyLmMJMjAwOS0wNi0xNyAyMzoz
NDowNC4wMDAwMDAwMDAgKzA1MzAKQEAgLTE0Niw3ICsxNDYsNyBAQAogICAgICAgICAgKiBUaGlz
IGNhbGwgdG8gZ2V0X3RocmVhZF9hcmVhIGZ1bmN0aW9uIHNob3VsZCBiZSBzdWNlc3NmdWwuCiAg
ICAgICAgICAqLwogCi0gICAgICAgICAgICAgICAgICAgICBURVNUKHJlc3VsdCA9IHN5c2NhbGwo
MjQ0LCAmdV9pbmZvKSk7ICAgICAvL2NhbGwgZ2V0X3RocmVhZF9hcmVhKCkKKyAgICAgICAgICAg
ICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbChfX05SX2dldF90aHJlYWRfYXJlYSwgJnVf
aW5mbykpOyAgICAgLy9jYWxsIGdldF90aHJlYWRfYXJlYSgpCiAgICAgICAgICAgICAgICAgICAg
ICBpZihURVNUX1JFVFVSTiA9PSAtMSkgewogICAgICAgICAgICAgICAgICAJICAgdHN0X3Jlc20o
VEZBSUwsICJjYWxsIGdldF90aHJhZWRfYXJlYSgpIGZhaWxlZCB3aXRoIGVycm5vID0gJWQgIiwg
VEVTVF9FUlJOTywgc3RyZXJyb3IoVEVTVF9FUlJOTykpOwogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY2xlYW51cCgpOwpAQCAtMTU4LDcgKzE1OCw3IEBACiAgICAgICAgICAqIFRoaXMgY2Fs
bCB0byBzZXRfdGhyZWFkX2FyZWEgZnVuY3Rpb24gd2l0aCBpbnZhbGlkIGVudHJ5X251bWJlciBz
aG91bGQgYmUgRkFJTEVELgogICAgICAgICAgKi8KIAotICAgICAgICAgICAgICAgICAgICAgVEVT
VChyZXN1bHQgPSBzeXNjYWxsKDI0MywgJnVfaW5mbykpOyAgICAgLy9jYWxsIHNldF90aHJlYWRf
YXJlYSgpCisgICAgICAgICAgICAgICAgICAgICBURVNUKHJlc3VsdCA9IHN5c2NhbGwoX19OUl9z
ZXRfdGhyZWFkX2FyZWEsICZ1X2luZm8pKTsgICAgIC8vY2FsbCBzZXRfdGhyZWFkX2FyZWEoKQog
ICAgICAgICAgICAgICAgICAgICAgaWYoVEVTVF9SRVRVUk4gPT0gLTEpIHsKIAkJCWlmKFRFU1Rf
RVJSTk8gPT0gRUlOVkFMKXsKIAkJCQl0c3RfcmVzbShUUEFTUywgIkNhbGwgdG8gc2V0X3RocmVh
ZF9hcmVhIGNhbGwgZmFpbGVkIHdpdGggaW52YWxpZCBlbnRyeV9udW1iZXIgcmVzdWx0ID0gJWQg
KGV4cGVjdGVkIEVJTlZBTCkiLFRFU1RfRVJSTk8pOwpAQCAtMTc3LDcgKzE3Nyw3IEBACiAgICAg
ICAgICAqIFRoaXMgY2FsbCB0byBzZXRfdGhyZWFkX2FyZWEgZnVuY3Rpb24gd2l0aCBhbiBpbnZh
bGlkIHBvaW50ZXIgc2hvdWxkIGJlIEZBSUxFRCB3aXRoIEVGQVVMVC4KICAgICAgICAgICovCiAK
LSAgICAgICAgICAgICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbCgyNDMsKHN0cnVjdCB1
c2VyX2Rlc2MgKiktOSkpOyAgICAgLy9jYWxsIHNldF90aHJlYWRfYXJlYSgpCisgICAgICAgICAg
ICAgICAgICAgICBURVNUKHJlc3VsdCA9IHN5c2NhbGwoX19OUl9zZXRfdGhyZWFkX2FyZWEsKHN0
cnVjdCB1c2VyX2Rlc2MgKiktOSkpOyAgICAgLy9jYWxsIHNldF90aHJlYWRfYXJlYSgpCiAgICAg
ICAgICAgICAgICAgICAgICBpZihURVNUX1JFVFVSTiA9PSAtMSkgewogCQkJaWYoVEVTVF9FUlJO
TyA9PSBFRkFVTFQpewogCQkJCXRzdF9yZXNtKFRQQVNTLCAiQ2FsbCB0byBzZXRfdGhyZWFkX2Fy
ZWEgY2FsbCB3aXRoIGludmFsaWQgZW50cnlfbnVtYmVyIHJlc3VsdCA9ICVkIChnb3QgZXhwZWN0
ZWQgZXJyb3IgRUZBVUxUKSIsVEVTVF9FUlJOTyk7Cg==
--001e680f128412d082046c9108ef
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
--001e680f128412d082046c9108ef
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f128412d082046c9108ef--

