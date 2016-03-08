From: Zorro Lang <zlang@redhat.com>
Date: Tue,  8 Mar 2016 21:35:32 +0800
Subject: [LTP] [PATCH 1/2] lib/tst_mkfs: new tst_mkfs_sized function for
	create appointed size fs
Message-ID: <1457444133-5671-1-git-send-email-zlang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the device which pointed by -b or -z options is too large, mkfs on
it will cost lots of time, some cases even return ETIMEDOUT error(e.g.
mmap16). So I do below change:

Change tst_mkfs() function to tst_mkfs_sized(), add two new parameters:
fssize and blocksize. tst_mkfs_sized() can create an appointed size fs
with appointed block size, or just point block size.

tst_mkfs() still can be used. It's defined as tst_mkfs_sized(..., NULL,
NULL).

Until now tst_mkfs_sized() only support extX, xfs and btrfs, if we
point fs size or block size parameters.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 include/test.h |  10 ++++--
 lib/tst_mkfs.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/include/test.h b/include/test.h
index 5c78b1d..25d14d9 100644
--- a/include/test.h
+++ b/include/test.h
@@ -317,9 +317,15 @@ int tst_system(const char *command);
  * @dev: path to a device
  * @fs_type: filesystem type
  * @fs_opts: NULL or NULL terminated array of extra mkfs options
+ * @fssize: fs size, can use k,m,g,t,p,e as unit. NULL can be accepted
+ * @blocksize: fs block size, can use k,m as unit. NULL can be accepted
  */
-void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-	      const char *fs_type, const char *const fs_opts[]);
+void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
+                    const char *fs_type, const char *const fs_opts[],
+                    const char *fssize, const char *blocksize);
+
+#define tst_mkfs(cleanup_fn, dev, fs_type, fs_opts) \
+	tst_mkfs_sized(cleanup_fn, dev, fs_type, fs_opts, NULL, NULL)
 
 /*
  * Returns filesystem type to be used for the testing. Unless your test is
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 5f959a4..94135c2 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -16,32 +16,84 @@
  * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <stdlib.h>
 #include "test.h"
 #include "ltp_priv.h"
 
 #define OPTS_MAX 32
 
-void tst_mkfs(void (cleanup_fn)(void), const char *dev,
-	      const char *fs_type, const char *const fs_opts[])
+long long cvtnum(const char *s)
+{
+	long long i;
+	char *sp = NULL;
+
+	i = strtoll(s, &sp, 0);
+	if (i == 0 && sp == s)
+		return -1LL;
+	if (*sp == '\0')
+		return i;
+
+	if (*sp == 'k' && sp[1] == '\0')
+		return 1024LL * i;
+	if (*sp == 'm' && sp[1] == '\0')
+		return 1024LL * 1024LL * i;
+	if (*sp == 'g' && sp[1] == '\0')
+		return 1024LL * 1024LL * 1024LL * i;
+	if (*sp == 't' && sp[1] == '\0')
+		return 1024LL * 1024LL * 1024LL * 1024LL * i;
+	if (*sp == 'p' && sp[1] == '\0')
+		return 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * i;
+	if (*sp == 'e' && sp[1] == '\0')
+		return 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * 1024LL * i;
+	return -1LL;
+}
+
+void tst_mkfs_sized(void (cleanup_fn)(void), const char *dev,
+                    const char *fs_type, const char *const fs_opts[],
+                    const char *fssize, const char *blocksize)
 {
 	int i, pos = 3;
 	const char *argv[OPTS_MAX] = {"mkfs", "-t", fs_type};
 	char fs_opts_str[1024] = "";
+	char blk_size_str[256] = "";
+	char fs_size_str[256] = "";
+	long long fssz = 0;
+	unsigned int blsz= 0;
 
 	if (!fs_type)
 		tst_brkm(TBROK, cleanup_fn, "No fs_type specified");
 
-	/*
-	 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
-	 * superblock on the device, which is the case here as we
-	 * reuse one device for all tests.
-	 */
 	if (!strcmp(fs_type, "xfs")) {
+		/*
+		 * mkfs.xfs and mkfs.btrfs aborts if it finds a filesystem
+		 * superblock on the device, which is the case here as we
+		 * reuse one device for all tests.
+		 */
 		tst_resm(TINFO, "Appending '-f' flag to mkfs.%s", fs_type);
 		argv[pos++] = "-f";
-	}
+		if (blocksize) {
+			argv[pos++] = "-b";
+			strcat(blk_size_str, "size=");
+			strcat(blk_size_str, blocksize);
+			argv[pos++] = blk_size_str;
+		}
 
-	if (!strcmp(fs_type, "btrfs")) {
+		if (!fssize) {
+			argv[pos++] = "-d";
+			strcat(fs_size_str, "size=");
+			strcat(fs_size_str, fssize);
+			argv[pos++] = fs_size_str;
+		}
+	} else if (!strncmp(fs_type, "ext", 3)) {
+		if (blocksize) {
+			argv[pos++] = "-b";
+			argv[pos++] = blocksize;
+		}
+		/*
+		 * If fs is extX, the fs_size should be set behind device name.
+		 * Not set at here.
+		 */
+	} else if (!strcmp(fs_type, "btrfs")) {
 		/*
 		 * The -f option was added to btrfs-progs v3.12
 		 */
@@ -50,6 +102,21 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 				fs_type);
 			argv[pos++] = "-f";
 		}
+		if (fssize) {
+			/*
+			 * The recommended size for the mixed mode is for filesystems less than 1GiB
+			 */
+			if (cvtnum(fssize) < 1024 * 1024 * 1024)
+				argv[pos++] = "--mixed";
+			argv[pos++] = "-b";
+			argv[pos++] = fssize;
+		}
+	} else if (fssize || blocksize) {
+		/*
+		 * Can't set fs size or block size for others fs,
+		 * except add new fs support as above.
+		 */
+		tst_brkm(TBROK, cleanup_fn, "tst_mkfs_sized don't support '%s' fs, please add this fs as a new feature", fs_type);
 	}
 
 	if (fs_opts) {
@@ -68,10 +135,30 @@ void tst_mkfs(void (cleanup_fn)(void), const char *dev,
 	}
 
 	argv[pos++] = dev;
+
+	/*
+	 * According to mke2fs(8) manual, fs-size need be behind the device
+	 * parameter. So add fs size into argv[pos++] after dev name.
+	 */
+	if (!strncmp(fs_type, "ext", 3) && fssize && blocksize) {
+		fssz = cvtnum(fssize);
+		blsz = cvtnum(blocksize);
+		if (fssz > 0 && blsz > 0){
+			sprintf(fs_size_str, "%llu", fssz / blsz);
+		} else {
+			tst_brkm(TBROK, cleanup_fn, "No suitable filesystem/block size specified");
+		}
+		argv[pos++] = fs_size_str;
+	}
+
 	argv[pos] = NULL;
 
-	tst_resm(TINFO, "Formatting %s with %s extra opts='%s'",
-		 dev, fs_type, fs_opts_str);
+	if (!fssize)
+		fssize = "Default";
+	if (!blocksize)
+		blocksize = "Default";
+	tst_resm(TINFO, "Formatting %s with %s extra opts='%s', blocksize is %s, fs size is %s",
+	         dev, fs_type, fs_opts_str, blocksize, fssize);
 	tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 0);
 }
 
-- 
2.5.0

