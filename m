Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MSsYR-00014O-SG
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 13:05:19 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSsYN-0005wl-Hi
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 13:05:19 +0000
Received: by gxk20 with SMTP id 20so12042573gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jul 2009 06:05:13 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 20 Jul 2009 18:35:13 +0530
Message-ID: <f5a7b3810907200605r5fc2f575ta761cd45c92b0837@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd6ad60e12f42046f22c945
Subject: [LTP] [FIX PATCHES] open_posix_execute.sh
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
Cc: Brandon Philips <bphilips@suse.de>

--000e0cd6ad60e12f42046f22c945
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

As per the execute.sh script file there is time limit of two minutes
for each test case execution if it takes more time it will be reported
as HUNG.

shm_open/23-1.c test case under posix test suite which executes more
than two minitutes so test case reported as HUNG.

I have changed time limit from 120 to 300 sec. that is nothing but two
minutes to five minutes. In low end machines this test case taking 4
min to complete execution.

Now test cases reported as PASS

I have attached patch and below.
Please review the same.


Best regards,
Naresh Kamboju


/*****************************************************/
Before Patch:

conformance/interfaces/shm_open/23-1.test:execution:HUNG


After Patch:

conformance/interfaces/shm_open/23-1.test:execution:PASS
/*****************************************************/


Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/execute.sh
b/testcases/open_posix_testsuite/execute.sh
--- a/testcases/open_posix_testsuite/execute.sh	2007-07-26
17:32:11.000000000 +0530
+++ b/testcases/open_posix_testsuite/execute.sh	2009-07-20
17:53:15.000000000 +0530
@@ -163,8 +163,8 @@
 declare -i SEGV=0
 declare -i OTH=0

-# Maximum Two minutes waiting time period to execute a test. If it
exceeds, the test case will go into the 'HUNG' category.
-TIMEOUT_VAL=120
+# Maximum five minutes waiting time period to execute a test. If it
exceeds, the test case will go into the 'HUNG' category.
+TIMEOUT_VAL=300

 # if gcc available then remove the below line comment else put the t0
in posixtestsuite directory.
 #gcc -o t0 t0.c

--000e0cd6ad60e12f42046f22c945
Content-Type: application/octet-stream; name="ltp-posix-execute.patch"
Content-Disposition: attachment; filename="ltp-posix-execute.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxd7f45q0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvZXhlY3V0ZS5zaCBi
L3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9leGVjdXRlLnNoCi0tLSBhL3Rlc3RjYXNl
cy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9leGVjdXRlLnNoCTIwMDctMDctMjYgMTc6MzI6MTEuMDAw
MDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9leGVjdXRl
LnNoCTIwMDktMDctMjAgMTc6NTM6MTUuMDAwMDAwMDAwICswNTMwCkBAIC0xNjMsOCArMTYzLDgg
QEAKIGRlY2xhcmUgLWkgU0VHVj0wCiBkZWNsYXJlIC1pIE9USD0wCiAKLSMgTWF4aW11bSBUd28g
bWludXRlcyB3YWl0aW5nIHRpbWUgcGVyaW9kIHRvIGV4ZWN1dGUgYSB0ZXN0LiBJZiBpdCBleGNl
ZWRzLCB0aGUgdGVzdCBjYXNlIHdpbGwgZ28gaW50byB0aGUgJ0hVTkcnIGNhdGVnb3J5LgotVElN
RU9VVF9WQUw9MTIwCisjIE1heGltdW0gZml2ZSBtaW51dGVzIHdhaXRpbmcgdGltZSBwZXJpb2Qg
dG8gZXhlY3V0ZSBhIHRlc3QuIElmIGl0IGV4Y2VlZHMsIHRoZSB0ZXN0IGNhc2Ugd2lsbCBnbyBp
bnRvIHRoZSAnSFVORycgY2F0ZWdvcnkuCitUSU1FT1VUX1ZBTD0zMDAKIAogIyBpZiBnY2MgYXZh
aWxhYmxlIHRoZW4gcmVtb3ZlIHRoZSBiZWxvdyBsaW5lIGNvbW1lbnQgZWxzZSBwdXQgdGhlIHQw
IGluIHBvc2l4dGVzdHN1aXRlIGRpcmVjdG9yeS4KICNnY2MgLW8gdDAgdDAuYwo=
--000e0cd6ad60e12f42046f22c945
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
--000e0cd6ad60e12f42046f22c945
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd6ad60e12f42046f22c945--

