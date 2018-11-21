From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 21 Nov 2018 09:39:50 +0800
Subject: [LTP] [PATCH] syscalls/statx06.c: Fix compiler errors
Message-ID: <1542764390-22962-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

struct statx and statx_timestamp are only defined in sys/stat.h when
_GNU_SOURCE is defined, so statx06.c should define _GNU_SOURCE as m4
struct check does.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/statx/statx06.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
index dbf34a8..5240224 100644
--- a/testcases/kernel/syscalls/statx/statx06.c
+++ b/testcases/kernel/syscalls/statx/statx06.c
@@ -33,6 +33,7 @@
  *
  */
 
+#define _GNU_SOURCE
 #include <stdio.h>
 #include <sys/mount.h>
 #include <time.h>
-- 
1.8.3.1



