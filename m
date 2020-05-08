From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 8 May 2020 14:15:35 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Ensure do zero offset in
 kernel always
Message-ID: <1588918535-4682-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently, we use return instead of zero_offset. I debug this code
(early return, ext4 filesystem)as below:
---------------------------------------
TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
if (TST_RET == 0) {
	tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded unexpectedly");
        SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
}
return;
---------------------------------------
this case will broke when using i parameter,
ioctl_loop05.c:62: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed: EINVAL (22)

It seems the last test affected this test, so I think we should use
goto instead of return. Also including a typo, updata->update.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 6cf701f47..a103aaa94 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -5,7 +5,7 @@
  *
  * This is a basic ioctl test about loopdevice.
  *
- * It is designed to test LOOP_SET_DIRECT_IO can updata a live
+ * It is designed to test LOOP_SET_DIRECT_IO can update a live
  * loop device dio mode. It needs the backing file also supports
  * dio mode and the lo_offset is aligned with the logical block size.
  *
@@ -85,13 +85,14 @@ static void verify_ioctl_loop(void)
 	if (TST_RET == 0) {
 		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
-		return;
+		goto zero_offset;
 	}
 	if (TST_ERR == EINVAL)
 		tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as expected");
 	else
 		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed expected EINVAL got");
 
+zero_offset:
 	loopinfo.lo_offset = 0;
 	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
 }
-- 
2.23.0



