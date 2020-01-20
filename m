From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jan 2020 14:36:46 +0100
Subject: [LTP] [PATCH 2/2] tst_device: Move tst_dev_sync() into from header
 to source file
In-Reply-To: <20200120133646.8629-1-pvorel@suse.cz>
References: <20200120133646.8629-1-pvorel@suse.cz>
Message-ID: <20200120133646.8629-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

While socketcall01.c was already fixed by previous commit and we expect
nothing else was broken by 9e83513eb, it's still better not include
lapi/syscalls.h to everything which uses new C API.

Fixes: 9e83513eb "tst_device.h: Use lapi/syscalls.h instead of <sys/syscall.h>"

Suggested-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Feel free to reject this one.

Kind regards,
Petr

 include/tst_device.h | 6 +-----
 lib/tst_device.c     | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 13d92ee54..64ea77768 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -19,7 +19,6 @@
 #define TST_DEVICE_H__
 
 #include <unistd.h>
-#include "lapi/syscalls.h"
 
 struct tst_device {
 	const char *dev;
@@ -76,10 +75,7 @@ int tst_detach_device(const char *dev_path);
  * simply before the tst_dev_bytes_written invocation. For easy to use,
  * we create this inline function tst_dev_sync.
  */
-static inline int tst_dev_sync(int fd)
-{
-	return syscall(__NR_syncfs, fd);
-}
+static int tst_dev_sync(int fd);
 
 /*
  * Reads test block device stat file and returns the bytes written since the
diff --git a/lib/tst_device.c b/lib/tst_device.c
index e78549c94..ade6fdd52 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -31,6 +31,7 @@
 #include <linux/loop.h>
 #include <stdint.h>
 #include <inttypes.h>
+#include "lapi/syscalls.h"
 #include "test.h"
 #include "safe_macros.h"
 
@@ -222,6 +223,11 @@ int tst_detach_device(const char *dev)
 	return 1;
 }
 
+static int tst_dev_sync(int fd)
+{
+	return syscall(__NR_syncfs, fd);
+}
+
 const char *tst_acquire_device__(unsigned int size)
 {
 	int fd;
-- 
2.24.1

