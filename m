From: Yixin Zhang <yixin.zhang@intel.com>
Date: Thu, 26 Jul 2018 17:22:19 +0800
Subject: [LTP] [PATCH v3 ltp 4/4] fs/ext4: update format and fix typo
In-Reply-To: <20180726092219.15667-1-yixin.zhang@intel.com>
References: <20180726092219.15667-1-yixin.zhang@intel.com>
Message-ID: <20180726092219.15667-4-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 .../ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh              | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index e44b9f62e..06b4a31ed 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -71,7 +71,7 @@ ext4_test_nsec_timestamps()
 
 	mkfs.ext3 -I 256 $EXT4_DEV >/dev/null 2>&1
 	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to create ext4 filesystem"
+		tst_resm TFAIL "failed to create ext3 filesystem"
 		return
 	fi
 
@@ -100,8 +100,7 @@ ext4_test_nsec_timestamps()
 	nsec_ctime=`ext4_file_time mnt_point/tmp_file ctime nsec`
 
 	# Test nanosecond
-	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]
-	then
+	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]; then
 		tst_resm TFAIL "The timestamp is not nanosecond(nsec_atime: $nsec_atime, nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)"
 		tst_mount mnt_point
 		return
@@ -142,7 +141,7 @@ ext4_test_nsec_timestamps()
 	nsec_ctime2=`ext4_file_time mnt_point/tmp_file ctime nsec`
 
 	if [ $nsec_atime -ne $nsec_atime2 -o $nsec_ctime -ne $nsec_ctime2 -o \
-	     $nsec_mtime -ne $nsec_mtime2 ]; then
+			$nsec_mtime -ne $nsec_mtime2 ]; then
 		tst_resm TFAIL "File nanosecond timestamp has changed \
 			unexpected. Before[atime mtime ctime]: $nsec_atime \
 			$nsec_mtime $nsec_ctime, After[atime mtime ctime]: \
-- 
2.14.1

