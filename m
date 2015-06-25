Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z83Nl-0008Op-Af
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 09:23:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z83Nj-0006GH-28
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 09:23:41 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 3204EC1F75
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Jun 2015 09:23:33 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t5P9NV7P030367
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2015 05:23:32 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 25 Jun 2015 11:23:29 +0200
Message-Id: <94d1ed7d81ae24abe9ae8a8d4a8ef8b5e6e78f66.1435223906.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] getrandom: fix compilation with older kernels
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Add configure check for GRND_* defines
Add getrandom to syscalls number list for common architectures
Replace syscall with ltp_syscall

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 configure.ac                                      |  1 +
 m4/ltp-getrandom.m4                               | 25 +++++++++++++++++
 testcases/kernel/include/arm.in                   |  1 +
 testcases/kernel/include/i386.in                  |  1 +
 testcases/kernel/include/ia64.in                  |  1 +
 testcases/kernel/include/linux_syscall_numbers.h  | 27 ++++++++++++++++++
 testcases/kernel/include/powerpc.in               |  1 +
 testcases/kernel/include/powerpc64.in             |  1 +
 testcases/kernel/include/regen.sh                 |  2 +-
 testcases/kernel/include/s390.in                  |  1 +
 testcases/kernel/include/s390x.in                 |  1 +
 testcases/kernel/include/x86_64.in                |  1 +
 testcases/kernel/syscalls/getrandom/getrandom01.c | 34 +++++++++++++----------
 testcases/kernel/syscalls/getrandom/getrandom02.c | 30 ++++++++++++--------
 testcases/kernel/syscalls/getrandom/getrandom03.c | 11 ++------
 testcases/kernel/syscalls/getrandom/getrandom04.c | 13 ++-------
 16 files changed, 105 insertions(+), 46 deletions(-)
 create mode 100644 m4/ltp-getrandom.m4

diff --git a/configure.ac b/configure.ac
index 0ca21a6..a078a34 100644
--- a/configure.ac
+++ b/configure.ac
@@ -176,5 +176,6 @@ LTP_CHECK_TIMERFD
 LTP_CHECK_CAN_SUPPORT
 LTP_CHECK_IOVEC
 LTP_CHECK_KEYCTL
+LTP_CHECK_GETRANDOM_SUPPORT
 
 AC_OUTPUT
diff --git a/m4/ltp-getrandom.m4 b/m4/ltp-getrandom.m4
new file mode 100644
index 0000000..121820e
--- /dev/null
+++ b/m4/ltp-getrandom.m4
@@ -0,0 +1,25 @@
+dnl
+dnl Copyright (c) Linux Test Project, 2015
+dnl
+dnl This program is free software;  you can redistribute it and/or modify
+dnl it under the terms of the GNU General Public License as published by
+dnl the Free Software Foundation; either version 2 of the License, or
+dnl (at your option) any later version.
+dnl
+dnl This program is distributed in the hope that it will be useful,
+dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
+dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+dnl the GNU General Public License for more details.
+dnl
+
+dnl
+dnl LTP_CHECK_GETRANDOM_SUPPORT
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_GETRANDOM_SUPPORT],[
+AC_CHECK_HEADERS(linux/random.h,[
+	AC_CHECK_DECLS([GRND_NONBLOCK, GRND_RANDOM], [],[],[dnl
+#include <linux/random.h>
+#]) dnl AC_CHECK_DECLS
+])]
+)
diff --git a/testcases/kernel/include/arm.in b/testcases/kernel/include/arm.in
index a6d5a2c..841b064 100644
--- a/testcases/kernel/include/arm.in
+++ b/testcases/kernel/include/arm.in
@@ -333,3 +333,4 @@ accept4 (__NR_SYSCALL_BASE+366)
 fanotify_init (__NR_SYSCALL_BASE+367)
 fanotify_mark (__NR_SYSCALL_BASE+368)
 prlimit64 (__NR_SYSCALL_BASE+369)
+getrandom (__NR_SYSCALL_BASE+384)
diff --git a/testcases/kernel/include/i386.in b/testcases/kernel/include/i386.in
index 540d4a2..a4585c2 100644
--- a/testcases/kernel/include/i386.in
+++ b/testcases/kernel/include/i386.in
@@ -333,3 +333,4 @@ recvmmsg 337
 fanotify_init 338
 fanotify_mark 339
 prlimit64 340
+getrandom 355
diff --git a/testcases/kernel/include/ia64.in b/testcases/kernel/include/ia64.in
index 9ab1983..4f8fb74 100644
--- a/testcases/kernel/include/ia64.in
+++ b/testcases/kernel/include/ia64.in
@@ -292,3 +292,4 @@ recvmmsg 1322
 fanotify_init 1323
 fanotify_mark 1324
 prlimit64 1325
+getrandom 1339
diff --git a/testcases/kernel/include/linux_syscall_numbers.h b/testcases/kernel/include/linux_syscall_numbers.h
index 332cddd..e1ee38e 100644
--- a/testcases/kernel/include/linux_syscall_numbers.h
+++ b/testcases/kernel/include/linux_syscall_numbers.h
@@ -1810,6 +1810,9 @@
 # ifndef __NR_prlimit64
 #  define __NR_prlimit64 (__NR_SYSCALL_BASE+369)
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom (__NR_SYSCALL_BASE+384)
+# endif
 #endif
 
 
@@ -2874,6 +2877,9 @@
 # ifndef __NR_prlimit64
 #  define __NR_prlimit64 340
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 355
+# endif
 #endif
 
 
@@ -3760,6 +3766,9 @@
 # ifndef __NR_prlimit64
 #  define __NR_prlimit64 1325
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 1339
+# endif
 #endif
 
 
@@ -4790,6 +4799,9 @@
 # ifndef __NR_syscalls
 #  define __NR_syscalls 345
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 359
+# endif
 #endif
 
 
@@ -5820,6 +5832,9 @@
 # ifndef __NR_syscalls
 #  define __NR_syscalls 345
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 359
+# endif
 #endif
 
 
@@ -6802,6 +6817,9 @@
 # ifndef __NR_newfstatat
 #  define __NR_newfstatat 293
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 349
+# endif
 #endif
 
 
@@ -7784,6 +7802,9 @@
 # ifndef __NR_newfstatat
 #  define __NR_newfstatat 293
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 349
+# endif
 #endif
 
 
@@ -11721,6 +11742,9 @@
 # ifndef __NR_prlimit64
 #  define __NR_prlimit64 302
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom 318
+# endif
 #endif
 
 
@@ -12049,6 +12073,9 @@
 # ifndef __NR_getpriority
 #  define __NR_getpriority __LTP__NR_INVALID_SYSCALL
 # endif
+# ifndef __NR_getrandom
+#  define __NR_getrandom __LTP__NR_INVALID_SYSCALL
+# endif
 # ifndef __NR_getresgid
 #  define __NR_getresgid __LTP__NR_INVALID_SYSCALL
 # endif
diff --git a/testcases/kernel/include/powerpc.in b/testcases/kernel/include/powerpc.in
index 4824f83..4025436 100644
--- a/testcases/kernel/include/powerpc.in
+++ b/testcases/kernel/include/powerpc.in
@@ -340,3 +340,4 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+getrandom 359
diff --git a/testcases/kernel/include/powerpc64.in b/testcases/kernel/include/powerpc64.in
index 4824f83..4025436 100644
--- a/testcases/kernel/include/powerpc64.in
+++ b/testcases/kernel/include/powerpc64.in
@@ -340,3 +340,4 @@ recvmsg 342
 recvmmsg 343
 accept4 344
 syscalls 345
+getrandom 359
diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index c01bf1a..eebac0f 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -69,7 +69,7 @@ for arch in $(cat "${srcdir}/order") ; do
 		nr="__NR_$1"
 		shift
 		if [ $# -eq 0 ] ; then
-			err "invalid line found"
+			err "invalid line found: $line"
 		fi
 		cat <<-EOF
 		# ifndef ${nr}
diff --git a/testcases/kernel/include/s390.in b/testcases/kernel/include/s390.in
index 737a3ea..9c7cfa1 100644
--- a/testcases/kernel/include/s390.in
+++ b/testcases/kernel/include/s390.in
@@ -324,3 +324,4 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+getrandom 349
diff --git a/testcases/kernel/include/s390x.in b/testcases/kernel/include/s390x.in
index 737a3ea..9c7cfa1 100644
--- a/testcases/kernel/include/s390x.in
+++ b/testcases/kernel/include/s390x.in
@@ -324,3 +324,4 @@ setgid 214
 setfsuid 215
 setfsgid 216
 newfstatat 293
+getrandom 349
diff --git a/testcases/kernel/include/x86_64.in b/testcases/kernel/include/x86_64.in
index 0b27aed..860e726 100644
--- a/testcases/kernel/include/x86_64.in
+++ b/testcases/kernel/include/x86_64.in
@@ -300,3 +300,4 @@ recvmmsg 299
 fanotify_init 300
 fanotify_mark 301
 prlimit64 302
+getrandom 318
diff --git a/testcases/kernel/syscalls/getrandom/getrandom01.c b/testcases/kernel/syscalls/getrandom/getrandom01.c
index d16cae5..9eadc3d 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -26,15 +26,18 @@
  *
  */
 
-#include <sys/syscall.h>
-#include <errno.h>
-#include <linux/random.h>
 #include "test.h"
-
-static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
-						GRND_RANDOM | GRND_NONBLOCK};
+#include "config.h"
 
 char *TCID = "getrandom01";
+
+#if HAVE_DECL_GRND_NONBLOCK && HAVE_DECL_GRND_RANDOM
+#include <linux/random.h>
+#include "linux_syscall_numbers.h"
+
+static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
+		       GRND_RANDOM | GRND_NONBLOCK };
+
 int TST_TOTAL = ARRAY_SIZE(modes);
 
 int main(int ac, char **av)
@@ -48,18 +51,21 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
-			TEST(syscall(SYS_getrandom, NULL, 100, modes[i]));
-
-			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, NULL,
-						"This test needs kernel 3.17 or newer");
-
-			if (TEST_RETURN == -1)
+			TEST(ltp_syscall(__NR_getrandom, NULL, 100, modes[i]));
+			if (TEST_RETURN == -1) {
 				tst_resm(TPASS, "getrandom returned %ld",
 						TEST_RETURN);
-			else
+			} else {
 				tst_resm(TFAIL | TTERRNO, "getrandom failed");
+			}
 		}
 	}
 	tst_exit();
 }
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "GRND_NONBLOCK / GRND_RANDOM not defined");
+}
+#endif
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index b2ed06e..2250b46 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -27,15 +27,18 @@
  *
  */
 
-#include <sys/syscall.h>
-#include <errno.h>
-#include <linux/random.h>
 #include "test.h"
-
-static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
-						GRND_RANDOM | GRND_NONBLOCK};
+#include "config.h"
 
 char *TCID = "getrandom02";
+
+#if HAVE_DECL_GRND_NONBLOCK && HAVE_DECL_GRND_RANDOM
+#include <linux/random.h>
+#include "linux_syscall_numbers.h"
+
+static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
+		       GRND_RANDOM | GRND_NONBLOCK };
+
 int TST_TOTAL = ARRAY_SIZE(modes);
 
 static unsigned char buf[256];
@@ -57,15 +60,11 @@ int main(int ac, char **av)
 			fill();
 
 			do {
-					TEST(syscall(SYS_getrandom, buf, size,
-								modes[i]));
+				TEST(ltp_syscall(__NR_getrandom, buf, size,
+					modes[i]));
 			} while ((modes[i] & GRND_NONBLOCK) && TEST_RETURN == -1
 				&& TEST_ERRNO == EAGAIN);
 
-			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, NULL,
-					"This test needs kernel 3.17 at least");
-
 			if (!check_content(TEST_RETURN))
 				tst_resm(TFAIL | TTERRNO, "getrandom failed");
 			else
@@ -101,3 +100,10 @@ static int check_content(int nb)
 	}
 	return 1;
 }
+
+#else
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "GRND_NONBLOCK / GRND_RANDOM not defined");
+}
+#endif
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index 0a07c26..5a223b1 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -30,10 +30,8 @@
  *  number of bytes required and expects success.
  */
 
-#include <errno.h>
-#include <linux/random.h>
-#include <sys/syscall.h>
 #include "test.h"
+#include "linux_syscall_numbers.h"
 
 #define MAX_SIZE 256
 
@@ -53,12 +51,7 @@ int main(int ac, char **av)
 		tst_count = 0;
 		for (i = 0; i < TST_TOTAL; i++) {
 			size = random() % MAX_SIZE;
-			TEST(syscall(SYS_getrandom, buf, size, 0));
-
-			if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-				tst_brkm(TCONF, NULL,
-					"This test needs kernel 3.17 or newer");
-
+			TEST(ltp_syscall(__NR_getrandom, buf, size, 0));
 			if (TEST_RETURN != size)
 				tst_resm(TFAIL | TTERRNO, "getrandom failed");
 			else
diff --git a/testcases/kernel/syscalls/getrandom/getrandom04.c b/testcases/kernel/syscalls/getrandom/getrandom04.c
index e049af8..cbe05fe 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -30,12 +30,9 @@
  *  descriptors to 3 and expects success.
  */
 
-#include <sys/syscall.h>
-#include <errno.h>
-#include <linux/random.h>
-#include <sys/resource.h>
 #include "test.h"
-
+#include "linux_syscall_numbers.h"
+#include <sys/resource.h>
 
 char *TCID = "getrandom04";
 int TST_TOTAL = 1;
@@ -54,11 +51,7 @@ int main(int ac, char **av)
 	if (r == -1)
 		tst_brkm(TBROK | TTERRNO, NULL, "setrlimit failed");
 
-	TEST(syscall(SYS_getrandom, buf, 100, 0));
-	if (TEST_RETURN == -1 && TEST_ERRNO == ENOSYS)
-		tst_brkm(TCONF, NULL,
-			"This test needs kernel 3.17 or newer");
-
+	TEST(ltp_syscall(__NR_getrandom, buf, 100, 0));
 	if (TEST_RETURN == -1)
 		tst_resm(TFAIL | TTERRNO, "getrandom failed");
 	else
-- 
1.8.3.1


------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
