From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Jan 2021 15:46:49 +0100
Subject: [LTP] [PATCH 1/1] lib: Fix fs support detection for non-root
Message-ID: <20210128144649.6012-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

grep /proc/filesystems to find kernel support.
But consider only 0 (filesystem found) or 1 (not found),
ignore other results (e.g. 2: /proc/filesystems not available or
no permissions) and fallback to old solution (calling mount()).

Warn when mount() fails due no permission (EPERM).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_supported_fs_types.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
index 00ede549d..66307e09e 100644
--- a/lib/tst_supported_fs_types.c
+++ b/lib/tst_supported_fs_types.c
@@ -52,10 +52,29 @@ static int has_kernel_support(const char *fs_type, int flags)
 	char buf[128];
 	int ret;
 
+	const char * const argv[] = { "grep", "-q", "-F", "-w", fs_type, "/proc/filesystems", NULL };
+	ret = tst_cmd_(NULL, argv, "/dev/null", "/dev/null", TST_CMD_PASS_RETVAL);
+
+	if (ret == 0) {
+		tst_res(TINFO, "Kernel supports %s", fs_type);
+		return 1;
+	}
+
+	if (ret == 1) {
+		tst_res(TINFO, "Filesystem %s is not supported", fs_type);
+		return 0;
+	}
+
 	if (!tmpdir)
 		tmpdir = "/tmp";
 
 	mount("/dev/zero", tmpdir, fs_type, 0, NULL);
+
+	if (errno == EPERM) {
+		tst_res(TWARN, "No permission to detect support for %s", fs_type);
+		return 1;
+	}
+
 	if (errno != ENODEV) {
 		tst_res(TINFO, "Kernel supports %s", fs_type);
 		return 1;
-- 
2.30.0

