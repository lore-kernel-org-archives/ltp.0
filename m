From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Sep 2018 17:30:12 +0200
Subject: [LTP] [PATCH 1/2] lib: tst_mkfs: Allow passing more extra options
Message-ID: <20180911153013.2609-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This commit changes the extra_opt pointer from a string to an array so
that we can pass more than one extra option to the mkfs and also adjusts
two tests that are using this feature.

+ Fixes the docs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt           |  9 +++++----
 include/old/test.h                        |  6 +++---
 include/tst_mkfs.h                        |  7 ++++---
 include/tst_test.h                        |  2 +-
 lib/tst_mkfs.c                            | 23 +++++++++++++++--------
 lib/tst_test.c                            |  2 +-
 testcases/kernel/syscalls/mmap/mmap16.c   |  3 ++-
 testcases/kernel/syscalls/statx/statx05.c |  2 +-
 8 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 0194f2098..9dad88688 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -976,7 +976,7 @@ then.
 If '.format_device' flag is set the device is formatted with a filesystem as
 well. You can use '.dev_fs_type' to override the default filesystem type if
 needed and pass additional options to mkfs via '.dev_fs_opts' and
-'.dev_extra_opt' pointers. Note that '.format_device' implies '.needs_device'
+'.dev_extra_opts' pointers. Note that '.format_device' implies '.needs_device'
 there is no need to set both.
 
 If '.mount_device' is set, the device is mounted at '.mntpoint' which is used
@@ -1051,9 +1051,10 @@ The fs options 'fs_opts' should either be 'NULL' if there are none, or a
 'NULL' terminated array of strings such as:
 +const char *const opts[] = {"-b", "1024", NULL}+.
 
-The extra option 'extra_opt' should either be 'NULL' if there is none, or a
-string such as '"102400"'; 'extra_opt' will be passed after device name. e.g:
-+mkfs -t ext4 -b 1024 /dev/sda1 102400+ in this case.
+The extra options 'extra_opts' should either be 'NULL' if there are none, or a
+'NULL' terminated array of strings such as +{"102400", NULL}+; 'extra_opts'
+will be passed after device name. e.g: +mkfs -t ext4 -b 1024 /dev/sda1 102400+
+in this case.
 
 2.2.16 Verifying a filesystem's free space
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/include/old/test.h b/include/old/test.h
index 59dce0e56..0738237e9 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -188,12 +188,12 @@ int self_exec(const char *argv0, const char *fmt, ...);
  * @fs_opts: NULL or NULL terminated array of mkfs options
  * @extra_opt: extra mkfs option which is passed after the device name
  */
-#define tst_mkfs(cleanup, dev, fs_type, fs_opts, extra_opt) \
+#define tst_mkfs(cleanup, dev, fs_type, fs_opts, extra_opts) \
 	tst_mkfs_(__FILE__, __LINE__, cleanup, dev, fs_type, \
-		  fs_opts, extra_opt)
+		  fs_opts, extra_opts)
 void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *dev, const char *fs_type,
-	       const char *const fs_opts[], const char *extra_opt);
+	       const char *const fs_opts[], const char *const extra_opts[]);
 
 /* lib/tst_net.c
  *
diff --git a/include/tst_mkfs.h b/include/tst_mkfs.h
index d3aea9ebc..eb5f6642a 100644
--- a/include/tst_mkfs.h
+++ b/include/tst_mkfs.h
@@ -22,13 +22,14 @@
  * @dev: path to a device
  * @fs_type: filesystem type
  * @fs_opts: NULL or NULL terminated array of extra mkfs options
+ * @extra_opts: NULL or NULL terminated array of extra mkfs options
  */
 void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *dev, const char *fs_type,
-	       const char *const fs_opts[], const char *extra_opt);
+	       const char *const fs_opts[], const char *const extra_opts[]);
 
-#define SAFE_MKFS(device, fs_type, fs_opts, extra_opt) \
+#define SAFE_MKFS(device, fs_type, fs_opts, extra_opts) \
 	tst_mkfs_(__FILE__, __LINE__, NULL, device, fs_type, \
-		  fs_opts, extra_opt)
+		  fs_opts, extra_opts)
 
 #endif	/* TST_MKFS_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 10de68825..ea23c8bdb 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -148,7 +148,7 @@ struct tst_test {
 
 	/* Options passed to SAFE_MKFS() when format_device is set */
 	const char *const *dev_fs_opts;
-	const char *dev_extra_opt;
+	const char *const *dev_extra_opts;
 
 	/* Device mount options, used if mount_device is set */
 	const char *mntpoint;
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 7385a939f..a33d36a6b 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -24,12 +24,13 @@
 
 void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *dev, const char *fs_type,
-	       const char *const fs_opts[], const char *extra_opt)
+	       const char *const fs_opts[], const char *const extra_opts[])
 {
 	int i, pos = 1, ret;
 	char mkfs[64];
 	const char *argv[OPTS_MAX] = {mkfs};
 	char fs_opts_str[1024] = "";
+	char extra_opts_str[1024] = "";
 
 	if (!dev) {
 		tst_brkm(TBROK, cleanup_fn,
@@ -64,13 +65,19 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	argv[pos++] = dev;
 
-	if (extra_opt) {
-		argv[pos++] = extra_opt;
+	if (extra_opts) {
+		for (i = 0; extra_opts[i]; i++) {
+			argv[pos++] = extra_opts[i];
 
-		if (pos + 1 > OPTS_MAX) {
-			tst_brkm(TBROK, cleanup_fn,
-			         "%s:%d: Too much mkfs options", file, lineno);
-			return;
+			if (pos + 1 > OPTS_MAX) {
+				tst_brkm(TBROK, cleanup_fn,
+				         "%s:%d: Too much mkfs options", file, lineno);
+				return;
+			}
+
+			if (i)
+				strcat(extra_opts_str, " ");
+			strcat(extra_opts_str, extra_opts[i]);
 		}
 	}
 
@@ -80,7 +87,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 		tst_brkm(TBROK, cleanup_fn, "tst_clear_device() failed");
 
 	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
-	         dev, fs_type, fs_opts_str, extra_opt ? extra_opt : "");
+	         dev, fs_type, fs_opts_str, extra_opts_str);
 	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
 
 	switch (ret) {
diff --git a/lib/tst_test.c b/lib/tst_test.c
index cedab53b3..128040026 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -745,7 +745,7 @@ static void prepare_device(void)
 {
 	if (tst_test->format_device) {
 		SAFE_MKFS(tdev.dev, tdev.fs_type, tst_test->dev_fs_opts,
-			  tst_test->dev_extra_opt);
+			  tst_test->dev_extra_opts);
 	}
 
 	if (tst_test->needs_rofs) {
diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index 52c291f45..0d1fc3e96 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -145,6 +145,7 @@ static void do_test(void)
 static void setup(void)
 {
 	const char *fs_opts[3] = {"-b", "1024", NULL};
+	const char *extra_opts[] = {"10240", NULL};
 
 	tst_sig(FORK, DEF_HANDLER, NULL);
 	tst_require_root();
@@ -159,7 +160,7 @@ static void setup(void)
 	device = tst_acquire_device(cleanup);
 	if (!device)
 		tst_brkm(TCONF, cleanup, "Failed to obtain block device");
-	tst_mkfs(cleanup, device, fs_type, fs_opts, "10240");
+	tst_mkfs(cleanup, device, fs_type, fs_opts, extra_opts);
 
 	SAFE_MKDIR(cleanup, MNTPOINT, 0755);
 	/*
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index 1a890cfbc..11f1fb7bc 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -101,6 +101,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MOUNT_POINT,
 	.dev_fs_type = "ext4",
-	.dev_extra_opt = "-O encrypt",
+	.dev_extra_opts = (const char *const[]){"-O encrypt", NULL},
 	.dev_min_size = 512,
 };
-- 
2.16.4

