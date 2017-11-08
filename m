From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Wed, 8 Nov 2017 11:13:14 +0800
Subject: [LTP] [PATCH] cpuset_syscall_test/cpuset_syscall_test.c: Fix
	compilation with wrong macro definition
Message-ID: <1510110794-7375-1-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 .../kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 9e568a9..e2bc39b 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -51,7 +51,7 @@
 char *TCID = "cpuset_syscall_test";
 int TST_TOTAL = 1;
 
-#ifdef defined(HAVE_NUMA_V2) && defined(HAVE_LINUX_MEMPOLICY_H)
+#if defined(HAVE_NUMA_V2) && defined(HAVE_LINUX_MEMPOLICY_H)
 
 #include "../cpuset_lib/cpuset.h"
 #include "../cpuset_lib/bitmask.h"
-- 
1.8.3.1



