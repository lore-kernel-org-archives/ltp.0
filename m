From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2019 17:18:04 +0300
Subject: [LTP] [PATCH] syscalls/fanotify: fix build errors on centos 6
Message-ID: <20190620141804.20902-1-amir73il@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Do not try to build fanotify1[35] and helpers when system does not
support name_to_handle_at().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Petr,

This patch is on top of Matthew's series.
Please see if it fixed build errors you reported in centos 6.

Thanks,
Amir.

 testcases/kernel/syscalls/fanotify/fanotify.h   | 16 +++++++---------
 testcases/kernel/syscalls/fanotify/fanotify13.c |  4 ++++
 testcases/kernel/syscalls/fanotify/fanotify15.c |  4 ++++
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index f9803c1cc..1c7623d3b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -125,21 +125,22 @@ struct fanotify_event_info_header {
 	uint16_t len;
 };
 
+#ifdef HAVE_NAME_TO_HANDLE_AT
 struct fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
 	__kernel_fsid_t fsid;
 	unsigned char handle[0];
 };
-
+#endif
 #endif
 
+#ifdef HAVE_NAME_TO_HANDLE_AT
 /*
- * Helper function used to obtain __kernel_fsid_t and file_handle objects
- * for a given path. Used by test files correlated to FAN_REPORT_FID
- * functionality.
+ * Helper function used to obtain fsid and file_handle for a given path.
+ * Used by test files correlated to FAN_REPORT_FID functionality.
  */
 static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
-			struct file_handle *handle)
+				    struct file_handle *handle)
 {
 	int mount_id;
 	struct statfs stats;
@@ -149,7 +150,6 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 			"statfs(%s, ...) failed", path);
 	memcpy(fsid, &stats.f_fsid, sizeof(stats.f_fsid));
 
-#ifdef HAVE_NAME_TO_HANDLE_AT
 	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
 		if (errno == EOPNOTSUPP) {
 			tst_brk(TCONF,
@@ -159,10 +159,8 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 		tst_brk(TBROK | TERRNO,
 			"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
 	}
-#else
-	tst_brk(TCONF, "name_to_handle_at() is not implmented");
-#endif /* HAVE_NAME_TO_HANDLE_AT */
 }
+#endif /* HAVE_NAME_TO_HANDLE_AT */
 
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 8f9baacfa..e5681c804 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -38,6 +38,7 @@
 #define FILE_PATH_ONE MOUNT_PATH"/"FILE_ONE
 #define FILE_PATH_TWO MOUNT_PATH"/"FILE_TWO
 
+#if defined(HAVE_NAME_TO_HANDLE_AT)
 struct event_t {
 	unsigned long long expected_mask;
 	__kernel_fsid_t fsid;
@@ -323,6 +324,9 @@ static struct tst_test test = {
 	.all_filesystems = 1
 };
 
+#else
+	TST_TEST_TCONF("System does not have required name_to_handle_at() support");
+#endif
 #else
 	TST_TEST_TCONF("System does not have required fanotify support");
 #endif
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 6981b7891..e9e926078 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -35,6 +35,7 @@
 #define FILE1 TEST_DIR"/file1"
 #define FILE2 TEST_DIR"/file2"
 
+#if defined(HAVE_NAME_TO_HANDLE_AT)
 struct event_t {
 	unsigned long long mask;
 	__kernel_fsid_t fsid;
@@ -241,6 +242,9 @@ static struct tst_test test = {
 	.cleanup = do_cleanup
 };
 
+#else
+	TST_TEST_TCONF("System does not have required name_to_handle_at() support");
+#endif
 #else
 	TST_TEST_TCONF("System does not have required fanotify support");
 #endif
-- 
2.17.1

