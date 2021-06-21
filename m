From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 21 Jun 2021 12:38:03 +0100
Subject: [LTP] [PATCH 2/3] API: Remove TEST macro usage from library headers
In-Reply-To: <20210621113804.26179-1-rpalethorpe@suse.com>
References: <20210621113804.26179-1-rpalethorpe@suse.com>
Message-ID: <20210621113804.26179-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Technically the headers are part of the test translation unit. However
we think of them as being part of the API. So we should also remove
TEST from here.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Suggested-by: Li Wang <liwang@redhat.com>
---
 include/lapi/clone.h             |  6 ++++--
 include/lapi/fsmount.h           | 10 ++++++----
 include/lapi/init_module.h       |  6 ++++--
 include/lapi/io_uring.h          |  9 +++++----
 include/lapi/name_to_handle_at.h |  7 ++++---
 include/lapi/openat2.h           |  6 ++++--
 6 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/include/lapi/clone.h b/include/lapi/clone.h
index 81db443c9..5bf51d90e 100644
--- a/include/lapi/clone.h
+++ b/include/lapi/clone.h
@@ -39,10 +39,12 @@ static inline int clone3(struct clone_args *args, size_t size)
 
 static inline void clone3_supported_by_kernel(void)
 {
+	long ret;
+
 	if ((tst_kvercmp(5, 3, 0)) < 0) {
 		/* Check if the syscall is backported on an older kernel */
-		TEST(syscall(__NR_clone3, NULL, 0));
-		if (TST_RET == -1 && TST_ERR == ENOSYS)
+		ret = syscall(__NR_clone3, NULL, 0);
+		if (ret == -1 && errno == ENOSYS)
 			tst_brk(TCONF, "Test not supported on kernel version < v5.3");
 	}
 }
diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
index d6ebed9b4..dc39c8791 100644
--- a/include/lapi/fsmount.h
+++ b/include/lapi/fsmount.h
@@ -133,12 +133,14 @@ enum fsconfig_command {
 
 static inline void fsopen_supported_by_kernel(void)
 {
+	long ret;
+
 	if ((tst_kvercmp(5, 2, 0)) < 0) {
 		/* Check if the syscall is backported on an older kernel */
-		TEST(syscall(__NR_fsopen, NULL, 0));
-		if (TST_RET != -1)
-			SAFE_CLOSE(TST_RET);
-		else if (TST_ERR == ENOSYS)
+		ret = syscall(__NR_fsopen, NULL, 0);
+		if (ret != -1)
+			SAFE_CLOSE(ret);
+		else if (errno == ENOSYS)
 			tst_brk(TCONF, "Test not supported on kernel version < v5.2");
 	}
 }
diff --git a/include/lapi/init_module.h b/include/lapi/init_module.h
index 14eaabee6..48464a2e4 100644
--- a/include/lapi/init_module.h
+++ b/include/lapi/init_module.h
@@ -24,10 +24,12 @@ static inline int finit_module(int fd, const char *param_values, int flags)
 
 static inline void finit_module_supported_by_kernel(void)
 {
+       long ret;
+
        if ((tst_kvercmp(3, 8, 0)) < 0) {
                /* Check if the syscall is backported on an older kernel */
-               TEST(syscall(__NR_finit_module, 0, "", 0));
-               if (TST_RET == -1 && TST_ERR == ENOSYS)
+               ret = syscall(__NR_finit_module, 0, "", 0);
+               if (ret == -1 && errno == ENOSYS)
                        tst_brk(TCONF, "Test not supported on kernel version < v3.8");
        }
 }
diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
index 897ed7c64..e5c879951 100644
--- a/include/lapi/io_uring.h
+++ b/include/lapi/io_uring.h
@@ -296,11 +296,12 @@ static inline int io_uring_enter(int fd, unsigned int to_submit,
 
 static inline void io_uring_setup_supported_by_kernel(void)
 {
+	long ret;
 	if ((tst_kvercmp(5, 1, 0)) < 0) {
-		TEST(syscall(__NR_io_uring_setup, NULL, 0));
-		if (TST_RET != -1)
-			SAFE_CLOSE(TST_RET);
-		else if (TST_ERR == ENOSYS)
+		ret = syscall(__NR_io_uring_setup, NULL, 0);
+		if (ret != -1)
+			SAFE_CLOSE(ret);
+		else if (errno == ENOSYS)
 			tst_brk(TCONF,
 				"Test not supported on kernel version < v5.1");
 	}
diff --git a/include/lapi/name_to_handle_at.h b/include/lapi/name_to_handle_at.h
index 275db4ae0..3f081f1c0 100644
--- a/include/lapi/name_to_handle_at.h
+++ b/include/lapi/name_to_handle_at.h
@@ -34,6 +34,7 @@ static inline int open_by_handle_at(int mount_fd, struct file_handle *handle,
 static inline struct file_handle *
 allocate_file_handle(int dfd, const char *pathname)
 {
+	long ret;
 	struct file_handle fh = {}, *fhp;
 	int mount_id;
 
@@ -41,9 +42,9 @@ allocate_file_handle(int dfd, const char *pathname)
 	 * Make an initial call to name_to_handle_at() to discover the size
 	 * required for the file handle.
 	 */
-	TEST(name_to_handle_at(dfd, pathname, &fh, &mount_id, 0));
-	if (TST_RET != -1 || TST_ERR != EOVERFLOW) {
-		tst_res(TFAIL | TTERRNO,
+	ret = name_to_handle_at(dfd, pathname, &fh, &mount_id, 0);
+	if (ret != -1 || errno != EOVERFLOW) {
+		tst_res(TFAIL | TERRNO,
 			"name_to_handle_at() should fail with EOVERFLOW");
 		return NULL;
 	}
diff --git a/include/lapi/openat2.h b/include/lapi/openat2.h
index d4154c26e..46804a441 100644
--- a/include/lapi/openat2.h
+++ b/include/lapi/openat2.h
@@ -62,10 +62,12 @@ struct open_how_pad {
 
 static inline void openat2_supported_by_kernel(void)
 {
+	long ret;
+
 	if ((tst_kvercmp(5, 6, 0)) < 0) {
 		/* Check if the syscall is backported on an older kernel */
-		TEST(syscall(__NR_openat2, -1, NULL, NULL, 0));
-		if (TST_RET == -1 && TST_ERR == ENOSYS)
+		ret = syscall(__NR_openat2, -1, NULL, NULL, 0);
+		if (ret == -1 && errno == ENOSYS)
 			tst_brk(TCONF, "Test not supported on kernel version < v5.6");
 	}
 }
-- 
2.31.1

