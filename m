From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Sat, 20 Feb 2016 16:34:11 +0300
Subject: [LTP] [PATCH 2/2] mkfs01.sh: use df -P
In-Reply-To: <1455975251-30056-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1455975251-30056-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1455975251-30056-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the same reason as it was in
commit deab0acd12a6 ("df01: use the POSIX output format").

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/commands/mkfs/mkfs01.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 6edecd7..eda9829 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -90,7 +90,7 @@ mkfs_verify_type()
 mkfs_verify_size()
 {
 	mkfs_mount
-	local blocknum=`df -B 1k mntpoint | tail -n1 | awk '{print $2}'`
+	local blocknum=`df -P -B 1k mntpoint | tail -n1 | awk '{print $2}'`
 	tst_umount "$TST_DEVICE"
 
 	if [ $blocknum -gt "$2" ]; then
-- 
1.7.1

