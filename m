From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 5 Jun 2020 18:41:21 +0800
Subject: [LTP] [PATCH v2] syscalls/ioctl_loop01: Add test for clear loop flag
Message-ID: <1591353681-1079-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

After seeing loop driver kernel code, I found LO_FLAGS_PARTSCAN can
not be clear and LO_FLAGS_AUTOCLEAR can be clear. Test this.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v1->v2:
1.also check partpath whether existed when clear flag
2. check_loop_flag -> check_loog_value
 .../kernel/syscalls/ioctl/ioctl_loop01.c      | 47 +++++++++++--------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index 2d9733f95..e11807df2 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -13,6 +13,9 @@
  * But we also check whether we can scan partition table correctly ie check
  * whether /dev/loopnp1 and /sys/bloclk/loop0/loop0p1 existed.
  *
+ * For LO_FLAGS_AUTOCLEAR flag, it can be clear. For LO_FLAGS_PARTSCAN flag,
+ * it cannot be clear. We also check this.
+ *
  * It is also a regression test for kernel
  * commit 10c70d95c0f2 ("block: remove the bd_openers checks in blk_drop_partitions").
  */
@@ -38,38 +41,26 @@ static int dev_num, attach_flag, dev_fd, parted_sup;
 static char partscan_path[1024], autoclear_path[1024];
 static char loop_partpath[1026], sys_loop_partpath[1026];
 
-static void verify_ioctl_loop(void)
+static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 {
+	struct loop_info loopinfo = {0}, loopinfoget = {0};
 	int ret;
-	struct loop_info loopinfo, loopinfoget;
 
-	tst_attach_device(dev_path, "test.img");
-	attach_flag = 1;
-
-	TST_ASSERT_INT(partscan_path, 0);
-	TST_ASSERT_INT(autoclear_path, 0);
-	TST_ASSERT_STR(backing_path, backing_file_path);
-
-	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
-	memset(&loopinfo, 0, sizeof(loopinfo));
-	memset(&loopinfoget, 0, sizeof(loopinfoget));
-
-	loopinfo.lo_flags = SET_FLAGS;
+	loopinfo.lo_flags = set_flag;
 	SAFE_IOCTL(dev_fd, LOOP_SET_STATUS, &loopinfo);
-
 	SAFE_IOCTL(dev_fd, LOOP_GET_STATUS, &loopinfoget);
 
-	if (loopinfoget.lo_flags & ~GET_FLAGS)
-		tst_res(TFAIL, "expect %d but got %d", GET_FLAGS, loopinfoget.lo_flags);
+	if (loopinfoget.lo_flags & ~get_flag)
+		tst_res(TFAIL, "expect %d but got %d", get_flag, loopinfoget.lo_flags);
 	else
 		tst_res(TPASS, "get expected lo_flag %d", loopinfoget.lo_flags);
 
 	TST_ASSERT_INT(partscan_path, 1);
-	TST_ASSERT_INT(autoclear_path, 1);
+	TST_ASSERT_INT(autoclear_path, autoclear_field);
 
 	if (!parted_sup) {
 		tst_res(TINFO, "Current environment doesn't have parted disk, skip it");
-		goto detach_device;
+		return;
 	}
 
 	ret = access(loop_partpath, F_OK);
@@ -83,8 +74,24 @@ static void verify_ioctl_loop(void)
 		tst_res(TPASS, "access %s succeeds", sys_loop_partpath);
 	else
 		tst_res(TFAIL, "access %s fails", sys_loop_partpath);
+}
+
+static void verify_ioctl_loop(void)
+{
+	tst_attach_device(dev_path, "test.img");
+	attach_flag = 1;
+
+	TST_ASSERT_INT(partscan_path, 0);
+	TST_ASSERT_INT(autoclear_path, 0);
+	TST_ASSERT_STR(backing_path, backing_file_path);
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+
+	check_loop_value(SET_FLAGS, GET_FLAGS, 1);
+
+	tst_res(TINFO, "Test flag can be clear");
+	check_loop_value(0, LO_FLAGS_PARTSCAN, 0);
 
-detach_device:
 	SAFE_CLOSE(dev_fd);
 	tst_detach_device(dev_path);
 	attach_flag = 0;
-- 
2.23.0



