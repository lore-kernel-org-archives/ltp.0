From: Sandeep Patil <sspatil@google.com>
Date: Wed,  8 Nov 2017 16:34:38 -0800
Subject: [LTP] [PATCH 6/6] lib: mkfs: use 'mke2fs' on android systems for
	formatting filesystems
In-Reply-To: <20171109003438.130802-1-sspatil@google.com>
References: <20171109003438.130802-1-sspatil@google.com>
Message-ID: <20171109003438.130802-7-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Android does not have mkfs.extN symlinks and only extN filesystems
images can be created on the device. So, make sure we use 'mke2fs -t
<fs_type>' when being built for Android and filter out any non-ext
filesystem type requests from tst_mkfs_() when built for Android.

syscalls/mmap16, syscalls/rename11 are the tests the tests currently
known to start working after this change on Android systems

Signed-off-by: Sandeep Patil <sspatil@google.com>
---
 lib/tst_mkfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index 7385a939f..c46d07044 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -43,7 +43,23 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 		return;
 	}
 
+#ifdef __ANDROID__
+	if (strncmp(fs_type, "ext", 3)) {
+		tst_brkm(TBROK, cleanup_fn,
+			 "%s:%d: \'%s\' fs_type not supported", file, lineno, fs_type);
+		return;
+	}
+	strcpy(mkfs, "mke2fs");
+
+	/* insert '-t <fs_type> in arguments here */
+	argv[pos++] = "-t";
+	strcat(fs_opts_str, "-t ");
+	argv[pos++] = fs_type;
+	strcat(fs_opts_str, fs_type);
+	strcat(fs_opts_str, " ");
+#else
 	snprintf(mkfs, sizeof(mkfs), "mkfs.%s", fs_type);
+#endif
 
 	if (fs_opts) {
 		for (i = 0; fs_opts[i]; i++) {
-- 
2.15.0.448.gf294e3d99a-goog

