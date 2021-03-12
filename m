From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 12 Mar 2021 12:06:20 +0100
Subject: [LTP] [PATCH v3] lib: Add proper filesystem skiplist
In-Reply-To: <20210311105509.2701-2-chrubis@suse.cz>
References: <20210311105509.2701-2-chrubis@suse.cz>
Message-ID: <20210312110620.13395-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The approach with flags we added for FUSE does not scale at all, we need
a proper skiplist so that we can skip individual filesystems.

The motivation here is the addition of tmpfs to the supported
filesystems check. One of the problems there is that sync() is no-op on
tmpfs and hence the syncfs test fails. After this patchset we can simply
skip syncfs test on tmpfs by setting the right skiplist.

As a bonus point the list of unsupported filesystem gets nicely
propagated to the metadata as well.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Co-authored-by: Martin Doucha <mdoucha@suse.cz>
---

Moving the skiplist logic from has_kernel_support() to tst_fs_is_supported()
misses the point of my objection. This is the code I had in mind when I was
commenting on the patchset.

 include/tst_fs.h                              | 26 +++++++---
 include/tst_test.h                            |  9 +++-
 lib/tst_supported_fs_types.c                  | 51 ++++++++++++++-----
 lib/tst_test.c                                |  2 +-
 .../kernel/syscalls/fsconfig/fsconfig01.c     |  2 +-
 testcases/kernel/syscalls/fsmount/fsmount01.c |  2 +-
 testcases/kernel/syscalls/fsmount/fsmount02.c |  2 +-
 testcases/kernel/syscalls/fsopen/fsopen01.c   |  2 +-
 testcases/kernel/syscalls/fspick/fspick01.c   |  2 +-
 testcases/kernel/syscalls/fspick/fspick02.c   |  2 +-
 .../kernel/syscalls/move_mount/move_mount01.c |  2 +-
 .../kernel/syscalls/move_mount/move_mount02.c |  2 +-
 .../kernel/syscalls/open_tree/open_tree01.c   |  2 +-
 .../kernel/syscalls/open_tree/open_tree02.c   |  2 +-
 .../sync_file_range/sync_file_range02.c       |  2 +-
 testcases/lib/tst_supported_fs.c              |  4 +-
 16 files changed, 79 insertions(+), 35 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 4f7dd68d2..ae58a9647 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -44,6 +44,9 @@ enum {
 #define OVL_WORK	OVL_BASE_MNTPOINT"/work"
 #define OVL_MNT		OVL_BASE_MNTPOINT"/ovl"
 
+#define TST_FS_NATIVE 1
+#define TST_FS_FUSE   2
+
 /*
  * @path: path is the pathname of any file within the mounted file system
  * @mult: mult should be TST_KB, TST_MB or TST_GB
@@ -167,18 +170,29 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
  */
 int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
 
-#define TST_FS_SKIP_FUSE 0x01
-
 /*
- * Return 1 if a specified fiilsystem is supported
- * Return 0 if a specified fiilsystem isn't supported
+ * Return TST_FS_NATIVE if a specified filesystem is supported by kernel
+ * Return TST_FS_FUSE if a specified filesystem is supported through FUSE
+ * Return 0 if a specified filesystem isn't supported
+ *
+ * @fs_type A filesystem type to check the support for.
  */
-int tst_fs_is_supported(const char *fs_type, int flags);
+int tst_fs_is_supported(const char *fs_type);
 
 /*
  * Returns NULL-terminated array of kernel-supported filesystems.
+ *
+ * @skiplist A NULL terminated array of filesystems to skip.
+ */
+const char **tst_get_supported_fs_types(const char *const *skiplist);
+
+/*
+ * Returns 1 if filesystem is in skiplist 0 otherwise.
+ *
+ * @fs_type A filesystem type to lookup.
+ * @skiplist A NULL terminated array of fileystemsytems to skip.
  */
-const char **tst_get_supported_fs_types(int flags);
+int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist);
 
 /*
  * Creates and writes to files on given path until write fails with ENOSPC
diff --git a/include/tst_test.h b/include/tst_test.h
index 1fbebe752..4eee6f897 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -159,6 +159,13 @@ struct tst_test {
 	 */
 	int all_filesystems:1;
 
+	/*
+	 * The skip_filesystem is a NULL terminated list of filesystems the
+	 * test does not support. It can also be used to disable whole class of
+	 * filesystems with a special keyworks such as "fuse".
+	 */
+	const char *const *skip_filesystems;
+
 	/* Minimum number of online CPU required by the test */
 	unsigned long min_cpus;
 
@@ -197,8 +204,6 @@ struct tst_test {
 
 	/* Device filesystem type override NULL == default */
 	const char *dev_fs_type;
-	/* Flags to be passed to tst_get_supported_fs_types() */
-	int dev_fs_flags;
 
 	/* Options passed to SAFE_MKFS() when format_device is set */
 	const char *const *dev_fs_opts;
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 00ede549d..7a420f481 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -45,7 +45,22 @@ static int has_mkfs(const char *fs_type)
 	return 1;
 }
 
-static int has_kernel_support(const char *fs_type, int flags)
+int tst_fs_in_skiplist(const char *fs_type, const char *const *skiplist)
+{
+	unsigned int i;
+
+	if (!skiplist)
+		return 0;
+
+	for (i = 0; skiplist[i]; i++) {
+		if (!strcmp(fs_type, skiplist[i]))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int has_kernel_support(const char *fs_type)
 {
 	static int fuse_supported = -1;
 	const char *tmpdir = getenv("TMPDIR");
@@ -58,7 +73,7 @@ static int has_kernel_support(const char *fs_type, int flags)
 	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
 	if (errno != ENODEV) {
 		tst_res(TINFO, "Kernel supports %s", fs_type);
-		return 1;
+		return TST_FS_NATIVE;
 	}
 
 	/* Is FUSE supported by kernel? */
@@ -84,26 +99,36 @@ static int has_kernel_support(const char *fs_type, int flags)
 		return 0;
 	}
 
-	if (flags & TST_FS_SKIP_FUSE) {
-		tst_res(TINFO, "Skipping FUSE as requested by the test");
-		return 0;
-	}
-
 	tst_res(TINFO, "FUSE does support %s", fs_type);
-	return 1;
+	return TST_FS_FUSE;
 }
 
-int tst_fs_is_supported(const char *fs_type, int flags)
+int tst_fs_is_supported(const char *fs_type)
 {
-	return has_kernel_support(fs_type, flags) && has_mkfs(fs_type);
+	if (has_mkfs(fs_type))
+		return has_kernel_support(fs_type);
+
+	return 0;
 }
 
-const char **tst_get_supported_fs_types(int flags)
+const char **tst_get_supported_fs_types(const char *const *skiplist)
 {
-	unsigned int i, j = 0;
+	unsigned int ret, skip_fuse, i, j = 0;
+
+	skip_fuse = tst_fs_in_skiplist("fuse", skiplist);
 
 	for (i = 0; fs_type_whitelist[i]; i++) {
-		if (tst_fs_is_supported(fs_type_whitelist[i], flags))
+		if (tst_fs_in_skiplist(fs_type_whitelist[i], skiplist))
+			continue;
+
+		ret = tst_fs_is_supported(fs_type_whitelist[i]);
+
+		if (ret == TST_FS_FUSE && skip_fuse) {
+			tst_res(TINFO, "Skipping FUSE as requested by test");
+			continue;
+		}
+
+		if (ret)
 			fs_types[j++] = fs_type_whitelist[i];
 	}
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 45753d1ca..639e21727 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1347,7 +1347,7 @@ static int run_tcases_per_fs(void)
 {
 	int ret = 0;
 	unsigned int i;
-	const char *const *filesystems = tst_get_supported_fs_types(tst_test->dev_fs_flags);
+	const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
 
 	if (!filesystems[0])
 		tst_brk(TCONF, "There are no supported filesystems");
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
index 47941136d..a585daa6d 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -89,5 +89,5 @@ static struct tst_test test = {
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index e81981871..5f755863f 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -95,5 +95,5 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.format_device = 1,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index effc86351..a4f42dc18 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -76,5 +76,5 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.format_device = 1,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
index 8dabd6814..c2c719c96 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen01.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -76,5 +76,5 @@ static struct tst_test test = {
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index 2f372f7f1..d3309a912 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -63,5 +63,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/fspick/fspick02.c b/testcases/kernel/syscalls/fspick/fspick02.c
index b9d020226..f9a3697c1 100644
--- a/testcases/kernel/syscalls/fspick/fspick02.c
+++ b/testcases/kernel/syscalls/fspick/fspick02.c
@@ -50,5 +50,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/move_mount/move_mount01.c b/testcases/kernel/syscalls/move_mount/move_mount01.c
index fd785da02..445e6197e 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount01.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount01.c
@@ -79,5 +79,5 @@ static struct tst_test test = {
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
index f75991a3f..45b1db4be 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount02.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -88,5 +88,5 @@ static struct tst_test test = {
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
index f217866bb..808d25665 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree01.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -70,5 +70,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
index 32ad1aefe..ddaa204f2 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree02.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -51,5 +51,5 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 };
diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
index 64d069e93..f68f46233 100644
--- a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
+++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
@@ -121,7 +121,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.mount_device = 1,
 	.all_filesystems = 1,
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
+	.skip_filesystems = (const char *const []){"fuse", NULL},
 	.mntpoint = MNTPOINT,
 	.setup = setup,
 	.test = run,
diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
index 022a61508..154b12ece 100644
--- a/testcases/lib/tst_supported_fs.c
+++ b/testcases/lib/tst_supported_fs.c
@@ -37,9 +37,9 @@ int main(int argc, char *argv[])
 	}
 
 	if (argv[1])
-		return !tst_fs_is_supported(argv[1], 0);
+		return !tst_fs_is_supported(argv[1]);
 
-	filesystems = tst_get_supported_fs_types(0);
+	filesystems = tst_get_supported_fs_types(NULL);
 	for (i = 0; filesystems[i]; i++)
 		printf("%s\n", filesystems[i]);
 
-- 
2.30.1

