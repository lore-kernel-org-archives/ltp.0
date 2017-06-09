From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  9 Jun 2017 09:35:30 -0700
Subject: [LTP] [PATCH] dirtyc0w: Include stdint.h
Message-ID: <20170609163530.29056-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

uintptr_t is defined in stdint.h

Fixes
| dirtyc0w_child.c:76:15: error: 'uintptr_t' undeclared (first use in this function); did you mean 'intptr_t'?
|    lseek(mfd, (uintptr_t) map, SEEK_SET);
|                ^~~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/security/dirtyc0w/dirtyc0w_child.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
index 5328a9bc4..49abdd6ba 100644
--- a/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
+++ b/testcases/kernel/security/dirtyc0w/dirtyc0w_child.c
@@ -23,6 +23,7 @@
 #include <sys/stat.h>
 #include <string.h>
 #include <stdlib.h>
+#include <stdint.h>
 #include <pwd.h>
 
 #include "tst_safe_pthread.h"
-- 
2.13.1

