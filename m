From: Khem Raj <raj.khem@gmail.com>
Date: Thu,  7 Jan 2016 07:38:01 +0000
Subject: [LTP] [PATCH] remove inclusion of deprecated sys/kdaemon.h header
Message-ID: <1452152281-128165-1-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

glibc 2.23+ has dropped this header and moreover its not used in
testcase

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
Upstream-Status: Pending

 testcases/kernel/syscalls/bdflush/bdflush01.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/bdflush/bdflush01.c b/testcases/kernel/syscalls/bdflush/bdflush01.c
index df739f1..a529ba9 100644
--- a/testcases/kernel/syscalls/bdflush/bdflush01.c
+++ b/testcases/kernel/syscalls/bdflush/bdflush01.c
@@ -81,7 +81,6 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sys/stat.h>
-#include <sys/kdaemon.h>
 
 #include "test.h"
 #include "linux_syscall_numbers.h"
-- 
2.6.4

