From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 27 Jul 2016 18:41:21 +0800
Subject: [LTP] [PATCH] syscalls/sched_getparam03.c: Fix order of included
	headers
Message-ID: <1469616081-517-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on RHEL5.11GA and RHEL6.8GA because definition of clone()
function in sched.h will be replaced by the test.h defined clone(...) macro.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/sched_getparam/sched_getparam03.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
index dec6e41..ceec4c3 100644
--- a/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
+++ b/testcases/kernel/syscalls/sched_getparam/sched_getparam03.c
@@ -70,10 +70,9 @@
  *
  *********************************************************************/
 
-#include "test.h"
-
 #include <errno.h>
 #include <sched.h>
+#include "test.h"
 
 #define LARGE_PID 999999
 
-- 
1.8.3.1



