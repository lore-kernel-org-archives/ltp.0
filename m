From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 11 Feb 2021 17:45:41 +0000
Subject: [LTP] [PATCH v2 3/5] API: Fix clone.h
In-Reply-To: <20210211174543.25003-1-rpalethorpe@suse.com>
References: <20210211174543.25003-1-rpalethorpe@suse.com>
Message-ID: <20210211174543.25003-4-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Functions in headers should be static inline. Also add stdint.h
because it results in confusing error messages if it is missing.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/lapi/clone.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/lapi/clone.h b/include/lapi/clone.h
index 2b8cbdbe0..81db443c9 100644
--- a/include/lapi/clone.h
+++ b/include/lapi/clone.h
@@ -10,6 +10,7 @@
 #include <sys/syscall.h>
 #include <linux/types.h>
 #include <sched.h>
+#include <stdint.h>
 
 #include "config.h"
 #include "lapi/syscalls.h"
@@ -26,7 +27,7 @@ struct clone_args {
 	uint64_t __attribute__((aligned(8))) tls;
 };
 
-int clone3(struct clone_args *args, size_t size)
+static inline int clone3(struct clone_args *args, size_t size)
 {
 	return tst_syscall(__NR_clone3, args, size);
 }
@@ -36,7 +37,7 @@ int clone3(struct clone_args *args, size_t size)
 #define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
 #endif
 
-void clone3_supported_by_kernel(void)
+static inline void clone3_supported_by_kernel(void)
 {
 	if ((tst_kvercmp(5, 3, 0)) < 0) {
 		/* Check if the syscall is backported on an older kernel */
-- 
2.30.0

