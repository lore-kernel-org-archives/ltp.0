From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Mar 2021 11:53:18 +0100
Subject: [LTP] [PATCH v3 4/4] doc: Update docs on filesystem detection
In-Reply-To: <20210317105318.32017-1-chrubis@suse.cz>
References: <20210317105318.32017-1-chrubis@suse.cz>
Message-ID: <20210317105318.32017-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/test-writing-guidelines.txt | 47 +++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 50696e14a..79642810c 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -978,39 +978,58 @@ LTP_ALIGN(x, a)
 
 Aligns the x to be next multiple of a. The a must be power of 2.
 
-2.2.13 Filesystem type detection
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+2.2.13 Filesystem type detection and skiplist
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Some tests are known to fail on certain filesystems (you cannot swap on TMPFS,
 there are unimplemented 'fcntl()' etc.).
 
-If your test needs to be skipped on certain filesystems, use the interface
-below:
+If your test needs to be skipped on certain filesystems use the
+'.skip_filesystems' field in the tst_test structure as follows:
 
 [source,c]
 -------------------------------------------------------------------------------
 #include "tst_test.h"
 
-	/*
-	 * Unsupported only on NFS.
-	 */
-	if (tst_fs_type(".") == TST_NFS_MAGIC)
-		tst_brk(TCONF, "Test not supported on NFS filesystem");
+static struct tst_test test = {
+	...
+        .skip_filesystems = (const char *const []) {
+                "tmpfs",
+                "ramfs",
+                "nfs",
+                NULL
+        },
+};
+-------------------------------------------------------------------------------
 
+When the '.all_filesystem' flag is set the '.skip_filesystems' list is passed
+to the function that detects supported filesystems any listed filesystem is
+not included in the resulting list of supported filesystems.
 
-	/*
-	 * Unsupported on NFS, TMPFS and RAMFS
-	 */
-	long type;
+If test needs to adjust expectations based on filesystem type it's also
+possible to detect filesystem type at the runtime. This is preferably used
+when only subset of the test is not applicable for a given filesystem.
+
+[source,c]
+-------------------------------------------------------------------------------
+#include "tst_test.h"
+
+static void run(void)
+{
+	...
 
 	switch ((type = tst_fs_type("."))) {
 	case TST_NFS_MAGIC:
 	case TST_TMPFS_MAGIC:
 	case TST_RAMFS_MAGIC:
-		tst_brk(TCONF, "Test not supported on %s filesystem",
+		tst_brk(TCONF, "Subtest not supported on %s",
 		        tst_fs_type_name(type));
+		return;
 	break;
 	}
+
+	...
+}
 -------------------------------------------------------------------------------
 
 2.2.14 Thread-safety in the LTP library
-- 
2.26.2

