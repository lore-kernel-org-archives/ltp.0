From: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 15 Jul 2021 09:39:29 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_ns05,6: Fix buffer overflow
Message-ID: <1626313169-30611-1-git-send-email-xuyang2018.jy@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since pid's max value is 2147483647, the child_namespace maybe not
enough to store "/proc/%s/ns/user" string when using a large pid.
Fix it by improving the length to 30.

Fixes: #847
Reported-by: Marius Hillenbrand <mhillen@linux.ibm.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index a67ddbe2c..488c48d8e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -59,7 +59,7 @@ static void run(void)
 	if (pid == -1)
 		tst_brk(TBROK | TERRNO, "ltp_clone failed");
 
-	char child_namespace[20];
+	char child_namespace[30];
 	int my_fd, child_fd, parent_fd;
 
 	sprintf(child_namespace, "/proc/%i/ns/pid", pid);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index b6ac80208..77ec04edc 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -51,7 +51,7 @@ static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 
 static void run(void)
 {
-	char child_namespace[20];
+	char child_namespace[30];
 
 	pid_t pid = ltp_clone(CLONE_NEWUSER | SIGCHLD, &child, 0,
 		STACK_SIZE, child_stack);
-- 
2.23.0

