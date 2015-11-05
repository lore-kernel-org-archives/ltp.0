From: Eryu Guan <eguan@redhat.com>
Date: Thu,  5 Nov 2015 22:35:01 +0800
Subject: [LTP] [PATCH 3/3] test_robind: use tst_mkfs helper to mkfs
In-Reply-To: <1446734101-6175-1-git-send-email-eguan@redhat.com>
References: <1446734101-6175-1-git-send-email-eguan@redhat.com>
Message-ID: <1446734101-6175-3-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

So xfs and btrfs are handled correctly.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/fs/fs_readonly/test_robind.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
index 5674ca4..dfe6f7e 100755
--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
@@ -194,17 +194,14 @@ setup $*
 
 # Executes the tests for differnt FS's
 for fstype in $FSTYPES; do
-	opts="-F"
 	if [ "$fstype" = "reiserfs" ]; then
 		opts="-f --journal-size 513 -q"
-	elif [ "$fstype" = "jfs" ]; then
-		opts="-f"
-	elif [ "$fstype" = "xfs" ]; then
-		opts=""
+	elif echo "$fstype" | grep -q "ext"; then
+		opts="-F"
 	fi
 
 	if [ "$fstype" != "ramfs" ]; then
-		mkfs.$fstype $opts $device > /dev/null
+		tst_mkfs $fstype $device $opts
 	fi
 
 	mount -t $fstype $device  dir1
-- 
2.5.0

