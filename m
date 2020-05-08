From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri,  8 May 2020 09:53:58 +0530
Subject: [LTP] [PATCH V2 13/17] syscalls/select6: Add support for time64
 tests
In-Reply-To: <cover.1588911607.git.viresh.kumar@linaro.org>
References: <cover.1588911607.git.viresh.kumar@linaro.org>
Message-ID: <614763566d03f6d88fa0d60d15a719bbbc467cd0.1588911607.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This adds support for time64 tests to the existing select6() syscall
tests.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/select/select_var.h | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index b19a1d1bf085..6e8d44088217 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -6,6 +6,8 @@
 #define SELECT_VAR__
 
 #include "lapi/syscalls.h"
+#include "tst_timer.h"
+#include "lapi/abisize.h"
 
 struct compat_sel_arg_struct {
 	long _n;
@@ -47,7 +49,24 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 		timeout->tv_usec = ts.tv_nsec / 1000;
 		return ret;
 	}
-	case 3:
+	case 3: {
+		int ret = 0;
+		struct __kernel_timespec ts = {
+			.tv_sec = timeout->tv_sec,
+			.tv_nsec = timeout->tv_usec * 1000,
+		};
+#if defined(TST_ABI64)
+		ret = tst_syscall(__NR_pselect6, nfds, readfds, writefds, exceptfds, &ts, NULL);
+#elif (__NR_clock_settime64 != __LTP__NR_INVALID_SYSCALL)
+		ret = tst_syscall(__NR_pselect6_time64, nfds, readfds, writefds, exceptfds, &ts, NULL);
+#else
+		tst_brk(TCONF, "__NR_pselect6 time64 variant not supported");
+#endif
+		timeout->tv_sec = ts.tv_sec;
+		timeout->tv_usec = ts.tv_nsec / 1000;
+		return ret;
+	}
+	case 4:
 #ifdef __NR__newselect
 		return tst_syscall(__NR__newselect, nfds, readfds, writefds, exceptfds, timeout);
 #else
@@ -55,7 +74,6 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 #endif
 	break;
 	}
-
 	return -1;
 }
 
@@ -72,11 +90,14 @@ static void select_info(void)
 		tst_res(TINFO, "Testing SYS_pselect6 syscall");
 	break;
 	case 3:
+		tst_res(TINFO, "Testing SYS_pselect6 time64 syscall");
+	break;
+	case 4:
 		tst_res(TINFO, "Testing SYS__newselect syscall");
 	break;
 	}
 }
 
-#define TEST_VARIANTS 4
+#define TEST_VARIANTS 5
 
 #endif /* SELECT_VAR__ */
-- 
2.25.0.rc1.19.g042ed3e048af

