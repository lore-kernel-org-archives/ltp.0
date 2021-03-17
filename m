From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 17 Mar 2021 18:01:54 +0800
Subject: [LTP] [PATCH v2] cleanup: Unify the annotation style and remove
 Redundant code
Message-ID: <20210317100154.20389-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Change 'DESCRIPTION' to 'Description' and change 'ALGORITHM' to
'Algorithm', and remove Redundant tst_reap_children since
tst_reap_children has been called in the test skeleton.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2:
	1. Change 'DESCRIPTION' to 'Description'
	2. Change 'ALGORITHM' to 'Algorithm'
 testcases/kernel/containers/pidns/pidns13.c                   | 2 --
 testcases/kernel/device-drivers/rtc/rtc02.c                   | 4 ++--
 testcases/kernel/syscalls/abort/abort01.c                     | 4 ++--
 testcases/kernel/syscalls/accept/accept01.c                   | 2 +-
 testcases/kernel/syscalls/accept/accept02.c                   | 2 +-
 testcases/kernel/syscalls/brk/brk02.c                         | 2 +-
 testcases/kernel/syscalls/chdir/chdir04.c                     | 2 +-
 testcases/kernel/syscalls/close_range/close_range01.c         | 2 +-
 testcases/kernel/syscalls/close_range/close_range02.c         | 2 +-
 testcases/kernel/syscalls/dup/dup02.c                         | 4 ++--
 testcases/kernel/syscalls/dup/dup03.c                         | 4 ++--
 testcases/kernel/syscalls/finit_module/finit_module01.c       | 4 ++--
 testcases/kernel/syscalls/finit_module/finit_module02.c       | 4 ++--
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c     | 2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c     | 2 +-
 testcases/kernel/syscalls/getdents/getdents01.c               | 2 +-
 testcases/kernel/syscalls/getdents/getdents02.c               | 2 +-
 testcases/kernel/syscalls/getpid/getpid01.c                   | 2 +-
 testcases/kernel/syscalls/getpid/getpid02.c                   | 2 +-
 testcases/kernel/syscalls/init_module/init_module01.c         | 4 ++--
 testcases/kernel/syscalls/init_module/init_module02.c         | 4 ++--
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c               | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl02.c               | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl03.c               | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl04.c               | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl05.c               | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl07.c               | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl09.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl07.c               | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c               | 2 +-
 testcases/kernel/syscalls/mallinfo/mallinfo01.c               | 2 +-
 testcases/kernel/syscalls/mallinfo/mallinfo02.c               | 2 +-
 testcases/kernel/syscalls/mallopt/mallopt01.c                 | 2 +-
 testcases/kernel/syscalls/move_pages/move_pages12.c           | 2 +-
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at01.c   | 4 ++--
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at02.c   | 2 +-
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at01.c   | 4 ++--
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at02.c   | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace11.c                   | 2 +-
 testcases/kernel/syscalls/sched_getparam/sched_getparam01.c   | 2 +-
 testcases/kernel/syscalls/sched_getparam/sched_getparam03.c   | 2 +-
 testcases/kernel/syscalls/select/select04.c                   | 4 ++--
 testcases/kernel/syscalls/time/time01.c                       | 2 +-
 testcases/kernel/syscalls/times/times01.c                     | 2 +-
 testcases/kernel/syscalls/truncate/truncate02.c               | 2 +-
 testcases/kernel/syscalls/truncate/truncate03.c               | 2 +-
 testcases/kernel/syscalls/writev/writev03.c                   | 2 +-
 53 files changed, 63 insertions(+), 65 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 12aee917b..da62bc27c 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -116,8 +116,6 @@ static void run(void)

 	SAFE_CLOSE(pipe_fd[0]);
 	SAFE_CLOSE(pipe_fd[1]);
-
-	tst_reap_children();
 }

 static struct tst_test test = {
diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index 9d2141656..ef83aad89 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * RTC device set time function test.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *
  * - Save RTC time
  * - Set RTC time
diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index 242389783..aa9ca3a2d 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -8,11 +8,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Checks that process which called abort() gets killed by SIGIOT and dumps core.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *  - Fork child.
  *  - Child calls abort.
  *  - Parent checks return status.
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index d4a6bc396..52234b792 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -6,7 +6,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  * Verify that accept() returns the proper errno for various failure cases.
  */

diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 7f84d3b45..12a1e3ca3 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -4,7 +4,7 @@
  * Author: Christian Amann <camann@suse.com>
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for CVE-2017-8890
  *
diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
index 5493e4607..cd4cfd1be 100644
--- a/testcases/kernel/syscalls/brk/brk02.c
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  * Expand brk() by at least 2 pages to ensure there is a newly created VMA
  * and not expanding the original due to multiple anon pages.  mprotect() that
  * new VMA then brk() back to the original address therefore causing a munmap of
diff --git a/testcases/kernel/syscalls/chdir/chdir04.c b/testcases/kernel/syscalls/chdir/chdir04.c
index 31aa70981..cdbb29668 100644
--- a/testcases/kernel/syscalls/chdir/chdir04.c
+++ b/testcases/kernel/syscalls/chdir/chdir04.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Testcase to test whether chdir(2) sets errno correctly.
  */
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 912f56c56..5e2de4d1e 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -10,7 +10,7 @@
  * Copyright (c) 2021 SUSE LLC, other copyrights may apply.
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * We check that close_range()
  *
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index 90f8e5e0b..bd46936bb 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 SUSE LLC
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * - First check close_range works on a valid range.
  * - Then check close_range does not accept invalid paramters.
diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index 105e95afa..528bcdbc1 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -7,10 +7,10 @@
  *
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  * Negative test for dup(2) with bad fds.
  *
- * [ALGORITHM]
+ * [Algorithm]
  * Call dup(2) with invalid argument and make sure it returns -1 with errno set
  * to EBADF.
  */
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index 592246d06..caef078b2 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -5,10 +5,10 @@
  *
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  * Negative test for dup(2) (too many fds).
  *
- * [ALGORITHM]
+ * [Algorithm]
  * Open the maximum allowed number of file descriptors and then try to call
  * dup() once more and verify it fails with EMFILE.
  */
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index 489923ec4..9c34282e1 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic finit_module() tests.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *
  * Inserts a simple module after opening and mmaping the module file.
  */
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 2849fb2ec..9d9255c6d 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic finit_module() failure tests.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *
  * Tests various failure scenarios for finit_module().
  */
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 3a9bd5b8b..23f62091a 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -12,7 +12,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that get_mempolicy() returns a proper return value and errno for various cases.
  */
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
index b37030be7..4a855596d 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
@@ -12,7 +12,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that get_mempolicy() returns a proper return errno for failure cases.
  */
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index cfc3fa306..ef8f4e864 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -8,7 +8,7 @@

 /*\
  *
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic getdents() test that checks if directory listing is correct and
  * complete.
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index e43203304..ade1c9476 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -7,7 +7,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that:
  *
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 8ce97b76f..ec18b67d5 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that getpid() system call returns process ID in range 2 ... PID_MAX
  */
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index dbe7bc2ad..d826724f4 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Check that:
  * - fork() in parent returns the same pid as getpid() in child
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index d3096a00d..2f47eed32 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic init_module() tests.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *
  * Inserts a simple module after opening and mmaping the module file.
  */
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index be998e600..3953f4f61 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic init_module() failure tests.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *
  * Tests various failure scenarios for init_module().
  */
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index 90f2ccf74..722a0cca0 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -4,7 +4,7 @@
  * Author: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Call msgctl() with MSG_INFO flag and check that:
  *
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index 3dc09539a..3134dde57 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -5,7 +5,7 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for semctl() EACCES error.
  */
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index 051b86a85..ed2a46b16 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -6,7 +6,7 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for semctl() EINVAL and EFAULT errors
  */
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
index 0a88e93a6..015850a3b 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
@@ -6,7 +6,7 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for semctl() EPERM error
  *
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index 386b14bd8..69df08750 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -7,7 +7,7 @@
  *	03/2001 - Written by Wayne Boyer
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for semctl() ERANGE error
  */
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 39f10ed22..1b203ef5e 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -10,7 +10,7 @@
  *	  to conflict with other instances of the same test.
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic tests for semctl().
  *
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index 1a17803df..a933cff0e 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -4,7 +4,7 @@
  * Author: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Call semctl() with SEM_INFO flag and check that:
  *
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index 54a0ae990..b32752fb1 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -5,7 +5,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that shmctl() IPC_STAT and SHM_STAT reports correct data.
  *
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index df7aba835..9057b7f54 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -9,7 +9,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for EACCES, EFAULT and EINVAL errors.
  *
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index 86d981d19..0f700a9bd 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Call shmctl() with IPC_INFO flag and check that the data are consistent with
  * /proc/sys/kernel/shm*.
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 5453132b7..c70a76fb2 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Call shmctl() with SHM_INFO flag and check that:
  *
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index ec25f4eae..f8b76bda7 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Regression test for commit
  * 3f05317d9889 (ipc/shm: fix use-after-free of shm file via remap_file_pages()).
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
index b8dbc3bd1..92aaa38e2 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Cross verify the _high fields being set to 0 by the kernel.
  */
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
index 37c23441f..15af7b452 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for a SHM_LOCK and SHM_UNLOCK.
  */
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
index 071cf7b72..88fcfe41f 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test for a SHM_SET.
  *
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
index d6c47299b..48fce0132 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo01.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -5,7 +5,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic mallinfo() test. Refer to glibc test mallinfo2 test
  * https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo02.c b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
index 05539abe3..6012b4e22 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo02.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
@@ -5,7 +5,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic mallinfo() test for malloc() using sbrk or mmap.
  * It size > MMAP_THRESHOLD, it will use mmap. Otherwise, use sbrk.
diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index a47f65d2c..8ff4649e3 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -7,7 +7,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic mallinfo() and mallopt() testing.
  */
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 16d14779d..220130f4b 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -8,7 +8,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * *Test 1*
  *
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
index 7c91d1598..9677b0671 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic name_to_handle_at() tests.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *  - Check that EOVERFLOW is returned as expected by name_to_handle_at().
  *  - Check that we were able to access a file's stat with name_to_handle_at()
  *    and open_by_handle_at().
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
index 12ee31c2c..d60c8a0c1 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Failure tests for name_to_handle_at().
  */
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
index ae962fb62..76be720ca 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
@@ -4,11 +4,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Basic open_by_handle_at() tests.
  *
- * [ALGORITHM]
+ * [Algorithm]
  *
  * Check that we were able to access a file's stat which is opened with
  * open_by_handle_at().
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
index e66194df5..a505deeb1 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Failure tests for open_by_handle_at().
  */
diff --git a/testcases/kernel/syscalls/ptrace/ptrace11.c b/testcases/kernel/syscalls/ptrace/ptrace11.c
index 08a2246df..c54441671 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace11.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace11.c
@@ -5,7 +5,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Before kernel 2.6.26 we could not trace init(1) process and ptrace() would
  * fail with EPERM. This case just checks whether we can trace init(1) process
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index f638a6b83..efb697707 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that:
  *
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index f8723008f..9eb4ecc0c 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -4,7 +4,7 @@
  */

  /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that:
  *
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index cdf6762de..f7a463ee1 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -5,11 +5,11 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Test to check if fd set bits are cleared by select().
  *
- * [ALGORITHM]
+ * [Algorithm]
  *  - Check that writefds flag is cleared on full pipe
  *  - Check that readfds flag is cleared on empty pipe
  */
diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index cdcd37e8f..d8625c04d 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  * - Basic test for the time(2) system call. It is intended to provide a
  * limited exposure of the system call.
  * - Verify that time(2) returns the value of time in seconds since the Epoch
diff --git a/testcases/kernel/syscalls/times/times01.c b/testcases/kernel/syscalls/times/times01.c
index 407410fa1..408b91c9c 100644
--- a/testcases/kernel/syscalls/times/times01.c
+++ b/testcases/kernel/syscalls/times/times01.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
  */
 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * This is a Phase I test for the times(2) system call.  It is intended to
  * provide a limited exposure of the system call.
diff --git a/testcases/kernel/syscalls/truncate/truncate02.c b/testcases/kernel/syscalls/truncate/truncate02.c
index 9e59bfc14..8d7f9a6fa 100644
--- a/testcases/kernel/syscalls/truncate/truncate02.c
+++ b/testcases/kernel/syscalls/truncate/truncate02.c
@@ -5,7 +5,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that:
  *
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 6794eb695..a9cd4b3ed 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -5,7 +5,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Verify that:
  *
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index b13cf396e..d0c64743b 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -4,7 +4,7 @@
  */

 /*\
- * [DESCRIPTION]
+ * [Description]
  *
  * Check for potential issues in writev() if the first iovec entry is NULL
  * and the next one is not present in RAM. This can result in a brief window
--
2.17.1

