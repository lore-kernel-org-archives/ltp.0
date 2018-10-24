From: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Date: Wed, 24 Oct 2018 14:28:19 +1100
Subject: [LTP] [RFC 3/3] syscalls/fanotify03: add FAN_OPEN_EXEC_PERM tcase
	support
In-Reply-To: <cover.1540348505.git.mbobrowski@mbobrowski.org>
References: <cover.1540348505.git.mbobrowski@mbobrowski.org>
Message-ID: <dc279fdedc3c3bf45ee2f8d6f5a9547291eb2ac7.1540348505.git.mbobrowski@mbobrowski.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Defined FAN_OPEN_EXEC_PERM flag in local tests header file to
  accommodate for the fact if it's not defined in system user space
  headers

* Defined new tcase's for each mark type to support new fanotify flag
  FAN_OPEN_EXEC_PERM tests

* Updated fanotify_mark failure logic to report the instance where
  FAN_OPEN_EXEC_PERM flag is not available within the kernel

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 14 ++++++
 .../kernel/syscalls/fanotify/fanotify03.c     | 45 ++++++++++++++++---
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 535f1cef2..b0a847ab6 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -60,6 +60,20 @@ static long fanotify_mark(int fd, unsigned int flags, uint64_t mask,
 #ifndef FAN_MARK_FILESYSTEM
 #define FAN_MARK_FILESYSTEM	0x00000100
 #endif
+#ifndef FAN_OPEN_EXEC_PERM
+#define FAN_OPEN_EXEC_PERM	0x00040000
+#endif
+
+/*
+ * FAN_ALL_PERM_EVENTS has been deprecated, so any new permission events
+ * are not to be added to it. To cover the instance where a new permission
+ * event is defined, we need to update FAN_ALL_PERM_EVENTS accordingly,
+ * thus needing to do the undef/define. Any new permission events should
+ * be added to the newly defined macro below.
+ */
+#undef FAN_ALL_PERM_EVENTS
+#define FAN_ALL_PERM_EVENTS	(FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
+				 FAN_ACCESS_PERM)
 
 struct fanotify_mark_type {
 	unsigned int flag;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index f9418ee6b..d6d8fb8bf 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -59,7 +59,7 @@ static struct tcase {
 	struct event event_set[EVENT_MAX];
 } tcases[] = {
 	{
-		"inode mark permission events",
+		"inode mark, FAN_OPEN_PERM | FAN_ACCESS_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(INODE),
 		FAN_OPEN_PERM | FAN_ACCESS_PERM, 3,
 		{
@@ -69,7 +69,16 @@ static struct tcase {
 		}
 	},
 	{
-		"mount mark permission events",
+		"inode mark, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(INODE),
+		FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 2,
+		{
+			{FAN_ACCESS_PERM, FAN_DENY},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY}
+		}
+	},
+	{
+		"mount mark, FAN_OPEN_PERM | FAN_ACCESS_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(MOUNT),
 		FAN_OPEN_PERM | FAN_ACCESS_PERM, 3,
 		{
@@ -79,7 +88,16 @@ static struct tcase {
 		}
 	},
 	{
-		"filesystem mark permission events",
+		"mount mark, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 2,
+		{
+			{FAN_ACCESS_PERM, FAN_DENY},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY}
+		}
+	},
+	{
+		"filesystem mark, FAN_OPEN_PERM | FAN_ACCESS_PERM events",
 		INIT_FANOTIFY_MARK_TYPE(FILESYSTEM),
 		FAN_OPEN_PERM | FAN_ACCESS_PERM, 3,
 		{
@@ -87,7 +105,16 @@ static struct tcase {
 			{FAN_ACCESS_PERM, FAN_DENY},
 			{FAN_OPEN_PERM, FAN_DENY}
 		}
-	}
+	},
+	{
+		"filesystem mark, FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM events",
+		INIT_FANOTIFY_MARK_TYPE(MOUNT),
+		FAN_ACCESS_PERM | FAN_OPEN_EXEC_PERM, 2,
+		{
+			{FAN_ACCESS_PERM, FAN_DENY},
+			{FAN_OPEN_EXEC_PERM, FAN_DENY}
+		}
+	},
 };
 
 static void generate_events(void)
@@ -182,7 +209,13 @@ static int setup_mark(unsigned int n)
 		if (fanotify_mark(fd_notify, FAN_MARK_ADD | mark->flag,
 				  tc->mask, AT_FDCWD, files[i]) < 0) {
 			if (errno == EINVAL && support_perm_events &&
-			    mark->flag == FAN_MARK_FILESYSTEM) {
+				tc->mask & FAN_OPEN_EXEC_PERM) {
+				tst_res(TCONF,
+					"FAN_OPEN_EXEC_PERM not supported in "
+					"kernel?");
+				return -1;
+			} else if (errno == EINVAL && support_perm_events &&
+					mark->flag == FAN_MARK_FILESYSTEM) {
 				tst_res(TCONF,
 					"FAN_MARK_FILESYSTEM not supported in "
 					"kernel?");
@@ -193,7 +226,7 @@ static int setup_mark(unsigned int n)
 					"not configured in kernel?");
 			} else {
 				tst_brk(TBROK | TERRNO,
-					"fanotify_mark (%d, FAN_MARK_ADD | %s, "
+					"fanotify_mark(%d, FAN_MARK_ADD | %s, "
 					"FAN_ACCESS_PERM | FAN_OPEN_PERM, "
 					"AT_FDCWD, %s) failed.",
 					fd_notify, mark->name, fname);
-- 
2.17.2


-- 
Matthew Bobrowski <mbobrowski@mbobrowski.org>
