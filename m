From: Jinhui huang <huangjh.jy@cn.fujitsu.com>
Date: Wed, 3 Apr 2019 14:29:50 +0800
Subject: [LTP] [PATCH] syscall/pivot_root01.c: Fix compile error
Message-ID: <1554272990-8651-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)The 'MS_REC' and 'MS_PRIVATE' flag are not defined on some old distros,
  so add them into 'include/lapi/mount.h' to fix it.
2)Enclose macro with complex values in parentheses.

Signed-off-by: Jinhui huang <huangjh.jy@cn.fujitsu.com>
---
 include/lapi/mount.h                                | 10 +++++++++-
 testcases/kernel/syscalls/pivot_root/pivot_root01.c |  1 +
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/lapi/mount.h b/include/lapi/mount.h
index 74e85c7..6c41e45 100644
--- a/include/lapi/mount.h
+++ b/include/lapi/mount.h
@@ -19,8 +19,16 @@
 #ifndef __MOUNT_H__
 #define __MOUNT_H__
 
+#ifndef MS_REC
+#define MS_REC 16384
+#endif
+
+#ifndef MS_PRIVATE
+#define MS_PRIVATE (1<<18)
+#endif
+
 #ifndef MS_STRICTATIME
-#define MS_STRICTATIME  1 << 24
+#define MS_STRICTATIME (1 << 24)
 #endif
 
 #ifndef MNT_DETACH
diff --git a/testcases/kernel/syscalls/pivot_root/pivot_root01.c b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
index eed3704..2e8a7ff 100644
--- a/testcases/kernel/syscalls/pivot_root/pivot_root01.c
+++ b/testcases/kernel/syscalls/pivot_root/pivot_root01.c
@@ -14,6 +14,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
+#include "lapi/mount.h"
 
 #ifdef HAVE_UNSHARE
 
-- 
1.8.3.1



