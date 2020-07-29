From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 29 Jul 2020 20:56:47 +0530
Subject: [LTP] [PATCH V8 1/2] syscalls: select: Use struct
 __kernel_old_timespec for pselect6()
Message-ID: <b78d4e9530a47fd8cb2693e0b27f7e7ffd6177a8.1596036365.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The kernel expects struct __kernel_old_timespec for __NR_pselect6
syscall.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 testcases/kernel/syscalls/select/select_var.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index b19a1d1bf085..857e5d164582 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -38,7 +38,7 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 	}
 	case 2: {
 		int ret;
-		struct timespec ts = {
+		struct __kernel_old_timespec ts = {
 			.tv_sec = timeout->tv_sec,
 			.tv_nsec = timeout->tv_usec * 1000,
 		};
-- 
2.14.1

