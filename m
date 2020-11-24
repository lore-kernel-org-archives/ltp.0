From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2020 13:01:54 +0100
Subject: [LTP] [PATCH] syscalls/select03: Fix segfaults on aarch64
Message-ID: <20201124120154.27017-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The select() syscall is implemented via pselect6() in aarch64 glibc, which
means that glibc has to convert the timeout from timeval to timespec hence it
will segfault rather than return EFAULT.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/select/select03.c   | 30 ++++++++++++++++++-
 testcases/kernel/syscalls/select/select_var.h |  2 ++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
index fb52284ce..1cec3a4c7 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -7,8 +7,10 @@
 
 #include <unistd.h>
 #include <errno.h>
+#include <stdlib.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <sys/wait.h>
 #include <fcntl.h>
 #include "select_var.h"
 
@@ -40,7 +42,7 @@ static struct tcases {
 	{ "Faulty timeout", &maxfds, &preadfds_reg, &pwritefds_reg, &nullfds, &invalid_to, EFAULT },
 };
 
-static void run(unsigned int n)
+static void verify_select(unsigned int n)
 {
 	struct tcases *tc = &tests[n];
 
@@ -61,6 +63,31 @@ static void run(unsigned int n)
 	}
 
 	tst_res(TPASS | TTERRNO, "%s: select() failed as expected", tc->name);
+
+	exit(0);
+}
+
+static void run(unsigned int n)
+{
+	int pid, status;
+
+	pid = SAFE_FORK();
+	if (!pid)
+		verify_select(n);
+
+	SAFE_WAITPID(pid, &status, 0);
+
+	if (WIFEXITED(status))
+		return;
+
+	if (tst_variant == GLIBC_SELECT_VARIANT &&
+	    tests[n].timeout == &invalid_to &&
+	    WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
+		tst_res(TPASS, "%s: select() killed by signal", tests[n].name);
+		return;
+	}
+
+	tst_res(TFAIL, "Child %s", tst_strstatus(status));
 }
 
 static void setup(void)
@@ -94,4 +121,5 @@ static struct tst_test test = {
 	.test_variants = TEST_VARIANTS,
 	.setup = setup,
 	.needs_tmpdir = 1,
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index c8a8eb64e..a17b2fdd6 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -16,6 +16,8 @@ struct compat_sel_arg_struct {
 	long _tvp;
 };
 
+#define GLIBC_SELECT_VARIANT 0
+
 static int do_select_faulty_to(int nfds, fd_set *readfds, fd_set *writefds,
 		fd_set *exceptfds, struct timeval *timeout, int faulty_to)
 {
-- 
2.26.2

