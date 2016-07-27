From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Jul 2016 13:44:06 +0800
Subject: [LTP] [PATCH 1/2] test.sh: make the loop device size can be
	customized
Message-ID: <1469598247-23993-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/lib/test.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 23d68c6..10a3ea7 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -257,6 +257,8 @@ ROD()
 
 tst_acquire_device()
 {
+	local dev_size=${1:-100}
+
 	if [ -z ${TST_TMPDIR} ]; then
 		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
 	fi
@@ -274,7 +276,7 @@ tst_acquire_device()
 		return
 	fi
 
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=102400
+	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$(($dev_size*1024))
 
 	TST_DEVICE=$(losetup -f)
 	if [ $? -ne 0 ]; then
-- 
1.8.3.1

