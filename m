From: Alistair Strachan <astrachan@google.com>
Date: Tue, 29 Jan 2019 12:54:25 -0800
Subject: [LTP] [PATCH] lib/tst_kernel.c: Fix tst_check_driver() for Android
Message-ID: <20190129205425.62110-1-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The change 1f70b0a ("lib/tst_test.c: add 'needs_drivers' option with
tst_check_drivers cmd") and subsequent changes to tests to use
.needs_drivers caused some tests from older LTP releases to longer run
successfully under Android.

Android's modprobe currently lacks a dry-run mode, so it will return a
positive error code when invoked as 'modprobe -n', which pessimistically
disables tests that could run (such as fsetxattr2) with a TCONF status.

Even if this was fixed, Android systems might not have the
modprobe.*.bin files available to determine which drivers were built
into the kernel, so this probing method does not work for Android.

For now, allow tests that set .needs_drivers to continue to run under
Android by assuming that drivers are always present. The Android
ecosystem has other ways to enforce the presence of kernel features.

Signed-off-by: Alistair Strachan <astrachan@google.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Steve Muckle <smuckle@google.com>
Cc: kernel-team@android.com
---
 lib/tst_kernel.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c
index d051f3b07..a7fd38b4d 100644
--- a/lib/tst_kernel.c
+++ b/lib/tst_kernel.c
@@ -83,9 +83,17 @@ int tst_kernel_bits(void)
 
 int tst_check_driver(const char *name)
 {
+#ifndef __ANDROID__
 	const char * const argv[] = { "modprobe", "-n", name, NULL };
 	int res = tst_run_cmd_(NULL, argv, "/dev/null", "/dev/null", 1);
 
 	/* 255 - it looks like modprobe not available */
 	return (res == 255) ? 0 : res;
+#else
+	/* Android modprobe may not have '-n', or properly installed
+	 * module.*.bin files to determine built-in drivers. Assume
+	 * all drivers are available.
+	 */
+	return 0;
+#endif
 }
-- 
2.20.1.495.gaa96b0ce6b-goog

