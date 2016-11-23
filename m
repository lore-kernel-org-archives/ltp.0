From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 23 Nov 2016 12:00:50 +0000
Subject: [LTP]  [PATCH] fs_racer: cleanup
Message-ID: <1479902450-53501-1-git-send-email-cuibixuan@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Remove the DIR at the end of test

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/fs/racer/fs_racer.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/racer/fs_racer.sh b/testcases/kernel/fs/racer/fs_racer.sh
index 5c4dc69..e7d5e4b 100755
--- a/testcases/kernel/fs/racer/fs_racer.sh
+++ b/testcases/kernel/fs/racer/fs_racer.sh
@@ -86,6 +86,7 @@ call_exit()
     killall fs_racer_file_symlink.sh
     killall fs_racer_file_list.sh
     killall fs_racer_file_concat.sh
+    rm -rf $DIR >/dev/null
     exit 0
 }
 
-- 
1.8.3.4

