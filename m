Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MO8kt-0008Fq-U6
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 11:22:35 +0000
Received: from mail-qy0-f200.google.com ([209.85.221.200])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MO8km-0006wg-Ik
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 11:22:35 +0000
Received: by qyk38 with SMTP id 38so4753615qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 04:22:27 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Jul 2009 14:49:21 +0530
Message-ID: <f5a7b3810907070219k5ca1e6d5u7ad4fbfb2a85250e@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=0015175caade2ef6e1046e1a1e33
Subject: [LTP] [FIX PATCH] ltp-posix-mmap_18-1.c
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
Cc: Brandon Philips <bphilips@suse.de>, Jiri Palecek <jpalecek@web.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

--0015175caade2ef6e1046e1a1e33
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed FAIL and fixed mmap/18-1.c under open posix testsuite.
I have fixed this test case by changing the seteuid() from root to
non-root. To get resource limit setrlimit()

STEPS:
mmap:
EAGAIN:
Lock all the memory by mlockall().
Set resource limit setrlimit()
Change the user to non-root then only setrmilit is applicable.

I have attached the patch and below.
Please review the same.

Best regards,
Naresh Kamboju

/*****************************************************************/
[mmap]# ./18-1.test
Test Pass: mmap/18-1.c Get EAGAIN: Resource temporarily unavailable
/*****************************************************************/


Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c	2005-06-03
22:00:33.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/18-1.c	2009-07-07
14:03:47.000000000 +0530
@@ -13,9 +13,11 @@
  * 1. Call mlockall(), setting MCL_FUTURE;
  * 2. Call setrlimit(), set rlim_cur of resource RLIMIT_MEMLOCK to a
  *    certain value.
- * 3. Map a shared memory object, with size larger than the
+ * 3. Change user to non-root user seteuid()
+ * 4. Map a shared memory object, with size larger than the
  *    rlim_cur value set in step 2
- * 4. Should get EAGAIN.
+ * 5. Should get EAGAIN.
+ * 6. Change user to root seteuid()
  */

 #define _XOPEN_SOURCE 600
@@ -28,12 +30,43 @@
 #include <sys/stat.h>
 #include <sys/resource.h>
 #include <fcntl.h>
+#include <pwd.h>
 #include <string.h>
 #include <errno.h>
 #include "posixtest.h"

 #define TNAME "mmap/18-1.c"

+
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
 int main()
 {
   char tmpfname[256];
@@ -93,11 +126,29 @@
   }

   fd = shm_fd;	
+	
+  /* This test should be run under standard user permissions */
+  if (getuid() == 0) {
+	  if (set_nonroot() != 0) {
+		  printf("Cannot run this test as non-root user\n");	
+		  return PTS_UNTESTED;
+	  }
+  }
+
+  /*
+   * EAGAIN:
+   * Lock all the memory by mlockall().
+   * Set resource limit setrlimit()
+   * Change the user to non-root then only setrmilit is applicable.
+   */
+
   pa = mmap (addr, len, prot, flag, fd, off);
   if (pa == MAP_FAILED && errno == EAGAIN)
   {
     printf ("Test Pass: " TNAME " Get EAGAIN: %s\n",
             strerror(errno));
+    /* Change user to root */
+    seteuid(0);
     close(fd);
     munmap(pa, len);
     exit(PTS_PASS);

--0015175caade2ef6e1046e1a1e33
Content-Type: application/octet-stream; name="ltp-posix-mmap_18-1.patch"
Content-Disposition: attachment; filename="ltp-posix-mmap_18-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fwuedbve0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tbWFwLzE4LTEuYyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9j
b25mb3JtYW5jZS9pbnRlcmZhY2VzL21tYXAvMTgtMS5jCi0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bv
c2l4X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21tYXAvMTgtMS5jCTIwMDUtMDYt
MDMgMjI6MDA6MzMuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rl
c3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21tYXAvMTgtMS5jCTIwMDktMDctMDcgMTQ6
MDM6NDcuMDAwMDAwMDAwICswNTMwCkBAIC0xMyw5ICsxMywxMSBAQAogICogMS4gQ2FsbCBtbG9j
a2FsbCgpLCBzZXR0aW5nIE1DTF9GVVRVUkU7CiAgKiAyLiBDYWxsIHNldHJsaW1pdCgpLCBzZXQg
cmxpbV9jdXIgb2YgcmVzb3VyY2UgUkxJTUlUX01FTUxPQ0sgdG8gYQogICogICAgY2VydGFpbiB2
YWx1ZS4KLSAqIDMuIE1hcCBhIHNoYXJlZCBtZW1vcnkgb2JqZWN0LCB3aXRoIHNpemUgbGFyZ2Vy
IHRoYW4gdGhlIAorICogMy4gQ2hhbmdlIHVzZXIgdG8gbm9uLXJvb3QgdXNlciBzZXRldWlkKCkg
CisgKiA0LiBNYXAgYSBzaGFyZWQgbWVtb3J5IG9iamVjdCwgd2l0aCBzaXplIGxhcmdlciB0aGFu
IHRoZSAKICAqICAgIHJsaW1fY3VyIHZhbHVlIHNldCBpbiBzdGVwIDIKLSAqIDQuIFNob3VsZCBn
ZXQgRUFHQUlOLiAKKyAqIDUuIFNob3VsZCBnZXQgRUFHQUlOLiAKKyAqIDYuIENoYW5nZSB1c2Vy
IHRvIHJvb3Qgc2V0ZXVpZCgpCiAgKi8KIAogI2RlZmluZSBfWE9QRU5fU09VUkNFIDYwMApAQCAt
MjgsMTIgKzMwLDQzIEBACiAjaW5jbHVkZSA8c3lzL3N0YXQuaD4KICNpbmNsdWRlIDxzeXMvcmVz
b3VyY2UuaD4KICNpbmNsdWRlIDxmY250bC5oPgorI2luY2x1ZGUgPHB3ZC5oPgogI2luY2x1ZGUg
PHN0cmluZy5oPgogI2luY2x1ZGUgPGVycm5vLmg+CiAjaW5jbHVkZSAicG9zaXh0ZXN0LmgiCiAg
CiAjZGVmaW5lIFROQU1FICJtbWFwLzE4LTEuYyIKIAorCisvKiogU2V0IHRoZSBldWlkIG9mIHRo
aXMgcHJvY2VzcyB0byBhIG5vbi1yb290IHVpZCAqLworaW50IHNldF9ub25yb290KCkKK3sKKwlz
dHJ1Y3QgcGFzc3dkICpwdzsKKwlzZXRwd2VudCgpOworCS8qIHNlYXJjaCBmb3IgdGhlIGZpcnN0
IHVzZXIgd2hpY2ggaXMgbm9uIHJvb3QgKi8gCisJd2hpbGUoKHB3ID0gZ2V0cHdlbnQoKSkgIT0g
TlVMTCkKKwkJaWYoc3RyY21wKHB3LT5wd19uYW1lLCAicm9vdCIpKQorCQkJYnJlYWs7CisJZW5k
cHdlbnQoKTsKKwlpZihwdyA9PSBOVUxMKSB7CisJCXByaW50ZigiVGhlcmUgaXMgbm8gb3RoZXIg
dXNlciB0aGFuIGN1cnJlbnQgYW5kIHJvb3QuXG4iKTsKKwkJcmV0dXJuIDE7CisJfQorCisJaWYo
c2V0ZXVpZChwdy0+cHdfdWlkKSAhPSAwKSB7CisJCWlmKGVycm5vID09IEVQRVJNKSB7CisJCQlw
cmludGYoIllvdSBkb24ndCBoYXZlIHBlcm1pc3Npb24gdG8gY2hhbmdlIHlvdXIgVUlELlxuIik7
CisJCQlyZXR1cm4gMTsKKwkJfQorCQlwZXJyb3IoIkFuIGVycm9yIG9jY3VycyB3aGVuIGNhbGxp
bmcgc2V0ZXVpZCgpIik7CisJCXJldHVybiAxOworCX0KKwkKKwlwcmludGYoIlRlc3Rpbmcgd2l0
aCB1c2VyICclcycgKHVpZDogJWQpXG4iLAorCSAgICAgICBwdy0+cHdfbmFtZSwgKGludClnZXRl
dWlkKCkpOworCXJldHVybiAwOworfQorCiBpbnQgbWFpbigpCiB7CiAgIGNoYXIgdG1wZm5hbWVb
MjU2XTsKQEAgLTkzLDExICsxMjYsMjkgQEAKICAgfQogCiAgIGZkID0gc2htX2ZkOwkKKwkKKyAg
LyogVGhpcyB0ZXN0IHNob3VsZCBiZSBydW4gdW5kZXIgc3RhbmRhcmQgdXNlciBwZXJtaXNzaW9u
cyAqLworICBpZiAoZ2V0dWlkKCkgPT0gMCkgeworCSAgaWYgKHNldF9ub25yb290KCkgIT0gMCkg
eworCQkgIHByaW50ZigiQ2Fubm90IHJ1biB0aGlzIHRlc3QgYXMgbm9uLXJvb3QgdXNlclxuIik7
CQorCQkgIHJldHVybiBQVFNfVU5URVNURUQ7CisJICB9CisgIH0KKworICAvKgorICAgKiBFQUdB
SU46CisgICAqIExvY2sgYWxsIHRoZSBtZW1vcnkgYnkgbWxvY2thbGwoKS4KKyAgICogU2V0IHJl
c291cmNlIGxpbWl0IHNldHJsaW1pdCgpCisgICAqIENoYW5nZSB0aGUgdXNlciB0byBub24tcm9v
dCB0aGVuIG9ubHkgc2V0cm1pbGl0IGlzIGFwcGxpY2FibGUuCisgICAqLworCiAgIHBhID0gbW1h
cCAoYWRkciwgbGVuLCBwcm90LCBmbGFnLCBmZCwgb2ZmKTsKICAgaWYgKHBhID09IE1BUF9GQUlM
RUQgJiYgZXJybm8gPT0gRUFHQUlOKQogICB7CiAgICAgcHJpbnRmICgiVGVzdCBQYXNzOiAiIFRO
QU1FICIgR2V0IEVBR0FJTjogJXNcbiIsIAogICAgICAgICAgICAgc3RyZXJyb3IoZXJybm8pKTsg
ICAgCisgICAgLyogQ2hhbmdlIHVzZXIgdG8gcm9vdCAqLyAKKyAgICBzZXRldWlkKDApOwogICAg
IGNsb3NlKGZkKTsKICAgICBtdW5tYXAocGEsIGxlbik7CiAgICAgZXhpdChQVFNfUEFTUyk7Cg==
--0015175caade2ef6e1046e1a1e33
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--0015175caade2ef6e1046e1a1e33
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--0015175caade2ef6e1046e1a1e33--

