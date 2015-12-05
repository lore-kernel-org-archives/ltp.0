From: Yury Norov <ynorov@caviumnetworks.com>
Date: Sun, 6 Dec 2015 01:28:22 +0300
Subject: [LTP] [PATCH] set_thread_area01: fix build issue
Message-ID: <1449354502-15020-1-git-send-email-ynorov@caviumnetworks.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

get_thread_area() and set_thread_area() system calls are not supported
on a set of targets. Corresponding syscall numbers are not defined, and
in LTP they become defined as '-1' in <linux_syscall_numbers.h> header.

This test uses switch-case for its own purposes with _NR_get_thread_area
and __NR_set_thread_area as case selections. It causes compile-time
error, at least for ARM target.

In this patch, the test code is refactored to remove switch-case, and
repair test build.

By the way, warning about comparsion of signed and unsigned fixed too.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 .../syscalls/set_thread_area/set_thread_area01.c   | 39 +++++++++-------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
index 511543c..11b76d1 100644
--- a/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
+++ b/testcases/kernel/syscalls/set_thread_area/set_thread_area01.c
@@ -21,6 +21,9 @@
 
 #include "set_thread_area.h"
 
+#define SET_THREAD_AREA	"set_thread_area()"
+#define GET_THREAD_AREA	"get_thread_area()"
+
 char *TCID = "set_thread_area_01";
 int TST_TOTAL = 6;
 
@@ -37,6 +40,7 @@ static void setup(void)
 
 struct test {
 	int syscall;
+	const char *const syscall_name;
 	thread_area_s *u_info;
 	int exp_ret;
 	int exp_errno;
@@ -52,31 +56,18 @@ static struct user_desc u_info1 = {.entry_number = -1 };
 static struct user_desc u_info2 = {.entry_number = -2 };
 
 static struct test tests[] = {
-	{__NR_set_thread_area, &u_info1, 0, 0},
-	{__NR_get_thread_area, &u_info1, 0, 0},
-	{__NR_set_thread_area, &u_info2, -1, EINVAL},
-	{__NR_get_thread_area, &u_info2, -1, EINVAL},
-	{__NR_set_thread_area, (void *)-9, -1, EFAULT},
-	{__NR_get_thread_area, (void *)-9, -1, EFAULT},
+	{__NR_set_thread_area, SET_THREAD_AREA, &u_info1, 0, 0},
+	{__NR_get_thread_area, GET_THREAD_AREA, &u_info1, 0, 0},
+	{__NR_set_thread_area, SET_THREAD_AREA, &u_info2, -1, EINVAL},
+	{__NR_get_thread_area, GET_THREAD_AREA, &u_info2, -1, EINVAL},
+	{__NR_set_thread_area, SET_THREAD_AREA, (void *)-9, -1, EFAULT},
+	{__NR_get_thread_area, GET_THREAD_AREA, (void *)-9, -1, EFAULT},
 };
 
-static const char *get_name(int syscall)
-{
-	switch (syscall) {
-	case __NR_set_thread_area:
-		return "set_thread_area()";
-		break;
-	case __NR_get_thread_area:
-		return "get_thread_area()";
-		break;
-	default:
-		return "invalid syscall";
-	}
-}
-
 int main(int argc, char *argv[])
 {
-	int lc, i;
+	int lc;
+	unsigned i;
 
 	tst_parse_opts(argc, argv, NULL, NULL);
 
@@ -88,7 +79,7 @@ int main(int argc, char *argv[])
 
 			if (TEST_RETURN != tests[i].exp_ret) {
 				tst_resm(TFAIL, "%s returned %li expected %i",
-					 get_name(tests[i].syscall),
+					 tests[i].syscall_name,
 					 TEST_RETURN, tests[i].exp_ret);
 				continue;
 			}
@@ -96,7 +87,7 @@ int main(int argc, char *argv[])
 			if (TEST_ERRNO != tests[i].exp_errno) {
 				tst_resm(TFAIL,
 					 "%s failed with %i (%s) expected %i (%s)",
-					 get_name(tests[i].syscall), TEST_ERRNO,
+					 tests[i].syscall_name, TEST_ERRNO,
 					 strerror(TEST_ERRNO),
 					 tests[i].exp_errno,
 					 strerror(tests[i].exp_errno));
@@ -104,7 +95,7 @@ int main(int argc, char *argv[])
 			}
 
 			tst_resm(TPASS, "%s returned %li errno %i (%s)",
-				 get_name(tests[i].syscall), TEST_RETURN,
+				 tests[i].syscall_name, TEST_RETURN,
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 		}
 	}
-- 
2.5.0

