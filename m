Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MH1ag-0008SS-18
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:18:38 +0000
Received: from mail-gx0-f207.google.com ([209.85.217.207])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MH1ad-0001PE-3O
	for ltp-list@lists.sourceforge.net; Wed, 17 Jun 2009 20:18:35 +0000
Received: by gxk3 with SMTP id 3so2185817gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Jun 2009 13:18:33 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 18 Jun 2009 01:48:33 +0530
Message-ID: <f5a7b3810906171318v503b0c77l27a5df2f057fb85c@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f1298dd79a3046c90fea0
Subject: [LTP] [FIX PATCH] ltp-add_key
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

--001e680f1298dd79a3046c90fea0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed following failures and fixed.
1. add_key01.c
2. add_key02.c


Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
diff -Naurb a/testcases/kernel/syscalls/add_key/add_key01.c
b/testcases/kernel/syscalls/add_key/add_key01.c
--- a/testcases/kernel/syscalls/add_key/add_key01.c	2009-05-21
23:39:37.000000000 +0530
+++ b/testcases/kernel/syscalls/add_key/add_key01.c	2009-06-17
23:00:15.000000000 +0530
@@ -125,7 +125,7 @@
         for (lc = 0; TEST_LOOPING(lc); ++lc) {
                 Tst_count = 0;
                 for (testno = 0; testno < TST_TOTAL; ++testno) {
-                     TEST(result = syscall(286, "keyring", "wjkey",
NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
+                     TEST(result = syscall(__NR_add_key, "keyring",
"wjkey", NULL, 0, KEY_SPEC_THREAD_KEYRING));     //call add_key()
                      if(TEST_RETURN != -1) {
         		tst_resm(TPASS, "add_key call succeeded");
                         cleanup();
@@ -139,4 +139,3 @@
         }	
         tst_exit();
 }
-
diff -Naurb a/testcases/kernel/syscalls/add_key/add_key02.c
b/testcases/kernel/syscalls/add_key/add_key02.c
--- a/testcases/kernel/syscalls/add_key/add_key02.c	2009-05-21
23:40:50.000000000 +0530
+++ b/testcases/kernel/syscalls/add_key/add_key02.c	2009-06-17
23:47:48.000000000 +0530
@@ -140,7 +140,7 @@
                 for (testno = 0; testno < TST_TOTAL; ++testno) {

 		for(i=0; i<test_count; i++) {
-                	TEST(syscall(286, test_cases[i].type,
test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
KEY_SPEC_USER_KEYRING));    //call add_key()
+                	TEST(syscall(__NR_add_key, test_cases[i].type,
test_cases[i].desc, test_cases[i].payload, test_cases[i].plen,
KEY_SPEC_USER_KEYRING));    //call add_key()
                 	if(TEST_RETURN != -1){
                         	tst_resm(TINFO,"call add_key() with wrong
args succeed, but should fail");
                         	fail++;
@@ -170,4 +170,3 @@
       }	
         tst_exit();
 }
-

--001e680f1298dd79a3046c90fea0
Content-Type: application/octet-stream; name="ltp-fix-add_key.patch"
Content-Disposition: attachment; filename="ltp-fix-add_key.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fw2gbxo00

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FkZF9rZXkvYWRkX2tleTAx
LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2FkZF9rZXkvYWRkX2tleTAxLmMKLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9hZGRfa2V5L2FkZF9rZXkwMS5jCTIwMDktMDUtMjEg
MjM6Mzk6MzcuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
YWRkX2tleS9hZGRfa2V5MDEuYwkyMDA5LTA2LTE3IDIzOjAwOjE1LjAwMDAwMDAwMCArMDUzMApA
QCAtMTI1LDcgKzEyNSw3IEBACiAgICAgICAgIGZvciAobGMgPSAwOyBURVNUX0xPT1BJTkcobGMp
OyArK2xjKSB7CiAgICAgICAgICAgICAgICAgVHN0X2NvdW50ID0gMDsKICAgICAgICAgICAgICAg
ICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8IFRTVF9UT1RBTDsgKyt0ZXN0bm8pIHsKLSAgICAg
ICAgICAgICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbCgyODYsICJrZXlyaW5nIiwgIndq
a2V5IiwgTlVMTCwgMCwgS0VZX1NQRUNfVEhSRUFEX0tFWVJJTkcpKTsgICAgIC8vY2FsbCBhZGRf
a2V5KCkKKyAgICAgICAgICAgICAgICAgICAgIFRFU1QocmVzdWx0ID0gc3lzY2FsbChfX05SX2Fk
ZF9rZXksICJrZXlyaW5nIiwgIndqa2V5IiwgTlVMTCwgMCwgS0VZX1NQRUNfVEhSRUFEX0tFWVJJ
TkcpKTsgICAgIC8vY2FsbCBhZGRfa2V5KCkKICAgICAgICAgICAgICAgICAgICAgIGlmKFRFU1Rf
UkVUVVJOICE9IC0xKSB7CiAgICAgICAgIAkJdHN0X3Jlc20oVFBBU1MsICJhZGRfa2V5IGNhbGwg
c3VjY2VlZGVkIik7CiAgICAgICAgICAgICAgICAgICAgICAgICBjbGVhbnVwKCk7CkBAIC0xMzks
NCArMTM5LDMgQEAKICAgICAgICAgfQkKICAgICAgICAgdHN0X2V4aXQoKTsKIH0KLQpkaWZmIC1O
YXVyYiBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYWRkX2tleS9hZGRfa2V5MDIuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvYWRkX2tleS9hZGRfa2V5MDIuYwotLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2FkZF9rZXkvYWRkX2tleTAyLmMJMjAwOS0wNS0yMSAyMzo0MDo1
MC4wMDAwMDAwMDAgKzA1MzAKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9hZGRfa2V5
L2FkZF9rZXkwMi5jCTIwMDktMDYtMTcgMjM6NDc6NDguMDAwMDAwMDAwICswNTMwCkBAIC0xNDAs
NyArMTQwLDcgQEAKICAgICAgICAgICAgICAgICBmb3IgKHRlc3RubyA9IDA7IHRlc3RubyA8IFRT
VF9UT1RBTDsgKyt0ZXN0bm8pIHsKIAogCQlmb3IoaT0wOyBpPHRlc3RfY291bnQ7IGkrKykgewot
ICAgICAgICAgICAgICAgIAlURVNUKHN5c2NhbGwoMjg2LCB0ZXN0X2Nhc2VzW2ldLnR5cGUsIHRl
c3RfY2FzZXNbaV0uZGVzYywgdGVzdF9jYXNlc1tpXS5wYXlsb2FkLCB0ZXN0X2Nhc2VzW2ldLnBs
ZW4sIEtFWV9TUEVDX1VTRVJfS0VZUklORykpOyAgICAvL2NhbGwgYWRkX2tleSgpCisgICAgICAg
ICAgICAgICAgCVRFU1Qoc3lzY2FsbChfX05SX2FkZF9rZXksIHRlc3RfY2FzZXNbaV0udHlwZSwg
dGVzdF9jYXNlc1tpXS5kZXNjLCB0ZXN0X2Nhc2VzW2ldLnBheWxvYWQsIHRlc3RfY2FzZXNbaV0u
cGxlbiwgS0VZX1NQRUNfVVNFUl9LRVlSSU5HKSk7ICAgIC8vY2FsbCBhZGRfa2V5KCkKICAgICAg
ICAgICAgICAgICAJaWYoVEVTVF9SRVRVUk4gIT0gLTEpewogICAgICAgICAgICAgICAgICAgICAg
ICAgCXRzdF9yZXNtKFRJTkZPLCJjYWxsIGFkZF9rZXkoKSB3aXRoIHdyb25nIGFyZ3Mgc3VjY2Vl
ZCwgYnV0IHNob3VsZCBmYWlsIik7CiAgICAgICAgICAgICAgICAgICAgICAgICAJZmFpbCsrOwpA
QCAtMTcwLDQgKzE3MCwzIEBACiAgICAgICB9CQogICAgICAgICB0c3RfZXhpdCgpOwogfQotCg==
--001e680f1298dd79a3046c90fea0
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
--001e680f1298dd79a3046c90fea0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f1298dd79a3046c90fea0--

