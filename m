From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Nov 2020 11:44:26 +0100
Subject: [LTP] [PATCH v2 2/7] Unify error handling in lib/tst_safe_timerfd.c
In-Reply-To: <20201113104431.17808-1-mdoucha@suse.cz>
References: <20201113104431.17808-1-mdoucha@suse.cz>
Message-ID: <20201113104431.17808-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line locations
- Pedantically check for invalid syscall return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Added missing "else" keyword

 lib/tst_safe_timerfd.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/lib/tst_safe_timerfd.c b/lib/tst_safe_timerfd.c
index ffe7b2ef7..d31f6e35e 100644
--- a/lib/tst_safe_timerfd.c
+++ b/lib/tst_safe_timerfd.c
@@ -17,9 +17,14 @@ int safe_timerfd_create(const char *file, const int lineno,
 	int fd;
 
 	fd = timerfd_create(clockid, flags);
-	if (fd < 0) {
-		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_create(%s) failed",
-			file, lineno, tst_clock_name(clockid));
+
+	if (fd == -1) {
+		tst_brk_(file, lineno, TTYPE | TERRNO,
+			"timerfd_create(%s) failed", tst_clock_name(clockid));
+	} else if (fd < 0) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timerfd_create(%s) return value %d",
+			tst_clock_name(clockid), fd);
 	}
 
 	return fd;
@@ -31,9 +36,13 @@ int safe_timerfd_gettime(const char *file, const int lineno,
 	int rval;
 
 	rval = timerfd_gettime(fd, curr_value);
-	if (rval != 0) {
-		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_gettime() failed",
-			file, lineno);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TTYPE | TERRNO,
+			"timerfd_gettime() failed");
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timerfd_gettime() return value %d", rval);
 	}
 
 	return rval;
@@ -47,9 +56,13 @@ int safe_timerfd_settime(const char *file, const int lineno,
 	int rval;
 
 	rval = timerfd_settime(fd, flags, new_value, old_value);
-	if (rval != 0) {
-		tst_brk(TTYPE | TERRNO, "%s:%d timerfd_settime() failed",
-			file, lineno);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TTYPE | TERRNO,
+			"timerfd_settime() failed");
+	} else if (rval) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid timerfd_settime() return value %d", rval);
 	}
 
 	return rval;
-- 
2.28.0

