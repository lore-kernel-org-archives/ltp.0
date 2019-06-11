From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Jun 2019 12:25:18 +0200
Subject: [LTP] [PATCH v2] syscalls/ioctl_ns0[156]: align stack and wait for
	child
Message-ID: <916c20b9a379badd37a85aa1e1339566c9807d23.1560248542.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test crashes (SIGBUS) when using child stack have been observed for
ioctl_ns01. Align stack to 64 bytes for all testcases using clone,
which should work for any arch.

Add SIGCHLD to clone flags, so that LTP library can reap all children
and check their return code.  Also check ltp_clone() return value.

Suppress warning for unused *arg in child().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c |  9 +++++----
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c |  8 +++++---
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 11 +++++++----
 3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index dfde4da6c5d6..a6ff57d4cbf9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -23,7 +23,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char child_stack[STACK_SIZE] __attribute__((aligned(64)));
 
 static void setup(void)
 {
@@ -53,7 +53,7 @@ static void test_ns_get_parent(void)
 	}
 }
 
-static int child(void *arg)
+static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	test_ns_get_parent();
 	return 0;
@@ -63,8 +63,9 @@ static void run(void)
 {
 	test_ns_get_parent();
 
-	ltp_clone(CLONE_NEWPID, &child, 0,
-		STACK_SIZE, child_stack);
+	if (ltp_clone(CLONE_NEWPID | SIGCHLD, &child, 0,
+		STACK_SIZE, child_stack) == -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index a8dee07a1154..685a5f683b25 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -22,7 +22,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char child_stack[STACK_SIZE] __attribute__((aligned(64)));
 
 static void setup(void)
 {
@@ -32,7 +32,7 @@ static void setup(void)
 		tst_res(TCONF, "namespace not available");
 }
 
-static int child(void *arg)
+static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	if (getpid() != 1)
 		tst_res(TFAIL, "child should think its pid is 1");
@@ -44,8 +44,10 @@ static int child(void *arg)
 
 static void run(void)
 {
-	pid_t pid = ltp_clone(CLONE_NEWPID, &child, 0,
+	pid_t pid = ltp_clone(CLONE_NEWPID | SIGCHLD, &child, 0,
 		STACK_SIZE, child_stack);
+	if (pid == -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
 
 	char child_namespace[20];
 	int my_fd, child_fd, parent_fd;
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index 805a0a072e2f..bf5800434723 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -23,7 +23,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char child_stack[STACK_SIZE] __attribute__((aligned(64)));
 
 static void setup(void)
 {
@@ -33,7 +33,7 @@ static void setup(void)
 		tst_res(TCONF, "namespace not available");
 }
 
-static int child(void *arg)
+static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	TST_CHECKPOINT_WAIT(0);
 	return 0;
@@ -41,10 +41,13 @@ static int child(void *arg)
 
 static void run(void)
 {
-	pid_t pid = ltp_clone(CLONE_NEWUSER, &child, 0,
-		STACK_SIZE, child_stack);
 	char child_namespace[20];
 
+	pid_t pid = ltp_clone(CLONE_NEWUSER | SIGCHLD, &child, 0,
+		STACK_SIZE, child_stack);
+	if (pid == -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
+
 	sprintf(child_namespace, "/proc/%i/ns/user", pid);
 	int my_fd, child_fd, parent_fd;
 
-- 
1.8.3.1

