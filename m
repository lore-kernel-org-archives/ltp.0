From: Boyang Xue <bxue@redhat.com>
Date: Tue, 24 May 2016 15:49:36 +0800
Subject: [LTP] [PATCH v1 1/1] test_robind: add "-f" mkfs option for xfs and
	btrfs
Message-ID: <20160524074936.11253-1-bxue@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add "-f" mkfs option for xfs and btrfs to aid the failure in creating
filesystem due to commit a7f854472ebc ("tst_mkfs: drop -f from mkfs").

Signed-off-by: Boyang Xue <bxue@redhat.com>
---
 testcases/kernel/fs/fs_readonly/test_robind.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
index dfe6f7e..181ae9e 100755
--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
@@ -198,6 +198,10 @@ for fstype in $FSTYPES; do
 		opts="-f --journal-size 513 -q"
 	elif echo "$fstype" | grep -q "ext"; then
 		opts="-F"
+	elif [ "$fstype" = "xfs" ]; then
+		opts="-f"
+	elif [ "$fstype" = "btrfs" ]; then
+		opts="-f"
 	fi
 
 	if [ "$fstype" != "ramfs" ]; then
-- 
2.8.3

