From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 26 Aug 2020 12:12:06 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop07: Using LOOP_CONFIGURE to test
 lo_sizelimit field
Message-ID: <1598415126-9703-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl"),
it can set the lo_sizelimit by specifying loop_config.info.lo_sizelimit
value. It is also regression test for
https://patchwork.kernel.org/patch/11735047/

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop07.c      | 86 ++++++++++++++++---
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
index ce4b47690..44f4a5423 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop07.c
@@ -8,6 +8,10 @@
  * Test its lo_sizelimit field. If lo_sizelimit is 0,it means max
  * available. If sizelimit is less than loop_size, loopsize will
  * be truncated.
+ *
+ * We also use LOOP_CONFIGURE ioctl to test lo_sizelimit field. It is
+ * also a regression test for
+ * https://patchwork.kernel.org/patch/11735047/
  */
 
 #include <stdio.h>
@@ -18,15 +22,26 @@
 #include "tst_test.h"
 
 static char dev_path[1024], sys_loop_sizepath[1024], sys_loop_sizelimitpath[1024];
-static int dev_num, dev_fd, file_fd, attach_flag;
+static int dev_num, dev_fd, file_fd, attach_flag, loop_configure_sup = 1;
+static struct loop_config loopconfig;
 
 static struct tcase {
 	unsigned int set_sizelimit;
 	unsigned int exp_loopsize;
+	int ioctl_flag;
 	char *message;
 } tcases[] = {
-	{1024 * 4096, 2048, "When sizelimit is greater than loopsize "},
-	{1024 * 512, 1024, "When sizelimit is less than loopsize"},
+	{1024 * 4096, 2048, LOOP_SET_STATUS64,
+	"When sizelimit is greater than loopsize by using LOOP_SET_STATUS64"},
+
+	{1024 * 512, 1024, LOOP_SET_STATUS64,
+	"When sizelimit is less than loopsize by using LOOP_SET_STATUS64"},
+
+	{1024 * 4096, 2048, LOOP_CONFIGURE,
+	"When sizelimit is greater than loopsize by using LOOP_CONFIGURE"},
+
+	{1024 * 512, 1024, LOOP_CONFIGURE,
+	"When sizelimit is less than loopsize by using LOOP_CONFIGURE"},
 };
 
 static void verify_ioctl_loop(unsigned int n)
@@ -34,12 +49,15 @@ static void verify_ioctl_loop(unsigned int n)
 	struct tcase *tc = &tcases[n];
 	struct loop_info64 loopinfo, loopinfoget;
 
-	tst_res(TINFO, "%s", tc->message);
 	memset(&loopinfo, 0, sizeof(loopinfo));
 	memset(&loopinfoget, 0, sizeof(loopinfoget));
 
-	loopinfo.lo_sizelimit = tc->set_sizelimit;
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS64, &loopinfo), TST_RETVAL_EQ0);
+	if (tc->ioctl_flag == LOOP_CONFIGURE) {
+		SAFE_IOCTL(dev_fd, LOOP_CONFIGURE, &loopconfig);
+	} else {
+		loopinfo.lo_sizelimit = tc->set_sizelimit;
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS64, &loopinfo), TST_RETVAL_EQ0);
+	}
 
 	TST_ASSERT_INT(sys_loop_sizepath, tc->exp_loopsize);
 	TST_ASSERT_INT(sys_loop_sizelimitpath, tc->set_sizelimit);
@@ -50,12 +68,46 @@ static void verify_ioctl_loop(unsigned int n)
 		tst_res(TFAIL, "LOOP_GET_STATUS64 gets wrong lo_sizelimit(%llu), expect %d",
 				loopinfoget.lo_sizelimit, tc->set_sizelimit);
 	/*Reset*/
-	loopinfo.lo_sizelimit = 0;
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+	if (tc->ioctl_flag == LOOP_CONFIGURE) {
+			tst_detach_device_by_fd(dev_path, dev_fd);
+	} else {
+		loopinfo.lo_sizelimit = 0;
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+	}
+}
+
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
+
+	tst_res(TINFO, "%s", tc->message);
+
+	if (tc->ioctl_flag == LOOP_SET_STATUS64) {
+		if (!attach_flag) {
+			tst_attach_device(dev_path, "test.img");
+			attach_flag = 1;
+		}
+
+		verify_ioctl_loop(n);
+		return;
+	}
+
+	if (tc->ioctl_flag == LOOP_CONFIGURE && !loop_configure_sup) {
+		tst_res(TCONF, "LOOP_CONFIGURE ioctl not supported");
+		return;
+	}
+	if (attach_flag) {
+		tst_detach_device_by_fd(dev_path, dev_fd);
+		attach_flag = 0;
+	}
+	loopconfig.info.lo_sizelimit = tc->set_sizelimit;
+	verify_ioctl_loop(n);
 }
 
 static void setup(void)
 {
+	int ret;
+
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
@@ -67,8 +119,22 @@ static void setup(void)
 	sprintf(sys_loop_sizepath, "/sys/block/loop%d/size", dev_num);
 	sprintf(sys_loop_sizelimitpath, "/sys/block/loop%d/loop/sizelimit", dev_num);
 
-	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	tst_detach_device(dev_path);
+	attach_flag = 0;
+
 	tst_res(TINFO, "original loop size 2048 sectors");
+	file_fd = SAFE_OPEN("test.img", O_RDWR);
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+
+	loopconfig.fd = -1;
+	ret = ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig);
+	if (ret && errno != EBADF) {
+		tst_res(TINFO | TERRNO, "LOOP_CONFIGURE is not supported");
+		loop_configure_sup = 0;
+		return;
+	}
+
+	loopconfig.fd = file_fd;
 }
 
 static void cleanup(void)
@@ -84,7 +150,7 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.test = verify_ioctl_loop,
+	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
-- 
2.23.0



