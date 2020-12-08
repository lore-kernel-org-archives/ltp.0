From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  8 Dec 2020 17:05:16 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/ipc/shmctl: Reformat doc comments
Message-ID: <20201208160516.32672-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So that they are properly picked up by the docparser.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/syscalls/ipc/shmctl/shmctl01.c     | 11 ++++++----
 .../kernel/syscalls/ipc/shmctl/shmctl02.c     |  6 +++--
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     |  7 ++++--
 .../kernel/syscalls/ipc/shmctl/shmctl04.c     |  7 ++++--
 .../kernel/syscalls/ipc/shmctl/shmctl05.c     | 22 +++++++++++--------
 .../kernel/syscalls/ipc/shmctl/shmctl06.c     |  8 +++++--
 .../kernel/syscalls/ipc/shmctl/shmctl07.c     |  7 ++++--
 .../kernel/syscalls/ipc/shmctl/shmctl08.c     |  7 ++++--
 8 files changed, 50 insertions(+), 25 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index eb5307d1e..c22a8bcc6 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -3,16 +3,19 @@
  * Copyright (c) International Business Machines  Corp., 2001
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
+
+/*\
+ * [DESCRIPTION]
+ *
  * Verify that shmctl() IPC_STAT and SHM_STAT reports correct data.
  *
  * The shm_nattach is excercised by:
  *
- * 1. forking() children that attach and detach SHM
- * 2. attaching the SHM before fork and letting the children detach it
+ * - forking() children that attach and detach SHM
+ * - attaching the SHM before fork and letting the children detach it
  *
  * We check that the number shm_nattach is correct after each step we do.
- */
+\*/
 
 #define _GNU_SOURCE
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
index 677b15d40..fde17ffbb 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
@@ -8,7 +8,9 @@
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
 
-/*
+/*\
+ * [DESCRIPTION]
+ *
  * Test for EACCES, EFAULT and EINVAL errors.
  *
  * * EACCES - segment has no read or write permissions
@@ -23,7 +25,7 @@
  * * EPERM  - attempt to change root-owned shm
  * * EPERM  - attempt to lock root-owned shm
  * * EPERM  - attempt to unlock root-owned shm
- */
+\*/
 
 #include <pwd.h>
 
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index 8868ab1cb..f5d3e4f17 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -2,10 +2,13 @@
 /*
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
+
+/*\
+ * [DESCRIPTION]
+ *
  * Call shmctl() with IPC_INFO flag and check that the data are consistent with
  * /proc/sys/kernel/shm*.
- */
+\*/
 
 #define _GNU_SOURCE
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
index f4235ff40..3068b7ace 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
@@ -2,7 +2,10 @@
 /*
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
+
+/*\
+ * [DESCRIPTION]
+ *
  * Call shmctl() with SHM_INFO flag and check that:
  *
  * * The returned index points to a valid SHM by calling SHM_STAT_ANY
@@ -15,7 +18,7 @@
  *
  * Note what we create a SHM segment in the test setup to make sure that there
  * is at least one during the testrun.
- */
+\*/
 
 #define _GNU_SOURCE
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
index 50196ae99..263e06e4c 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl05.c
@@ -3,15 +3,19 @@
  * Copyright (c) 2018 Google, Inc.
  */
 
-/*
- * Regression test for commit 3f05317d9889 ("ipc/shm: fix use-after-free of shm
- * file via remap_file_pages()").  This bug allowed the remap_file_pages()
- * syscall to use the file of a System V shared memory segment after its ID had
- * been reallocated and the file freed.  This test reproduces the bug as a NULL
- * pointer dereference in touch_atime(), although it's a race condition so it's
- * not guaranteed to work.  This test is based on the reproducer provided in the
- * fix's commit message.
- */
+/*\
+ * [DESCRIPTION]
+ *
+ * Regression test for commit
+ * 3f05317d9889 (ipc/shm: fix use-after-free of shm file via remap_file_pages()).
+ *
+ * This bug allowed the remap_file_pages() syscall to use the file of a System
+ * V shared memory segment after its ID had been reallocated and the file
+ * freed. This test reproduces the bug as a NULL pointer dereference in
+ * touch_atime(), although it's a race condition so it's not guaranteed to
+ * work. This test is based on the reproducer provided in the fix's commit
+ * message.
+\*/
 
 #include "lapi/syscalls.h"
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
index 368759980..c804b3208 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
@@ -1,10 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+/*\
+ * [DESCRIPTION]
  *
- * Description:
  * Cross verify the _high fields being set to 0 by the kernel.
- */
+\*/
+
 #include <sys/shm.h>
 #include "lapi/shmbuf.h"
 #include "libnewipc.h"
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
index 39b9ad78a..8f74435f9 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
@@ -2,9 +2,12 @@
 /*
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
+
+/*\
+ * [DESCRIPTION]
+ *
  * Test for a SHM_LOCK and SHM_UNLOCK.
- */
+\*/
 
 #define _GNU_SOURCE
 #include <stdio.h>
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
index 157ced608..f763a07eb 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
@@ -2,12 +2,15 @@
 /*
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
  */
-/*
+
+/*\
+ * [DESCRIPTION]
+ *
  * Test for a SHM_SET.
  *
  * The test clears the group and others bits from the shm_perm.mode and checks
  * the result as well as if the ctime was updated correctly.
- */
+\*/
 
 #define _GNU_SOURCE
 #include <stdio.h>
-- 
2.26.2

