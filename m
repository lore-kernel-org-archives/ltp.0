From: Yixin Zhang <yixin.zhang@intel.com>
Date: Thu, 26 Jul 2018 17:22:17 +0800
Subject: [LTP] [PATCH v3 ltp 2/4] fs/ext4: Replace umount with tst_umount
In-Reply-To: <20180726092219.15667-1-yixin.zhang@intel.com>
References: <20180726092219.15667-1-yixin.zhang@intel.com>
Message-ID: <20180726092219.15667-2-yixin.zhang@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replace umount with tst_umount in common lib to handle umount failed due
to device busy

Signed-off-by: Yixin Zhang <yixin.zhang@intel.com>
---
 .../ext4_nsec_timestamps_test.sh                   | 25 +++++++---------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
index c6ff7c2ba..fdf64fde8 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-nsec-timestamps/ext4_nsec_timestamps_test.sh
@@ -56,15 +56,10 @@ ext4_test_sec_timestamps()
 	if [ $atime -ne 0 -o $mtime -ne 0 -o $ctime -ne 0 ]; then
 		tst_resm TFAIL "Timestamp is not second(atime: $atime, mtime: \
 				$mtime, ctime: $ctime)"
-		umount mnt_point
-		return
-	fi
-
-	umount mnt_point
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to umount ext4 filesystem"
+		tst_umount mnt_point
 		return
 	fi
+	tst_umount mnt_point
 
 	tst_resm TPASS "Ext4 nanosecond timestamps test with 128 inode size pass"
 }
@@ -108,7 +103,7 @@ ext4_test_nsec_timestamps()
 	if [ $nsec_atime -eq 0 -a $nsec_mtime -eq 0 -a $nsec_ctime -eq 0 ]
 	then
 		tst_resm TFAIL "The timestamp is not nanosecond(nsec_atime: $nsec_atime, nsec_mtime: $nsec_mtime, nsec_ctime: $nsec_ctime)"
-		umount mnt_point
+		tst_mount mnt_point
 		return
 	fi
 
@@ -122,15 +117,11 @@ ext4_test_nsec_timestamps()
 			than the current time we got.(sec_atime: $sec_atime, \
 			sec_mtime: $sec_mtime, sec_ctime: $sec_ctime, \
 			cur_time[s]: $sec)"
-		umount mnt_point
+		tst_umount mnt_point
 		return
 	fi
 
-	umount mnt_point
-	if [ $? -ne 0 ]; then
-		tst_resm TFAIL "failed to umount ext4 filesystem"
-		return
-	fi
+	tst_umount mnt_point
 
 	# Test mount to ext3 and then mount back to ext4
 	mount -t ext3 $EXT4_DEV mnt_point
@@ -138,7 +129,7 @@ ext4_test_nsec_timestamps()
 		tst_resm TFAIL "failed to mount to ext3"
 		return
 	fi
-	umount mnt_point
+	tst_umount mnt_point
 
 	mount -t ext4 $EXT4_DEV mnt_point
 	if [ $? -ne 0 ]; then
@@ -156,11 +147,11 @@ ext4_test_nsec_timestamps()
 			unexpected. Before[atime mtime ctime]: $nsec_atime \
 			$nsec_mtime $nsec_ctime, After[atime mtime ctime]: \
 			$nsec_atime2 $nsec_mtime2 $nsec_ctime2)"
-		umount mnt_point
+		tst_umount mnt_point
 		return
 	fi
 
-	umount mnt_point
+	tst_umount mnt_point
 	tst_resm TPASS "Ext4 nanosecond timestamps test with 256 inode size pass"
 }
 
-- 
2.14.1

