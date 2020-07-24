From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 24 Jul 2020 10:05:57 +0800
Subject: [LTP] [PATCH v3 2/2] syscalls/ioctl_loop05: Using LOOP_CONFIGURE to
 set direct io
In-Reply-To: <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20200722125946.GA22573@yuki.lan>
 <1595556357-29932-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <1595556357-29932-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since kernel commit 3448914e8cc5("loop: Add LOOP_CONFIGURE ioctl"),
it can explicitly request direct I/O mode by setting LO_FLAGS_DIRECT_IO
in loop_config.info.lo_flags.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
v2->v3:
1.Use tst_detach_device_by_fd api
 .../kernel/syscalls/ioctl/ioctl_loop05.c      | 151 +++++++++++++-----
 1 file changed, 114 insertions(+), 37 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index e3c14faab..7491e62fa 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -19,6 +19,9 @@
  * enabled but falls back to buffered I/O later on. This is the case at least
  * for Btrfs. Because of that the test passes both with failure as well as
  * success with non-zero offset.
+ *
+ * Also use LOOP_CONFIGURE to test this by setting LO_FLAGS_DIRECT_IO
+ * in loop_config.info.lo_flags.
  */
 
 #include <stdio.h>
@@ -32,8 +35,36 @@
 #define DIO_MESSAGE "In dio mode"
 #define NON_DIO_MESSAGE "In non dio mode"
 
-static char dev_path[1024], sys_loop_diopath[1024], backing_file_path[1024];;
+static char dev_path[1024], sys_loop_diopath[1024], backing_file_path[1024];
 static int dev_num, dev_fd, block_devfd, attach_flag, logical_block_size;
+static int file_fd, loop_configure_sup = 1;
+static struct loop_config loopconfig;
+static struct loop_info loopinfo;
+
+static struct tcase {
+	int multi; /*logical_block_size / 2 as unit */
+	int dio_value;
+	int ioctl_flag;
+	char *message;
+} tcases[] = {
+	{0, 1, LOOP_SET_DIRECT_IO,
+	"Using LOOP_SET_DIRET_IO without setting lo_offset or sizelimit"},
+
+	{2, 1, LOOP_SET_DIRECT_IO,
+	"Using LOOP_SET_DIRECT_IO With offset equal to logical_block_size"},
+
+	{1, 0, LOOP_SET_DIRECT_IO,
+	"Using LOOP_SET_DIRECT_IO with offset less than logical_block_size"},
+
+	{0, 1, LOOP_CONFIGURE,
+	"Using LOOP_CONFIGURE without setting lo_offset or sizelimit"},
+
+	{2, 1, LOOP_CONFIGURE,
+	"Using LOOP_CONFIGURE With offset equal to logical_block_size"},
+
+	{1, 0, LOOP_CONFIGURE,
+	"Using LOOP_CONFIGURE witg offset less than logical_block_size"},
+};
 
 static void check_dio_value(int flag)
 {
@@ -42,61 +73,91 @@ static void check_dio_value(int flag)
 	memset(&loopinfoget, 0, sizeof(loopinfoget));
 
 	SAFE_IOCTL(dev_fd, LOOP_GET_STATUS, &loopinfoget);
-	tst_res(TINFO, "%s", flag ? DIO_MESSAGE : NON_DIO_MESSAGE);
 
 	if (loopinfoget.lo_flags & LO_FLAGS_DIRECT_IO)
-		tst_res(flag ? TPASS : TFAIL, "lo_flags has LO_FLAGS_DIRECT_IO flag");
+		tst_res(flag ? TPASS : TFAIL,
+			"%s, lo_flags has LO_FLAGS_DIRECT_IO flag",
+			flag ? DIO_MESSAGE : NON_DIO_MESSAGE);
 	else
-		tst_res(flag ? TFAIL : TPASS, "lo_flags doesn't have LO_FLAGS_DIRECT_IO flag");
+		tst_res(flag ? TFAIL : TPASS,
+			"%s, lo_flags doesn't have LO_FLAGS_DIRECT_IO flag",
+			flag ? DIO_MESSAGE : NON_DIO_MESSAGE);
 
 	TST_ASSERT_INT(sys_loop_diopath, flag);
 }
 
-static void verify_ioctl_loop(void)
+static void verify_ioctl_loop(unsigned int n)
 {
-	struct loop_info loopinfo;
-
-	memset(&loopinfo, 0, sizeof(loopinfo));
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+	if (tcases[n].ioctl_flag == LOOP_SET_DIRECT_IO) {
+		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
+
+		TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
+		if (TST_RET == 0) {
+			if (tcases[n].dio_value)
+				tst_res(TPASS, "set direct io succeeded");
+			else
+				tst_res(TPASS, "set direct io succeeded, offset is ignored");
+			check_dio_value(1);
+			SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
+			return;
+		}
+		if (TST_ERR == EINVAL && !tcases[n].dio_value)
+			tst_res(TPASS | TTERRNO,
+				"set direct io failed as expected");
+		else
+			tst_res(TFAIL | TTERRNO, "set direct io failed");
+		return;
+	}
+	/*
+	 * When we call loop_configure ioctl successfully and detach it,
+	 * the subquent loop_configure without non-zero lo_offset or
+	 * sizelimit may trigger the blk_update_request I/O error.
+	 * To avoid this, sleep 1s to ensure last blk_update_request has
+	 * completed.
+	 */
+	sleep(1);
+	/*
+	 * loop_cofigure calls loop_update_dio() function, it will ignore
+	 * the result of setting dio. It is different from loop_set_dio.
+	 */
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig), TST_RETVAL_EQ0);
+	check_dio_value(tcases[n].dio_value);
+	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_CLR_FD, 0), TST_RETVAL_EQ0);
+}
 
-	tst_res(TINFO, "Without setting lo_offset or sizelimit");
-	SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 1);
-	check_dio_value(1);
+static void run(unsigned int n)
+{
+	struct tcase *tc = &tcases[n];
 
-	SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
-	check_dio_value(0);
+	tst_res(TINFO, "%s", tc->message);
 
-	tst_res(TINFO, "With offset equal to logical_block_size");
-	loopinfo.lo_offset = logical_block_size;
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
-	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
-	if (TST_RET == 0) {
-		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded");
-		check_dio_value(1);
+	if (tc->ioctl_flag == LOOP_SET_DIRECT_IO) {
+		if (!attach_flag) {
+			tst_attach_device(dev_path, "test.img");
+			attach_flag = 1;
+		}
 		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
-	} else {
-		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed");
+		check_dio_value(0);
+		loopinfo.lo_offset = logical_block_size * tc->multi / 2;
+		verify_ioctl_loop(n);
+		return;
 	}
-
-	tst_res(TINFO, "With nonzero offset less than logical_block_size");
-	loopinfo.lo_offset = logical_block_size / 2;
-	TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), TST_RETVAL_EQ0);
-
-	TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
-	if (TST_RET == 0) {
-		tst_res(TPASS, "LOOP_SET_DIRECT_IO succeeded, offset is ignored");
-		SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
+	if (tc->ioctl_flag == LOOP_CONFIGURE && !loop_configure_sup) {
+		tst_res(TCONF, "LOOP_CONFIGURE ioctl not supported");
 		return;
 	}
-	if (TST_ERR == EINVAL)
-		tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as expected");
-	else
-		tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed expected EINVAL got");
+	if (attach_flag) {
+		tst_detach_device_by_fd(dev_path, dev_fd);
+		attach_flag = 0;
+	}
+	loopconfig.info.lo_offset = logical_block_size * tc->multi / 2;
+	verify_ioctl_loop(n);
 }
 
 static void setup(void)
 {
 	char bd_path[100];
+	int ret;
 
 	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
 		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
@@ -128,8 +189,21 @@ static void setup(void)
 	SAFE_IOCTL(block_devfd, BLKSSZGET, &logical_block_size);
 	tst_res(TINFO, "backing dev(%s) logical_block_size is %d", bd_path, logical_block_size);
 	SAFE_CLOSE(block_devfd);
+
 	if (logical_block_size > 512)
 		TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_BLOCK_SIZE, logical_block_size), TST_RETVAL_EQ0);
+
+	file_fd = SAFE_OPEN("test.img", O_RDWR);
+	loopconfig.fd = -1;
+	ret = ioctl(dev_fd, LOOP_CONFIGURE, &loopconfig);
+	if (ret && errno != EBADF) {
+		tst_res(TINFO | TERRNO, "LOOP_CONFIGURE is not supported");
+		loop_configure_sup = 0;
+		return;
+	}
+	loopconfig.block_size = logical_block_size;
+	loopconfig.fd = file_fd;
+	loopconfig.info.lo_flags = LO_FLAGS_DIRECT_IO;
 }
 
 static void cleanup(void)
@@ -138,6 +212,8 @@ static void cleanup(void)
 		SAFE_CLOSE(dev_fd);
 	if (block_devfd > 0)
 		SAFE_CLOSE(block_devfd);
+	if (file_fd > 0)
+		SAFE_CLOSE(file_fd);
 	if (attach_flag)
 		tst_detach_device(dev_path);
 }
@@ -145,7 +221,8 @@ static void cleanup(void)
 static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
-	.test_all = verify_ioctl_loop,
+	.test = run,
+	.tcnt = ARRAY_SIZE(tcases),
 	.needs_root = 1,
 	.needs_tmpdir = 1,
 	.needs_drivers = (const char *const []) {
-- 
2.23.0



