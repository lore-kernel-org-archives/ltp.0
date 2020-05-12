From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 12 May 2020 13:11:10 +0800
Subject: [LTP] [PATCH v2] syscalls/ioctl_loop05: Ensure do zero offset when
 using -i parameter
Message-ID: <1589260270-3636-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
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
this case will be broke when using i parameter,
ioctl_loop05.c:62: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed: EINVAL (22)

It seems the last test affected this test, so I move zero status to the
beginning of the test to avoid unknown error.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index 6cf701f47..c9138be95 100644
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
@@ -57,6 +57,11 @@ static void verify_ioctl_loop(void)
 	struct loop_info loopinfo;
 
 	memset(&loopinfo, 0, sizeof(loopinfo));
+	/*
+	 * Setting loopdevice with zero loop_info struct, so we can avoid unknown
+	 * error when using -i parameter.
+	 */
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
 
 	tst_res(TINFO, "Without setting lo_offset or sizelimit");
 	SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 1);
@@ -91,9 +96,6 @@ static void verify_ioctl_loop(void)
 		tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as expected");
 	else
 		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed expected EINVAL got");
-
-	loopinfo.lo_offset = 0;
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
 }
 
 static void setup(void)
-- 
2.23.0



