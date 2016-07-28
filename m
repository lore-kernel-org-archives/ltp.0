From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Jul 2016 13:17:39 +0800
Subject: [LTP] [PATCH v2 2/2] test.sh: make the loop device size can be
	customized
Message-ID: <1469683059-6318-1-git-send-email-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The LTP_DEV default size is 150MB, but sometimes we need different
(larger or smaller) size of test block device.

For the purpose of satisfying specific requirements, here adding
parameters to tst_acquire_device() to make the loop device can be
customized according to real needed.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/lib/test.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 4fe2773..835ea39 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -257,11 +257,13 @@ ROD()
 
 tst_acquire_device()
 {
+	local acq_dev_size=${1:-150}
+
 	if [ -z ${TST_TMPDIR} ]; then
 		tst_brkm "Use 'tst_tmpdir' before 'tst_acquire_device'"
 	fi
 
-	if [ -n "${LTP_DEV}" ]; then
+	if [ -n "${LTP_DEV}" ] && [ ${acq_dev_size} -eq 150 ]; then
 		tst_resm TINFO "Using test device LTP_DEV='${LTP_DEV}'"
 		if [ ! -b ${LTP_DEV} ]; then
 			tst_brkm TBROK "${LTP_DEV} is not a block device"
@@ -274,7 +276,7 @@ tst_acquire_device()
 		return
 	fi
 
-	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=153600
+	ROD_SILENT dd if=/dev/zero of=test_dev.img bs=1024 count=$((1024*$acq_dev_size))
 
 	TST_DEVICE=$(losetup -f)
 	if [ $? -ne 0 ]; then
-- 
1.8.3.1

