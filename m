From: Greg Hackmann <ghackmann@google.com>
Date: Thu,  1 Nov 2018 15:34:16 -0700
Subject: [LTP] [PATCH] fork/fork05: replace assembly block with ltp_syscall()
Message-ID: <20181101223416.118325-1-ghackmann@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When an x86 kernel is built with CONFIG_MODIFY_LTP_SYSCALL=n, the
modify_ltp syscall fails with ENOSYS and fork05 crashes.

Reimplementing modify_ldt() using ltp_syscall(__NR_modify_ldt) causes
fork05 to gracefully exit with TCONF instead.  Plus it's arguably much
clearer than a hard-coded int 0x80 call in assembly.

Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 testcases/kernel/syscalls/fork/fork05.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork05.c b/testcases/kernel/syscalls/fork/fork05.c
index 65400c324..ce03dcd22 100644
--- a/testcases/kernel/syscalls/fork/fork05.c
+++ b/testcases/kernel/syscalls/fork/fork05.c
@@ -104,6 +104,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <sys/wait.h>
+#include "lapi/syscalls.h"
 #include "test.h"
 
 char *TCID = "fork05";
@@ -130,18 +131,10 @@ struct modify_ldt_ldt_s {
 
 static int a = 42;
 
-static void modify_ldt(int, struct modify_ldt_ldt_s *, int);
-asm("	.text\n\
-	.type modify_ldt,@function \n\
-modify_ldt: \n\
-	push   %ebx \n\
-	mov    0x10(%esp,1),%edx \n\
-	mov    0xc(%esp,1),%ecx \n\
-	mov    0x8(%esp,1),%ebx \n\
-	mov    $0x7b,%eax \n\
-	int    $0x80 \n\
-	pop    %ebx \n\
-	ret");
+static void modify_ldt(int func, struct modify_ldt_ldt_s *ptr, int bytecount)
+{
+	ltp_syscall(__NR_modify_ldt, func, ptr, bytecount);
+}
 
 int main(void)
 {
-- 
2.19.1.930.g4563a0d9d0-goog

