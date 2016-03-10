From: Zorro Lang <zlang@redhat.com>
Date: Thu, 10 Mar 2016 17:07:36 +0800
Subject: [LTP] [PATCH 2/2] tst_mkfs: add new function tst_mkfs_sized
In-Reply-To: <1457600856-29034-1-git-send-email-zlang@redhat.com>
References: <1457600856-29034-1-git-send-email-zlang@redhat.com>
Message-ID: <1457600856-29034-2-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The new function as below:
  void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
                      const char *fs_type, const char *fs_size,
                      const char *blk_size);

This is an extensional function of tst_mkfs(), This function is only
used to make fs with an appointed fs size or block size or both. For
some filesystems(e.g. ext2/3/4), if you set 'fs_size', then you need
to give blk_size at the same time, the reason please check the manual
of mke2fs.

Generally we can use tst_mkfs() function to make an appointed size
fs, by use its fs_opts and extra_opts option. But if a testcase maybe
mkfs different filesystem type, due to different fs need different
options, so we need to check the fs_type and do different operations.
tst_mkfs_sized() function is used for that.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi Cyril,

I still think tst_mkfs_sized() function is needed, even I haven't
use it in any testcase.

tst_mkfs() can make an appointed size fs for someone pointed fs. But
if the fs_type can't be sure before call tst_mkfs(), for example:

for fs_type in "xfs ext4 btrfs"
do
    tst_mkfs(....);
done

In this condition, we can't use tst_mkfs directly. So I think this
tst_mkfs_sized is needed. For fs test, fs size and block size always
be used, maybe this function is useful in the future:)

In xfstests, we alway use scratch_mkfs_sized() function, I just try to
copy it to here. You can merge this if you feel it's helpful, or wait
for LTP really need it. I just sent this patch as I already did it.

Thanks,
Zorro

 doc/test-writing-guidelines.txt | 20 +++++++++++
 include/test.h                  | 13 +++++++
 lib/tst_mkfs.c                  | 76 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index e9c56c8..17d262a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -921,6 +921,26 @@ a string such as "102400". 'extra_opts' will be used behind device name. e.g:
 mkfs -t ext4 -b 1024 /dev/sda1 102400
                                ^^^^^^
 
+[source,c]
+-------------------------------------------------------------------------------
+#include "test.h"
+
+void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
+                    const char *fs_type, const char *fs_size,
+                    const char *blk_size);
+-------------------------------------------------------------------------------
+
+This is an extensional function of tst_mkfs(), This function is only used to
+make fs with an appointed fs size or block size or both. For some filesystems
+(e.g. ext2/3/4), if you set 'fs_size', then you need to give blk_size
+at the same time, the reason please check the manual of mke2fs.
+
+Generally we can use tst_mkfs() function to make an appointed size fs, by use
+its fs_opts and extra_opts option. But if a testcase maybe mkfs different file-
+system type, due to different fs need different options, so we need to check
+the fs_type and do different operations. tst_mkfs_sized() function is used for
+that.
+
 2.2.16 Verifying a filesystem's free space
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/include/test.h b/include/test.h
index 211ffb6..e6435a5 100644
--- a/include/test.h
+++ b/include/test.h
@@ -323,6 +323,19 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
               const char *fs_type, const char *const fs_opts[],
               const char *extra_opts);
 
+/* lib/tst_mkfs.c
+ *
+ * @dev: path to a device
+ * @fs_type: filesystem type
+ * @fs_size: filesystem size, e.g. "512m", "2g", "1024000"
+ * @blk_size: filesystem block size, e.g. "512", "1024", "4096"
+ * If both @fs_size and @blk_size aren NULL, it will same as
+ *    tst_mkfs(cleanup_fn, dev, fs_type, NULL, NULL);
+ */
+void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
+                    const char *fs_type, const char *fs_size,
+                    const char *blk_size);
+
 /*
  * Returns filesystem type to be used for the testing. Unless your test is
  * designed for specific filesystem you should use this function to the tested
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 7b02578..246b34f 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -18,6 +18,7 @@
 
 #include "test.h"
 #include "ltp_priv.h"
+#include "bytes_by_prefix.h"
 
 #define OPTS_MAX 32
 
@@ -99,6 +100,81 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
 }
 
+void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
+                    const char *fs_type, const char *fs_size,
+                    const char *blk_size)
+{
+	const char *fs_opts[OPTS_MAX] = {NULL};
+	char *extra_opts = NULL;
+	int pos = 0;
+	long long fsz = 0;
+	long long blz = 0;
+	char *fsz_str = NULL;
+	char *blz_str = NULL;
+
+	if (!strcmp(fs_type, "xfs")) {
+		fsz_str = malloc(128);
+		blz_str = malloc(128);
+		if (fs_size) {
+			fs_opts[pos++] = "-d";
+			strcpy(fsz_str, "size=");
+			strcat(fsz_str, fs_size);
+			fs_opts[pos++] = fsz_str;
+			fs_opts[pos] = NULL;
+		}
+
+		if (blk_size) {
+			fs_opts[pos++] = "-b";
+			strcpy(blz_str, "size=");
+			strcat(blz_str, blk_size);
+			fs_opts[pos++] = blz_str;
+			fs_opts[pos] = NULL;
+		}
+	} else if (!strncmp(fs_type, "ext", 3)) {
+		if (fs_size) {
+			extra_opts = malloc(128);
+			/*
+			 * extX must know block size, for calculate block counts
+			 */
+			if (!blk_size)
+				blk_size = "4096";
+			fsz = llbytes_by_prefix(fs_size);
+			blz = llbytes_by_prefix(blk_size);
+			sprintf(extra_opts, "%llu", fsz / blz);
+		}
+
+		if (blk_size) {
+			fs_opts[pos++] = "-b";
+			fs_opts[pos++] = blk_size;
+			fs_opts[pos] = NULL;
+		}
+	} else if (!strcmp(fs_type, "btrfs")) {
+		if (fs_size) {
+			/*
+			 * The recommended size for the mixed mode is for filesystems less than 1GiB
+			 */
+			if (llbytes_by_prefix(fs_size) < 1024 * 1024 * 1024)
+				fs_opts[pos++] = "--mixed";
+			fs_opts[pos++] = "-b";
+			fs_opts[pos++] = fs_size;
+			fs_opts[pos] = NULL;
+		}
+	} else if (fs_size || blk_size) {
+		/*
+		 * Can't set fs size or block size for others fs,
+		 * except add new fs support as above.
+		 */
+		tst_brkm(TBROK, cleanup_fn,
+		         "tst_mkfs_sized doesn't support '%s' fs, please add this fs as a new feature",
+		         fs_type);
+	}
+
+	tst_mkfs(cleanup_fn, dev, fs_type, fs_opts, extra_opts);
+	free(extra_opts);
+	free(fsz_str);
+	free(blz_str);
+}
+
 const char *tst_dev_fs_type(void)
 {
 	const char *fs_type;
-- 
2.5.0

