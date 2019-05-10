From: Murphy Zhou <xzhou@redhat.com>
Date: Fri, 10 May 2019 12:38:45 +0800
Subject: [LTP] [PATCH] safe_setuid: skip if testing on CIFS
Message-ID: <20190510043845.4977-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As CIFS is not supporting setuid operations.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 include/tst_fs.h      |  1 +
 lib/safe_macros.c     | 16 ++++++++++++++++
 lib/tst_fs_type.c     |  2 ++
 lib/tst_safe_macros.c |  8 ++++++++
 4 files changed, 27 insertions(+)

diff --git a/include/tst_fs.h b/include/tst_fs.h
index 423ca82ec..5025f0459 100644
--- a/include/tst_fs.h
+++ b/include/tst_fs.h
@@ -42,6 +42,7 @@
 #define TST_NILFS_MAGIC    0x3434
 #define TST_EXOFS_MAGIC    0x5DF5
 #define TST_OVERLAYFS_MAGIC 0x794c7630
+#define TST_CIFS_MAGIC     0xfe534d42
 
 enum {
 	TST_BYTES = 1,
diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index bac34cdb7..c3ba1d5be 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -277,6 +277,14 @@ int safe_seteuid(const char *file, const int lineno, void (*cleanup_fn) (void),
                  uid_t euid)
 {
 	int rval;
+	long fs_type;
+
+	fs_type = tst_fs_type(NULL, ".");
+	if (fs_type == TST_CIFS_MAGIC) {
+		tst_brkm(TCONF, cleanup_fn,
+			 "seteuid is not supported on %s filesystem",
+			 tst_fs_type_name(fs_type));
+	}
 
 	rval = seteuid(euid);
 	if (rval == -1) {
@@ -307,6 +315,14 @@ int safe_setuid(const char *file, const int lineno, void (*cleanup_fn) (void),
                 uid_t uid)
 {
 	int rval;
+	long fs_type;
+
+	fs_type = tst_fs_type(NULL, ".");
+	if (fs_type == TST_CIFS_MAGIC) {
+		tst_brkm(TCONF, cleanup_fn,
+			 "setuid is not supported on %s filesystem",
+			 tst_fs_type_name(fs_type));
+	}
 
 	rval = setuid(uid);
 	if (rval == -1) {
diff --git a/lib/tst_fs_type.c b/lib/tst_fs_type.c
index 1d0ac9669..eea7c5d4b 100644
--- a/lib/tst_fs_type.c
+++ b/lib/tst_fs_type.c
@@ -84,6 +84,8 @@ const char *tst_fs_type_name(long f_type)
 		return "EXOFS";
 	case TST_OVERLAYFS_MAGIC:
 		return "OVERLAYFS";
+	case TST_CIFS_MAGIC:
+		return "CIFS";
 	default:
 		return "Unknown";
 	}
diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index 0e59a3f98..36941ec0b 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -111,6 +111,7 @@ int safe_setreuid(const char *file, const int lineno,
 		  uid_t ruid, uid_t euid)
 {
 	int rval;
+	long fs_type;
 
 	rval = setreuid(ruid, euid);
 	if (rval == -1) {
@@ -119,6 +120,13 @@ int safe_setreuid(const char *file, const int lineno,
 			 (long)ruid, (long)euid);
 	}
 
+	fs_type = tst_fs_type(".");
+	if (fs_type == TST_CIFS_MAGIC) {
+		tst_brk_(file, lineno, TCONF,
+			 "setreuid is not supported on %s filesystem",
+			 tst_fs_type_name(fs_type));
+	}
+
 	return rval;
 }
 
-- 
2.21.0

