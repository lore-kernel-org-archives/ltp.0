From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 22 Mar 2019 18:11:34 +0100
Subject: [LTP] [PATCH v3 2/2] syscalls/select04: Test four syscall variants
In-Reply-To: <20190322171134.899-1-chrubis@suse.cz>
References: <20190322171134.899-1-chrubis@suse.cz>
Message-ID: <20190322171134.899-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit makes use of the newly added test_multiplex() function to
switch between different syscall variants/wrappers at runtime.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
CC: Steve Muckle <smuckle@google.com>
CC: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/select/select04.c   |  7 +-
 testcases/kernel/syscalls/select/select_var.h | 82 +++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/select/select_var.h

diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 86bdffcdf..64aa4ac9b 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -27,6 +27,8 @@
 
 #include "tst_timer_test.h"
 
+#include "select_var.h"
+
 static int fds[2];
 
 static int sample_fn(int clk_id, long long usec)
@@ -39,7 +41,7 @@ static int sample_fn(int clk_id, long long usec)
 	FD_SET(fds[0], &sfds);
 
 	tst_timer_start(clk_id);
-	TEST(select(1, &sfds, NULL, NULL, &timeout));
+	TEST(do_select(1, &sfds, NULL, NULL, &timeout));
 	tst_timer_stop();
 	tst_timer_sample();
 
@@ -53,6 +55,8 @@ static int sample_fn(int clk_id, long long usec)
 
 static void setup(void)
 {
+	select_info();
+
 	SAFE_PIPE(fds);
 }
 
@@ -69,5 +73,6 @@ static struct tst_test test = {
 	.scall = "select()",
 	.sample = sample_fn,
 	.setup = setup,
+	.test_variants = TEST_VARIANTS,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
new file mode 100644
index 000000000..d0bc5550e
--- /dev/null
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -0,0 +1,82 @@
+/*
+ * Copyright (C) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef SELECT_MPX
+#define SELECT_MPX
+
+#include "lapi/syscalls.h"
+
+struct compat_sel_arg_struct {
+	long _n;
+	long _inp;
+	long _outp;
+	long _exp;
+	long _tvp;
+};
+
+static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout)
+{
+	switch (tst_variant) {
+	case 0:
+		return select(nfds, readfds, writefds, exceptfds, timeout);
+	break;
+	case 1: {
+#ifdef __LP64__
+		return tst_syscall(__NR_select, nfds, readfds, writefds, exceptfds, timeout);
+#else
+		struct compat_sel_arg_struct arg = {
+			._n = (long)nfds,
+			._inp = (long)readfds,
+			._outp = (long)writefds,
+			._exp = (long)exceptfds,
+			._tvp = (long)timeout,
+		};
+
+		return tst_syscall(__NR_select, &arg);
+#endif /* __LP64__ */
+	}
+	case 2: {
+		int ret;
+		struct timespec ts = {
+			.tv_sec = timeout->tv_sec,
+			.tv_nsec = timeout->tv_usec * 1000,
+		};
+		ret = tst_syscall(__NR_pselect6, nfds, readfds, writefds, exceptfds, &ts, NULL);
+		timeout->tv_sec = ts.tv_sec;
+		timeout->tv_usec = ts.tv_nsec / 1000;
+		return ret;
+	}
+	case 3:
+#ifdef __NR__newselect
+		return tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, timeout);
+#else
+		tst_brk(TCONF, "__NR__newselect not implemented");
+#endif
+	break;
+	}
+
+	return -1;
+}
+
+static void select_info(void)
+{
+	switch (tst_variant) {
+	case 0:
+		tst_res(TINFO, "Testing glibc select()");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing SYS_select syscall");
+	break;
+	case 2:
+		tst_res(TINFO, "Testing SYS_pselect6 syscall");
+	break;
+	case 3:
+		tst_res(TINFO, "Testing SYS__newselect syscall");
+	break;
+	}
+}
+
+#define TEST_VARIANTS 4
+
+#endif /* SELECT_MPX */
-- 
2.19.2

