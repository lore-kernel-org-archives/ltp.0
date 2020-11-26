From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 26 Nov 2020 09:28:38 +0800
Subject: [LTP] [PATCH] lapi/name_to_handle_at.h: Fix compiler error on
 centos6
Message-ID: <20201126012838.531070-1-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From travis-ci, compiling name_to_handle_at/open_by_handle_at tests
failed on centos6 due to undefined AT_EMPTY_PATH and MAX_HANDLE_SZ.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 include/lapi/fcntl.h             | 4 ++++
 include/lapi/name_to_handle_at.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/lapi/fcntl.h b/include/lapi/fcntl.h
index 576a18daf..d6665915f 100644
--- a/include/lapi/fcntl.h
+++ b/include/lapi/fcntl.h
@@ -136,4 +136,8 @@
 # define SPLICE_F_NONBLOCK 2
 #endif
 
+#ifndef MAX_HANDLE_SZ
+# define MAX_HANDLE_SZ	128
+#endif
+
 #endif /* __LAPI_FCNTL_H__ */
diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
index c0759c463..3484133d1 100644
--- a/include/lapi/name_to_handle_at.h
+++ b/include/lapi/name_to_handle_at.h
@@ -10,6 +10,7 @@
 #include <sys/syscall.h>
 #include "config.h"
 #include "lapi/syscalls.h"
+#include "lapi/fcntl.h"
 #include "tst_buffers.h"
 #include "tst_test.h"
 
-- 
2.25.1



