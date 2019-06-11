From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 11 Jun 2019 09:43:40 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_ns01: fix crash on aarch64
Message-ID: <2abbf8596a01ea056f6e7c9e6c481d67093cea0c.1560238866.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test crashes with SIGBUS when using child stack. Align stack to 256 bytes,
which is more than enough for any arch.

Neither parent or library is waiting for child process. Add SIGCHLD to
clone flags.

Check return value of ltp_clone(), and TBROK on failure.

Fix warning about unused *arg.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns01.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
index dfde4da6c5d6..625de9bd832d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns01.c
@@ -23,7 +23,7 @@
 
 #define STACK_SIZE (1024 * 1024)
 
-static char child_stack[STACK_SIZE];
+static char child_stack[STACK_SIZE] __attribute__((aligned(256)));
 
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
@@ -61,10 +61,14 @@ static int child(void *arg)
 
 static void run(void)
 {
+	int child_pid;
+
 	test_ns_get_parent();
 
-	ltp_clone(CLONE_NEWPID, &child, 0,
+	child_pid = ltp_clone(CLONE_NEWPID | SIGCHLD, &child, 0,
 		STACK_SIZE, child_stack);
+	if (child_pid == -1)
+		tst_brk(TBROK | TERRNO, "ltp_clone failed");
 }
 
 static struct tst_test test = {
-- 
1.8.3.1

