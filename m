From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:06 +0100
Subject: [LTP] [PATCH v5 02/10] fanotify: Add helper for access permission
 check
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

i.e. CONFIG_FANOTIFY_ACCESS_PERMISSIONS
and use it in relevant tests setup().

The purpose is to reduce checks (cleanup).
Permission is required by all tests cases, hence tst_brk().

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Originally part of "[v4,2/6] fanotify: Handle supported features checks in setup()".

 testcases/kernel/syscalls/fanotify/fanotify.h | 19 +++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify03.c     |  2 ++
 .../kernel/syscalls/fanotify/fanotify07.c     | 14 +++++---------
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 0afbc02aa..687089ace 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -242,4 +242,23 @@ static inline void fanotify_save_fid(const char *path,
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
 
+static inline void require_fanotify_access_permissions_supported_by_kernel(void)
+{
+	int fd;
+
+	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
+
+	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, ".") < 0) {
+		if (errno == EINVAL) {
+			tst_brk(TCONF | TERRNO,
+				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not configured in kernel?");
+		} else {
+			tst_brk(TBROK | TERRNO,
+				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, \".\") failed", fd);
+		}
+	}
+
+	SAFE_CLOSE(fd);
+}
+
 #endif /* __FANOTIFY_H__ */
diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 1ef1c206b..cd5576f3a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -347,6 +347,8 @@ static void test_fanotify(unsigned int n)
 
 static void setup(void)
 {
+	require_fanotify_access_permissions_supported_by_kernel();
+
 	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "1");
 
diff --git a/testcases/kernel/syscalls/fanotify/fanotify07.c b/testcases/kernel/syscalls/fanotify/fanotify07.c
index c2e185710..8822e9c51 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify07.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify07.c
@@ -106,15 +106,9 @@ static int setup_instance(void)
 	if (fanotify_mark(fd, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD,
 			  fname) < 0) {
 		close(fd);
-		if (errno == EINVAL) {
-			tst_brk(TCONF | TERRNO,
-				"CONFIG_FANOTIFY_ACCESS_PERMISSIONS not "
-				"configured in kernel?");
-		} else {
-			tst_brk(TBROK | TERRNO,
-				"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, "
-				"AT_FDCWD, %s) failed.", fd, fname);
-		}
+		tst_brk(TBROK | TERRNO,
+			"fanotify_mark (%d, FAN_MARK_ADD, FAN_ACCESS_PERM, AT_FDCWD, %s) failed",
+			fd, fname);
 	}
 
 	return fd;
@@ -195,6 +189,8 @@ static void test_fanotify(void)
 
 static void setup(void)
 {
+	require_fanotify_access_permissions_supported_by_kernel();
+
 	sprintf(fname, "fname_%d", getpid());
 	SAFE_FILE_PRINTF(fname, "%s", fname);
 }
-- 
2.29.2

