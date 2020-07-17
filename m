From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 17 Jul 2020 12:13:11 +0800
Subject: [LTP] [PATCH] lapi/io_uring.h: Add declaration of __kernel_rwf_t
Message-ID: <1594959191-25155-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit ddef7ed2b5cb ("annotate RWF_... flags"), fs.h introduced
 __kernel_rwf_t data type in 4.14-rc1.

Fix build error on old kernel.
In file included from io_uring01.c:20:
../../../../include/lapi/io_uring.h:38: error: expected specifier-qualifier-list before ?__kernel_rwf_t?
io_uring01.c:266: warning: missing initializer
io_uring01.c:266: warning: (near initialization for ?(anonymous)[1].ptr?)
io_uring01.c:268: warning: missing initializer
io_uring01.c:268: warning: (near initialization for ?test.caps?)
make: *** [io_uring01] Error 1

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 include/lapi/io_uring.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 8e47501a5..4a8978e87 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -12,6 +12,7 @@
 #include <unistd.h>
 #include <fcntl.h>
 #include <sys/types.h>
+#include <linux/types.h>
 #include <sys/uio.h>
 #include <stdlib.h>
 #include <linux/fs.h>
@@ -20,6 +21,10 @@
 
 #ifndef IOSQE_FIXED_FILE
 
+#ifndef __kernel_rwf_t
+typedef int __bitwise __kernel_rwf_t;
+#endif
+
 /*
  * IO submission data structure (Submission Queue Entry)
  */
-- 
2.23.0



