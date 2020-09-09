From: Li Wang <liwang@redhat.com>
Date: Wed,  9 Sep 2020 12:57:53 +0000
Subject: [LTP] [Patch v2] ioctl: take use of TST_RETRY_FN* macro
Message-ID: <20200909125753.7724-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To avoid of race with udev, let's use TST_RETRY_FN* macro to loop
access() function for more times.

---Errors---
ioctl_loop01.c:59: PASS: /sys/block/loop0/loop/partscan = 1
ioctl_loop01.c:60: PASS: /sys/block/loop0/loop/autoclear = 0
ioctl_loop01.c:71: FAIL: access /dev/loop0p1 fails
ioctl_loop01.c:77: FAIL: access /sys/block/loop0/loop0p1 fails

ioctl09.c:41: PASS: access /sys/block/loop0/loop0p1 succeeds
ioctl09.c:52: FAIL: access /dev/loop0p1 fails

Fixes: #718
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ioctl/ioctl09.c      | 7 +++++--
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 151618df4..9728ecb9c 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -15,6 +15,9 @@
 #include "lapi/loop.h"
 #include "tst_test.h"
 
+#define RETVAL_CHECK(x) \
+       ({ value ? TST_RETVAL_EQ0(x) : TST_RETVAL_NOTNULL(x); })
+
 static char dev_path[1024];
 static int dev_num, attach_flag, dev_fd;
 static char loop_partpath[1026], sys_loop_partpath[1026];
@@ -36,7 +39,7 @@ static void check_partition(int part_num, bool value)
 		dev_num, dev_num, part_num);
 	sprintf(loop_partpath, "%sp%d", dev_path, part_num);
 
-	ret = access(sys_loop_partpath, F_OK);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK), RETVAL_CHECK, 30);
 	if (ret == 0)
 		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
 			sys_loop_partpath);
@@ -44,7 +47,7 @@ static void check_partition(int part_num, bool value)
 		tst_res(value ? TFAIL : TPASS, "access %s fails",
 			sys_loop_partpath);
 
-	ret = access(loop_partpath, F_OK);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(loop_partpath, F_OK), RETVAL_CHECK, 30);
 	if (ret == 0)
 		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
 			loop_partpath);
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
index 845a1399b..cf71184b4 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -64,13 +64,13 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
 		return;
 	}
 
-	ret = access(loop_partpath, F_OK);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(loop_partpath, F_OK), TST_RETVAL_EQ0, 30);
 	if (ret == 0)
 		tst_res(TPASS, "access %s succeeds", loop_partpath);
 	else
 		tst_res(TFAIL, "access %s fails", loop_partpath);
 
-	ret = access(sys_loop_partpath, F_OK);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK), TST_RETVAL_EQ0, 30);
 	if (ret == 0)
 		tst_res(TPASS, "access %s succeeds", sys_loop_partpath);
 	else
-- 
2.21.1

