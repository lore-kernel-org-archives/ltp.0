From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 29 Apr 2020 16:14:11 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Do not fail on success
Message-ID: <20200429141411.9051-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The code in __loop_update_dio() uses inode->i_sb->s_bdev to get the
logical block size for the backing file for the loop device. If that
pointer is NULL, which happens to be the case for Btrfs, the checks for
alignment and block size are ignored and direct I/O can be turned on
regardless of the offset and logical block size.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
CC: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 3a028ba2c..d26fa61bf 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -71,7 +71,7 @@ static void verify_ioctl_loop(void)
 
 	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
 	if (TST_RET == 0) {
-		tst_res(TFAIL, "LOOP_SET_DIRECT_IO succeeded unexpectedly");
+		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
 		return;
 	}
-- 
2.24.1

