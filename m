From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Mon, 13 May 2019 09:46:05 +0800
Subject: [LTP] [PATCH] syscall/ioctl: fix compiler error
Message-ID: <1557711965-11638-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"CLONE_NEWPID" and "CLONE_NEWUSER" are not defined on some old distros,
so include "lapi/namespaces_constants.h" to fix it.

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index 59b215f..f2c77a0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -19,6 +19,7 @@
 #include <sched.h>
 #include "tst_test.h"
 #include "lapi/ioctl_ns.h"
+#include "lapi/namespaces_constants.h"
 
 #define STACK_SIZE (1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index add6980..bdef4d6 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -18,6 +18,7 @@
 #include <sched.h>
 #include "tst_test.h"
 #include "lapi/ioctl_ns.h"
+#include "lapi/namespaces_constants.h"
 
 #define STACK_SIZE (1024 * 1024)
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index f077a3b..eabb7e4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -19,6 +19,7 @@
 #include <sched.h>
 #include "tst_test.h"
 #include "lapi/ioctl_ns.h"
+#include "lapi/namespaces_constants.h"
 
 #define STACK_SIZE (1024 * 1024)
 
-- 
1.8.3.1



