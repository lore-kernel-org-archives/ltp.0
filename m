From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Aug 2016 21:09:09 +0800
Subject: [LTP] [PATCH v3 1/2] test.sh: make the loop device size can be
	increased
Message-ID: <1471525749-18509-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the purpose of satisfying specific requirements, here adding
parameters to tst_acquire_device() to make the test device can be
increased according to real need.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/lib/test.sh | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index bd66109..60f8836 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -258,11 +258,15 @@ ROD()
 
 tst_acquire_device()
 {
+	local acq_dev_size=${1:-150}
+
 	if [ -z ${TST_TMPDIR} ]; then
 		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
 	fi
 
-	if [ -n "${LTP_DEV}" ]; then
+	ltp_dev_size=$((`blockdev --getsize64 $LTP_DEV`/1024/1024))
+
+	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -le ${ltp_dev_size} ]; then
 		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
 		if [ ! -b ${LTP_DEV} ]; then
 			tst_brkm TBROK "${LTP_DEV} is not a block device"
@@ -275,7 +279,7 @@ tst_acquire_device()
 		return
 	fi
 
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
+	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
 
 	TST_DEVICE=$(losetup -f)
 	if [ $? -ne 0 ]; then
-- 
1.8.3.1

