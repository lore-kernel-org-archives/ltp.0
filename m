From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Apr 2021 15:53:51 +0800
Subject: [LTP] [PATCH] mkfs: print more info for debugging
Message-ID: <20210420075351.16059-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We can NOT reproduce the problem by manual with both ppc64le and s390x,
so let's print more useful info from test when getting fail.

 mkfs01 1 TPASS: 'mkfs -t ext4  /dev/loop0 ' passed.
 mkfs01 2 TFAIL: 'mkfs -t ext4  /dev/loop0 16000' failed, not expected.
 mkfs01 3 TPASS: 'mkfs -t ext4 -c /dev/loop0 ' passed.
 mkfs01 4 TPASS: 'mkfs -V   ' passed.
 mkfs01 5 TPASS: 'mkfs -h   ' passed.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/commands/mkfs/mkfs01.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 90368190d..55296c8df 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -128,7 +128,8 @@ mkfs_test()
 	if [ -n "$device" ]; then
 		mkfs_verify_type "$fs_type" "$device"
 		if [ $? -ne 0 ]; then
-			tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
+			tst_res TFAIL "'${mkfs_cmd}' failed, not expected type."
+			cat temp
 			return
 		fi
 	fi
@@ -136,7 +137,8 @@ mkfs_test()
 	if [ -n "$size" ]; then
 		mkfs_verify_size "$fs_type" "$size"
 		if [ $? -ne 0 ]; then
-			tst_res TFAIL "'${mkfs_cmd}' failed, not expected."
+			tst_res TFAIL "'${mkfs_cmd}' failed, not expected size."
+			cat temp
 			return
 		fi
 	fi
-- 
2.30.2

