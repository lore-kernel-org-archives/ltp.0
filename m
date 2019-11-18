From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 18 Nov 2019 17:08:11 +0100
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
Message-ID: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

write() returning ENOSPC doesn't guarantee that filesystem after
some internal book-keeping, flushing, finishing transactions, etc.
won't still find some extra space.

Increase FALLOCATE_SIZE to minimize chance of hitting sporadic
failures when that happens.

Thanks to Carlos Maiolino and Eric Sandeen for their comments
and suggestions.

Fixes #610
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/fallocate/fallocate05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate05.c b/testcases/kernel/syscalls/fallocate/fallocate05.c
index 50c610c448ba..17034e5b11e7 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate05.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate05.c
@@ -17,7 +17,7 @@
 #include "lapi/fallocate.h"
 
 #define MNTPOINT "mntpoint"
-#define FALLOCATE_SIZE 8192
+#define FALLOCATE_SIZE (1024*1024)
 #define TESTED_FLAGS "fallocate(FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)"
 
 static int fd;
-- 
1.8.3.1

