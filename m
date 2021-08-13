From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 13 Aug 2021 14:45:54 +0200
Subject: [LTP] [PATCH] [v4,
 5/6] syscalls/sysfs: Convert sysfs05 to the new API
In-Reply-To: <20210813033507.18781-1-sujiaxun@uniontech.com>
References: <20210813033507.18781-1-sujiaxun@uniontech.com>
Message-ID: <YRZpgsgh2N2csZ9s@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks.

The main change is that we do pass a valid buffer for the cases where
option != 1. That is because the order of checks in kernel is not
guaranteed. So if we pass bad_address as well as invalid index the
kernel can return either one of EINVAL or EFAULT. If we want to get
specific error we have to make sure that all parameters but one are
correct.

Also while strictly not an error LKML coding style prefers curly braces
around multiline blocks even if they are a single function.

Full diff:

diff --git a/testcases/kernel/syscalls/sysfs/sysfs05.c b/testcases/kernel/syscalls/sysfs/sysfs05.c
index 3586453cf..bfcead7db 100644
--- a/testcases/kernel/syscalls/sysfs/sysfs05.c
+++ b/testcases/kernel/syscalls/sysfs/sysfs05.c
@@ -5,6 +5,7 @@
 
 /*\
  * [Description]
+ *
  * This test case checks whether sysfs(2) system call returns appropriate
  * error number for invalid option and for invalid filesystem name and fs index out of bounds.
  */
@@ -12,8 +13,6 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-static char *bad_addr;
-
 static struct test_case {
 	int option;
 	char *fsname;
@@ -22,27 +21,29 @@ static struct test_case {
 	int exp_errno;
 } tcases[] = {
 	{1, "ext0", 0, "Invalid filesystem name", EINVAL},
-	{4, "ext4", 0, "Invalid option", EINVAL},
-	{1, (char *)-1, 0, "Address is out of your address space", EFAULT},
+	{4, NULL, 0, "Invalid option", EINVAL},
+	{1, NULL, 0, "Address is out of your address space", EFAULT},
 	{2, NULL, 1000, "fs_index is out of bounds", EINVAL}
 };
 
 static void verify_sysfs05(unsigned int nr)
 {
 	struct test_case *tc = &tcases[nr];
+	char buf[1024];
 
-	if (tc->option == 1)
+	if (tc->option == 1) {
 		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tc->option, tc->fsname),
 					tc->exp_errno, "%s", tc->err_desc);
-	else
-		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tc->option, tc->fsindex, bad_addr),
+	} else {
+		TST_EXP_FAIL(tst_syscall(__NR_sysfs, tc->option, tc->fsindex, buf),
 					tc->exp_errno, "%s", tc->err_desc);
-
+	}
 }
 
 static void setup(void)
 {
 	unsigned int i;
+	char *bad_addr;
 
 	bad_addr = tst_get_bad_addr(NULL);
 

-- 
Cyril Hrubis
chrubis@suse.cz
