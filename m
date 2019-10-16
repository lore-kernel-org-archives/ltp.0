From: Petr Vorel <petr.vorel@gmail.com>
Date: Wed, 16 Oct 2019 23:30:01 +0200
Subject: [LTP] [PATCH 1/1] setxattr03: define _GNU_SOURCE to fix build on
 musl
Message-ID: <20191016213001.23047-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

musl defines loff_t in <fcntl.h> (already included) and guard it under _GNU_SOURCE.
NOTE: glibc and others define it in <sys/types.h>

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/setxattr/setxattr03.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index bb511d5ba..58ee0f880 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -13,6 +13,7 @@
  *    -1 and set errno to EPERM
  */
 
+#define _GNU_SOURCE
 #include "config.h"
 #include <sys/ioctl.h>
 #include <sys/types.h>
-- 
2.23.0

