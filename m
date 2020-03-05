From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  5 Mar 2020 16:14:59 +0100
Subject: [LTP] [PATCH v2 2/2] Reimplement TST_SAFE_TIMERFD_*() using
 TST_ASSERT_SYSCALL*()
In-Reply-To: <20200305151459.30341-1-mdoucha@suse.cz>
References: <20200305151459.30341-1-mdoucha@suse.cz>
Message-ID: <20200305151459.30341-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Example usage of the TST_ASSERT_SYSCALL*() macros.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v2: Added back argument pretty printing for timerfd_create()

 lib/tst_safe_timerfd.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
index ffe7b2ef7..8c042f8c8 100644
--- a/lib/tst_safe_timerfd.c
+++ b/lib/tst_safe_timerfd.c
@@ -9,34 +9,18 @@
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 
-#define TTYPE (errno == ENOTSUP ? TCONF : TBROK)
-
 int safe_timerfd_create(const char *file, const int lineno,
 				      int clockid, int flags)
 {
-	int fd;
-
-	fd = timerfd_create(clockid, flags);
-	if (fd < 0) {
-		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
-			file, lineno, tst_clock_name(clockid));
-	}
-
-	return fd;
+	return TST_ASSERT_SYSCALL_FD_IMPL(timerfd_create(clockid, flags), file,
+		lineno, "timerfd_create(%s)", tst_clock_name(clockid));
 }
 
 int safe_timerfd_gettime(const char *file, const int lineno,
 				int fd, struct itimerspec *curr_value)
 {
-	int rval;
-
-	rval = timerfd_gettime(fd, curr_value);
-	if (rval != 0) {
-		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_gettime() failed",
-			file, lineno);
-	}
-
-	return rval;
+	return TST_ASSERT_SYSCALL_IMPL(timerfd_gettime(fd, curr_value), file,
+		lineno, "timerfd_gettime()");
 }
 
 int safe_timerfd_settime(const char *file, const int lineno,
@@ -44,13 +28,6 @@ int safe_timerfd_settime(const char *file, const int lineno,
 				const struct itimerspec *new_value,
 				struct itimerspec *old_value)
 {
-	int rval;
-
-	rval = timerfd_settime(fd, flags, new_value, old_value);
-	if (rval != 0) {
-		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_settime() failed",
-			file, lineno);
-	}
-
-	return rval;
+	return TST_ASSERT_SYSCALL_IMPL(timerfd_settime(fd, flags, new_value,
+		old_value), file, lineno, "timerfd_settime()");
 }
-- 
2.25.1

