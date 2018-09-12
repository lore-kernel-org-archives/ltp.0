From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 12 Sep 2018 10:09:15 +0200
Subject: [LTP] [PATCH] sigwaitinfo01: recent glibc calls syscall directly
Message-ID: <dbe33b2d18cd674954668fa62ab61f0d57e0c704.1536739517.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

glibc commit
  8b0e795aaa44 ("Simplify Linux sig{timed}wait{info} implementations")
changed sigwaitinfo to call sigtimedwait, which calls rt_sigtimedwait
syscall directly.

So, an invalid pointer no longer crashes child process and test
reports failure. Fix it by accepting either crash or EFAULT.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    | 29 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 95a9436a44c9..02730364db4d 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -371,19 +371,40 @@ void test_bad_address2(swi_func sigwaitinfo, int signo)
 		tst_brkm(TBROK | TERRNO, NULL, "fork() failed");
 	case 0:
 		signal(SIGSEGV, SIG_DFL);
+
+		/*
+		 * depending on glibc implementation we should
+		 * either crash or get EFAULT
+		 */
 		TEST(sigwaitinfo((void *)1, NULL, NULL));
 
-		_exit(0);
+		if (TEST_RETURN == -1 && TEST_ERRNO == EFAULT)
+			_exit(0);
+
+		tst_resm(TINFO, "swi_func returned: %ld, errno: %d",
+			TEST_RETURN, TEST_ERRNO);
+		_exit(1);
 		break;
 	default:
 		break;
 	}
 
 	SUCCEED_OR_DIE(waitpid, "waitpid failed", pid, &status, 0);
-	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+
+	if ((WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
+		|| (WIFEXITED(status) && WEXITSTATUS(status) == 0)) {
 		tst_resm(TPASS, "Test passed");
-	else
-		tst_resm(TFAIL, "Unrecognised child exit code");
+		return;
+	}
+
+	if (WIFEXITED(status)) {
+		tst_resm(TFAIL, "Unrecognised child exit code: %d",
+			WEXITSTATUS(status));
+	}
+	if (WIFSIGNALED(status)) {
+		tst_resm(TFAIL, "Unrecognised child termsig: %d",
+			WTERMSIG(status));
+	}
 }
 
 void test_bad_address3(swi_func sigwaitinfo, int signo)
-- 
1.8.3.1

