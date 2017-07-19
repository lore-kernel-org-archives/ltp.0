From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 19 Jul 2017 19:01:29 +0800
Subject: [LTP] [PATCH] syscalls/clone09.c: Fix compilation without
	CLONE_NEWNET
Message-ID: <1500462089-3992-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on some older distributions(e.g. RHEL5.11) due
to undefined CLONE_NEWNET, so we include namespaces_constants.h to
fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/clone/clone09.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index 15aa438..ad4dbfb 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -23,6 +23,7 @@
 #include "tst_test.h"
 #include "clone_platform.h"
 #include "linux_syscall_numbers.h"
+#include "lapi/namespaces_constants.h" 
 
 static void *child_stack;
 static int sysctl_net = -1;
-- 
1.8.3.1



