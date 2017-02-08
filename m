From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed,  8 Feb 2017 12:02:55 +0100
Subject: [LTP] [PATCH 6/6] runltp,
	tst_device: Bump minimal device size to 256MB
In-Reply-To: <20170208110255.443-1-chrubis@suse.cz>
References: <20170208110255.443-1-chrubis@suse.cz>
Message-ID: <20170208110255.443-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_device.c | 3 ++-
 runltp           | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 24e8c6f..4cefd60 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -41,6 +41,7 @@
 #define LOOP_CONTROL_FILE "/dev/loop-control"
 
 #define DEV_FILE "test_dev.img"
+#define DEV_SIZE_MB 256
 
 static char dev_path[1024];
 static int device_acquired;
@@ -204,7 +205,7 @@ const char *tst_acquire_device__(unsigned int size)
 	unsigned int acq_dev_size;
 	uint64_t ltp_dev_size;
 
-	acq_dev_size = size > 150 ? size : 150;
+	acq_dev_size = size > DEV_SIZE_MB ? size : DEV_SIZE_MB;
 
 	dev = getenv("LTP_DEV");
 
diff --git a/runltp b/runltp
index f347f55..f081805 100755
--- a/runltp
+++ b/runltp
@@ -986,7 +986,7 @@ main()
 create_block()
 {
     #create a block device
-    dd if=/dev/zero of=${TMP}/test.img bs=1024 count=153600 >/dev/null 2>&1
+    dd if=/dev/zero of=${TMP}/test.img bs=1024 count=262144 >/dev/null 2>&1
     if [ $? -ne 0 ]; then
         echo "Failed to create loopback device image, please check disk space and re-run"
         return 1
-- 
2.10.2

