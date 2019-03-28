From: Federico Bonfiglio <fedebonfi95@gmail.com>
Date: Thu, 28 Mar 2019 21:22:35 +0100
Subject: [LTP] [PATCH v4 1/2] include/SAFE_UNSHARE() macro added
In-Reply-To: <20190326192052.GA15776@rei.lan>
References: <20190326192052.GA15776@rei.lan>
Message-ID: <20190328202235.7872-1-fedebonfi95@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

---
Hi Cyril, thanks again for your review. Here the updated patches, I removed the "." check and split them.
I left the include/lapi/ioctl_ns.h in the testcases patch since it doesn't have to do with SAFE_UNSHARE.
However let me know if it belongs here instead

 include/tst_safe_macros.h |  4 ++++
 lib/tst_safe_macros.c     | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 5e85abc9c..04aedb39a 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -526,4 +526,8 @@ int safe_personality(const char *filename, unsigned int lineno,
 	}							\
 	} while (0)
 
+void safe_unshare(const char *file, const int lineno, int flags);
+#define SAFE_UNSHARE(flags) safe_unshare(__FILE__, __LINE__, (flags))
+
+
 #endif /* SAFE_MACROS_H__ */
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index c375030a4..9480ca910 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -18,6 +18,7 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
+#include <sched.h>
 #include "config.h"
 #ifdef HAVE_SYS_FANOTIFY_H
 # include <sys/fanotify.h>
@@ -197,3 +198,19 @@ int safe_chroot(const char *file, const int lineno, const char *path)
 
 	return rval;
 }
+
+void safe_unshare(const char *file, const int lineno, int flags)
+{
+	int res;
+
+	res = unshare(flags);
+	if (res == -1) {
+		if (errno == EINVAL) {
+			tst_brk_(file, lineno, TCONF | TERRNO,
+				 "unshare(%d) unsupported", flags);
+		} else {
+			tst_brk_(file, lineno, TBROK | TERRNO,
+				 "unshare(%d) unsupported", flags);
+		}
+	}
+}
-- 
2.11.0

