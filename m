From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Jan 2020 12:37:14 +0100
Subject: [LTP] [PATCH 2/3] tst_device.h: Use lapi/syscalls.h instead of
 <sys/syscall.h>
In-Reply-To: <20200117113715.22786-1-pvorel@suse.cz>
References: <20200117113715.22786-1-pvorel@suse.cz>
Message-ID: <20200117113715.22786-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As a fallback for old distros which does not define __NR_syncfs
(the dependency is in the library itself).

This was needed on SLES 11 (kernel 2.6.32).

Fixes: 74aeb88c9 ("tst_device: use raw syscall in the tst_device.h")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_device.h b/include/tst_device.h
index 3db5275c9..13d92ee54 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -19,7 +19,7 @@
 #define TST_DEVICE_H__
 
 #include <unistd.h>
-#include <sys/syscall.h>
+#include "lapi/syscalls.h"
 
 struct tst_device {
 	const char *dev;
-- 
2.24.1

