From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:36 -0800
Subject: [LTP] [PATCH v2 4/6] direct_io: diotest4: use getpagesize() for
	mmap if shm header is absent
In-Reply-To: <20171109003438.130802-1-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
Message-ID: <20171109003438.130802-5-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For some architectures, mmap(MAP_FIXED) has to be aligned to SHMLBA
(instead of getpagesize()) --

   https://sourceforge.net/p/ltp/mailman/ltp-list/?viewmonth=200804

This dependency on SHMLBA causes the test to fail building for Android
due to absence of sys/shm.h. Make the header dependency configurable and
use getpagesize() as mmap granularity if the header is absent allowing
the test to work on Android while not breaking the architectures that
depend on the shm headers.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
v1->v2
------
- Instead of relying on __BIONIC__, fix by doing a header check for <sys/shm> and
  if the header doesn't exist, use getpagesize() as mmap granularity, otherwise
  use SHMBA (as before)

 configure.ac                             | 1 +
 include/lapi/mmap.h                      | 8 ++++++++
 testcases/kernel/io/direct_io/diotest4.c | 4 ++--
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index ffcbf57c5..16c8e4692 100644
--- a/configure.ac
+++ b/configure.ac
@@ -47,6 +47,7 @@ AC_CHECK_HEADERS([ \
     sys/fanotify.h \
     sys/inotify.h \
     sys/prctl.h \
+    sys/shm.h \
     sys/ustat.h \
     sys/xattr.h \
 ])
diff --git a/include/lapi/mmap.h b/include/lapi/mmap.h
index 10065a4df..7a5580079 100644
--- a/include/lapi/mmap.h
+++ b/include/lapi/mmap.h
@@ -71,4 +71,12 @@
 # define MADV_FREE	8
 #endif
 
+#ifdef HAVE_SYS_SHM_H
+# include <sys/shm.h>
+# define MMAP_GRANULARITY SHMLBA
+#else
+# include <unistd.h>
+# define MMAP_GRANULARITY getpagesize()
+#endif /* HAVE_SYS_SHM_H */
+
 #endif /* LAPI_MMAP_H__ */
diff --git a/testcases/kernel/io/direct_io/diotest4.c b/testcases/kernel/io/direct_io/diotest4.c
index dbcacf1ae..e4616e400 100644
--- a/testcases/kernel/io/direct_io/diotest4.c
+++ b/testcases/kernel/io/direct_io/diotest4.c
@@ -65,12 +65,12 @@
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <errno.h>
-#include <sys/shm.h>
 
 #include "diotest_routines.h"
 
 #include "test.h"
 #include "safe_macros.h"
+#include "lapi/mmap.h"
 
 char *TCID = "diotest4";	/* Test program identifier.    */
 int TST_TOTAL = 17;		/* Total number of test conditions */
@@ -196,7 +196,7 @@ int main(int argc, char *argv[])
 	int fd, newfd;
 	int i, l_fail = 0, fail_count = 0, total = 0;
 	int failed = 0;
-	int shmsz = SHMLBA;
+	int shmsz = MMAP_GRANULARITY;
 	int pagemask = ~(sysconf(_SC_PAGE_SIZE) - 1);
 	char *buf0, *buf1, *buf2;
 	caddr_t shm_base;
-- 
2.15.0.448.gf294e3d99a-goog

