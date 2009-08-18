Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MdKAo-0004cN-W8
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 08:36:06 +0000
Received: from mail-gx0-f212.google.com ([209.85.217.212])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdKAi-0003rm-QW
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 08:36:06 +0000
Received: by gxk8 with SMTP id 8so4542584gxk.9
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2009 01:35:55 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 18 Aug 2009 14:05:53 +0530
Message-ID: <f5a7b3810908180135m6d185842i78ac522f4a163e25@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd5f12a15bb200471666889
Subject: [LTP] [FIX PATCH] ltp-fix-mlockall_15-1.c
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
To: ltp-list <ltp-list@lists.sourceforge.net>
Cc: Brandon Philips <bphilips@suse.de>

--000e0cd5f12a15bb200471666889
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed UNRESOLVED of following test cases
mlockall/15-1.c
mlockall/speculative/15-1.c

These test cases are fixed by setting the Rlimit to zero to get EPERM
as per the kernel code.

I have attached patch and below
Please review the same

Best regards,
Naresh Kamboju

/***********************************************************/
Results:
Before patch:
=============

conformance/interfaces/mlockall/15-1.test:execution:UNRESOLVED
conformance/interfaces/mlockall/speculative/15-1.test:execution:UNRESOLVED

After Patch:
============

conformance/interfaces/mlockall/15-1.test:execution:PASS
conformance/interfaces/mlockall/speculative/15-1.test:execution:PASS

/***********************************************************/

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c	2005-06-03
22:00:33.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/15-1.c	2009-08-18
11:28:02.000000000 +0530
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <pwd.h>
 #include <string.h>
+#include <sys/resource.h>
 #include "posixtest.h"


@@ -28,6 +29,9 @@
 int set_nonroot()
 {
 	struct passwd *pw;
+        struct rlimit rlim;
+        int ret=0;
+
 	setpwent();
 	/* search for the first user which is non root */
 	while((pw = getpwent()) != NULL)
@@ -39,6 +43,11 @@
 		return 1;
 	}

+        rlim.rlim_cur = 0;
+        rlim.rlim_max = 0;
+        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
+                printf("Failed at setrlimit() return %d \n", ret);
+
 	if(seteuid(pw->pw_uid) != 0) {
 		if(errno == EPERM) {
 			printf("You don't have permission to change your UID.\n");
diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c	2007-07-26
17:32:13.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlockall/speculative/15-1.c	2009-08-18
11:28:00.000000000 +0530
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <pwd.h>
 #include <string.h>
+#include <sys/resource.h>
 #include "posixtest.h"


@@ -28,6 +29,9 @@
 int set_nonroot()
 {
 	struct passwd *pw;
+        struct rlimit rlim;
+        int ret=0;
+
 	setpwent();
 	/* search for the first user which is non root */
 	while((pw = getpwent()) != NULL)
@@ -39,6 +43,11 @@
 		return 1;
 	}

+        rlim.rlim_cur = 0;
+        rlim.rlim_max = 0;
+        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
+                printf("Failed at setrlimit() return %d \n", ret);
+
 	if(seteuid(pw->pw_uid) != 0) {
 		if(errno == EPERM) {
 			printf("You don't have permission to change your UID.\n");

--000e0cd5f12a15bb200471666889
Content-Type: message/rfc822; name="ltp-fix-mlockall_15-1.patch"
Content-Disposition: attachment; filename="ltp-fix-mlockall_15-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyidoaxu0


ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tbG9ja2FsbC8xNS0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tbG9ja2FsbC8xNS0xLmMKLS0tIGEvdGVzdGNhc2Vz
L29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbWxvY2thbGwvMTUt
MS5jCTIwMDUtMDYtMDMgMjI6MDA6MzMuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9v
cGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21sb2NrYWxsLzE1LTEu
YwkyMDA5LTA4LTE4IDExOjI4OjAyLjAwMDAwMDAwMCArMDUzMApAQCAtMjEsNiArMjEsNyBAQAog
I2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPHB3ZC5oPgogI2luY2x1ZGUgPHN0cmlu
Zy5oPgorI2luY2x1ZGUgPHN5cy9yZXNvdXJjZS5oPgogI2luY2x1ZGUgInBvc2l4dGVzdC5oIgog
CiAKQEAgLTI4LDYgKzI5LDkgQEAKIGludCBzZXRfbm9ucm9vdCgpCiB7CiAJc3RydWN0IHBhc3N3
ZCAqcHc7CisgICAgICAgIHN0cnVjdCBybGltaXQgcmxpbTsKKyAgICAgICAgaW50IHJldD0wOwor
CiAJc2V0cHdlbnQoKTsKIAkvKiBzZWFyY2ggZm9yIHRoZSBmaXJzdCB1c2VyIHdoaWNoIGlzIG5v
biByb290ICovIAogCXdoaWxlKChwdyA9IGdldHB3ZW50KCkpICE9IE5VTEwpCkBAIC0zOSw2ICs0
MywxMSBAQAogCQlyZXR1cm4gMTsKIAl9CiAKKyAgICAgICAgcmxpbS5ybGltX2N1ciA9IDA7Cisg
ICAgICAgIHJsaW0ucmxpbV9tYXggPSAwOworICAgICAgICBpZiAoKHJldCA9IHNldHJsaW1pdChS
TElNSVRfTUVNTE9DSywmcmxpbSkpICE9IDApCisgICAgICAgICAgICAgICAgcHJpbnRmKCJGYWls
ZWQgYXQgc2V0cmxpbWl0KCkgcmV0dXJuICVkIFxuIiwgcmV0KTsKKwogCWlmKHNldGV1aWQocHct
PnB3X3VpZCkgIT0gMCkgewogCQlpZihlcnJubyA9PSBFUEVSTSkgewogCQkJcHJpbnRmKCJZb3Ug
ZG9uJ3QgaGF2ZSBwZXJtaXNzaW9uIHRvIGNoYW5nZSB5b3VyIFVJRC5cbiIpOwpkaWZmIC1OYXVy
YiBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2Vz
L21sb2NrYWxsL3NwZWN1bGF0aXZlLzE1LTEuYyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3Rz
dWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21sb2NrYWxsL3NwZWN1bGF0aXZlLzE1LTEuYwot
LS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNl
cy9tbG9ja2FsbC9zcGVjdWxhdGl2ZS8xNS0xLmMJMjAwNy0wNy0yNiAxNzozMjoxMy4wMDAwMDAw
MDAgKzA1MzAKKysrIGIvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNl
L2ludGVyZmFjZXMvbWxvY2thbGwvc3BlY3VsYXRpdmUvMTUtMS5jCTIwMDktMDgtMTggMTE6Mjg6
MDAuMDAwMDAwMDAwICswNTMwCkBAIC0yMSw2ICsyMSw3IEBACiAjaW5jbHVkZSA8c3lzL3R5cGVz
Lmg+CiAjaW5jbHVkZSA8cHdkLmg+CiAjaW5jbHVkZSA8c3RyaW5nLmg+CisjaW5jbHVkZSA8c3lz
L3Jlc291cmNlLmg+CiAjaW5jbHVkZSAicG9zaXh0ZXN0LmgiCiAKIApAQCAtMjgsNiArMjksOSBA
QAogaW50IHNldF9ub25yb290KCkKIHsKIAlzdHJ1Y3QgcGFzc3dkICpwdzsKKyAgICAgICAgc3Ry
dWN0IHJsaW1pdCBybGltOworICAgICAgICBpbnQgcmV0PTA7CisKIAlzZXRwd2VudCgpOwogCS8q
IHNlYXJjaCBmb3IgdGhlIGZpcnN0IHVzZXIgd2hpY2ggaXMgbm9uIHJvb3QgKi8gCiAJd2hpbGUo
KHB3ID0gZ2V0cHdlbnQoKSkgIT0gTlVMTCkKQEAgLTM5LDYgKzQzLDExIEBACiAJCXJldHVybiAx
OwogCX0KIAorICAgICAgICBybGltLnJsaW1fY3VyID0gMDsKKyAgICAgICAgcmxpbS5ybGltX21h
eCA9IDA7CisgICAgICAgIGlmICgocmV0ID0gc2V0cmxpbWl0KFJMSU1JVF9NRU1MT0NLLCZybGlt
KSkgIT0gMCkKKyAgICAgICAgICAgICAgICBwcmludGYoIkZhaWxlZCBhdCBzZXRybGltaXQoKSBy
ZXR1cm4gJWQgXG4iLCByZXQpOworCiAJaWYoc2V0ZXVpZChwdy0+cHdfdWlkKSAhPSAwKSB7CiAJ
CWlmKGVycm5vID09IEVQRVJNKSB7CiAJCQlwcmludGYoIllvdSBkb24ndCBoYXZlIHBlcm1pc3Np
b24gdG8gY2hhbmdlIHlvdXIgVUlELlxuIik7Cg==
--000e0cd5f12a15bb200471666889
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd5f12a15bb200471666889
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd5f12a15bb200471666889--

