From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Sep 2018 15:53:15 +0800
Subject: [LTP] [PATCH] syscalls/statx*: Fix compiler errors on old distros
Message-ID: <1536825195-522-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

With glibc-2.5 on RHEL5, compilation failed because of undefined
AT_FDCWD, O_DIRECTORY or WEXITSTATUS().

1) Fix undefined AT_FDCWD and O_DIRECTORY by defining _GNU_SOURCE.
2) Fix undefined WEXITSTATUS() by including <sys/wait.h>.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx01.c | 2 ++
 testcases/kernel/syscalls/statx/statx02.c | 1 +
 testcases/kernel/syscalls/statx/statx03.c | 2 ++
 testcases/kernel/syscalls/statx/statx04.c | 1 +
 testcases/kernel/syscalls/statx/statx05.c | 3 +++
 5 files changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
index 574560b..23ea99b 100644
--- a/testcases/kernel/syscalls/statx/statx01.c
+++ b/testcases/kernel/syscalls/statx/statx01.c
@@ -33,6 +33,8 @@
  * predefined values.
  * Minimum kernel version required is 4.11.
  */
+
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <sys/types.h>
 #include <sys/sysmacros.h>
diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
index f21abf2..08ea940 100644
--- a/testcases/kernel/syscalls/statx/statx02.c
+++ b/testcases/kernel/syscalls/statx/statx02.c
@@ -22,6 +22,7 @@
  * Minimum kernel version required is 4.11.
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <inttypes.h>
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/statx/statx03.c b/testcases/kernel/syscalls/statx/statx03.c
index 4dc1cd0..c72d7fe 100644
--- a/testcases/kernel/syscalls/statx/statx03.c
+++ b/testcases/kernel/syscalls/statx/statx03.c
@@ -26,6 +26,8 @@
  *
  * Minimum Kernel version required is 4.11.
  */
+
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <string.h>
 #include "tst_test.h"
diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index f27cec7..8caf092 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -23,6 +23,7 @@
  * Minimum kernel version required is 4.11.
  */
 
+#define _GNU_SOURCE
 #include "tst_test.h"
 #include "lapi/fs.h"
 #include <stdlib.h>
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 1a890cf..130e5bc 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -19,9 +19,12 @@
  * Minimum kernel version required is 4.11.
  */
 
+#define _GNU_SOURCE
 #include "tst_test.h"
 #include "lapi/fs.h"
 #include <stdlib.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 #include "lapi/stat.h"
 
 #define MOUNT_POINT "mnt_point"
-- 
1.7.11.rc0



