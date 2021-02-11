From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 11 Feb 2021 17:45:39 +0000
Subject: [LTP] [PATCH v2 1/5] API: Add close_range syscall wrapper
In-Reply-To: <20210211174543.25003-1-rpalethorpe@suse.com>
References: <20210211174543.25003-1-rpalethorpe@suse.com>
Message-ID: <20210211174543.25003-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add the syscall number and a wrapper function. Presently there is no
wrapper function in libc.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 configure.ac                       |  2 ++
 include/lapi/close_range.h         | 28 ++++++++++++++++++++++++++++
 include/lapi/syscalls/aarch64.in   |  1 +
 include/lapi/syscalls/arc.in       |  1 +
 include/lapi/syscalls/arm.in       |  1 +
 include/lapi/syscalls/hppa.in      |  1 +
 include/lapi/syscalls/i386.in      |  1 +
 include/lapi/syscalls/ia64.in      |  1 +
 include/lapi/syscalls/mips_n32.in  |  1 +
 include/lapi/syscalls/mips_n64.in  |  1 +
 include/lapi/syscalls/mips_o32.in  |  1 +
 include/lapi/syscalls/powerpc.in   |  1 +
 include/lapi/syscalls/powerpc64.in |  1 +
 include/lapi/syscalls/s390.in      |  1 +
 include/lapi/syscalls/s390x.in     |  1 +
 include/lapi/syscalls/sh.in        |  1 +
 include/lapi/syscalls/sparc.in     |  1 +
 include/lapi/syscalls/sparc64.in   |  1 +
 include/lapi/syscalls/x86_64.in    |  1 +
 19 files changed, 47 insertions(+)
 create mode 100644 include/lapi/close_range.h

diff --git a/configure.ac b/configure.ac
index 9fb50c173..d4bef5e45 100644
--- a/configure.ac
+++ b/configure.ac
@@ -43,6 +43,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/can.h \
     linux/cgroupstats.h \
     linux/cryptouser.h \
+    linux/close_range.h \
     linux/dccp.h \
     linux/fs.h \
     linux/genetlink.h \
@@ -77,6 +78,7 @@ AC_SUBST(HAVE_FTS_H, $have_fts)
 
 AC_CHECK_FUNCS_ONCE([ \
     clone3 \
+    close_range \
     copy_file_range \
     epoll_pwait \
     execveat \
diff --git a/include/lapi/close_range.h b/include/lapi/close_range.h
new file mode 100644
index 000000000..19db52d3d
--- /dev/null
+++ b/include/lapi/close_range.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Copyright (c) 2021 SUSE LLC  */
+
+#ifndef LAPI_CLOSE_RANGE__
+# define LAPI_CLOSE_RANGE__
+
+# include "lapi/syscalls.h"
+
+# ifdef HAVE_LINUX_CLOSE_RANGE_H
+#  include <linux/close_range.h>
+# endif
+
+# ifndef CLOSE_RANGE_UNSHARE
+#  define CLOSE_RANGE_UNSHARE	(1U << 1)
+# endif
+
+# ifndef CLOSE_RANGE_CLOEXEC
+#  define CLOSE_RANGE_CLOEXEC	(1U << 2)
+# endif
+
+# ifndef HAVE_CLOSE_RANGE
+static inline int close_range(unsigned int fd, unsigned int max_fd,
+			      unsigned int flags)
+{
+	return tst_syscall(__NR_close_range, fd, max_fd, flags);
+}
+# endif
+#endif	/* LAPI_CLOSE_RANGE_H__ */
diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
index 07556933f..2def6ba3d 100644
--- a/include/lapi/syscalls/aarch64.in
+++ b/include/lapi/syscalls/aarch64.in
@@ -310,6 +310,7 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
 _sysctl 1078
diff --git a/include/lapi/syscalls/arc.in b/include/lapi/syscalls/arc.in
index 0cadb150c..9bcd84706 100644
--- a/include/lapi/syscalls/arc.in
+++ b/include/lapi/syscalls/arc.in
@@ -310,5 +310,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
index 395d53a68..98c840cb8 100644
--- a/include/lapi/syscalls/arm.in
+++ b/include/lapi/syscalls/arm.in
@@ -388,5 +388,6 @@ fsmount (__NR_SYSCALL_BASE+432)
 fspick (__NR_SYSCALL_BASE+433)
 pidfd_open (__NR_SYSCALL_BASE+434)
 clone3 (__NR_SYSCALL_BASE+435)
+close_range (__NR_SYSCALL_BASE+436)
 openat2 (__NR_SYSCALL_BASE+437)
 pidfd_getfd (__NR_SYSCALL_BASE+438)
diff --git a/include/lapi/syscalls/hppa.in b/include/lapi/syscalls/hppa.in
index 7f9b5e0a0..e1628c4b1 100644
--- a/include/lapi/syscalls/hppa.in
+++ b/include/lapi/syscalls/hppa.in
@@ -39,3 +39,4 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+close_range 436
\ No newline@end of file
diff --git a/include/lapi/syscalls/i386.in b/include/lapi/syscalls/i386.in
index d6773abcb..aaa02c7bf 100644
--- a/include/lapi/syscalls/i386.in
+++ b/include/lapi/syscalls/i386.in
@@ -424,5 +424,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/ia64.in b/include/lapi/syscalls/ia64.in
index 427b711b1..5467f80f2 100644
--- a/include/lapi/syscalls/ia64.in
+++ b/include/lapi/syscalls/ia64.in
@@ -337,5 +337,6 @@ fsconfig 1455
 fsmount 1456
 fspick 1457
 pidfd_open 1458
+close_range 1460
 openat2 1461
 pidfd_getfd 1462
diff --git a/include/lapi/syscalls/mips_n32.in b/include/lapi/syscalls/mips_n32.in
index eb6140ebc..a509ca5c6 100644
--- a/include/lapi/syscalls/mips_n32.in
+++ b/include/lapi/syscalls/mips_n32.in
@@ -362,5 +362,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/mips_n64.in b/include/lapi/syscalls/mips_n64.in
index 5480aa3c9..532c69dd8 100644
--- a/include/lapi/syscalls/mips_n64.in
+++ b/include/lapi/syscalls/mips_n64.in
@@ -338,5 +338,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/mips_o32.in b/include/lapi/syscalls/mips_o32.in
index feee8fbf3..c71a62a35 100644
--- a/include/lapi/syscalls/mips_o32.in
+++ b/include/lapi/syscalls/mips_o32.in
@@ -408,5 +408,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/powerpc.in b/include/lapi/syscalls/powerpc.in
index cdbebc62d..2d287a606 100644
--- a/include/lapi/syscalls/powerpc.in
+++ b/include/lapi/syscalls/powerpc.in
@@ -417,5 +417,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/powerpc64.in b/include/lapi/syscalls/powerpc64.in
index cdbebc62d..2d287a606 100644
--- a/include/lapi/syscalls/powerpc64.in
+++ b/include/lapi/syscalls/powerpc64.in
@@ -417,5 +417,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/s390.in b/include/lapi/syscalls/s390.in
index c3f249aed..c978b6660 100644
--- a/include/lapi/syscalls/s390.in
+++ b/include/lapi/syscalls/s390.in
@@ -404,5 +404,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/s390x.in b/include/lapi/syscalls/s390x.in
index 88cc9b86b..d123db6cb 100644
--- a/include/lapi/syscalls/s390x.in
+++ b/include/lapi/syscalls/s390x.in
@@ -352,5 +352,6 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/sh.in b/include/lapi/syscalls/sh.in
index 06055ed10..22da7d6ff 100644
--- a/include/lapi/syscalls/sh.in
+++ b/include/lapi/syscalls/sh.in
@@ -398,5 +398,6 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/sparc.in b/include/lapi/syscalls/sparc.in
index 522e3c997..7324b4ac6 100644
--- a/include/lapi/syscalls/sparc.in
+++ b/include/lapi/syscalls/sparc.in
@@ -403,5 +403,6 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/sparc64.in b/include/lapi/syscalls/sparc64.in
index 6f884a7bf..862d806fa 100644
--- a/include/lapi/syscalls/sparc64.in
+++ b/include/lapi/syscalls/sparc64.in
@@ -368,5 +368,6 @@ fsconfig 431
 fsmount 432
 fspick 433
 pidfd_open 434
+close_range 436
 openat2 437
 pidfd_getfd 438
diff --git a/include/lapi/syscalls/x86_64.in b/include/lapi/syscalls/x86_64.in
index c76328c93..1345002f5 100644
--- a/include/lapi/syscalls/x86_64.in
+++ b/include/lapi/syscalls/x86_64.in
@@ -345,6 +345,7 @@ fsmount 432
 fspick 433
 pidfd_open 434
 clone3 435
+close_range 436
 openat2 437
 pidfd_getfd 438
 rt_sigaction 512
-- 
2.30.0

