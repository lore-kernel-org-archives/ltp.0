From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Thu, 26 Oct 2017 11:44:47 +0800
Subject: [LTP] [PATCH] syscalls/ptrace07.c: Fix compilation without
	WIFEXITED and WEXITSTATUS
Message-ID: <1508989487-6715-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Compilation failed on some older distributions due to undefined
WIFEXITED and WEXITSTATUS, so we include sys/wait.h to fix it.

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ptrace/ptrace07.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index d561b30..82698a4 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -42,6 +42,7 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/uio.h>
+#include <sys/wait.h>
 
 #include "config.h"
 #include "ptrace.h"
-- 
1.8.3.1



