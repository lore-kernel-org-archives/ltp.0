Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1Z86KC-0005gb-4r
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 12:32:12 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z86KA-0006jE-AC
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 12:32:12 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 429D82EBD03
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Jun 2015 12:32:04 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t5PCW22F010841
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2015 08:32:03 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 25 Jun 2015 14:32:01 +0200
Message-Id: <53635abf85856cffa2799ea43f942a619faec342.1435235333.git.jstancek@redhat.com>
Subject: [LTP] [PATCH v2] getrandom: fix compilation with older kernels
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

Add lapi/getrandom.h as fallback for GRND_* defines
Add getrandom to syscalls number list for common architectures
Replace syscall with ltp_syscall

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 include/lapi/getrandom.h                          | 37 +++++++++++++++++++++++
 testcases/kernel/include/arm.in                   |  1 +
 testcases/kernel/include/i386.in                  |  1 +
 testcases/kernel/include/ia64.in                  |  1 +
 testcases/kernel/include/linux_syscall_numbers.h  | 27 +++++++++++++++++
 testcases/kernel/include/powerpc.in               |  1 +
 testcases/kernel/include/powerpc64.in             |  1 +
 testcases/kernel/include/regen.sh                 |  2 +-
 testcases/kernel/include/s390.in                  |  1 +
 testcases/kernel/include/s390x.in                 |  1 +
 testcases/kernel/include/x86_64.in                |  1 +
 testcases/kernel/syscalls/getrandom/getrandom01.c | 22 ++++++--------
 testcases/kernel/syscalls/getrandom/getrandom02.c | 18 +++++------
 testcases/kernel/syscalls/getrandom/getrandom03.c | 11 ++-----
 testcases/kernel/syscalls/getrandom/getrandom04.c | 11 ++-----
 15 files changed, 95 insertions(+), 41 deletions(-)
 create mode 100644 include/lapi/getrandom.h

diff --git a/include/lapi/getrandom.h b/include/lapi/getrandom.h
new file mode 100644
index 0000000..0b3686c
--- /dev/null
+++ b/include/lapi/getrandom.h
@@ -0,0 +1,37 @@
+/*
+ * Copyright (c) 2015 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software Foundation,
+ * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifndef __GETRANDOM_H__
+#define __GETRANDOM_H__
+
+/*
+ * Flags for getrandom(2)
+ *
+ * GRND_NONBLOCK	Don't block and return EAGAIN instead
+ * GRND_RANDOM		Use the /dev/random pool instead of /dev/urandom
+ */
+
+#ifndef GRND_NONBLOCK
+ #define GRND_NONBLOCK	0x0001
+#endif
+
+#ifndef GRND_RANDOM
+ #define GRND_RANDOM	0x0002
+#endif
+
+#endif /* __GETRANDOM_H__ */
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
index d16cae5..818372e 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom01.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom01.c
@@ -26,15 +26,15 @@
  *
  */
 
-#include <sys/syscall.h>
-#include <errno.h>
 #include <linux/random.h>
+#include "lapi/getrandom.h"
+#include "linux_syscall_numbers.h"
 #include "test.h"
 
-static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
-						GRND_RANDOM | GRND_NONBLOCK};
-
 char *TCID = "getrandom01";
+static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
+		       GRND_RANDOM | GRND_NONBLOCK };
+
 int TST_TOTAL = ARRAY_SIZE(modes);
 
 int main(int ac, char **av)
@@ -48,17 +48,13 @@ int main(int ac, char **av)
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
diff --git a/testcases/kernel/syscalls/getrandom/getrandom02.c b/testcases/kernel/syscalls/getrandom/getrandom02.c
index b2ed06e..905917b 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom02.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom02.c
@@ -27,15 +27,15 @@
  *
  */
 
-#include <sys/syscall.h>
-#include <errno.h>
 #include <linux/random.h>
+#include "lapi/getrandom.h"
+#include "linux_syscall_numbers.h"
 #include "test.h"
 
-static int modes[] = {0, GRND_RANDOM, GRND_NONBLOCK,
-						GRND_RANDOM | GRND_NONBLOCK};
-
 char *TCID = "getrandom02";
+static int modes[] = { 0, GRND_RANDOM, GRND_NONBLOCK,
+		       GRND_RANDOM | GRND_NONBLOCK };
+
 int TST_TOTAL = ARRAY_SIZE(modes);
 
 static unsigned char buf[256];
@@ -57,15 +57,11 @@ int main(int ac, char **av)
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
diff --git a/testcases/kernel/syscalls/getrandom/getrandom03.c b/testcases/kernel/syscalls/getrandom/getrandom03.c
index 0a07c26..9c13d09 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom03.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom03.c
@@ -30,9 +30,9 @@
  *  number of bytes required and expects success.
  */
 
-#include <errno.h>
 #include <linux/random.h>
-#include <sys/syscall.h>
+#include "lapi/getrandom.h"
+#include "linux_syscall_numbers.h"
 #include "test.h"
 
 #define MAX_SIZE 256
@@ -53,12 +53,7 @@ int main(int ac, char **av)
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
index e049af8..4e099e1 100644
--- a/testcases/kernel/syscalls/getrandom/getrandom04.c
+++ b/testcases/kernel/syscalls/getrandom/getrandom04.c
@@ -30,13 +30,12 @@
  *  descriptors to 3 and expects success.
  */
 
-#include <sys/syscall.h>
-#include <errno.h>
 #include <linux/random.h>
 #include <sys/resource.h>
+#include "lapi/getrandom.h"
+#include "linux_syscall_numbers.h"
 #include "test.h"
 
-
 char *TCID = "getrandom04";
 int TST_TOTAL = 1;
 static char buf[128];
@@ -54,11 +53,7 @@ int main(int ac, char **av)
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
