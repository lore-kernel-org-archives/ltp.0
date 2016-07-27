From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 27 Jul 2016 18:51:53 +0800
Subject: [LTP] [PATCH] syscalls/*: Fix order of included headers
Message-ID: <1469616713-1025-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on RHEL5.11GA and RHEL6.8GA because definition of clone()
function in sched.h will be replaced by the test.h defined clone(...) macro.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/ipc/semaphore/sem02.c                      | 2 +-
 testcases/kernel/syscalls/sched_setparam/sched_setparam04.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/ipc/semaphore/sem02.c b/testcases/kernel/ipc/semaphore/sem02.c
index 7db142b..81e77d6 100644
--- a/testcases/kernel/ipc/semaphore/sem02.c
+++ b/testcases/kernel/ipc/semaphore/sem02.c
@@ -41,7 +41,6 @@
  *      -ported to LTP
  *
  */
-#include "test.h"
 
 #include <stdio.h>
 #include <stdlib.h>
@@ -52,6 +51,7 @@
 #include <sys/types.h>
 #include <sys/ipc.h>
 #include "lapi/semun.h"
+#include "test.h"
 
 #define KEY IPC_PRIVATE
 
diff --git a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
index 3da1120..f6e017d 100644
--- a/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
+++ b/testcases/kernel/syscalls/sched_setparam/sched_setparam04.c
@@ -73,11 +73,10 @@
  *
  *********************************************************************/
 
-#include "test.h"
-
 #include <errno.h>
 #include <sched.h>
 #include <pwd.h>
+#include "test.h"
 
 static void cleanup(void);
 static void setup(void);
-- 
1.8.3.1



