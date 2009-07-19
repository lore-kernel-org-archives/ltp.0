Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSOAh-0005PQ-Gv
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:38:47 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSOAb-0001Ic-3x
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 04:38:47 +0000
Received: by pzk8 with SMTP id 8so1337706pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 21:38:39 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 18 Jul 2009 21:38:39 -0700
Message-ID: <364299f40907182138w484cc898gac9fe00dbde75afd@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd30470706d8e046f0798fa
Subject: [LTP] [PATCH] Fix bad strerror calls in
	testcases/kernel/syscalls/waitid01.c
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
To: LTP list <ltp-list@lists.sourceforge.net>

--000e0cd30470706d8e046f0798fa
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

For whatever reason the original author was using int casts to the
strerror strings. That's just plain wrong...

This corrects the issue by feeding back the proper strerror output,
which reduces noise at compile time and results in the same desired
behavior (because we shouldn't be negative testing strerror(3) in
waitid01.c:

gcooper@orangebox /scratch/ltp-nova2/ltp-nova $
/scratch/ltp-nova2/ltp-nova/testcases/kernel/syscalls/waitid/waitid01
waitid01    0  INFO  :  Process 29085 terminated:
waitid01    0  INFO  :  code = 1
waitid01    0  INFO  :  exit value = 123
waitid01    0  INFO  :  Process 29086 terminated:
waitid01    0  INFO  :  code = 2
waitid01    0  INFO  :  signal = 8
waitid01    0  INFO  :  Process 29087 terminated:
waitid01    0  INFO  :  code = 2
waitid01    0  INFO  :  signal = 1
waitid01    0  INFO  :  Process 29088 terminated:
waitid01    0  INFO  :  code = 1
waitid01    0  INFO  :  exit value = 123
waitid01    0  INFO  :  Process 29089 terminated:
waitid01    0  INFO  :  code = 2
waitid01    0  INFO  :  signal = 8
waitid01    0  INFO  :  Process 29090 terminated:
waitid01    0  INFO  :  code = 2
waitid01    0  INFO  :  signal = 1
waitid01    0  INFO  :  Process 29091 terminated:
waitid01    0  INFO  :  code = 1
waitid01    0  INFO  :  exit value = 123
waitid01    0  INFO  :  Process 29092 terminated:
waitid01    0  INFO  :  code = 2
waitid01    0  INFO  :  signal = 8
waitid01    0  INFO  :  Process 29093 terminated:
waitid01    0  INFO  :  code = 2
waitid01    0  INFO  :  signal = 1
waitid01    1  PASS  :  waitid(): system call passed

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/syscalls/waitid/waitid01.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/syscalls/waitid/waitid01.c,v
retrieving revision 1.1
diff -u -r1.1 waitid01.c
--- testcases/kernel/syscalls/waitid/waitid01.c	15 Jun 2009 18:39:45 -0000	1.1
+++ testcases/kernel/syscalls/waitid/waitid01.c	19 Jul 2009 04:34:39 -0000
@@ -116,14 +116,9 @@
 int errnochoose(void){   //choose the relative errno

     switch (TEST_ERRNO){
-        case    0:      tst_exit();
-        case    ECHILD: strerror((int)"ECHILD");
-        	        break;
-        case    EINTR:  strerror((int)"EINTR");
-                	break;
-        case    EINVAL: strerror((int)"EINVAL");
-                	break;
-        default:     strerror((int)"Other Error");
+        case  0:     tst_exit();
+		     break;
+        default:     strerror(TEST_ERRNO);
                      break;
    }
         TEST_RETURN = 0;

--000e0cd30470706d8e046f0798fa
Content-Type: application/octet-stream; name="fix-waitid-strerror-call.diff"
Content-Disposition: attachment; filename="fix-waitid-strerror-call.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxba0ug50

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvd2FpdGlkL3dhaXRpZDAxLmMKPT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3QvbHRwL2x0cC90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3dhaXRpZC93YWl0aWQwMS5jLHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjEKZGlmZiAtdSAtcjEu
MSB3YWl0aWQwMS5jCi0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3dhaXRpZC93YWl0aWQw
MS5jCTE1IEp1biAyMDA5IDE4OjM5OjQ1IC0wMDAwCTEuMQorKysgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy93YWl0aWQvd2FpdGlkMDEuYwkxOSBKdWwgMjAwOSAwNDozNDozOSAtMDAwMApAQCAt
MTE2LDE0ICsxMTYsOSBAQAogaW50IGVycm5vY2hvb3NlKHZvaWQpeyAgIC8vY2hvb3NlIHRoZSBy
ZWxhdGl2ZSBlcnJubwogCiAgICAgc3dpdGNoIChURVNUX0VSUk5PKXsKLSAgICAgICAgY2FzZSAg
ICAwOiAgICAgIHRzdF9leGl0KCk7Ci0gICAgICAgIGNhc2UgICAgRUNISUxEOiBzdHJlcnJvcigo
aW50KSJFQ0hJTEQiKTsKLSAgICAgICAgCSAgICAgICAgYnJlYWs7Ci0gICAgICAgIGNhc2UgICAg
RUlOVFI6ICBzdHJlcnJvcigoaW50KSJFSU5UUiIpOwotICAgICAgICAgICAgICAgIAlicmVhazsK
LSAgICAgICAgY2FzZSAgICBFSU5WQUw6IHN0cmVycm9yKChpbnQpIkVJTlZBTCIpOwotICAgICAg
ICAgICAgICAgIAlicmVhazsKLSAgICAgICAgZGVmYXVsdDogICAgIHN0cmVycm9yKChpbnQpIk90
aGVyIEVycm9yIik7CisgICAgICAgIGNhc2UgIDA6ICAgICB0c3RfZXhpdCgpOworCQkgICAgIGJy
ZWFrOworICAgICAgICBkZWZhdWx0OiAgICAgc3RyZXJyb3IoVEVTVF9FUlJOTyk7CiAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKICAgIH0KICAgICAgICAgVEVTVF9SRVRVUk4gPSAwOwo=
--000e0cd30470706d8e046f0798fa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--000e0cd30470706d8e046f0798fa
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd30470706d8e046f0798fa--

