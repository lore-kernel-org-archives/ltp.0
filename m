From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 21 Dec 2018 14:51:43 +0100
Subject: [LTP] [PATCH] syscalls/ptrace07: handle potential SIGSEGV on older
	kernels
Message-ID: <b8db71df3a21f600e2a52064df6d2a21ed2195a9.1545400016.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If a ptraced test process hits SIGSEGV, the entire testcase hangs.

Older kernels such as RHEL7 (3.10.0), check the error code returned
by restore_fpu_checking() and do drop_init_fpu() if it fails.
So the FPU state of the prev task can't leak.

But in the more likely case a task with xcomp_bv != 0 will be killed
by SIGSEGV; either from do_device_not_available() or from
sys_rt_sigreturn()->__restore_xstate_sig().

And this is why the test case hangs; it wrongly assumes that the
traced child can only exit and report nothing else. But since it
receives SIGSEGV it reports this signal to the main process and
sleeps in ptrace_stop(), it does not exit and thus the test-case
hangs in tst_reap_children() after return from do_test().

Replace PTRACE_CONT with PTRACE_DETACH, so we don't need to
handle subsequent stops. And treat exit code from test process
as info-only.

Debugged-by: Oleg Nesterov <onestero@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ptrace/ptrace07.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index 46ae59a105cf..9cbaefc3fbda 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -153,12 +153,32 @@ static void do_test(void)
 			"PTRACE_SETREGSET failed with unexpected error");
 	}
 
-	TEST(ptrace(PTRACE_CONT, pid, 0, 0));
+	/*
+	 * It is possible for test child 'pid' to crash on AMD
+	 * systems (e.g. AMD Opteron(TM) Processor 6234) with
+	 * older kernels. This causes tracee to stop and sleep
+	 * in ptrace_stop(). Without resuming the tracee, the
+	 * test hangs at do_test()->tst_reap_children() called
+	 * by the library. Use detach here, so we don't need to
+	 * worry about potential stops after this point.
+	 */
+	TEST(ptrace(PTRACE_DETACH, pid, 0, 0));
 	if (TST_RET != 0)
-		tst_brk(TBROK | TTERRNO, "PTRACE_CONT failed");
+		tst_brk(TBROK | TTERRNO, "PTRACE_DETACH failed");
+
+	/* If child 'pid' crashes, only report it as info. */
+	SAFE_WAITPID(pid, &status, 0);
+	if (WIFEXITED(status)) {
+		tst_res(TINFO, "test child %d exited, retcode: %d",
+			pid, WEXITSTATUS(status));
+	}
+	if (WIFSIGNALED(status)) {
+		tst_res(TINFO, "test child %d exited, termsig: %d",
+			pid, WTERMSIG(status));
+	}
 
 	okay = true;
-	for (i = 0; i < num_cpus + 1; i++) {
+	for (i = 0; i < num_cpus; i++) {
 		SAFE_WAIT(&status);
 		okay &= (WIFEXITED(status) && WEXITSTATUS(status) == 0);
 	}
-- 
1.8.3.1

