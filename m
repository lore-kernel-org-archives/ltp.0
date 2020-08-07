From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  7 Aug 2020 12:58:44 +0200
Subject: [LTP] [PATCH] syscalls/clone302: drop CLONE_CHILD_SETTID and
 CLONE_PARENT_SETTID
Message-ID: <8eefb21d278f0846024a16281c5e19b0e3936979.1596797812.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Per https://lore.kernel.org/linux-m68k/20200627122332.ki2otaiw3v7wndbl@wittgenstein/T/#u
EFAULT isn't propagated back to userspace so these will always appear
to succeed. Also issue is that multiple flags are tested together
and some arguments persisted between calls, because they were set
only when argument != NULL.

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clone3/clone302.c | 42 +++++++++++----------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
index a30df6f8286e..54d59a1f571a 100644
--- a/testcases/kernel/syscalls/clone3/clone302.c
+++ b/testcases/kernel/syscalls/clone3/clone302.c
@@ -21,27 +21,33 @@ static struct tcase {
 	size_t size;
 	uint64_t flags;
 	int **pidfd;
-	int **child_tid;
-	int **parent_tid;
 	int exit_signal;
 	unsigned long stack;
 	unsigned long stack_size;
 	unsigned long tls;
 	int exp_errno;
 } tcases[] = {
-	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
-	{"zero size", &valid_args, 0, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
-	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"fs-newns", &valid_args, sizeof(*valid_args), CLONE_FS | CLONE_NEWNS, NULL, NULL, NULL, SIGCHLD, 0, 0, 0, EINVAL},
-	{"invalid pidfd", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, &invalid_address, NULL, NULL, SIGCHLD, 0, 0, 0, EFAULT},
-	{"invalid childtid", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, &invalid_address, NULL, SIGCHLD, 0, 0, 0, EFAULT},
-	{"invalid parenttid", &valid_args, sizeof(*valid_args), CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, NULL, NULL, &invalid_address, SIGCHLD, 0, 0, 0, EFAULT},
-	{"invalid signal", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, CSIGNAL + 1, 0, 0, 0, EINVAL},
-	{"zero-stack-size", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, (unsigned long)&stack, 0, 0, EINVAL},
-	{"invalid-stack", &valid_args, sizeof(*valid_args), 0, NULL, NULL, NULL, SIGCHLD, 0, 4, 0, EINVAL},
+	{"invalid args", &invalid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
+	{"zero size", &valid_args, 0, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"short size", &valid_args, sizeof(*valid_args) - 1, 0, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"extra size", &valid_args, sizeof(*valid_args) + 1, 0, NULL, SIGCHLD, 0, 0, 0, EFAULT},
+	{"sighand-no-VM", &valid_args, sizeof(*valid_args), CLONE_SIGHAND, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"thread-no-sighand", &valid_args, sizeof(*valid_args), CLONE_THREAD, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"fs-newns", &valid_args, sizeof(*valid_args), CLONE_FS | CLONE_NEWNS, NULL, SIGCHLD, 0, 0, 0, EINVAL},
+	{"invalid pidfd", &valid_args, sizeof(*valid_args), CLONE_PIDFD, &invalid_address, SIGCHLD, 0, 0, 0, EFAULT},
+	{"invalid signal", &valid_args, sizeof(*valid_args), 0, NULL, CSIGNAL + 1, 0, 0, 0, EINVAL},
+	{"zero-stack-size", &valid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, (unsigned long)&stack, 0, 0, EINVAL},
+	{"invalid-stack", &valid_args, sizeof(*valid_args), 0, NULL, SIGCHLD, 0, 4, 0, EINVAL},
+	/*
+	 * Don't test CLONE_CHILD_SETTID and CLONE_PARENT_SETTID:
+	 * When the parent tid is written to the memory location for
+	 * CLONE_PARENT_SETTID we're past the point of no return of process
+	 * creation, i.e. the return value from put_user() isn't checked and
+	 * can't be checked anymore so you'd never receive EFAULT for a bogus
+	 * parent_tid memory address.
+	 *
+	 * https://lore.kernel.org/linux-m68k/20200627122332.ki2otaiw3v7wndbl@wittgenstein/T/#u
+	 */
 };
 
 static void setup(void)
@@ -63,10 +69,8 @@ static void run(unsigned int n)
 		args->flags = tc->flags;
 		if (tc->pidfd)
 			args->pidfd = (uint64_t)(*tc->pidfd);
-		if (tc->child_tid)
-			args->child_tid = (uint64_t)(*tc->child_tid);
-		if (tc->parent_tid)
-			args->parent_tid = (uint64_t)(*tc->parent_tid);
+		else
+			args->pidfd = 0;
 		args->exit_signal = tc->exit_signal;
 		args->stack = tc->stack;
 		args->stack_size = tc->stack_size;
-- 
2.18.1

