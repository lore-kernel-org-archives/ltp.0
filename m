From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:43 +0200
Subject: [LTP] [COMMITTED] [PATCH 10/40] Make use of SAFE_SETUID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c          | 3 +--
 testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c        | 3 +--
 testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c        | 3 +--
 testcases/kernel/syscalls/chmod/chmod03.c                     | 4 +---
 testcases/kernel/syscalls/chroot/chroot04.c                   | 4 +---
 testcases/kernel/syscalls/cma/process_vm01.c                  | 4 +---
 testcases/kernel/syscalls/fstat/fstat05.c                     | 4 +---
 testcases/kernel/syscalls/get_robust_list/get_robust_list01.c | 4 ++--
 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c     | 4 +---
 testcases/kernel/syscalls/open/open08.c                       | 6 ++----
 testcases/kernel/syscalls/setregid/setregid02.c               | 6 +-----
 testcases/kernel/syscalls/setresgid/setresgid03.c             | 7 ++-----
 testcases/kernel/syscalls/setreuid/setreuid03.c               | 4 ++--
 testcases/kernel/syscalls/setreuid/setreuid06.c               | 5 ++---
 14 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
index f628710ae..960bec184 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c
@@ -66,8 +66,7 @@ static void verify_hugeshmat(void)
 
 	switch (pid = SAFE_FORK()) {
 	case 0:
-		if (setuid(ltp_uid) == -1)
-			tst_brk(TBROK | TERRNO, "setuid");
+		SAFE_SETUID(ltp_uid);
 
 		addr = shmat(shm_id_1, NULL, 0);
 		if (addr != (void *)-1) {
diff --git a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
index 19df79f48..f58946fa0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c
@@ -85,8 +85,7 @@ static void test_hugeshmctl(void)
 	switch (pid = SAFE_FORK()) {
 	case 0:
 		/* set the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1)
-			tst_brk(TBROK | TERRNO, "setuid");
+		SAFE_SETUID(ltp_uid);
 		do_child();
 		exit(0);
 	default:
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
index b8aee0774..22138e354 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c
@@ -52,8 +52,7 @@ static void test_hugeshmget(void)
 		tst_brk(TBROK | TERRNO, "fork");
 	case 0:
 		/* set the user ID of the child to the non root user */
-		if (setuid(ltp_uid) == -1)
-			tst_brk(TBROK | TERRNO, "setuid");
+		SAFE_SETUID(ltp_uid);
 		do_child();
 		exit(0);
 	default:
diff --git a/testcases/kernel/syscalls/chmod/chmod03.c b/testcases/kernel/syscalls/chmod/chmod03.c
index 1ea242396..f53e437e4 100644
--- a/testcases/kernel/syscalls/chmod/chmod03.c
+++ b/testcases/kernel/syscalls/chmod/chmod03.c
@@ -149,9 +149,7 @@ void setup(void)
 	ltpuser = getpwnam(nobody_uid);
 	if (ltpuser == NULL)
 		tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid(%u) failed",
-			 ltpuser->pw_uid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 
diff --git a/testcases/kernel/syscalls/chroot/chroot04.c b/testcases/kernel/syscalls/chroot/chroot04.c
index 4bbdcd231..69fd213c8 100644
--- a/testcases/kernel/syscalls/chroot/chroot04.c
+++ b/testcases/kernel/syscalls/chroot/chroot04.c
@@ -126,9 +126,7 @@ void setup(void)
 void cleanup(void)
 {
 	/* reset the process ID to the saved ID (root) */
-	if (setuid(0) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "setuid(0) failed");
-	}
+	SAFE_SETUID(NULL, 0);
 	if (rmdir(TEST_TMPDIR) != 0) {
 		tst_brkm(TFAIL | TERRNO, NULL, "rmdir(%s) failed", TEST_TMPDIR);
 	}
diff --git a/testcases/kernel/syscalls/cma/process_vm01.c b/testcases/kernel/syscalls/cma/process_vm01.c
index 8ae16c41d..16a27e5b0 100644
--- a/testcases/kernel/syscalls/cma/process_vm01.c
+++ b/testcases/kernel/syscalls/cma/process_vm01.c
@@ -349,9 +349,7 @@ static void cma_test_invalid_perm(void)
 		ltpuser = getpwnam(nobody_uid);
 		if (ltpuser == NULL)
 			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-		if (setuid(ltpuser->pw_uid) == -1)
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "setuid(%u) failed", ltpuser->pw_uid);
+		SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 		params = cma_alloc_sane_params();
 		params->pid = parent_pid;
diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
index 69f746c73..29c253f48 100644
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -206,9 +206,7 @@ void setup(void)
 		signal(siglist[i], &sighandler);
 
 	ltpuser = getpwnam(nobody_uid);
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid(%d) failed",
-			 ltpuser->pw_uid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
index 6aa776f6a..222dc6f2e 100644
--- a/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
+++ b/testcases/kernel/syscalls/get_robust_list/get_robust_list01.c
@@ -51,6 +51,7 @@
 #include <stdlib.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "get_robust_list01";
@@ -156,8 +157,7 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL | TTERRNO,
 				 "get_robust_list failed unexpectedly");
 
-		if (setuid(1) == -1)
-			tst_brkm(TBROK | TERRNO, cleanup, "setuid(1) failed");
+		SAFE_SETUID(cleanup, 1);
 
 		TEST(ltp_syscall(__NR_get_robust_list, 1,
 				      (struct robust_list_head *)&head,
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 591ff3365..c68f95d83 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -182,9 +182,7 @@ static void test_invalid_perm(void)
 		ltpuser = getpwnam(nobody_uid);
 		if (ltpuser == NULL)
 			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-		if (setuid(ltpuser->pw_uid) == -1)
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "setuid(%u) failed", ltpuser->pw_uid);
+		SAFE_SETUID(NULL, ltpuser->pw_uid);
 		TEST(ltp_syscall(__NR_migrate_pages, parent_pid,
 			     sane_max_node, sane_old_nodes, sane_new_nodes));
 		ret |= check_ret(-1);
diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 6580b0cff..742771eef 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -57,6 +57,7 @@
 #include <signal.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 static void setup(void);
 static void cleanup(void);
@@ -143,10 +144,7 @@ static void setup(void)
 	if (setgid(ltpuser->pw_gid) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "setgid(%d) failed",
 			 ltpuser->pw_gid);
-	} else if (setuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "setuid(%d) failed",
-			 ltpuser->pw_uid);
-	}
+	} else SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	tst_tmpdir();
 
diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 0eb3c408c..21d1c823a 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -137,11 +137,7 @@ static void setup(void)
 		tst_brkm(TBROK, NULL, "getpwnam(\"nobody\") failed");
 
 	SAFE_SETGID(NULL, ltpuser->pw_gid);
-	if (setuid(ltpuser->pw_uid) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "setuid failed to to set the effective uid to %d",
-			 ltpuser->pw_uid);
-	}
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	root = get_group_by_name("root");
 	ltpgroup = get_group_by_gid(ltpuser->pw_gid);
diff --git a/testcases/kernel/syscalls/setresgid/setresgid03.c b/testcases/kernel/syscalls/setresgid/setresgid03.c
index 199c1b127..b669feef7 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid03.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid03.c
@@ -80,6 +80,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define EXP_RET_VAL	-1
@@ -217,11 +218,7 @@ void setup(void)
 			 " setting real/effective/saved gid");
 	}
 	/* Set euid to nobody */
-	if (setuid(nobody.pw_uid) == -1) {
-		tst_brkm(TBROK, NULL, "setuid failed to "
-			 "to set the effective uid to nodody");
-
-	}
+	SAFE_SETUID(NULL, nobody.pw_uid);
 	/* Pause if that option was specified
 	 * TEST_PAUSE contains the code to fork the test with the -c option.
 	 */
diff --git a/testcases/kernel/syscalls/setreuid/setreuid03.c b/testcases/kernel/syscalls/setreuid/setreuid03.c
index b62098eb7..ecf30d6ec 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid03.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid03.c
@@ -28,6 +28,7 @@
 #include <stdlib.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define FAILED  1
@@ -169,8 +170,7 @@ static void setup(void)
 	bin = *(getpwnam("bin"));
 	UID16_CHECK(bin.pw_uid, setreuid, cleanup);
 
-	if (setuid(nobody.pw_uid) < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid() to nobody failed");
+	SAFE_SETUID(NULL, nobody.pw_uid);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/setreuid/setreuid06.c b/testcases/kernel/syscalls/setreuid/setreuid06.c
index 8dbeb2005..22acd996f 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid06.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid06.c
@@ -33,6 +33,7 @@
 #include <sys/stat.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define INVAL_USER		 (USHRT_MAX-2)
@@ -84,9 +85,7 @@ static void setup(void)
 	if (ltpuser == NULL)
 		tst_brkm(TBROK, NULL, "nobody must be a valid user.");
 
-	if (setuid(ltpuser->pw_uid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setuid failed to "
-			 "to set the effective uid to %d", ltpuser->pw_uid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	TEST_PAUSE;
 }
-- 
2.13.5

