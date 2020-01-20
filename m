From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 11:54:41 +0100
Subject: [LTP] [PATCH 1/1] tst_device.h: Use <sys/syscall.h> and fallback to
 sync()
Message-ID: <20200120105441.19418-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This partly reverts commit 9e83513eb, which unconditionally included
lapi/syscalls.h. Put back <sys/syscall.h> and fallback to sync() for
these rare cases where __NR_syncfs.

Hope this is final fix for syncfs() issues.

Fixes: 9e83513eb "tst_device.h: Use lapi/syscalls.h instead of <sys/syscall.h>"
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_device.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 13d92ee54..1456cb2ff 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -19,7 +19,7 @@
 #define TST_DEVICE_H__
 
 #include <unistd.h>
-#include "lapi/syscalls.h"
+#include <sys/syscall.h>
 
 struct tst_device {
 	const char *dev;
@@ -78,7 +78,12 @@ int tst_detach_device(const char *dev_path);
  */
 static inline int tst_dev_sync(int fd)
 {
+#ifdef __NR_syncfs
 	return syscall(__NR_syncfs, fd);
+#else
+	sync();
+	return 0;
+#endif
 }
 
 /*
-- 
2.24.1

