From: Steve Muckle <smuckle.linux@gmail.com>
Date: Tue,  5 Sep 2017 13:40:29 -0700
Subject: [LTP] [PATCH] syscalls/kcmp03: work around bug in C library
Message-ID: <20170905204029.66280-1-smuckle.linux@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Some versions of glibc and bionic report the same PID for parent and
child when clone() is called with CLONE_VM but not CLONE_THREAD. This
causes an issue in the cleanup path which is supposed to execute in the
parent. If kcmp() support is not present, the child aborts and then
erroneously runs the cleanup handler, freeing its own stack.

Avoid this by statically allocating the stack.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
---
 testcases/kernel/syscalls/kcmp/kcmp03.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
index b6ca40cff..465cb1e8b 100644
--- a/testcases/kernel/syscalls/kcmp/kcmp03.c
+++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
@@ -40,7 +40,13 @@
 
 static int pid1;
 static int pid2;
-static void *stack;
+
+/*
+ * The cleanup handler may be run in the child due to a bug in some versions of
+ * glibc and bionic when clone() is called with CLONE_VM but not CLONE_THREAD.
+ * Use static allocation of stack to avoid this.
+ */
+static char stack[STACK_SIZE];
 
 static struct tcase {
 	int clone_type;
@@ -52,16 +58,6 @@ static struct tcase {
 	{CLONE_SYSVSEM, KCMP_SYSVSEM}
 };
 
-static void setup(void)
-{
-	stack = SAFE_MALLOC(STACK_SIZE);
-}
-
-static void cleanup(void)
-{
-	free(stack);
-}
-
 static int do_child(void *arg)
 {
 	pid2 = getpid();
@@ -96,8 +92,6 @@ static void verify_kcmp(unsigned int n)
 
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
-	.setup = setup,
-	.cleanup = cleanup,
 	.forks_child = 1,
 	.test = verify_kcmp,
 	.min_kver = "3.5.0"
-- 
2.14.1.581.gf28d330327-goog

