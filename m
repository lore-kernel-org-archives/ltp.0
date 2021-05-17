From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 17 May 2021 17:30:24 +0100
Subject: [LTP] [RFC PATCH 1/6] API: Make some internal symbols static
In-Reply-To: <20210517163029.22974-1-rpalethorpe@suse.com>
References: <20210517163029.22974-1-rpalethorpe@suse.com>
Message-ID: <20210517163029.22974-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

These do not appear to be referenced anywhere outside the library.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/old/test.h      | 1 -
 lib/tst_clocks.c        | 2 +-
 lib/tst_device.c        | 2 +-
 lib/tst_fs_link_count.c | 2 +-
 lib/tst_fs_setup.c      | 2 +-
 lib/tst_res.c           | 2 +-
 lib/tst_status.c        | 6 +++---
 lib/tst_test.c          | 2 +-
 lib/tst_timer_test.c    | 2 +-
 9 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/include/old/test.h b/include/old/test.h
index 2ae7dba71..a8994c08e 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -113,7 +113,6 @@ void tst_parse_opts(int argc, char *argv[], const option_t *user_optarg,
                     void (*user_help)(void));
 
 /* lib/tst_res.c */
-const char *strttype(int ttype);
 
 void tst_resm_(const char *file, const int lineno, int ttype,
 	const char *arg_fmt, ...)
diff --git a/lib/tst_clocks.c b/lib/tst_clocks.c
index cdcb9fc4f..9af4d2993 100644
--- a/lib/tst_clocks.c
+++ b/lib/tst_clocks.c
@@ -14,7 +14,7 @@
 
 typedef int (*mysyscall)(clockid_t clk_id, void *ts);
 
-int syscall_supported_by_kernel(long sysnr)
+static int syscall_supported_by_kernel(long sysnr)
 {
 	int ret;
 
diff --git a/lib/tst_device.c b/lib/tst_device.c
index c096b418b..079173b87 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -446,7 +446,7 @@ int tst_is_mounted_at_tmpdir(const char *path)
 	return tst_is_mounted(mpath);
 }
 
-int find_stat_file(const char *dev, char *path, size_t path_len)
+static int find_stat_file(const char *dev, char *path, size_t path_len)
 {
 	const char *devname = strrchr(dev, '/') + 1;
 
diff --git a/lib/tst_fs_link_count.c b/lib/tst_fs_link_count.c
index 860510d75..c4e20bebf 100644
--- a/lib/tst_fs_link_count.c
+++ b/lib/tst_fs_link_count.c
@@ -32,7 +32,7 @@
  * XXX: we cannot filter ext4 out, because ext2/ext3/ext4 have the
  * same magic number
  */
-const long subdir_limit_whitelist[] = {
+static const long subdir_limit_whitelist[] = {
 	TST_EXT2_OLD_MAGIC, TST_EXT234_MAGIC, TST_MINIX_MAGIC,
 	TST_MINIX_MAGIC2,   TST_MINIX2_MAGIC, TST_MINIX2_MAGIC2,
 	TST_MINIX3_MAGIC,   TST_UDF_MAGIC,    TST_SYSV2_MAGIC,
diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
index 6b93483de..b20fd06f2 100644
--- a/lib/tst_fs_setup.c
+++ b/lib/tst_fs_setup.c
@@ -11,7 +11,7 @@
 #define TST_FS_SETUP_OVERLAYFS_MSG "overlayfs is not configured in this kernel"
 #define TST_FS_SETUP_OVERLAYFS_CONFIG "lowerdir="OVL_LOWER",upperdir="OVL_UPPER",workdir="OVL_WORK
 
-void create_overlay_dirs(void)
+static void create_overlay_dirs(void)
 {
 	DIR *dir = opendir(OVL_LOWER);
 	if (dir == NULL) {
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8d86b48a4..c82e78a9a 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -139,7 +139,7 @@ struct pair {
 	return pair_arr[idx].name;                            \
 } while (0)
 
-const char *strttype(int ttype)
+static const char *strttype(int ttype)
 {
 	static const struct pair ttype_pairs[] = {
 		PAIR(TPASS)
diff --git a/lib/tst_status.c b/lib/tst_status.c
index 9124faaa3..12dee103f 100644
--- a/lib/tst_status.c
+++ b/lib/tst_status.c
@@ -11,14 +11,14 @@
 
 static char buf[32];
 
-const char *exited(int status)
+static const char *exited(int status)
 {
 	snprintf(buf, sizeof(buf), "exited with %i", WEXITSTATUS(status));
 
 	return buf;
 }
 
-const char *signaled(int status)
+static const char *signaled(int status)
 {
 	snprintf(buf, sizeof(buf), "killed by %s",
 		tst_strsig(WTERMSIG(status)));
@@ -26,7 +26,7 @@ const char *signaled(int status)
 	return buf;
 }
 
-const char *invalid(int status)
+static const char *invalid(int status)
 {
 	snprintf(buf, sizeof(buf), "invalid status 0x%x", status);
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 36a4809c7..4899ea70b 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -747,7 +747,7 @@ static void do_exit(int ret)
 	exit(ret);
 }
 
-void check_kver(void)
+static void check_kver(void)
 {
 	int v1, v2, v3;
 
diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c
index 3cd52fc9d..e77b911dd 100644
--- a/lib/tst_timer_test.c
+++ b/lib/tst_timer_test.c
@@ -251,7 +251,7 @@ static void write_to_file(void)
  *   - then we compute truncated mean and compare that with the requested sleep
  *     time increased by a threshold
  */
-void do_timer_test(long long usec, unsigned int nsamples)
+static void do_timer_test(long long usec, unsigned int nsamples)
 {
 	long long trunc_mean, median;
 	unsigned int discard = compute_discard(nsamples);
-- 
2.31.1

