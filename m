From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 21 Nov 2018 11:05:32 +0800
Subject: [LTP] [PATCH] syscalls/statx06.c: Fix compiler errors on old distros
Message-ID: <1542769532-7487-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation fails on old distros due to undefined CLOCK_REALTIME_COARSE,
AT_FDCWD or MS_STRICTATIME.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx06.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index 17fccc8..1ce7d48 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -36,6 +36,9 @@
 #include <stdio.h>
 #include "tst_test.h"
 #include "lapi/stat.h"
+#include "lapi/mount.h"
+#include "lapi/fcntl.h"
+#include "lapi/posix_clocks.h"
 #include "tst_safe_clocks.h"
 #include "tst_safe_macros.h"
 #include "tst_timer.h"
-- 
1.7.11.rc0



