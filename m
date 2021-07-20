From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 20 Jul 2021 16:37:08 +0800
Subject: [LTP] [PATCH v2] stime: Only o32 system calls require 32-bit
 programs on mips
Message-ID: <20210720083708.13281-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The stime() system call is only o32, not n32 and n64. If you do not
specify that the current program is compiled to 32-bit when compiling
the program on mips, the stime() system call will fail when the
program is running.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 testcases/kernel/syscalls/stime/stime_var.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/stime/stime_var.h b/testcases/kernel/syscalls/stime/stime_var.h
index 708b80573..c5bafac99 100644
--- a/testcases/kernel/syscalls/stime/stime_var.h
+++ b/testcases/kernel/syscalls/stime/stime_var.h
@@ -25,7 +25,11 @@ static int do_stime(time_t *ntime)
 #endif
 	break;
 	case 1:
+#if !defined(__mips__) ||  _MIPS_SZLONG == 32
 		return tst_syscall(__NR_stime, ntime);
+#else
+		tst_brk(TCONF, "the stime() syscall only o32 ABI in mips, make sure the current program is 32-bit");
+#endif
 	case 2: {
 		struct __kernel_old_timeval tv;

--
2.20.1



