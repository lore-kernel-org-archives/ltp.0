From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Mar 2021 15:14:36 +0100
Subject: [LTP] [PATCH 0/3] Add proper filesystem skiplist
In-Reply-To: <1320332024.40018791.1615380919351.JavaMail.zimbra@redhat.com>
References: <20210310122625.25425-1-chrubis@suse.cz>
 <1320332024.40018791.1615380919351.JavaMail.zimbra@redhat.com>
Message-ID: <YEjUTK+UlEcK+6Lx@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Ack. Can you please also add something to docs?

Sure, what about:

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index dd1911ceb..833f1f7bc 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -978,41 +978,69 @@ LTP_ALIGN(x, a)
 
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
 
-	/*
-	 * Unsupported on NFS, TMPFS and RAMFS
-	 */
-	long type;
+When the '.all_filesystem' flag is set the '.skip_filesystems' list is passed
+to the function that detects supported filesystems any listed filesystem is
+not included in the resulting list of supported filesystems.
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
 
+If test needs to adjust expectations based on filesystem type it's also
+possible to detect filesystem type at the runtime. This is preferably used
+when only subset of the test is not applicable for a given filesystem.
+
 2.2.14 Thread-safety in the LTP library
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 

-- 
Cyril Hrubis
chrubis@suse.cz
