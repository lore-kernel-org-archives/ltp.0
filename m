Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZJeA3-0004Bp-Pw
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 08:53:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJeA2-0006ph-DM
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 08:53:27 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 4A4FF91D06
	for <ltp-list@lists.sourceforge.net>;
	Mon, 27 Jul 2015 08:53:20 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
Date: Mon, 27 Jul 2015 16:53:12 +0800
Message-Id: <1437987192-7436-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [Patch v2] syscalls/sysfs: replace syscall() macro by
	ltp_syscall()
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

v1 ---> v2
	a. remove the __NR_sysfs macro defined
	b. replace syscall() with ltp_syscall()

Signed-off-by: Li Wang <liwang@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/sysfs/sysfs01.c | 11 +++--------
 testcases/kernel/syscalls/sysfs/sysfs02.c | 11 +++--------
 testcases/kernel/syscalls/sysfs/sysfs03.c | 11 +++--------
 testcases/kernel/syscalls/sysfs/sysfs04.c |  9 ++-------
 testcases/kernel/syscalls/sysfs/sysfs05.c |  9 ++-------
 testcases/kernel/syscalls/sysfs/sysfs06.c |  9 ++-------
 6 files changed, 15 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/syscalls/sysfs/sysfs01.c b/testcases/kernel/syscalls/sysfs/sysfs01.c
index 11ebe43..582918a 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs01.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs01.c
@@ -66,10 +66,11 @@
  *Kernel should be compiled with proc filesystem support
  ******************************************************************************/
 
-#include "test.h"
 #include <errno.h>
 #include <unistd.h>
 #include <syscall.h>
+#include "test.h"
+#include "linux_syscall_numbers.h"
 
 static void setup();
 static void cleanup();
@@ -85,14 +86,12 @@ int main(int ac, char **av)
 
 	setup();
 
-#ifdef __NR_sysfs
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
 		/* option 1, buf holds fs name */
-		TEST(syscall(__NR_sysfs, 1, "proc"));
+		TEST(ltp_syscall(__NR_sysfs, 1, "proc"));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -102,10 +101,6 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "sysfs(2) Passed for " "option 1");
 		}
 	}			/*End of TEST_LOOPING */
-#else
-	tst_resm(TWARN,
-		 "This test can only run on kernels that support the sysfs system call");
-#endif
 
 	/*Clean up and exit */
 	cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs02.c b/testcases/kernel/syscalls/sysfs/sysfs02.c
index f7cb96a..d7e8923 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs02.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs02.c
@@ -64,10 +64,11 @@
  *There is no glibc or libc support
  *****************************************************************************/
 
-#include "test.h"
 #include <errno.h>
 #include <unistd.h>
 #include <syscall.h>
+#include "test.h"
+#include "linux_syscall_numbers.h"
 
 static void setup();
 static void cleanup();
@@ -84,14 +85,12 @@ int main(int ac, char **av)
 
 	setup();
 
-#ifdef __NR_sysfs
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
 		/*option 2 buf holds fs name */
-		TEST(syscall(__NR_sysfs, 2, 0, buf));
+		TEST(ltp_syscall(__NR_sysfs, 2, 0, buf));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -102,10 +101,6 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "sysfs(2) Passed for option 2");
 		}
 	}			/*End of TEST_LOOPING */
-#else
-	tst_resm(TWARN,
-		 "This test can only run on kernels that support the sysfs system call");
-#endif
 
 	/*Clean up and exit */
 	cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs03.c b/testcases/kernel/syscalls/sysfs/sysfs03.c
index 59b997e..51fdc92 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs03.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs03.c
@@ -64,10 +64,11 @@
  *There is no glibc or libc support
  *****************************************************************************/
 
-#include "test.h"
 #include <errno.h>
 #include <unistd.h>
 #include <syscall.h>
+#include "test.h"
+#include "linux_syscall_numbers.h"
 
 static void setup();
 static void cleanup();
@@ -83,13 +84,11 @@ int main(int ac, char **av)
 
 	setup();
 
-#ifdef __NR_sysfs
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
 
-		TEST(syscall(__NR_sysfs, 3));
+		TEST(ltp_syscall(__NR_sysfs, 3));
 
 		/* check return code */
 		if (TEST_RETURN == -1) {
@@ -100,10 +99,6 @@ int main(int ac, char **av)
 			tst_resm(TPASS, "sysfs(2) Passed for option 3");
 		}
 	}			/*End of TEST_LOOPING */
-#else
-	tst_resm(TWARN,
-		 "This test can only run on kernels that support the sysfs system call");
-#endif
 
 	/*Clean up and exit */
 	cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs04.c b/testcases/kernel/syscalls/sysfs/sysfs04.c
index f4fda36..6f596e1 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs04.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs04.c
@@ -71,6 +71,7 @@
 #include <errno.h>
 #include  <syscall.h>
 #include "test.h"
+#include "linux_syscall_numbers.h"
 
 #define INVALID_OPTION 100
 static void setup();
@@ -87,12 +88,10 @@ int main(int ac, char **av)
 
 	setup();
 
-#ifdef __NR_sysfs
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		tst_count = 0;
-		TEST(syscall(__NR_sysfs, INVALID_OPTION));
+		TEST(ltp_syscall(__NR_sysfs, INVALID_OPTION));
 
 		/* check return code */
 		if ((TEST_RETURN == -1) && (TEST_ERRNO == EINVAL)) {
@@ -104,10 +103,6 @@ int main(int ac, char **av)
 				 " : EINVAL and got %d", EINVAL, TEST_ERRNO);
 		}
 	}
-#else
-	tst_resm(TWARN,
-		 "This test can only run on kernels that support the sysfs system call");
-#endif
 
 	/*Clean up and exit */
 	cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c b/testcases/kernel/syscalls/sysfs/sysfs05.c
index e97f0c8..749efe7 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs05.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
@@ -72,6 +72,7 @@
 #include <errno.h>
 #include <syscall.h>
 #include "test.h"
+#include "linux_syscall_numbers.h"
 
 static void setup();
 static void cleanup();
@@ -101,14 +102,12 @@ int main(int ac, char **av)
 
 	setup();
 
-#ifdef __NR_sysfs
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
 			tst_count = 0;
-			TEST(syscall(__NR_sysfs, option[i], fsname[i]));
+			TEST(ltp_syscall(__NR_sysfs, option[i], fsname[i]));
 
 			/* check return code */
 			if ((TEST_RETURN == -1)
@@ -128,10 +127,6 @@ int main(int ac, char **av)
 
 		}		/*End of TEST LOOPS */
 	}
-#else
-	tst_resm(TWARN,
-		 "This test can only run on kernels that support the sysfs system call");
-#endif
 
 	/*Clean up and exit */
 	cleanup();
diff --git a/testcases/kernel/syscalls/sysfs/sysfs06.c b/testcases/kernel/syscalls/sysfs/sysfs06.c
index 121e944..a282d93 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs06.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs06.c
@@ -73,6 +73,7 @@
 #include <syscall.h>
 #include <sys/mman.h>
 #include "test.h"
+#include "linux_syscall_numbers.h"
 
 static void setup();
 static void cleanup();
@@ -104,14 +105,12 @@ int main(int ac, char **av)
 
 	setup();
 
-#ifdef __NR_sysfs
-
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
 		for (i = 0; i < TST_TOTAL; i++) {
 
 			tst_count = 0;
-			TEST(syscall
+			TEST(ltp_syscall
 			     (__NR_sysfs, option[i], fsindex[i], bad_addr));
 
 			/* check return code */
@@ -131,10 +130,6 @@ int main(int ac, char **av)
 			}
 		}		/*End of TEST LOOPS */
 	}
-#else
-	tst_resm(TWARN,
-		 "This test can only run on kernels that support the sysfs system call");
-#endif
 
 	/*Clean up and exit */
 	cleanup();
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
