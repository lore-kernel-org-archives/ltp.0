From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  4 Jan 2017 16:44:43 +0100
Subject: [LTP] [COMMITTED] [PATCH] openposix/mmap31-1: Fix 32bit binary on
	64bit kernel
Message-ID: <1483544683-13272-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the test is compiled in 32bit mode but runs on 64bit kernel the
overflow does not happen, which is simply because the kernel stores the
offsets and lengths in unsigned long which is 64bit on 64bit kernel.

The do_mmap() in mm/mmap.c contains:

        /* offset overflow? */
        if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
                return -EOVERFLOW;

Which could be only triggered when pgoff and len are 32bit in size.

So we have to skip the test when it was compiled with 32bit compiler but
executed on 64bit kernel in 32bit compat mode. The only heuristic that came to
my mind is to check for "64" substring in machine from uname(), which seem to
work well enough for the case.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../open_posix_testsuite/conformance/interfaces/mmap/31-1.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
index 4e03068..2ca1517 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/31-1.c
@@ -34,6 +34,7 @@
 #include <fcntl.h>
 #include <string.h>
 #include <errno.h>
+#include <sys/utsname.h>
 #include "posixtest.h"
 
 int main(void)
@@ -51,6 +52,18 @@ int main(void)
 		return PTS_UNSUPPORTED;
 	}
 
+	/* The overflow does not happen when 32bit binary runs on 64bit kernel */
+#ifdef __linux__
+	struct utsname buf;
+
+	if (!uname(&buf) && strstr(buf.machine, "64")) {
+		printf("UNSUPPORTED: Looks like we run on 64bit kernel (%s)\n",
+		       buf.machine);
+		return PTS_UNSUPPORTED;
+	}
+
+#endif /* __linux__ */
+
 	long page_size = sysconf(_SC_PAGE_SIZE);
 
 	snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_mmap_31_1_%d", getpid());
-- 
2.7.3

