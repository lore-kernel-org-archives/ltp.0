From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:06 +0200
Subject: [LTP] [RFC] [PATCH 03/15] SAFE_MOUNT: Handle FUSE mounts as well
In-Reply-To: <20170905160918.6477-1-chrubis@suse.cz>
References: <20170905160918.6477-1-chrubis@suse.cz>
Message-ID: <20170905160918.6477-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FUSE mounts can be only mounted by the corresponding mount.$fs_type handler.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/safe_macros.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 7ca1849fa..c4aed0b30 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -699,6 +699,23 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
 	return rval;
 }
 
+static const char *const fuse_fs_types[] = {
+	"exfat",
+	"ntfs",
+};
+
+static int is_fuse(const char *fs_type)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(fuse_fs_types); i++) {
+		if (!strcmp(fuse_fs_types[i], fs_type))
+			return 1;
+	}
+
+	return 0;
+}
+
 int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	       const char *source, const char *target,
 	       const char *filesystemtype, unsigned long mountflags,
@@ -708,6 +725,28 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 
 	rval = mount(source, target, filesystemtype, mountflags, data);
 
+	/*
+	 * The FUSE filesystem executes mount.fuse helper, which tries to
+	 * execute corresponding binary name which is encoded@the start of
+	 * the source string and separated by # from the device name.
+         *
+	 * The mount helpers are called mount.$fs_type.
+	 */
+	if (rval == -1 && errno == ENODEV && is_fuse(filesystemtype)) {
+		char buf[1024];
+		int ret;
+
+		tst_resm(TINFO, "Trying FUSE...");
+		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
+			 filesystemtype, source, target);
+
+		ret = tst_system(buf);
+		if (WIFEXITED(ret) && WEXITSTATUS(ret) == 0)
+			return 0;
+
+		errno = ENODEV;
+	}
+
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: mount(%s, %s, %s, %lu, %p) failed",
-- 
2.13.0

