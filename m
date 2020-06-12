From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 12 Jun 2020 11:30:51 +0800
Subject: [LTP] [PATCH] syscalls/mmap17: Remove useless error.h
Message-ID: <1591932651-3136-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In this test, we don't use error() or error_at_line() function, so
remove this header file. It also fix build error on alpine:latest.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mmap/mmap17.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap17.c b/testcases/kernel/syscalls/mmap/mmap17.c
index bd3642e97..0001c3794 100644
--- a/testcases/kernel/syscalls/mmap/mmap17.c
+++ b/testcases/kernel/syscalls/mmap/mmap17.c
@@ -20,7 +20,6 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <error.h>
 #include <errno.h>
 #include <string.h>
 #include <stdlib.h>
-- 
2.23.0



