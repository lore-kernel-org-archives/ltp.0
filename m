From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Dec 2017 11:52:36 -0500 (EST)
Subject: [LTP] [PATCH v2 4/4] lib: mkfs: use 'mke2fs' for formatting
 extN filesystems
In-Reply-To: <20171114021118.103786-5-sspatil@google.com>
References: <20171114021118.103786-1-sspatil@google.com>
 <20171114021118.103786-5-sspatil@google.com>
Message-ID: <455367801.51525915.1512406356197.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Cyril,

when you get a chance, can you please also look at this one?
It's the last unpushed patch from Sandeep's series, that
touches newly added all_filesystems.

Regards,
Jan

----- Original Message -----
Android does not have mkfs.extN symlinks and only extN filesystems
images can be created on the device. So, make sure we use 'mke2fs -t
<fs_type>' when being built for Android and filter out any non-ext
filesystem type requests from tst_mkfs_() when built for Android.

In order to do this, we add a new "tst_get_mkfs()" api in the library
that checks if the given filesystem is supported and automatically
fills in the formatting tool's name in the buffer if it exists.

syscalls/mmap16, syscalls/rename11 are the tests the tests currently
known to start working after this change on Android systems

Signed-off-by: Sandeep Patil <sspatil@google.com>
---

v1->v2
-------
- Add the new tst_get_mkfs() API and use it in tst_mkfs_()
- Limit the __ANDROID__ ifdef to tst_supported_fs_types only
- Always use mke2fs for extN filesystem formatting instead of mkfs.extN
  (This allows all the tests that do filesystem formatting to run on Android
   systems)

 include/tst_fs.h             | 13 +++++++++++++
 lib/tst_mkfs.c               | 17 +++++++++++++++--
 lib/tst_supported_fs_types.c | 38 ++++++++++++++++++++++++++++++++------
 3 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 0ad535c2b..ad6979a58 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -151,6 +151,19 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
  */
 const char **tst_get_supported_fs_types(void);
 
+/*
+ * Returns 1 if given filesystem is supported, 0 otherwise.
+ */
+int tst_is_supported_fs_type(const char *fs_type);
+
+/*
+ * Test for the existence of filesystem formatting tool (mkfs.<fs_type>)
+ * and return the name if found.
+ *
+ * Returns 0 on Success, 1 if the buffer was too small or the tool wasn't found.
+ */
+int tst_get_mkfs(const char *fs_type, char *buf, size_t buf_len);
+
 /*
  * Creates and writes to files on given path until write fails with ENOSPC
  */
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 7385a939f..99ab2cac7 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -15,6 +15,8 @@
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <limits.h>
+
 #include "test.h"
 #include "ltp_priv.h"
 #include "tst_mkfs.h"
@@ -27,7 +29,7 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 	       const char *const fs_opts[], const char *extra_opt)
 {
 	int i, pos = 1, ret;
-	char mkfs[64];
+	char mkfs[NAME_MAX];
 	const char *argv[OPTS_MAX] = {mkfs};
 	char fs_opts_str[1024] = "";
 
@@ -43,7 +45,18 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 		return;
 	}
 
-	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
+	if (tst_get_mkfs(fs_type, mkfs, NAME_MAX))
+		tst_brkm(TCONF, cleanup_fn,
+			 "mkfs.%s not found for %s", fs_type, fs_type);
+
+	if (!strcmp(mkfs, "mke2fs")) {
+		/* insert '-t <fs_type> in arguments here */
+		argv[pos++] = "-t";
+		strcat(fs_opts_str, "-t ");
+		argv[pos++] = fs_type;
+		strcat(fs_opts_str, fs_type);
+		strcat(fs_opts_str, " ");
+	}
 
 	if (fs_opts) {
 		for (i = 0; fs_opts[i]; i++) {
diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index a23b1ed52..a62dda0da 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -29,31 +29,43 @@ static const char *const fs_type_whitelist[] = {
 	"ext2",
 	"ext3",
 	"ext4",
+#ifndef __ANDROID__
 	"xfs",
 	"btrfs",
 	"vfat",
 	"exfat",
 	"ntfs",
+#endif
 	NULL
 };
 
 static const char *fs_types[ARRAY_SIZE(fs_type_whitelist)];
 
+static void to_mkfs(char *buf, const char *fs_type)
+{
+	/* Use mke2fs instead of the mkfs.extN symlinks
+	 * so the same code works for Android systems
+	 */
+	if (!strncmp(fs_type, "ext", 3))
+		strcpy(buf, "mke2fs");
+	else
+		sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
+}
+
 static int has_mkfs(const char *fs_type)
 {
-	char buf[128];
+	char buf[NAME_MAX];
 	int ret;
 
-	sprintf(buf, "mkfs.%s >/dev/null 2>&1", fs_type);
-
+	to_mkfs(buf, fs_type);
 	ret = tst_system(buf);
-
 	if (WEXITSTATUS(ret) == 127) {
-		tst_res(TINFO, "mkfs.%s does not exist", fs_type);
+		tst_res(TINFO, "%s for formatting %s does not exist",
+			buf, fs_type);
 		return 0;
 	}
 
-	tst_res(TINFO, "mkfs.%s does exist", fs_type);
+	tst_res(TINFO, "%s for formatting %s does exist", buf, fs_type);
 	return 1;
 }
 
@@ -116,3 +128,17 @@ const char **tst_get_supported_fs_types(void)
 
 	return fs_types;
 }
+
+int tst_get_mkfs(const char *fs_type, char *buf, size_t buf_len)
+{
+	tst_res(TINFO, "Checking for mkfs - %s", fs_type);
+	if (!is_supported(fs_type))
+		return 1;
+
+	/* make sure we have big enough buffer */
+	if (buf_len <= strlen(fs_type) + 5)
+		return 1;
+
+	to_mkfs(buf, fs_type);
+	return 0;
+}
-- 
2.15.0.448.gf294e3d99a-goog

