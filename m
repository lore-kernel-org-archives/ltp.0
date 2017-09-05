From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  5 Sep 2017 18:09:04 +0200
Subject: [LTP] [RFC] [PATCH 01/15] lib/tst_mkfs: Clear first 512k of the
	device
Message-ID: <20170905160918.6477-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If we cal tst_mkfs() from a test more than once we end up with the very
same bug we already fixed by clearing the device in
tst_acquire_device(), i.e. some mkfs programs will not format it when
there is a valid FS signature there.

So this commit moves the code to clear up the first 512k of the device
from tst_acquire_device() to the tst_mkfs() where it rightfully belongs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_device.c | 9 +--------
 lib/tst_mkfs.c   | 6 ++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 936bbfd03..c0d689dde 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -244,15 +244,8 @@ const char *tst_acquire_device__(unsigned int size)
 
 		ltp_dev_size = ltp_dev_size/1024/1024;
 
-		if (acq_dev_size <= ltp_dev_size) {
-			if (tst_fill_file(dev, 0, 1024, 512)) {
-				tst_resm(TWARN | TERRNO,
-					 "Failed to clear the first 512k of %s",
-					 dev);
-			}
-
+		if (acq_dev_size <= ltp_dev_size)
 			return dev;
-		}
 
 		tst_resm(TINFO, "Skipping $LTP_DEV size %"PRIu64"MB, requested size %uMB",
 				ltp_dev_size, acq_dev_size);
diff --git a/lib/tst_mkfs.c b/lib/tst_mkfs.c
index f2e40ecd6..a63ee5e68 100644
--- a/lib/tst_mkfs.c
+++ b/lib/tst_mkfs.c
@@ -75,6 +75,12 @@ void tst_mkfs_(const char *file, const int lineno, void (cleanup_fn)(void),
 
 	argv[pos] = NULL;
 
+	if (tst_fill_file(dev, 0, 1024, 512)) {
+		tst_brkm(TBROK, cleanup_fn,
+			 "Failed to clear 512k block on %s", dev);
+		return;
+	}
+
 	tst_resm(TINFO, "Formatting %s with %s opts='%s' extra opts='%s'",
 	         dev, fs_type, fs_opts_str, extra_opt ? extra_opt : "");
 	ret = tst_run_cmd(cleanup_fn, argv, "/dev/null", NULL, 1);
-- 
2.13.0

