Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MYzYf-0003Wv-OE
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 09:46:49 +0000
Received: from mail-gx0-f220.google.com ([209.85.217.220])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYzYU-0003Rw-Gz
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 09:46:44 +0000
Received: by gxk20 with SMTP id 20so1873964gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Aug 2009 02:46:32 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 6 Aug 2009 15:16:32 +0530
Message-ID: <f5a7b3810908060246o597813b8gaf5a6b1087f0fba7@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd6b23ea7ca2b047075fe9b
Subject: [LTP] [FIX PATCHE]ltp-sched_setparam_26-1.c
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

--000e0cd6b23ea7ca2b047075fe9b
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed UNTESTED behavior with sched_setparam/26-1.c test case
under open_posix_testsuite.

Test needs to be executed as non-root user.
So I have changed user id from root to non-root user by adding
set_nonroot() function.
Now test case got PASSED.

I have attached patch and results before and after the patch.
please review the same.


Best regards,
Naresh Kamboju

/*********************************************************************************************/
Before Patch:
/*********************************************************************************************/
# ./26-1.test
Run this test case as a Regular User, but not ROOT
conformance/interfaces/sched_setparam/26-1.test:execution:UNTESTED
/*********************************************************************************************/
After Patch:
/*********************************************************************************************/
# ./26-1.test
Testing with user 'bin' (uid: 1)
Test PASSED
conformance/interfaces/sched_setparam/26-1.test:execution:PASSED
/*********************************************************************************************/

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c	2005-06-03
22:03:02.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setparam/26-1.c	2009-08-06
14:36:01.000000000 +0530
@@ -16,9 +16,39 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
+#include <pwd.h>
 #include "posixtest.h"


+/** Set the euid of this process to a non-root uid */
+int set_nonroot()
+{
+	struct passwd *pw;
+	setpwent();
+	/* search for the first user which is non root */
+	while((pw = getpwent()) != NULL)
+		if(strcmp(pw->pw_name, "root"))
+			break;
+	endpwent();
+	if(pw == NULL) {
+		printf("There is no other user than current and root.\n");
+		return 1;
+	}
+
+	if(seteuid(pw->pw_uid) != 0) {
+		if(errno == EPERM) {
+			printf("You don't have permission to change your UID.\n");
+			return 1;
+		}
+		perror("An error occurs when calling seteuid()");
+		return 1;
+	}
+	
+	printf("Testing with user '%s' (uid: %d)\n",
+	       pw->pw_name, (int)geteuid());
+	return 0;
+}
+

 int main(){
 	int result;
@@ -28,9 +58,11 @@
         /* and can only be accessed by root */
         /* This test should be run under standard user permissions */
         if (getuid() == 0) {
-                puts("Run this test case as a Regular User, but not ROOT");
+	  	if (set_nonroot() != 0) {
+			  printf("Cannot run this test as non-root user\n");	
                 return PTS_UNTESTED;
         }
+        }

 	if(sched_getparam(0, &param) == -1) {
 		perror("An error occurs when calling sched_getparam()");

--000e0cd6b23ea7ca2b047075fe9b
Content-Type: application/octet-stream; 
	name="ltp-fix-sched_setparam_26-1.patch"
Content-Disposition: attachment; filename="ltp-fix-sched_setparam_26-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fy1ay00y0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9zY2hlZF9zZXRwYXJhbS8yNi0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90
ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9zY2hlZF9zZXRwYXJhbS8yNi0xLmMKLS0t
IGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMv
c2NoZWRfc2V0cGFyYW0vMjYtMS5jCTIwMDUtMDYtMDMgMjI6MDM6MDIuMDAwMDAwMDAwICswNTMw
CisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZh
Y2VzL3NjaGVkX3NldHBhcmFtLzI2LTEuYwkyMDA5LTA4LTA2IDE0OjM2OjAxLjAwMDAwMDAwMCAr
MDUzMApAQCAtMTYsOSArMTYsMzkgQEAKICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPGVy
cm5vLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CisjaW5jbHVkZSA8cHdkLmg+CiAjaW5jbHVkZSAi
cG9zaXh0ZXN0LmgiCiAKIAorLyoqIFNldCB0aGUgZXVpZCBvZiB0aGlzIHByb2Nlc3MgdG8gYSBu
b24tcm9vdCB1aWQgKi8KK2ludCBzZXRfbm9ucm9vdCgpCit7CisJc3RydWN0IHBhc3N3ZCAqcHc7
CisJc2V0cHdlbnQoKTsKKwkvKiBzZWFyY2ggZm9yIHRoZSBmaXJzdCB1c2VyIHdoaWNoIGlzIG5v
biByb290ICovIAorCXdoaWxlKChwdyA9IGdldHB3ZW50KCkpICE9IE5VTEwpCisJCWlmKHN0cmNt
cChwdy0+cHdfbmFtZSwgInJvb3QiKSkKKwkJCWJyZWFrOworCWVuZHB3ZW50KCk7CisJaWYocHcg
PT0gTlVMTCkgeworCQlwcmludGYoIlRoZXJlIGlzIG5vIG90aGVyIHVzZXIgdGhhbiBjdXJyZW50
IGFuZCByb290LlxuIik7CisJCXJldHVybiAxOworCX0KKworCWlmKHNldGV1aWQocHctPnB3X3Vp
ZCkgIT0gMCkgeworCQlpZihlcnJubyA9PSBFUEVSTSkgeworCQkJcHJpbnRmKCJZb3UgZG9uJ3Qg
aGF2ZSBwZXJtaXNzaW9uIHRvIGNoYW5nZSB5b3VyIFVJRC5cbiIpOworCQkJcmV0dXJuIDE7CisJ
CX0KKwkJcGVycm9yKCJBbiBlcnJvciBvY2N1cnMgd2hlbiBjYWxsaW5nIHNldGV1aWQoKSIpOwor
CQlyZXR1cm4gMTsKKwl9CisJCisJcHJpbnRmKCJUZXN0aW5nIHdpdGggdXNlciAnJXMnICh1aWQ6
ICVkKVxuIiwKKwkgICAgICAgcHctPnB3X25hbWUsIChpbnQpZ2V0ZXVpZCgpKTsKKwlyZXR1cm4g
MDsKK30KKwogCiBpbnQgbWFpbigpewogCWludCByZXN1bHQ7CkBAIC0yOCw5ICs1OCwxMSBAQAog
ICAgICAgICAvKiBhbmQgY2FuIG9ubHkgYmUgYWNjZXNzZWQgYnkgcm9vdCAqLyAKICAgICAgICAg
LyogVGhpcyB0ZXN0IHNob3VsZCBiZSBydW4gdW5kZXIgc3RhbmRhcmQgdXNlciBwZXJtaXNzaW9u
cyAqLwogICAgICAgICBpZiAoZ2V0dWlkKCkgPT0gMCkgewotICAgICAgICAgICAgICAgIHB1dHMo
IlJ1biB0aGlzIHRlc3QgY2FzZSBhcyBhIFJlZ3VsYXIgVXNlciwgYnV0IG5vdCBST09UIik7CisJ
ICAJaWYgKHNldF9ub25yb290KCkgIT0gMCkgeworCQkJICBwcmludGYoIkNhbm5vdCBydW4gdGhp
cyB0ZXN0IGFzIG5vbi1yb290IHVzZXJcbiIpOwkKICAgICAgICAgICAgICAgICByZXR1cm4gUFRT
X1VOVEVTVEVEOwogICAgICAgICB9CisgICAgICAgIH0KIAogCWlmKHNjaGVkX2dldHBhcmFtKDAs
ICZwYXJhbSkgPT0gLTEpIHsKIAkJcGVycm9yKCJBbiBlcnJvciBvY2N1cnMgd2hlbiBjYWxsaW5n
IHNjaGVkX2dldHBhcmFtKCkiKTsK
--000e0cd6b23ea7ca2b047075fe9b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd6b23ea7ca2b047075fe9b
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd6b23ea7ca2b047075fe9b--

