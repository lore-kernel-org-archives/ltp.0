From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  8 Mar 2021 17:01:21 +0100
Subject: [LTP] [PATCH 1/2] docparse: Use C standard comment end
Message-ID: <20210308160122.24522-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Current \*/ docparse end emit error:
WARNING: Block comments use a trailing */ on a separate line

Commend is not required for docparse generation thus remove it to keep
checkpatch.pl quiet.

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/README.md                                              | 2 +-
 testcases/kernel/containers/pidns/pidns13.c                     | 2 +-
 testcases/kernel/device-drivers/rtc/rtc02.c                     | 2 +-
 testcases/kernel/syscalls/abort/abort01.c                       | 2 +-
 testcases/kernel/syscalls/accept/accept01.c                     | 2 +-
 testcases/kernel/syscalls/accept/accept02.c                     | 2 +-
 testcases/kernel/syscalls/acct/acct01.c                         | 2 +-
 testcases/kernel/syscalls/acct/acct02.c                         | 2 +-
 testcases/kernel/syscalls/brk/brk02.c                           | 2 +-
 testcases/kernel/syscalls/close_range/close_range01.c           | 2 +-
 testcases/kernel/syscalls/close_range/close_range02.c           | 2 +-
 testcases/kernel/syscalls/dup/dup02.c                           | 2 +-
 testcases/kernel/syscalls/dup/dup03.c                           | 2 +-
 testcases/kernel/syscalls/finit_module/finit_module01.c         | 2 +-
 testcases/kernel/syscalls/finit_module/finit_module02.c         | 2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c       | 2 +-
 testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c       | 2 +-
 testcases/kernel/syscalls/getdents/getdents01.c                 | 2 +-
 testcases/kernel/syscalls/getdents/getdents02.c                 | 2 +-
 testcases/kernel/syscalls/getpid/getpid01.c                     | 2 +-
 testcases/kernel/syscalls/getpid/getpid02.c                     | 2 +-
 testcases/kernel/syscalls/init_module/init_module01.c           | 2 +-
 testcases/kernel/syscalls/init_module/init_module02.c           | 2 +-
 testcases/kernel/syscalls/ipc/msgctl/msgctl06.c                 | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl02.c                 | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl03.c                 | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl04.c                 | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl05.c                 | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl07.c                 | 2 +-
 testcases/kernel/syscalls/ipc/semctl/semctl09.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl02.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl03.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl04.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl05.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl06.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl07.c                 | 2 +-
 testcases/kernel/syscalls/ipc/shmctl/shmctl08.c                 | 2 +-
 testcases/kernel/syscalls/mallinfo/mallinfo01.c                 | 2 +-
 testcases/kernel/syscalls/mallinfo/mallinfo02.c                 | 2 +-
 testcases/kernel/syscalls/mallopt/mallopt01.c                   | 2 +-
 testcases/kernel/syscalls/move_pages/move_pages12.c             | 2 +-
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at01.c     | 2 +-
 .../kernel/syscalls/name_to_handle_at/name_to_handle_at02.c     | 2 +-
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at01.c     | 2 +-
 .../kernel/syscalls/open_by_handle_at/open_by_handle_at02.c     | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace11.c                     | 2 +-
 testcases/kernel/syscalls/recvmmsg/recvmmsg01.c                 | 2 +-
 testcases/kernel/syscalls/sched_getparam/sched_getparam01.c     | 2 +-
 testcases/kernel/syscalls/select/select04.c                     | 2 +-
 testcases/kernel/syscalls/sendmmsg/sendmmsg01.c                 | 2 +-
 testcases/kernel/syscalls/sendmmsg/sendmmsg02.c                 | 2 +-
 testcases/kernel/syscalls/time/time01.c                         | 2 +-
 testcases/kernel/syscalls/times/times01.c                       | 2 +-
 testcases/kernel/syscalls/truncate/truncate02.c                 | 2 +-
 testcases/kernel/syscalls/truncate/truncate03.c                 | 2 +-
 testcases/kernel/syscalls/writev/writev03.c                     | 2 +-
 57 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/docparse/README.md b/docparse/README.md
index 2c2541760..37bf4614b 100644
--- a/docparse/README.md
+++ b/docparse/README.md
@@ -173,7 +173,7 @@ The test documentation is stored in a special comment such as:
  *
  * This is a test description.
  * Consisting of several lines.
-\*/
+ */
 ```
 
 Which will yield following json output:
diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 7c8a0bfa1..12aee917b 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -20,7 +20,7 @@
  * * in cinit1, set pipe read end to send SIGUSR1 for asynchronous I/O
  * * let cinit2 trigger async I/O on pipe write end
  * * in signal info, check si_code to be POLL_IN and si_fd to be pipe read fd
-\*/
+ */
 
 #define _GNU_SOURCE 1
 #include <sys/wait.h>
diff --git a/testcases/kernel/device-drivers/rtc/rtc02.c b/testcases/kernel/device-drivers/rtc/rtc02.c
index a992aa3d1..9d2141656 100644
--- a/testcases/kernel/device-drivers/rtc/rtc02.c
+++ b/testcases/kernel/device-drivers/rtc/rtc02.c
@@ -15,7 +15,7 @@
  * - Read the RTC time back
  * - Check if the set time and the read time are identical
  * - Restore RTC time
-\*/
+ */
 
 #include <stdio.h>
 #include "tst_rtctime.h"
diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index ba89cc524..242389783 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -16,7 +16,7 @@
  *  - Fork child.
  *  - Child calls abort.
  *  - Parent checks return status.
-\*/
+ */
 
 #include <sys/types.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/syscalls/accept/accept01.c b/testcases/kernel/syscalls/accept/accept01.c
index 8722f2c7f..d4a6bc396 100644
--- a/testcases/kernel/syscalls/accept/accept01.c
+++ b/testcases/kernel/syscalls/accept/accept01.c
@@ -8,7 +8,7 @@
 /*\
  * [DESCRIPTION]
  * Verify that accept() returns the proper errno for various failure cases.
-\*/
+ */
 
 #include <stdio.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/accept/accept02.c b/testcases/kernel/syscalls/accept/accept02.c
index 7fb6a494a..7f84d3b45 100644
--- a/testcases/kernel/syscalls/accept/accept02.c
+++ b/testcases/kernel/syscalls/accept/accept02.c
@@ -19,7 +19,7 @@
  *
  * For more information about this CVE see:
  * https://www.suse.com/security/cve/CVE-2017-8890/
-\*/
+ */
 
 #include <errno.h>
 #include <sys/socket.h>
diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index 60e81bfad..1f88e5307 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -10,7 +10,7 @@
 /*\
  * [DOCUMENTATION]
  *  Verify that acct() returns proper errno on failure.
-\*/
+ */
 
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
index aee96e365..b8eb1aad4 100644
--- a/testcases/kernel/syscalls/acct/acct02.c
+++ b/testcases/kernel/syscalls/acct/acct02.c
@@ -21,7 +21,7 @@
  *
  * This is also accidental regression test for:
  * 4d9570158b626 kernel/acct.c: fix the acct->needcheck check in check_free_space()
-\*/
+ */
 
 #include <sys/stat.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
index 2e604eb5d..5493e4607 100644
--- a/testcases/kernel/syscalls/brk/brk02.c
+++ b/testcases/kernel/syscalls/brk/brk02.c
@@ -9,7 +9,7 @@
  * and not expanding the original due to multiple anon pages.  mprotect() that
  * new VMA then brk() back to the original address therefore causing a munmap of
  * at least one full VMA.
-\*/
+ */
 
 #include <unistd.h>
 #include <sys/mman.h>
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 6ecd4576e..912f56c56 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -21,7 +21,7 @@
  *
  * The final test is the actual bug reproducer. Note that we call
  * clone directly to share the file table.
-\*/
+ */
 
 #include <stdlib.h>
 
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index d496316d3..90f8e5e0b 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -10,7 +10,7 @@
  * - Then check it accepts a large lower fd.
  * - Finally check CLOEXEC works
  *
-\*/
+ */
 
 #include <stdlib.h>
 
diff --git a/testcases/kernel/syscalls/dup/dup02.c b/testcases/kernel/syscalls/dup/dup02.c
index d55335cc7..105e95afa 100644
--- a/testcases/kernel/syscalls/dup/dup02.c
+++ b/testcases/kernel/syscalls/dup/dup02.c
@@ -13,7 +13,7 @@
  * [ALGORITHM]
  * Call dup(2) with invalid argument and make sure it returns -1 with errno set
  * to EBADF.
-\*/
+ */
 
 #include "tst_test.h"
 
diff --git a/testcases/kernel/syscalls/dup/dup03.c b/testcases/kernel/syscalls/dup/dup03.c
index 5736f3c3f..592246d06 100644
--- a/testcases/kernel/syscalls/dup/dup03.c
+++ b/testcases/kernel/syscalls/dup/dup03.c
@@ -11,7 +11,7 @@
  * [ALGORITHM]
  * Open the maximum allowed number of file descriptors and then try to call
  * dup() once more and verify it fails with EMFILE.
-\*/
+ */
 
 #include <stdlib.h>
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/finit_module/finit_module01.c b/testcases/kernel/syscalls/finit_module/finit_module01.c
index d215fc0ff..489923ec4 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module01.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module01.c
@@ -11,7 +11,7 @@
  * [ALGORITHM]
  *
  * Inserts a simple module after opening and mmaping the module file.
-\*/
+ */
 
 #include <errno.h>
 #include "lapi/init_module.h"
diff --git a/testcases/kernel/syscalls/finit_module/finit_module02.c b/testcases/kernel/syscalls/finit_module/finit_module02.c
index 96aec4591..2849fb2ec 100644
--- a/testcases/kernel/syscalls/finit_module/finit_module02.c
+++ b/testcases/kernel/syscalls/finit_module/finit_module02.c
@@ -11,7 +11,7 @@
  * [ALGORITHM]
  *
  * Tests various failure scenarios for finit_module().
-\*/
+ */
 
 #include <linux/capability.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
index 4e8955b36..3a9bd5b8b 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
@@ -15,7 +15,7 @@
  * [DESCRIPTION]
  *
  * Verify that get_mempolicy() returns a proper return value and errno for various cases.
-\*/
+ */
 
 #include "config.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
index 000098168..b37030be7 100644
--- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
+++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
@@ -15,7 +15,7 @@
  * [DESCRIPTION]
  *
  * Verify that get_mempolicy() returns a proper return errno for failure cases.
-\*/
+ */
 
 #include "config.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index b8de3b7ec..cfc3fa306 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -13,7 +13,7 @@
  * Basic getdents() test that checks if directory listing is correct and
  * complete.
  *
-\*/
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 3666dcc53..e43203304 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -15,7 +15,7 @@
  *   - getdents() fails with EINVAL if result buffer is too small
  *   - getdents() fails with ENOTDIR if file descriptor does not refer to a directory
  *   - getdents() fails with ENOENT if directory was unlinked()
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 326ee5840..8ce97b76f 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -7,7 +7,7 @@
  * [DESCRIPTION]
  *
  * Verify that getpid() system call returns process ID in range 2 ... PID_MAX
-\*/
+ */
 
 #include <stdlib.h>
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/getpid/getpid02.c b/testcases/kernel/syscalls/getpid/getpid02.c
index 815ce985f..dbe7bc2ad 100644
--- a/testcases/kernel/syscalls/getpid/getpid02.c
+++ b/testcases/kernel/syscalls/getpid/getpid02.c
@@ -9,7 +9,7 @@
  * Check that:
  * - fork() in parent returns the same pid as getpid() in child
  * - getppid() in child returns the same pid as getpid() in parent
-\*/
+ */
 
 #include <errno.h>
 
diff --git a/testcases/kernel/syscalls/init_module/init_module01.c b/testcases/kernel/syscalls/init_module/init_module01.c
index bbb2baabb..d3096a00d 100644
--- a/testcases/kernel/syscalls/init_module/init_module01.c
+++ b/testcases/kernel/syscalls/init_module/init_module01.c
@@ -11,7 +11,7 @@
  * [ALGORITHM]
  *
  * Inserts a simple module after opening and mmaping the module file.
-\*/
+ */
 
 #include <errno.h>
 #include "lapi/init_module.h"
diff --git a/testcases/kernel/syscalls/init_module/init_module02.c b/testcases/kernel/syscalls/init_module/init_module02.c
index 88917bd7c..be998e600 100644
--- a/testcases/kernel/syscalls/init_module/init_module02.c
+++ b/testcases/kernel/syscalls/init_module/init_module02.c
@@ -11,7 +11,7 @@
  * [ALGORITHM]
  *
  * Tests various failure scenarios for init_module().
-\*/
+ */
 
 #include <linux/capability.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
index 99e44851c..90f2ccf74 100644
--- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
+++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
@@ -21,7 +21,7 @@
  *
  * Also note that for MSG_INFO the members of the msginfo structure have
  * completely different meaning than their names seems to suggest.
-\*/
+ */
 
 #include <stdio.h>
 #include <pwd.h>
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
index 4980cac8d..3dc09539a 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
@@ -8,7 +8,7 @@
  * [DESCRIPTION]
  *
  * Test for semctl() EACCES error.
-\*/
+ */
 
 #include <pwd.h>
 #include "tst_safe_sysv_ipc.h"
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
index 589f25f28..051b86a85 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
@@ -9,7 +9,7 @@
  * [DESCRIPTION]
  *
  * Test for semctl() EINVAL and EFAULT errors
-\*/
+ */
 
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
index 8bbb721fe..0a88e93a6 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
@@ -12,7 +12,7 @@
  *
  * Runs IPC_SET and IPC_RMID from unprivileged child process.
  *
-\*/
+ */
 
 #include <pwd.h>
 #include <sys/wait.h>
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
index ee7f9c6c3..386b14bd8 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
@@ -10,7 +10,7 @@
  * [DESCRIPTION]
  *
  * Test for semctl() ERANGE error
-\*/
+ */
 
 #include "tst_safe_sysv_ipc.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
index 7b0a295d1..39f10ed22 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
@@ -18,7 +18,7 @@
  * - semctl() with SETVAL and GETVAL
  * - semctl() with GETPID
  * - semctl() with GETNCNT and GETZCNT
-\*/
+ */
 
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
index f0c757cdd..9450fdc8e 100644
--- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
+++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
@@ -31,7 +31,7 @@
  * * commit  574500a108be1d2a6a0dc97a075c9e0a98371aba
  * * Author: Dmitry V. Levin <ldv@altlinux.org>
  * * Date:   Tue, 29 Sep 2020 17:10:20 +0000 (14:10 -0300)
-\*/
+ */
 
 #include <stdio.h>
 #include <pwd.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index c22a8bcc6..54a0ae990 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -15,7 +15,7 @@
  * - attaching the SHM before fork and letting the children detach it
  *
  * We check that the number shm_nattach is correct after each step we do.
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index fde17ffbb..df7aba835 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -25,7 +25,7 @@
  * * EPERM  - attempt to change root-owned shm
  * * EPERM  - attempt to lock root-owned shm
  * * EPERM  - attempt to unlock root-owned shm
-\*/
+ */
 
 #include <pwd.h>
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index f5d3e4f17..86d981d19 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -8,7 +8,7 @@
  *
  * Call shmctl() with IPC_INFO flag and check that the data are consistent with
  * /proc/sys/kernel/shm*.
-\*/
+ */
 
 #define _GNU_SOURCE
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index 3068b7ace..5453132b7 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -18,7 +18,7 @@
  *
  * Note what we create a SHM segment in the test setup to make sure that there
  * is at least one during the testrun.
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 263e06e4c..ec25f4eae 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -15,7 +15,7 @@
  * touch_atime(), although it's a race condition so it's not guaranteed to
  * work. This test is based on the reproducer provided in the fix's commit
  * message.
-\*/
+ */
 
 #include "lapi/syscalls.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
index c804b3208..b8dbc3bd1 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
@@ -7,7 +7,7 @@
  * [DESCRIPTION]
  *
  * Cross verify the _high fields being set to 0 by the kernel.
-\*/
+ */
 
 #include <sys/shm.h>
 #include "lapi/shmbuf.h"
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
index 8f74435f9..37c23441f 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
@@ -7,7 +7,7 @@
  * [DESCRIPTION]
  *
  * Test for a SHM_LOCK and SHM_UNLOCK.
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
index f763a07eb..071cf7b72 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
@@ -10,7 +10,7 @@
  *
  * The test clears the group and others bits from the shm_perm.mode and checks
  * the result as well as if the ctime was updated correctly.
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo01.c b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
index ba5366896..d6c47299b 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo01.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo01.c
@@ -9,7 +9,7 @@
  *
  * Basic mallinfo() test. Refer to glibc test mallinfo2 test
  * https://sourceware.org/git/?p=glibc.git;a=blob;f=malloc/tst-mallinfo2.c
-\*/
+ */
 #include "mallinfo_common.h"
 #include "tst_safe_macros.h"
 
diff --git a/testcases/kernel/syscalls/mallinfo/mallinfo02.c b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
index 945d3227c..05539abe3 100644
--- a/testcases/kernel/syscalls/mallinfo/mallinfo02.c
+++ b/testcases/kernel/syscalls/mallinfo/mallinfo02.c
@@ -9,7 +9,7 @@
  *
  * Basic mallinfo() test for malloc() using sbrk or mmap.
  * It size > MMAP_THRESHOLD, it will use mmap. Otherwise, use sbrk.
-\*/
+ */
 
 #include "mallinfo_common.h"
 #include "tst_safe_macros.h"
diff --git a/testcases/kernel/syscalls/mallopt/mallopt01.c b/testcases/kernel/syscalls/mallopt/mallopt01.c
index e270b0bda..a47f65d2c 100644
--- a/testcases/kernel/syscalls/mallopt/mallopt01.c
+++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
@@ -10,7 +10,7 @@
  * [DESCRIPTION]
  *
  * Basic mallinfo() and mallopt() testing.
-\*/
+ */
 
 
 #include "../mallinfo/mallinfo_common.h"
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index d209426c7..16d14779d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -61,7 +61,7 @@
  *    Date:   Mon Dec 14 19:11:51 2020 -0800
  *
  *    mm,hwpoison: return -EBUSY when migration fails
-\*/
+ */
 
 #include <errno.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
index 1ac9d8214..7c91d1598 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at01.c
@@ -12,7 +12,7 @@
  *  - Check that EOVERFLOW is returned as expected by name_to_handle_at().
  *  - Check that we were able to access a file's stat with name_to_handle_at()
  *    and open_by_handle_at().
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <sys/stat.h>
diff --git a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
index 020b25531..12ee31c2c 100644
--- a/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
+++ b/testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at02.c
@@ -7,7 +7,7 @@
  * [DESCRIPTION]
  *
  * Failure tests for name_to_handle_at().
-\*/
+ */
 
 #define _GNU_SOURCE
 #include "lapi/name_to_handle_at.h"
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
index 0d09e1ed8..ae962fb62 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at01.c
@@ -12,7 +12,7 @@
  *
  * Check that we were able to access a file's stat which is opened with
  * open_by_handle_at().
-\*/
+ */
 
 #define _GNU_SOURCE
 #include <sys/stat.h>
diff --git a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
index 0f60752c4..e66194df5 100644
--- a/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
+++ b/testcases/kernel/syscalls/open_by_handle_at/open_by_handle_at02.c
@@ -7,7 +7,7 @@
  * [DESCRIPTION]
  *
  * Failure tests for open_by_handle_at().
-\*/
+ */
 #define _GNU_SOURCE
 #include <linux/capability.h>
 #include "tst_capability.h"
diff --git a/testcases/kernel/syscalls/ptrace/ptrace11.c b/testcases/kernel/syscalls/ptrace/ptrace11.c
index 734a99d3c..08a2246df 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace11.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace11.c
@@ -10,7 +10,7 @@
  * Before kernel 2.6.26 we could not trace init(1) process and ptrace() would
  * fail with EPERM. This case just checks whether we can trace init(1) process
  * successfully.
-\*/
+ */
 
 #include <errno.h>
 #include <signal.h>
diff --git a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
index 4e7e6aa28..10eaa3dcd 100644
--- a/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
+++ b/testcases/kernel/syscalls/recvmmsg/recvmmsg01.c
@@ -8,7 +8,7 @@
  * - EINVAL Bad seconds value for the timeout argument
  * - EINVAL Bad nanoseconds value for the timeout argument
  * - EFAULT Bad timeout address
-\*/
+ */
 
 #define _GNU_SOURCE
 #include "../sendmmsg/sendmmsg.h"
diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
index eec3ccaae..f638a6b83 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam01.c
@@ -15,7 +15,7 @@
  * for the calling process.
  * - If pid is not zero, sched_getparam(2) gets the scheduling
  * parameters for the specified [pid] process.
-\*/
+ */
 
 #include <errno.h>
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index dd042562d..cdf6762de 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -12,7 +12,7 @@
  * [ALGORITHM]
  *  - Check that writefds flag is cleared on full pipe
  *  - Check that readfds flag is cleared on empty pipe
-\*/
+ */
 
 #include <unistd.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
index e3884f1fd..de58abd92 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg01.c
@@ -4,7 +4,7 @@
  *
  * This test is based on source contained in the man pages for sendmmsg and
  * recvmmsg in release 4.15 of the Linux man-pages project.
-\*/
+ */
 
 #define _GNU_SOURCE
 #include "sendmmsg.h"
diff --git a/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c b/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
index d0b2c1668..b14faccb6 100644
--- a/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
+++ b/testcases/kernel/syscalls/sendmmsg/sendmmsg02.c
@@ -5,7 +5,7 @@
  *
  * - EBADF Bad socket file descriptor
  * - EFAULT Bad message vector address
-\*/
+ */
 
 #define _GNU_SOURCE
 #include "sendmmsg.h"
diff --git a/testcases/kernel/syscalls/time/time01.c b/testcases/kernel/syscalls/time/time01.c
index 2529d7c07..cdcd37e8f 100644
--- a/testcases/kernel/syscalls/time/time01.c
+++ b/testcases/kernel/syscalls/time/time01.c
@@ -9,7 +9,7 @@
  * limited exposure of the system call.
  * - Verify that time(2) returns the value of time in seconds since the Epoch
  * and stores this value in the memory pointed to by the parameter.
-\*/
+ */
 
 #include <time.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/times/times01.c b/testcases/kernel/syscalls/times/times01.c
index 53c5603d7..407410fa1 100644
--- a/testcases/kernel/syscalls/times/times01.c
+++ b/testcases/kernel/syscalls/times/times01.c
@@ -7,7 +7,7 @@
  *
  * This is a Phase I test for the times(2) system call.  It is intended to
  * provide a limited exposure of the system call.
-\*/
+ */
 
 #include <sys/times.h>
 #include <errno.h>
diff --git a/testcases/kernel/syscalls/truncate/truncate02.c b/testcases/kernel/syscalls/truncate/truncate02.c
index b8a76c0c6..9e59bfc14 100644
--- a/testcases/kernel/syscalls/truncate/truncate02.c
+++ b/testcases/kernel/syscalls/truncate/truncate02.c
@@ -13,7 +13,7 @@
  * - If the file is larger than the specified length, the extra data is lost.
  * - If the file is shorter than the specified length, the extra data is filled by '0'.
  * - truncate(2) doesn't change offset.
-\*/
+ */
 
 #include <errno.h>
 #include <unistd.h>
diff --git a/testcases/kernel/syscalls/truncate/truncate03.c b/testcases/kernel/syscalls/truncate/truncate03.c
index 0d8f1d579..6794eb695 100644
--- a/testcases/kernel/syscalls/truncate/truncate03.c
+++ b/testcases/kernel/syscalls/truncate/truncate03.c
@@ -27,7 +27,7 @@
  *   is larger than the maximum file size.
  * - truncate(2) returns -1 and sets errno to ELOOP if too many symbolic
  *   links were encountered in translating the pathname.
-\*/
+ */
 
 #define _GNU_SOURCE
 
diff --git a/testcases/kernel/syscalls/writev/writev03.c b/testcases/kernel/syscalls/writev/writev03.c
index 6514404e6..b13cf396e 100644
--- a/testcases/kernel/syscalls/writev/writev03.c
+++ b/testcases/kernel/syscalls/writev/writev03.c
@@ -11,7 +11,7 @@
  * where writev() first writes uninitialized data into the file (possibly
  * exposing internal kernel structures) and then overwrites it with the real
  * iovec contents later.
-\*/
+ */
 
 /*
  * Bugs fixed in:
-- 
2.30.1

