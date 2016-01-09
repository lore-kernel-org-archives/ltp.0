From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:20 +0000
Subject: [LTP] [PATCH V2 32/32] regen.sh: Include asm/unistd.h explicitly
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-32-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on musl this is not included indirectly and it results in errors like
testcases/kernel/include/linux_syscall_numbers.h:1035:25: error:
'__NR_SYSCALL_BASE' undeclared (first use in this function)
|  #  define __NR_readdir (__NR_SYSCALL_BASE+ 89)

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/include/regen.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index f93f49b..ee790af 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -32,6 +32,7 @@ cat << EOF > "${output_pid}"
 
 #include <errno.h>
 #include <sys/syscall.h>
+#include <asm/unistd.h>
 #include "cleanup.c"
 
 #define ltp_syscall(NR, ...) ({ \\
-- 
2.7.0

