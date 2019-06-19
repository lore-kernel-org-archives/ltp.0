From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Jun 2019 14:31:47 +0200
Subject: [LTP] [PATCH 1/2] lib: Add flags to tst_get_supported_fs_types()
In-Reply-To: <20190619123148.29733-1-chrubis@suse.cz>
References: <20190619123148.29733-1-chrubis@suse.cz>
Message-ID: <20190619123148.29733-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Now we can ask the library to filter-out FUSE backed fs types.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Amir Goldstein <amir73il@gmail.com>
CC: Sumit Garg <sumit.garg@linaro.org>
---
 include/tst_fs.h                 |  6 ++++--
 include/tst_test.h               |  2 ++
 lib/tst_supported_fs_types.c     | 15 ++++++++++-----
 lib/tst_test.c                   |  2 +-
 testcases/lib/tst_supported_fs.c |  4 ++--
 5 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index ebca065c6..62071e508 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -162,16 +162,18 @@ int tst_fill_fd(int fd, char pattern, size_t bs, size_t bcount);
  */
 int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 
+#define TST_FS_SKIP_FUSE 0x01
+
 /*
  * Return 1 if a specified fiilsystem is supported
  * Return 0 if a specified fiilsystem isn't supported
  */
-int tst_fs_is_supported(const char *fs_type);
+int tst_fs_is_supported(const char *fs_type, int flags);
 
 /*
  * Returns NULL-terminated array of kernel-supported filesystems.
  */
-const char **tst_get_supported_fs_types(void);
+const char **tst_get_supported_fs_types(int flags);
 
 /*
  * Creates and writes to files on given path until write fails with ENOSPC
diff --git a/include/tst_test.h b/include/tst_test.h
index 8bdf38482..2e8e36352 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -154,6 +154,8 @@ struct tst_test {
 
 	/* Device filesystem type override NULL == default */
 	const char *dev_fs_type;
+	/* Flags to be passed to tst_get_supported_fs_types() */
+	int dev_fs_flags;
 
 	/* Options passed to SAFE_MKFS() when format_device is set */
 	const char *const *dev_fs_opts;
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 9babcc31a..00ede549d 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -45,7 +45,7 @@ static int has_mkfs(const char *fs_type)
 	return 1;
 }
 
-static int has_kernel_support(const char *fs_type)
+static int has_kernel_support(const char *fs_type, int flags)
 {
 	static int fuse_supported = -1;
 	const char *tmpdir = getenv("TMPDIR");
@@ -84,21 +84,26 @@ static int has_kernel_support(const char *fs_type)
 		return 0;
 	}
 
+	if (flags & TST_FS_SKIP_FUSE) {
+		tst_res(TINFO, "Skipping FUSE as requested by the test");
+		return 0;
+	}
+
 	tst_res(TINFO, "FUSE does support %s", fs_type);
 	return 1;
 }
 
-int tst_fs_is_supported(const char *fs_type)
+int tst_fs_is_supported(const char *fs_type, int flags)
 {
-	return has_kernel_support(fs_type) && has_mkfs(fs_type);
+	return has_kernel_support(fs_type, flags) && has_mkfs(fs_type);
 }
 
-const char **tst_get_supported_fs_types(void)
+const char **tst_get_supported_fs_types(int flags)
 {
 	unsigned int i, j = 0;
 
 	for (i = 0; fs_type_whitelist[i]; i++) {
-		if (tst_fs_is_supported(fs_type_whitelist[i]))
+		if (tst_fs_is_supported(fs_type_whitelist[i], flags))
 			fs_types[j++] = fs_type_whitelist[i];
 	}
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index c08da6a80..245e287fa 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1151,7 +1151,7 @@ static int run_tcases_per_fs(void)
 {
 	int ret = 0;
 	unsigned int i;
-	const char *const *filesystems = tst_get_supported_fs_types();
+	const char *const *filesystems = tst_get_supported_fs_types(tst_test->dev_fs_flags);
 
 	if (!filesystems[0])
 		tst_brk(TCONF, "There are no supported filesystems");
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index ebebcbb37..022a61508 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -37,9 +37,9 @@ int main(int argc, char *argv[])
 	}
 
 	if (argv[1])
-		return !tst_fs_is_supported(argv[1]);
+		return !tst_fs_is_supported(argv[1], 0);
 
-	filesystems = tst_get_supported_fs_types();
+	filesystems = tst_get_supported_fs_types(0);
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
 
-- 
2.19.2

