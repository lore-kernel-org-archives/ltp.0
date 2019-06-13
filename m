From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Jun 2019 09:24:01 +0200
Subject: [LTP] [PATCH v3 3/3] syscalls/ioctl_ns0[156]: align stack and wait
	for child
In-Reply-To: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
References: <adca7c08dbf20805da9b99a7fa03d498de70235d.1560410182.git.jstancek@redhat.com>
Message-ID: <1b6ddab9cd8e3620da9e37b1132e911280c22e32.1560410182.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test crashes (SIGBUS) when using child stack have been observed for
ioctl_ns01. This is because stack isn't aligned. Use ltp_alloc_stack()
for stack allocation.

Add SIGCHLD to clone flags, so that LTP library can reap all children
and check their return code.  Also check ltp_clone() return value.

Suppress warning for unused *arg in child().

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 13 +++++++++----
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 12 +++++++++---
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 15 +++++++++++----
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index dfde4da6c5d6..d241a5d0fa53 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -23,7 +23,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char *child_stack;
 
 static void setup(void)
 {
@@ -31,6 +31,10 @@ static void setup(void)
 
 	if (exists < 0)
 		tst_res(TCONF, "namespace not available");
+
+	child_stack = ltp_alloc_stack(STACK_SIZE);
+	if (!child_stack)
+		tst_brk(TBROK|TERRNO, "stack alloc");
 }
 
 static void test_ns_get_parent(void)
@@ -53,7 +57,7 @@ static void test_ns_get_parent(void)
 	}
 }
 
-static int child(void *arg)
+static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	test_ns_get_parent();
 	return 0;
@@ -63,8 +67,9 @@ static void run(void)
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
index a8dee07a1154..7455ff17caf3 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -22,7 +22,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char *child_stack;
 
 static void setup(void)
 {
@@ -30,9 +30,13 @@ static void setup(void)
 
 	if (exists < 0)
 		tst_res(TCONF, "namespace not available");
+
+	child_stack = ltp_alloc_stack(STACK_SIZE);
+	if (!child_stack)
+		tst_brk(TBROK|TERRNO, "stack alloc");
 }
 
-static int child(void *arg)
+static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	if (getpid() != 1)
 		tst_res(TFAIL, "child should think its pid is 1");
@@ -44,8 +48,10 @@ static int child(void *arg)
 
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
index 805a0a072e2f..6b137e64ff25 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -23,7 +23,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char *child_stack;
 
 static void setup(void)
 {
@@ -31,9 +31,13 @@ static void setup(void)
 
 	if (exists < 0)
 		tst_res(TCONF, "namespace not available");
+
+	child_stack = ltp_alloc_stack(STACK_SIZE);
+	if (!child_stack)
+		tst_brk(TBROK|TERRNO, "stack alloc");
 }
 
-static int child(void *arg)
+static int child(void *arg LTP_ATTRIBUTE_UNUSED)
 {
 	TST_CHECKPOINT_WAIT(0);
 	return 0;
@@ -41,10 +45,13 @@ static int child(void *arg)
 
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

