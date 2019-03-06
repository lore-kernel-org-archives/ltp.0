From: Cyril Hrubis <metan@ucw.cz>
Date: Wed,  6 Mar 2019 16:21:04 +0100
Subject: [LTP] [RFC PATCH 2/2] syscalls/select04: Test four syscall variants
In-Reply-To: <20190306152104.24828-1-metan@ucw.cz>
References: <20190306152104.24828-1-metan@ucw.cz>
Message-ID: <20190306152104.24828-2-metan@ucw.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <chrubis@suse.cz>

This commit makes use of the newly added test_multiplex() function to
switch between different syscall variants/wrappers at runtime.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Mark Salyzyn <salyzyn@android.com>
CC: Steve Muckle <smuckle@google.com>
CC: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/select/select04.c   |  5 +-
 testcases/kernel/syscalls/select/select_mpx.h | 79 +++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/select/select_mpx.h

diff --git a/testcases/kernel/syscalls/select/select04.c b/testcases/kernel/syscalls/select/select04.c
index 86bdffcdf..300992233 100644
--- a/testcases/kernel/syscalls/select/select04.c
+++ b/testcases/kernel/syscalls/select/select04.c
@@ -27,6 +27,8 @@
 
 #include "tst_timer_test.h"
 
+#include "select_mpx.h"
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
 
@@ -69,5 +71,6 @@ static struct tst_test test = {
 	.scall = "select()",
 	.sample = sample_fn,
 	.setup = setup,
+	.test_multiplex = select_mpx,
 	.cleanup = cleanup,
 };
diff --git a/testcases/kernel/syscalls/select/select_mpx.h b/testcases/kernel/syscalls/select/select_mpx.h
new file mode 100644
index 000000000..39c4e6517
--- /dev/null
+++ b/testcases/kernel/syscalls/select/select_mpx.h
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2019 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+#ifndef SELECT_MPX
+#define SELECT_MPX
+
+#include "lapi/syscalls.h"
+
+static int sys_mpx = -1;
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
+	switch (sys_mpx) {
+	case 0:
+		return select(nfds, readfds, writefds, exceptfds, timeout);
+	break;
+	case 1:
+		return tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, timeout);
+	break;
+	case 2: {
+		struct compat_sel_arg_struct arg = {
+			._n = (long)nfds,
+			._inp = (long)readfds,
+			._outp = (long)writefds,
+			._exp = (long)exceptfds,
+			._tvp = (long)timeout,
+		};
+
+		return tst_syscall(__NR_select, &arg);
+	}
+	case 3: {
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
+	}
+
+	return -1;
+}
+
+static int select_mpx(void)
+{
+	switch (++sys_mpx) {
+	case 0:
+		tst_res(TINFO, "Testing glibc select()");
+	break;
+	case 1:
+		tst_res(TINFO, "Testing SYS__newselect syscall");
+	break;
+	case 2:
+		tst_res(TINFO, "Testing SYS_select syscall");
+	break;
+	case 3:
+		tst_res(TINFO, "Testing SYS_pselect6 syscall");
+	break;
+	case 4:
+		sys_mpx = -1;
+		return 0;
+	}
+
+	return 1;
+}
+
+#endif /* SELECT_MPX */
-- 
2.19.2

