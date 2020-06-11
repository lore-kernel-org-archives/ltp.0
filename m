From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Jun 2020 18:35:14 +0800
Subject: [LTP] [PATCH v1 2/4] syscalls/ioctl_loop02: Using LOOP_CONFIGURE to
 set read_only
In-Reply-To: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1591871716-21250-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1591871716-21250-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl"),
it can explicitly request read-only mode by setting LO_FLAGS_READ_ONLY
in loop_config.info.lo_flags regardless of backing file open mode.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop02.c      | 53 +++++++++++++++----
 1 file changed, 44 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index c43172ca1..c497017f5 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -11,6 +11,9 @@
  * For LOOP_CHANGE_FD, this operation is possible only if the loop device
  * is read-only and the new backing store is the same size and type as the
  * old backing store.
+ *
+ * If using LOOP_CONFIGURE ioctl, we can set LO_FLAGS_READ_ONLY
+ * flag even though backing file with write mode.
  */
 
 #include <stdio.h>
@@ -22,15 +25,39 @@
 
 static int file_fd, file_change_fd, file_fd_invalid;
 static char backing_path[1024], backing_file_path[1024], backing_file_change_path[1024];
-static int attach_flag, dev_fd, file_fd;
+static int attach_flag, dev_fd, loop_configure_sup = 1;
 static char loop_ro_path[1024], dev_path[1024];
+static struct loop_config loopconfig;
+
+static struct tcase {
+	int mode;
+	int ioctl;
+	char *message;
+} tcases[] = {
+	{O_RDONLY, LOOP_SET_FD, "Using LOOP_SET_FD to setup loopdevice"},
+	{O_RDWR, LOOP_CONFIGURE, "Using LOOP_CONFIGURE with read_only flag to setup loopdevice"},
+};
 
-static void verify_ioctl_loop(void)
+static void verify_ioctl_loop(unsigned int n)
 {
+	struct tcase *tc = &tcases[n];
 	struct loop_info loopinfoget;
 
+	tst_res(TINFO, "%s", tc->message);
+	file_fd = SAFE_OPEN("test.img", tc->mode);
 	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
-	SAFE_IOCTL(dev_fd, LOOP_SET_FD, file_fd);
+
+	if (tc->ioctl == LOOP_SET_FD) {
+		SAFE_IOCTL(dev_fd, LOOP_SET_FD, file_fd);
+	} else {
+		if (!loop_configure_sup) {
+			tst_res(TCONF,
+				"Current environmet doesn't support LOOP_CONFIGURE ioctl, skip this");
+			return;
+		}
+		loopconfig.fd = file_fd;
+		SAFE_IOCTL(dev_fd, LOOP_CONFIGURE, &loopconfig);
+	}
 	attach_flag = 1;
 
 	TST_ASSERT_INT(loop_ro_path, 1);
@@ -38,11 +65,6 @@ static void verify_ioctl_loop(void)
 
 	memset(&loopinfoget, 0, sizeof(loopinfoget));
 
-	/*
-	 * In drivers/block/loop.c code, set status function doesn't handle
-	 * LO_FLAGS_READ_ONLY flag and ignore it. Only loop_set_fd with readonly
-	 * mode, lo_flags will include LO_FLAGS_READ_ONLY.
-	 */
 	SAFE_IOCTL(dev_fd, LOOP_GET_STATUS, &loopinfoget);
 
 	if (loopinfoget.lo_flags & ~LO_FLAGS_READ_ONLY)
@@ -83,6 +105,7 @@ static void verify_ioctl_loop(void)
 static void setup(void)
 {
 	int dev_num;
+	int ret;
 
 	char *tmpdir = tst_get_tmpdir();
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
@@ -103,6 +126,17 @@ static void setup(void)
 	file_fd = SAFE_OPEN("test.img", O_RDONLY);
 	file_change_fd = SAFE_OPEN("test1.img", O_RDWR);
 	file_fd_invalid = SAFE_OPEN("test2.img", O_RDWR);
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	loopconfig.fd = -1;
+	ret = ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig);
+
+	if (ret && errno != EBADF) {
+		tst_res(TINFO | TERRNO, "LOOP_CONFIGURE is not supported");
+		loop_configure_sup = 0;
+	}
+	loopconfig.info.lo_flags = LO_FLAGS_READ_ONLY;
+	SAFE_CLOSE(dev_fd);
 }
 
 static void cleanup(void)
@@ -122,7 +156,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = verify_ioctl_loop,
+	.tcnt = ARRAY_SIZE(tcases),
+	.test = verify_ioctl_loop,
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.needs_drivers = (const char *const []) {
-- 
2.23.0



