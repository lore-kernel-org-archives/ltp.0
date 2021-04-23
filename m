From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 23 Apr 2021 13:16:12 +0200
Subject: [LTP] [PATCH] mkfs: relax size check
Message-ID: <f224defc029816a74c518c54af2fbf2b90a90da6.1619176445.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Number of total data blocks in filesystem reported by statfs
may be less than current formula of 90%. For example ext4 will
subtract "s_first_data_block plus internal journal blocks".

With recent change to e2fsprogs, overhead calculated in user-space
increased slightly and LTP test started failing:
  https://github.com/tytso/e2fsprogs/commit/59037c5357d39c6d0f14a0aff70e67dc13eafc84

Since there's no strict rule how much the overhead will be,
as rule of thumb relax the condition to 80%.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
I haven't found better way to set the test expectation,
so to address immediate failures I propose to relax the check.

 testcases/commands/mkfs/mkfs01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 13491c9685ae..3e3e56719cf3 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -69,11 +69,11 @@ mkfs_verify_size()
 	# 1k-block size should be devided by this argument for ntfs verification.
 	if [ "$1" = "ntfs" ]; then
 		local rate=1024/512
-		if [ $blocknum -lt "$(($2/$rate*9/10))" ]; then
+		if [ $blocknum -lt "$(($2/$rate*8/10))" ]; then
 			return 1
 		fi
 	else
-		if [ $blocknum -lt "$(($2*9/10))" ]; then
+		if [ $blocknum -lt "$(($2*8/10))" ]; then
 			return 1
 		fi
 	fi
-- 
2.18.1

