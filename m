From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Sep 2017 17:18:26 +0200
Subject: [LTP] [PATCH 1/2] [COMMITTED] syscalls/shmat01: Fix test on 32bit
Message-ID: <20170912151827.20551-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The problem there is that the address casted to intptr_t yields negative
number which when divided then multiplied by SHMLBA aligns the value up
instead of down.

The fix is simple, we cast the pointer to uintptr_t instead of intptr_t
and also include stdint.h explicitly.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 4f5c4e725..4c6ce58d3 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -35,12 +35,13 @@
 #include <sys/shm.h>
 #include <sys/wait.h>
 #include <stdlib.h>
+#include <stdint.h>
 
 #include "tst_test.h"
 #include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
-#define ALIGN_DOWN(in_addr) ((void *)(((intptr_t)in_addr / SHMLBA) * SHMLBA))
+#define ALIGN_DOWN(in_addr) ((void *)(((uintptr_t)in_addr / SHMLBA) * SHMLBA))
 
 static int shm_id = -1;
 static key_t shm_key;
-- 
2.13.0

