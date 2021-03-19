From: QI Fuli <fukuri.sai@gmail.com>
Date: Fri, 19 Mar 2021 20:59:34 +0900
Subject: [LTP] [PATCH] syscalls/swapon/swapon0{1..3}: remove checking if fs
 type is BTRFS
Message-ID: <20210319115934.1801692-1-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

remove redundant tasks as BTRFS is checked in is_swap_supported()
Fixes: caf453532("syscalls/swapon/swapon0{1..3}: use helpers to check
	support status")

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 testcases/kernel/syscalls/swapon/swapon01.c |  7 -------
 testcases/kernel/syscalls/swapon/swapon02.c |  5 -----
 testcases/kernel/syscalls/swapon/swapon03.c | 15 +--------------
 3 files changed, 1 insertion(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index f95ce0ab2..aff842e4c 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -32,18 +32,11 @@ static void cleanup(void);
 char *TCID = "swapon01";
 int TST_TOTAL = 1;

-static long fs_type;
-
 static void verify_swapon(void)
 {
 	TEST(ltp_syscall(__NR_swapon, "./swapfile01", 0));

 	if (TEST_RETURN == -1) {
-		if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
-			tst_brkm(TCONF, cleanup,
-			         "Swapfile on BTRFS not implemeted");
-			return;
-		}
 		tst_resm(TFAIL | TTERRNO, "Failed to turn on swapfile");
 	} else {
 		tst_resm(TPASS, "Succeeded to turn on swapfile");
diff --git a/testcases/kernel/syscalls/swapon/swapon02.c b/testcases/kernel/syscalls/swapon/swapon02.c
index 3d49d0c6b..653b1f33e 100644
--- a/testcases/kernel/syscalls/swapon/swapon02.c
+++ b/testcases/kernel/syscalls/swapon/swapon02.c
@@ -81,11 +81,6 @@ static void verify_swapon(struct test_case_t *test)
 		return;
 	}

-	if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL) {
-		tst_resm(TCONF, "Swapfile on BTRFS not implemeted");
-			return;
-	}
-
 	tst_resm(TFAIL, "swapon(2) failed to produce expected error:"
 	         " %d, errno: %s and got %d.", test->exp_errno,
 	         test->exp_errval, TEST_ERRNO);
diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index cef57150c..19455bfe6 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -52,8 +52,6 @@ int TST_TOTAL = 1;

 static int swapfiles;

-static long fs_type;
-
 int testfiles = 3;
 static struct swap_testfile_t {
 	char *filename;
@@ -215,9 +213,6 @@ static int setup_swap(void)
 			/* turn on the swap file */
 			res = ltp_syscall(__NR_swapon, filename, 0);
 			if (res != 0) {
-				if (fs_type == TST_BTRFS_MAGIC && errno == EINVAL)
-					exit(2);
-
 				if (errno == EPERM) {
 					printf("Successfully created %d "
 					       "swapfiles\n", j);
@@ -233,16 +228,8 @@ static int setup_swap(void)
 	} else
 		waitpid(pid, &status, 0);

-	switch (WEXITSTATUS(status)) {
-	case 0:
-	break;
-	case 2:
-		tst_brkm(TCONF, cleanup, "Swapfile on BTRFS not implemeted");
-	break;
-	default:
+	if (WEXITSTATUS(status) == 1)
 		tst_brkm(TFAIL, cleanup, "Failed to setup swaps");
-	break;
-	}

 	/* Create all needed extra swapfiles for testing */
 	for (j = 0; j < testfiles; j++)
--
2.29.2

