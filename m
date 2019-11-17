From: Petr Vorel <petr.vorel@gmail.com>
Date: Sun, 17 Nov 2019 14:32:47 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] utils/compat_16: Always include
 <sys/fsuid.h>
Message-ID: <20191117133247.6304-1-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

All major implementations have setfsuid() declaration in <sys/fsuid.h>.
This fixes build on musl and (probably) on uclibc).

NOTE: maybe we should guard presence of <sys/fsuid.h> with autotools,
but we're not doing that for other it's uses.

Fixes: 0e7a99b53 ("setfsgid, setfsuid: clean up and 16-bit version
fixes")

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/utils/compat_16.h     | 2 --
 testcases/kernel/syscalls/utils/compat_tst_16.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index 5b0338d38..75d5d2d28 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -24,9 +24,7 @@
 
 #include <errno.h>
 #include <grp.h>
-#if defined(__GLIBC__) || defined(__ANDROID__)
 #include <sys/fsuid.h>
-#endif
 #include <sys/types.h>
 #include <unistd.h>
 
diff --git a/testcases/kernel/syscalls/utils/compat_tst_16.h b/testcases/kernel/syscalls/utils/compat_tst_16.h
index 3b86ef3e3..09fa8b0d8 100644
--- a/testcases/kernel/syscalls/utils/compat_tst_16.h
+++ b/testcases/kernel/syscalls/utils/compat_tst_16.h
@@ -21,9 +21,7 @@
 
 #include <errno.h>
 #include <grp.h>
-#if defined(__GLIBC__) || defined(__ANDROID__)
 #include <sys/fsuid.h>
-#endif
 #include <sys/types.h>
 #include <unistd.h>
 
-- 
2.24.0

