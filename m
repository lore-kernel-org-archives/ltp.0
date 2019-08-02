From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 2 Aug 2019 10:26:53 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: correct wrong loop_devn
 judgment
Message-ID: <1564712813-2291-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We should open dev_path when loop_devn is not equal to -1.
Since Amir has pointed this obvious error on v6, I forgot it.
Sorry for everyone.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: Amir Goldstein <amir73il@gmail.com>
---
 testcases/kernel/syscalls/copy_file_range/copy_file_range02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index 36976156e..26bfa008a 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -180,7 +180,7 @@ static void setup(void)
 	fd_immutable = SAFE_OPEN(FILE_IMMUTABLE_PATH, O_RDWR | O_CREAT, 0664);
 	fd_swapfile = SAFE_OPEN(FILE_SWAP_PATH, O_RDWR | O_CREAT, 0600);
 
-	if (loop_devn == -1)
+	if (loop_devn != -1)
 		fd_blkdev = SAFE_OPEN(dev_path, O_RDWR, 0600);
 
 	fd_chrdev = SAFE_OPEN(FILE_CHRDEV, O_RDWR, 0600);
-- 
2.18.1



