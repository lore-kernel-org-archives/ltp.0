Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MF7Yb-00089n-SX
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 14:16:37 +0000
Received: from mail-yx0-f193.google.com ([209.85.210.193])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MF7YY-0007Bp-BX
	for ltp-list@lists.sourceforge.net; Fri, 12 Jun 2009 14:16:37 +0000
Received: by yxe31 with SMTP id 31so9965yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Fri, 12 Jun 2009 07:16:34 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 12 Jun 2009 19:16:14 +0530
Message-ID: <f5a7b3810906120646w6aff4e33wce787b684e91bee8@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Content-Type: multipart/mixed; boundary=001e680f14409e3239046c26ee7c
Subject: [LTP] [FIX PATCH] POSIX mlock/12-1.c and mlock/speculative/12-1.c
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
Cc: maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, rohit.170309@gmail.com, naresh.kernel@gmail.com

--001e680f14409e3239046c26ee7c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I have noticed failures under
testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c
and
testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c
and fixed as per man page
mlock()

EPERM:

(Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
and its RLIMIT_MEMLOCK soft resource limit was 0.

Please find the patch below and as attachment.

Best regards
Naresh Kamboju

Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c	2005-06-03
22:00:32.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/12-1.c	2009-06-12
17:18:00.000000000 +0530
@@ -8,7 +8,8 @@
  *  GNU General Public License for more details.
  *
  * Test that the mlock() function sets errno = EPERM if the calling process
- * does not have the appropriate privilege to perform the requested operation.
+ * does not have the appropriate privilege to perform the requested operation
+ * (Linux 2.6.9 and later) and its RLIMIT_MEMLOCK soft resource limit set to 0.
  */

 #define _XOPEN_SOURCE 600
@@ -21,6 +22,7 @@
 #include <sys/types.h>
 #include <pwd.h>
 #include <string.h>
+#include <sys/resource.h>
 #include "posixtest.h"

 #define BUFSIZE 8
@@ -29,6 +31,9 @@
 int set_nonroot()
 {
 	struct passwd *pw;
+        struct rlimit rlim;
+        int ret=0;
+
 	setpwent();
 	/* search for the first user which is non root */
 	while((pw = getpwent()) != NULL)
@@ -40,6 +45,18 @@
 		return 1;
 	}

+	/*
+	 * mlock()
+	 * EPERM:
+	 * (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
+	 * and its RLIMIT_MEMLOCK soft resource limit was 0.
+	 */
+
+        rlim.rlim_cur = 0;
+        rlim.rlim_max = 0;
+        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
+                printf("Failed at setrlimit() return %d \n", ret);
+
 	if(seteuid(pw->pw_uid) != 0) {
 		if(errno == EPERM) {
 			printf("You don't have permission to change your UID.\n");
diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c
b/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c
--- a/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c	2007-07-26
17:32:13.000000000 +0530
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mlock/speculative/12-1.c	2009-06-12
17:18:24.000000000 +0530
@@ -8,7 +8,8 @@
  *  GNU General Public License for more details.
  *
  * Test that the mlock() function sets errno = EPERM if the calling process
- * does not have the appropriate privilege to perform the requested operation.
+ * does not have the appropriate privilege to perform the requested operation
+ * (Linux 2.6.9 and later) and its RLIMIT_MEMLOCK soft resource limit set to 0.
  */

 #define _XOPEN_SOURCE 600
@@ -21,6 +22,7 @@
 #include <sys/types.h>
 #include <pwd.h>
 #include <string.h>
+#include <sys/resource.h>
 #include "posixtest.h"

 #define BUFSIZE 8
@@ -29,6 +31,9 @@
 int set_nonroot()
 {
 	struct passwd *pw;
+        struct rlimit rlim;
+        int ret=0;
+
 	setpwent();
 	/* search for the first user which is non root */
 	while((pw = getpwent()) != NULL)
@@ -40,6 +45,18 @@
 		return 1;
 	}

+	/*
+	 * mlock()
+	 * EPERM:
+	 * (Linux 2.6.9 and later) the caller was not privileged (CAP_IPC_LOCK)
+	 * and its RLIMIT_MEMLOCK soft resource limit was 0.
+	 */
+
+        rlim.rlim_cur = 0;
+        rlim.rlim_max = 0;
+        if ((ret = setrlimit(RLIMIT_MEMLOCK,&rlim)) != 0)
+                printf("Failed at setrlimit() return %d \n", ret);
+
 	if(seteuid(pw->pw_uid) != 0) {
 		if(errno == EPERM) {
 			printf("You don't have permission to change your UID.\n");

--001e680f14409e3239046c26ee7c
Content-Type: application/octet-stream; name="ltp-posix-mlock_12-1.patch"
Content-Disposition: attachment; filename="ltp-posix-mlock_12-1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fvuy778z0

ZGlmZiAtTmF1cmIgYS90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUvY29uZm9ybWFuY2Uv
aW50ZXJmYWNlcy9tbG9jay8xMi0xLmMgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3VpdGUv
Y29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tbG9jay8xMi0xLmMKLS0tIGEvdGVzdGNhc2VzL29wZW5f
cG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbWxvY2svMTItMS5jCTIwMDUt
MDYtMDMgMjI6MDA6MzIuMDAwMDAwMDAwICswNTMwCisrKyBiL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZS9jb25mb3JtYW5jZS9pbnRlcmZhY2VzL21sb2NrLzEyLTEuYwkyMDA5LTA2LTEy
IDE3OjE4OjAwLjAwMDAwMDAwMCArMDUzMApAQCAtOCw3ICs4LDggQEAKICAqICBHTlUgR2VuZXJh
bCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLgogICoKICAqIFRlc3QgdGhhdCB0aGUg
bWxvY2soKSBmdW5jdGlvbiBzZXRzIGVycm5vID0gRVBFUk0gaWYgdGhlIGNhbGxpbmcgcHJvY2Vz
cwotICogZG9lcyBub3QgaGF2ZSB0aGUgYXBwcm9wcmlhdGUgcHJpdmlsZWdlIHRvIHBlcmZvcm0g
dGhlIHJlcXVlc3RlZCBvcGVyYXRpb24uCisgKiBkb2VzIG5vdCBoYXZlIHRoZSBhcHByb3ByaWF0
ZSBwcml2aWxlZ2UgdG8gcGVyZm9ybSB0aGUgcmVxdWVzdGVkIG9wZXJhdGlvbgorICogKExpbnV4
IDIuNi45IGFuZCBsYXRlcikgYW5kIGl0cyBSTElNSVRfTUVNTE9DSyBzb2Z0IHJlc291cmNlIGxp
bWl0IHNldCB0byAwLgogICovCiAKICNkZWZpbmUgX1hPUEVOX1NPVVJDRSA2MDAKQEAgLTIxLDYg
KzIyLDcgQEAKICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KICNpbmNsdWRlIDxwd2QuaD4KICNpbmNs
dWRlIDxzdHJpbmcuaD4KKyNpbmNsdWRlIDxzeXMvcmVzb3VyY2UuaD4KICNpbmNsdWRlICJwb3Np
eHRlc3QuaCIKIAogI2RlZmluZSBCVUZTSVpFIDgKQEAgLTI5LDYgKzMxLDkgQEAKIGludCBzZXRf
bm9ucm9vdCgpCiB7CiAJc3RydWN0IHBhc3N3ZCAqcHc7CisgICAgICAgIHN0cnVjdCBybGltaXQg
cmxpbTsKKyAgICAgICAgaW50IHJldD0wOworCiAJc2V0cHdlbnQoKTsKIAkvKiBzZWFyY2ggZm9y
IHRoZSBmaXJzdCB1c2VyIHdoaWNoIGlzIG5vbiByb290ICovIAogCXdoaWxlKChwdyA9IGdldHB3
ZW50KCkpICE9IE5VTEwpCkBAIC00MCw2ICs0NSwxOCBAQAogCQlyZXR1cm4gMTsKIAl9CiAKKwkv
KgorCSAqIG1sb2NrKCkKKwkgKiBFUEVSTToKKwkgKiAoTGludXggMi42LjkgYW5kIGxhdGVyKSB0
aGUgY2FsbGVyIHdhcyBub3QgcHJpdmlsZWdlZCAoQ0FQX0lQQ19MT0NLKQorCSAqIGFuZCBpdHMg
UkxJTUlUX01FTUxPQ0sgc29mdCByZXNvdXJjZSBsaW1pdCB3YXMgMC4KKwkgKi8KKworICAgICAg
ICBybGltLnJsaW1fY3VyID0gMDsKKyAgICAgICAgcmxpbS5ybGltX21heCA9IDA7CisgICAgICAg
IGlmICgocmV0ID0gc2V0cmxpbWl0KFJMSU1JVF9NRU1MT0NLLCZybGltKSkgIT0gMCkKKyAgICAg
ICAgICAgICAgICBwcmludGYoIkZhaWxlZCBhdCBzZXRybGltaXQoKSByZXR1cm4gJWQgXG4iLCBy
ZXQpOworCiAJaWYoc2V0ZXVpZChwdy0+cHdfdWlkKSAhPSAwKSB7CiAJCWlmKGVycm5vID09IEVQ
RVJNKSB7CiAJCQlwcmludGYoIllvdSBkb24ndCBoYXZlIHBlcm1pc3Npb24gdG8gY2hhbmdlIHlv
dXIgVUlELlxuIik7CmRpZmYgLU5hdXJiIGEvdGVzdGNhc2VzL29wZW5fcG9zaXhfdGVzdHN1aXRl
L2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbWxvY2svc3BlY3VsYXRpdmUvMTItMS5jIGIvdGVzdGNh
c2VzL29wZW5fcG9zaXhfdGVzdHN1aXRlL2NvbmZvcm1hbmNlL2ludGVyZmFjZXMvbWxvY2svc3Bl
Y3VsYXRpdmUvMTItMS5jCi0tLSBhL3Rlc3RjYXNlcy9vcGVuX3Bvc2l4X3Rlc3RzdWl0ZS9jb25m
b3JtYW5jZS9pbnRlcmZhY2VzL21sb2NrL3NwZWN1bGF0aXZlLzEyLTEuYwkyMDA3LTA3LTI2IDE3
OjMyOjEzLjAwMDAwMDAwMCArMDUzMAorKysgYi90ZXN0Y2FzZXMvb3Blbl9wb3NpeF90ZXN0c3Vp
dGUvY29uZm9ybWFuY2UvaW50ZXJmYWNlcy9tbG9jay9zcGVjdWxhdGl2ZS8xMi0xLmMJMjAwOS0w
Ni0xMiAxNzoxODoyNC4wMDAwMDAwMDAgKzA1MzAKQEAgLTgsNyArOCw4IEBACiAgKiAgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0YWlscy4KICAqCiAgKiBUZXN0IHRoYXQg
dGhlIG1sb2NrKCkgZnVuY3Rpb24gc2V0cyBlcnJubyA9IEVQRVJNIGlmIHRoZSBjYWxsaW5nIHBy
b2Nlc3MKLSAqIGRvZXMgbm90IGhhdmUgdGhlIGFwcHJvcHJpYXRlIHByaXZpbGVnZSB0byBwZXJm
b3JtIHRoZSByZXF1ZXN0ZWQgb3BlcmF0aW9uLgorICogZG9lcyBub3QgaGF2ZSB0aGUgYXBwcm9w
cmlhdGUgcHJpdmlsZWdlIHRvIHBlcmZvcm0gdGhlIHJlcXVlc3RlZCBvcGVyYXRpb24KKyAqIChM
aW51eCAyLjYuOSBhbmQgbGF0ZXIpIGFuZCBpdHMgUkxJTUlUX01FTUxPQ0sgc29mdCByZXNvdXJj
ZSBsaW1pdCBzZXQgdG8gMC4KICAqLwogCiAjZGVmaW5lIF9YT1BFTl9TT1VSQ0UgNjAwCkBAIC0y
MSw2ICsyMiw3IEBACiAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+CiAjaW5jbHVkZSA8cHdkLmg+CiAj
aW5jbHVkZSA8c3RyaW5nLmg+CisjaW5jbHVkZSA8c3lzL3Jlc291cmNlLmg+CiAjaW5jbHVkZSAi
cG9zaXh0ZXN0LmgiCiAKICNkZWZpbmUgQlVGU0laRSA4CkBAIC0yOSw2ICszMSw5IEBACiBpbnQg
c2V0X25vbnJvb3QoKQogewogCXN0cnVjdCBwYXNzd2QgKnB3OworICAgICAgICBzdHJ1Y3Qgcmxp
bWl0IHJsaW07CisgICAgICAgIGludCByZXQ9MDsKKwogCXNldHB3ZW50KCk7CiAJLyogc2VhcmNo
IGZvciB0aGUgZmlyc3QgdXNlciB3aGljaCBpcyBub24gcm9vdCAqLyAKIAl3aGlsZSgocHcgPSBn
ZXRwd2VudCgpKSAhPSBOVUxMKQpAQCAtNDAsNiArNDUsMTggQEAKIAkJcmV0dXJuIDE7CiAJfQog
CisJLyoKKwkgKiBtbG9jaygpCisJICogRVBFUk06CisJICogKExpbnV4IDIuNi45IGFuZCBsYXRl
cikgdGhlIGNhbGxlciB3YXMgbm90IHByaXZpbGVnZWQgKENBUF9JUENfTE9DSykKKwkgKiBhbmQg
aXRzIFJMSU1JVF9NRU1MT0NLIHNvZnQgcmVzb3VyY2UgbGltaXQgd2FzIDAuCisJICovCisKKyAg
ICAgICAgcmxpbS5ybGltX2N1ciA9IDA7CisgICAgICAgIHJsaW0ucmxpbV9tYXggPSAwOworICAg
ICAgICBpZiAoKHJldCA9IHNldHJsaW1pdChSTElNSVRfTUVNTE9DSywmcmxpbSkpICE9IDApCisg
ICAgICAgICAgICAgICAgcHJpbnRmKCJGYWlsZWQgYXQgc2V0cmxpbWl0KCkgcmV0dXJuICVkIFxu
IiwgcmV0KTsKKwogCWlmKHNldGV1aWQocHctPnB3X3VpZCkgIT0gMCkgewogCQlpZihlcnJubyA9
PSBFUEVSTSkgewogCQkJcHJpbnRmKCJZb3UgZG9uJ3QgaGF2ZSBwZXJtaXNzaW9uIHRvIGNoYW5n
ZSB5b3VyIFVJRC5cbiIpOwo=
--001e680f14409e3239046c26ee7c
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
--001e680f14409e3239046c26ee7c
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001e680f14409e3239046c26ee7c--

