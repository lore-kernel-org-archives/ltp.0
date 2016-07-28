From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Jul 2016 13:17:26 +0800
Subject: [LTP] [PATCH v2 1/2] runltp: extend the default loop device size to
	150MB
Message-ID: <1469683046-6271-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Increase TST_DEVICE size to make btrfs-progs happy.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runltp                | 2 +-
 testcases/lib/test.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/runltp b/runltp
index 29f43a0..3a46765 100755
--- a/runltp
+++ b/runltp
@@ -978,7 +978,7 @@ main()
 create_block()
 {
     #create a block device
-    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=102400 >/dev/null 2>&1
+    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=153600 >/dev/null 2>&1
     if [ $? -ne 0 ]; then
         echo "Failed to create loopback device image, please check disk space and re-run"
         return 1
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 23d68c6..4fe2773 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -274,7 +274,7 @@ tst_acquire_device()
 		return
 	fi
 
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=102400
+	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
 
 	TST_DEVICE=$(losetup -f)
 	if [ $? -ne 0 ]; then
-- 
1.8.3.1

