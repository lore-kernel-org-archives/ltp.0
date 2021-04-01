From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  1 Apr 2021 14:47:24 +0200
Subject: [LTP] [PATCH 1/1] df01.sh: Fix DF_FS_TYPE assignment on bind mount
Message-ID: <20210401124724.25394-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In case of bind mount of testing directory, grep will assign filesystem
twice, with new line:

$ echo "DF_FS_TYPE: '$DF_FS_TYPE'"
DF_FS_TYPE: 'ext2
ext2'

Limiting only first line to avoid failure with confusing message:

df01 5 TFAIL: 'df' failed.
df: ext2: No such file or directory

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/df/df01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 0e73a16af..f59676bfa 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -39,7 +39,7 @@ setup()
 {
 	tst_mkfs
 	tst_mount
-	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
+	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk 'NR==1{print $5}')
 }
 
 df_test()
-- 
2.30.2

