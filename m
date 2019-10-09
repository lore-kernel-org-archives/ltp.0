From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  9 Oct 2019 08:21:12 +0200
Subject: [LTP] [PATCH] ext4-new-features: Fix paths to ffsb-config files
Message-ID: <20191009062112.49947-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

The path to the ffsb-config files was just plain wrong (they are copied to
$LTPROOT/testcases/data/ext4-ffsb, but searched in cwd.
This is the same fix as in 4ae5699d, only for other tests.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 .../ext4-journal-checksum/ext4_journal_checksum.sh            | 2 +-
 .../ext4-uninit-groups/ext4_uninit_groups_test.sh             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
index 9edb89397..822c94a8c 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-journal-checksum/ext4_journal_checksum.sh
@@ -69,7 +69,7 @@ ext4_test_journal_checksum()
 		return
 	fi
 
-	ffsb ffsb-config2 > /dev/null
+	ffsb $LTPROOT/testcases/data/ext4-ffsb/ffsb-config2 > /dev/null
 	if [ $? -ne 0 ]; then
 		tst_resm TFAIL "ffsb returned failure"
 		umount mnt_point
diff --git a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
index d39afae56..cf4c354d9 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-uninit-groups/ext4_uninit_groups_test.sh
@@ -34,13 +34,13 @@ age_filesystem()
 {
 	if [ $1 -eq $EMPTY ]; then
 		# aging, then del
-		ffsb ffsb-config3 > /dev/null
+		ffsb $LTPROOT/testcases/data/ext4-ffsb/ffsb-config3 > /dev/null
 		rm -rf mnt_point/*
 	elif [ $1 -eq $SMALL ]; then
 		# age filesystem from 0.0 to 0.2 -> 0.4 -> 0.6 -> 0.8 -> 1.0
 		for ((n = 3; n < 8; n++))
 		{
-			ffsb ffsb-config$n > /dev/null
+			ffsb $LTPROOT/testcases/data/ext4-ffsb/ffsb-config$n > /dev/null
 			mv mnt_point/data mnt_point/data$n
 		}
 	elif [ $1 -eq $LARGE ]; then
-- 
2.20.1

