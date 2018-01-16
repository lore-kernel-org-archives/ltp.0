From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 16 Jan 2018 10:23:18 +0100
Subject: [LTP] [PATCH] safe_mount: Do not try mount() syscall for FUSE fs
Message-ID: <20180116092318.20521-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The problem here is that there exists two NTFS implementations. There is
a readonly support in the kernel and full read/write FUSE
implementation. If there is a NTFS kernel module present on the system
the mount() syscall successfuly mounts the device in read-only mode
which causes the tests to fail once they attempt to create a file.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---

This is one small nit I found while testing LTP I think that it's safe
enough for the relese since it only touches code for ntfs and exfat.

 lib/safe_macros.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index c4aed0b30..c48e436dc 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -723,8 +723,6 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 {
 	int rval;
 
-	rval = mount(source, target, filesystemtype, mountflags, data);
-
 	/*
 	 * The FUSE filesystem executes mount.fuse helper, which tries to
 	 * execute corresponding binary name which is encoded at the start of
@@ -732,21 +730,23 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
          *
 	 * The mount helpers are called mount.$fs_type.
 	 */
-	if (rval == -1 && errno == ENODEV && is_fuse(filesystemtype)) {
+	if (is_fuse(filesystemtype)) {
 		char buf[1024];
-		int ret;
 
 		tst_resm(TINFO, "Trying FUSE...");
 		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
 			 filesystemtype, source, target);
 
-		ret = tst_system(buf);
-		if (WIFEXITED(ret) && WEXITSTATUS(ret) == 0)
+		rval = tst_system(buf);
+		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
 			return 0;
 
-		errno = ENODEV;
+		tst_brkm(TBROK, cleanup_fn, "mount.%s failed with %i",
+			 filesystemtype, rval);
+		return -1;
 	}
 
+	rval = mount(source, target, filesystemtype, mountflags, data);
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 			 "%s:%d: mount(%s, %s, %s, %lu, %p) failed",
-- 
2.13.6

