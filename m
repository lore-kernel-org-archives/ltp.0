From: XiaoLi Feng <xifeng@redhat.com>
Date: Mon,  8 Apr 2019 13:40:50 +0800
Subject: [LTP] [PATCH v1] ext4_subdir_limit_test.sh: fix "No Space" issue
Message-ID: <20190408054050.28262-1-xifeng@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Xiaoli Feng <fengxiaoli0714@gmail.com>

1G ext4 filesystem default has 65536 inode. And some inodes
will be used after format. So it will be failed when try to
create 65536 sub-directorys in this ext4 mountpoint. Change
it to create 65536 - used inodes directorys.
---

Re-send this mail again. Because I subscripted the ltp mail list failed last
time.

Thanks.

 .../ext4-subdir-limit/ext4_subdir_limit_test.sh  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
index 5cc0523a8..05581d5c6 100755
--- a/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
+++ b/testcases/kernel/fs/ext4-new-features/ext4-subdir-limit/ext4_subdir_limit_test.sh
@@ -46,6 +46,8 @@ prev_result=$FAIL
 ext4_run_case()
 {
 	local dir_name_len=
+	local free_inode=
+	local max_directorys=$1
 
 	if [ $2 -eq $SHORT_DIR ]; then
 		dir_name_len="short name"
@@ -53,9 +55,6 @@ ext4_run_case()
 		dir_name_len="long name"
 	fi
 
-	tst_resm TINFO "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
-			"Parent dir: $3, Block size: $4"
-
 	# only mkfs if block size has been changed,
 	# or previous case failed
 	if [ $prev_result -ne $PASS -o $4 -ne $prev_block_size ]; then
@@ -80,11 +79,18 @@ ext4_run_case()
 
 	# create directories
 	mkdir -p $3 2> /dev/null
+	free_inode=`df -i $EXT4_DEV | awk '{print $4}' | tr -cd "[0-9]"`
+	if [ "$free_inode" -lt "$1" ]; then
+		max_directorys=$free_inode
+	fi
+
+	tst_resm TINFO "Num of dirs to create: $max_directorys, Dir name len: $dir_name_len, " \
+			"Parent dir: $3, Block size: $4"
 
 	if [ $2 -eq $SHORT_DIR ]; then
-		create_short_dirs $1 $3
+		create_short_dirs $max_directorys $3
 	else
-		create_long_dirs $1 $3
+		create_long_dirs $max_directorys $3
 	fi
 
 	if [ $? -ne 0 ]; then
-- 
2.18.1

