From: Eryu Guan <eguan@redhat.com>
Date: Sat, 31 Oct 2015 14:43:20 +0800
Subject: [LTP] [PATCH 2/2] test_robind.sh: add xfs and btrfs support
In-Reply-To: <1446273800-2494-1-git-send-email-eguan@redhat.com>
References: <1446273800-2494-1-git-send-email-eguan@redhat.com>
Message-ID: <1446273800-2494-2-git-send-email-eguan@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add btrfs support and fix opts for xfs, which needs "-f" too.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 testcases/kernel/fs/fs_readonly/test_robind.sh | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/fs/fs_readonly/test_robind.sh b/testcases/kernel/fs/fs_readonly/test_robind.sh
index 5674ca4..371d5fa 100755
--- a/testcases/kernel/fs/fs_readonly/test_robind.sh
+++ b/testcases/kernel/fs/fs_readonly/test_robind.sh
@@ -197,10 +197,17 @@ for fstype in $FSTYPES; do
 	opts="-F"
 	if [ "$fstype" = "reiserfs" ]; then
 		opts="-f --journal-size 513 -q"
-	elif [ "$fstype" = "jfs" ]; then
+	elif [ "$fstype" = "jfs" -o "$fstype" = "xfs" ]; then
 		opts="-f"
-	elif [ "$fstype" = "xfs" ]; then
-		opts=""
+	elif [ "$fstype" = "btrfs" ]; then
+		# check if mkfs.btrfs supports -f option
+		# detect "-f --force" or "-f|--force" because btrfs-progs
+		# changes usage text in commit 3f312d500b73
+		if mkfs.btrfs 2>&1 | grep -q '\-f[ |]'; then
+			opts="-f"
+		else
+			opts=""
+		fi
 	fi
 
 	if [ "$fstype" != "ramfs" ]; then
-- 
2.4.3

