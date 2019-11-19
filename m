From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 19 Nov 2019 11:29:26 +0100
Subject: [LTP] [PATCH] lib: don't pass NULL to strcmp in safe_mount
Message-ID: <1a623a82dfac64c8a6f9805c197fa72cb5e6f046.1574159295.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Rachel reports, that pivot_root01 crashes on latest LTP:
  Thread 3.1 "pivot_root01" received signal SIGSEGV, Segmentation fault.
  0x00000000004062c4 in safe_mount (file=file@entry=0x413017 "pivot_root01.c"
  733             if (strcmp(filesystemtype, "ntfs")) {

Don't pass NULL ptr to strcmp. Also fix return in unreachable path,
to suppress warning about returning uninitialized 'rval'.

Fixes: ae52b6f41bf3 ("lib: Fix safe_mount() when mounting NTFS on kernels with NTFS support")
Reported-by: Rachel Sibley <rasibley@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 lib/safe_macros.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index c725c7d7763f..41fa4ca83004 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -730,7 +730,7 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
 	 * the kernel's NTFS driver doesn't have proper write support.
 	 */
-	if (strcmp(filesystemtype, "ntfs")) {
+	if (!filesystemtype || strcmp(filesystemtype, "ntfs")) {
 		rval = mount(source, target, filesystemtype, mountflags, data);
 		if (!rval)
 			return 0;
@@ -764,7 +764,7 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
 			 mountflags, data);
 	}
 
-	return rval;
+	return -1;
 }
 
 int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
-- 
1.8.3.1

