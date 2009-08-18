Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MdRZp-0006gU-Q0
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 16:30:25 +0000
Received: from mail-yx0-f174.google.com ([209.85.210.174])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdRZh-0003Vd-SO
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 16:30:25 +0000
Received: by yxe4 with SMTP id 4so5058443yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Aug 2009 09:30:12 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 18 Aug 2009 22:00:12 +0530
Message-ID: <f5a7b3810908180930q41ceddc0w24a15c21f3c4d796@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd23f3657409e04716d085a
Subject: [LTP] [FIX PATCH] ltp-fix-sched_setscheduler_17-6
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

--000e0cd23f3657409e04716d085a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed sched_setscheduler/17-6.c test case as UNTESTED.

Test needs to be executed as non-root user.
So I have changed user id from root to non-root user by adding
set_nonroot() function. Now test case got PASSED.

I have attached patch and results before and after the patch.
Please review the same.

Best regards
Naresh Kamboju

/************************************************************/
 Results:
/************************************************************/
Before patch:
conformance/interfaces/sched_setscheduler/17-6.test:execution:UNTESTED

After patch:
conformance/interfaces/sched_setscheduler/17-6.test:execution:PASS
/*************************************************************/


Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >


diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c
b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c	2005-06-03
22:03:12.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sched_setscheduler/17-6.c	2009-08-18
21:03:50.000000000 +0530
@@ -24,10 +24,42 @@
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
+#include <pwd.h>
+#include <string.h>
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
+
 int main(){
 	int max_priority, old_priority, old_policy, new_policy, policy;
         struct sched_param param;
@@ -36,9 +68,11 @@
         /* and can only be accessed by root */
         /* This test should be run under standard user permissions */
         if (getuid() == 0) {
-                puts("Run this test case as a Regular User, but not ROOT");
+	  	if (set_nonroot() != 0) {
+			printf("Cannot run this test as non-root user\n");	
                 return PTS_UNTESTED;
         }	
+        }	

 	if(sched_getparam(getpid(), &param) == -1) {
 		perror("An error occurs when calling sched_getparam()");

--000e0cd23f3657409e04716d085a
Content-Type: application/octet-stream; 
	name="ltp-fix-sched_setscheduler_17-6.patch"
Content-Disposition: attachment; 
	filename="ltp-fix-sched_setscheduler_17-6.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fyiugnsd0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9zY2hlZF9zZXRzY2hlZHVsZXIvMTctNi5jIGIvdGVzdGNhc2VzL29wZW5fcG9z
aXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvc2NoZWRfc2V0c2NoZWR1bGVyLzE3
LTYuYwotLS0gYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2UvaW50
ZXJmYWNlcy9zY2hlZF9zZXRzY2hlZHVsZXIvMTctNi5jCTIwMDUtMDYtMDMgMjI6MDM6MTIuMDAw
MDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25mb3Jt
YW5jZS9pbnRlcmZhY2VzL3NjaGVkX3NldHNjaGVkdWxlci8xNy02LmMJMjAwOS0wOC0xOCAyMTow
Mzo1MC4wMDAwMDAwMDAgKzA1MzAKQEAgLTI0LDEwICsyNCw0MiBAQAogI2luY2x1ZGUgPHN0ZGlv
Lmg+CiAjaW5jbHVkZSA8ZXJybm8uaD4KICNpbmNsdWRlIDx1bmlzdGQuaD4KKyNpbmNsdWRlIDxw
d2QuaD4KKyNpbmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlICJwb3NpeHRlc3QuaCIKIAogCiAK
Ky8qKiBTZXQgdGhlIGV1aWQgb2YgdGhpcyBwcm9jZXNzIHRvIGEgbm9uLXJvb3QgdWlkICovCitp
bnQgc2V0X25vbnJvb3QoKQoreworCXN0cnVjdCBwYXNzd2QgKnB3OworCXNldHB3ZW50KCk7CisJ
Lyogc2VhcmNoIGZvciB0aGUgZmlyc3QgdXNlciB3aGljaCBpcyBub24gcm9vdCAqLyAKKwl3aGls
ZSgocHcgPSBnZXRwd2VudCgpKSAhPSBOVUxMKQorCQlpZihzdHJjbXAocHctPnB3X25hbWUsICJy
b290IikpCisJCQlicmVhazsKKwllbmRwd2VudCgpOworCWlmKHB3ID09IE5VTEwpIHsKKwkJcHJp
bnRmKCJUaGVyZSBpcyBubyBvdGhlciB1c2VyIHRoYW4gY3VycmVudCBhbmQgcm9vdC5cbiIpOwor
CQlyZXR1cm4gMTsKKwl9CisKKwlpZihzZXRldWlkKHB3LT5wd191aWQpICE9IDApIHsKKwkJaWYo
ZXJybm8gPT0gRVBFUk0pIHsKKwkJCXByaW50ZigiWW91IGRvbid0IGhhdmUgcGVybWlzc2lvbiB0
byBjaGFuZ2UgeW91ciBVSUQuXG4iKTsKKwkJCXJldHVybiAxOworCQl9CisJCXBlcnJvcigiQW4g
ZXJyb3Igb2NjdXJzIHdoZW4gY2FsbGluZyBzZXRldWlkKCkiKTsKKwkJcmV0dXJuIDE7CisJfQor
CQorCXByaW50ZigiVGVzdGluZyB3aXRoIHVzZXIgJyVzJyAodWlkOiAlZClcbiIsCisJICAgICAg
IHB3LT5wd19uYW1lLCAoaW50KWdldGV1aWQoKSk7CisJcmV0dXJuIDA7Cit9CisKKwogaW50IG1h
aW4oKXsKIAlpbnQgbWF4X3ByaW9yaXR5LCBvbGRfcHJpb3JpdHksIG9sZF9wb2xpY3ksIG5ld19w
b2xpY3ksIHBvbGljeTsKICAgICAgICAgc3RydWN0IHNjaGVkX3BhcmFtIHBhcmFtOwpAQCAtMzYs
OSArNjgsMTEgQEAKICAgICAgICAgLyogYW5kIGNhbiBvbmx5IGJlIGFjY2Vzc2VkIGJ5IHJvb3Qg
Ki8gCiAgICAgICAgIC8qIFRoaXMgdGVzdCBzaG91bGQgYmUgcnVuIHVuZGVyIHN0YW5kYXJkIHVz
ZXIgcGVybWlzc2lvbnMgKi8KICAgICAgICAgaWYgKGdldHVpZCgpID09IDApIHsKLSAgICAgICAg
ICAgICAgICBwdXRzKCJSdW4gdGhpcyB0ZXN0IGNhc2UgYXMgYSBSZWd1bGFyIFVzZXIsIGJ1dCBu
b3QgUk9PVCIpOworCSAgCWlmIChzZXRfbm9ucm9vdCgpICE9IDApIHsKKwkJCXByaW50ZigiQ2Fu
bm90IHJ1biB0aGlzIHRlc3QgYXMgbm9uLXJvb3QgdXNlclxuIik7CQogICAgICAgICAgICAgICAg
IHJldHVybiBQVFNfVU5URVNURUQ7CiAgICAgICAgIH0JCisgICAgICAgIH0JCiAKIAlpZihzY2hl
ZF9nZXRwYXJhbShnZXRwaWQoKSwgJnBhcmFtKSA9PSAtMSkgewogCQlwZXJyb3IoIkFuIGVycm9y
IG9jY3VycyB3aGVuIGNhbGxpbmcgc2NoZWRfZ2V0cGFyYW0oKSIpOwo=
--000e0cd23f3657409e04716d085a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--000e0cd23f3657409e04716d085a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd23f3657409e04716d085a--

