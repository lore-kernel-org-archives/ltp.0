From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2019 16:57:37 +0300
Subject: [LTP] [PATCH v5 0/4] syscalls/fanotify: FAN_REPORT_FID and
 Directory Modification Events
In-Reply-To: <20190620132436.GA9804@dell5510>
References: <cover.1561018312.git.mbobrowski@mbobrowski.org>
 <20190620132436.GA9804@dell5510>
Message-ID: <CAOQ4uxjd8pvCpAHJ9Z9twY=EEvf9FNS3cycCZvHKhSN2JzY1Yw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jun 20, 2019 at 4:24 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir, Matthew,
>
> LGTM. Just one of this commits fails on centos 6

Hi Petr,

Can you please try attached patch.

Thanks,
Amir.
-------------- next part --------------
From 7d0feb7d7d9677cf348643bddf10507d2d1f0c3a Mon Sep 17 00:00:00 2001
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2019 16:53:46 +0300
Subject: [PATCH] syscalls/fanotify: fix build errors on centos 6

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 22 +++++++++++--------
 .../kernel/syscalls/fanotify/fanotify13.c     |  2 +-
 .../kernel/syscalls/fanotify/fanotify15.c     |  2 +-
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index f9803c1cc..05b4d9f2c 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -125,21 +125,25 @@ struct fanotify_event_info_header {
 	uint16_t len;
 };
 
+typedef struct {
+        int     val[2];
+} ltp_fsid_t;
+
 struct fanotify_event_info_fid {
 	struct fanotify_event_info_header hdr;
-	__kernel_fsid_t fsid;
+	ltp_fsid_t fsid;
 	unsigned char handle[0];
 };
 
 #endif
 
+#ifdef HAVE_NAME_TO_HANDLE_AT
 /*
- * Helper function used to obtain __kernel_fsid_t and file_handle objects
- * for a given path. Used by test files correlated to FAN_REPORT_FID
- * functionality.
+ * Helper function used to obtain fsid and file_handle for a given path.
+ * Used by test files correlated to FAN_REPORT_FID functionality.
  */
-static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
-			struct file_handle *handle)
+static inline void fanotify_get_fid(const char *path, ltp_fsid_t *fsid,
+				    struct file_handle *handle)
 {
 	int mount_id;
 	struct statfs stats;
@@ -149,7 +153,6 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 			"statfs(%s, ...) failed", path);
 	memcpy(fsid, &stats.f_fsid, sizeof(stats.f_fsid));
 
-#ifdef HAVE_NAME_TO_HANDLE_AT
 	if (name_to_handle_at(AT_FDCWD, path, handle, &mount_id, 0) == -1) {
 		if (errno == EOPNOTSUPP) {
 			tst_brk(TCONF,
@@ -159,10 +162,11 @@ static inline void fanotify_get_fid(const char *path, __kernel_fsid_t *fsid,
 		tst_brk(TBROK | TERRNO,
 			"name_to_handle_at(AT_FDCWD, %s, ...) failed", path);
 	}
+}
 #else
-	tst_brk(TCONF, "name_to_handle_at() is not implmented");
+#define fanotify_get_fid(path, fsid, handle) \
+	tst_brk(TCONF, "System does not have required name_to_handle_at() support")
 #endif /* HAVE_NAME_TO_HANDLE_AT */
-}
 
 #define INIT_FANOTIFY_MARK_TYPE(t) \
 	{ FAN_MARK_ ## t, "FAN_MARK_" #t }
diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 8f9baacfa..f79322fd0 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -40,7 +40,7 @@
 
 struct event_t {
 	unsigned long long expected_mask;
-	__kernel_fsid_t fsid;
+	ltp_fsid_t fsid;
 	struct file_handle handle;
 	char buf[MAX_HANDLE_SZ];
 };
diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index 6981b7891..3be913ba4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -37,7 +37,7 @@
 
 struct event_t {
 	unsigned long long mask;
-	__kernel_fsid_t fsid;
+	ltp_fsid_t fsid;
 	struct file_handle handle;
 	char buf[MAX_HANDLE_SZ];
 };
-- 
2.17.1

