From: Li Wang <liwang@redhat.com>
Date: Wed,  9 Sep 2020 07:53:47 +0000
Subject: [LTP] [PATCH] ioctl: take use of TST_RETRY_FN* macro
Message-ID: <20200909075347.2863-1-liwang@redhat.com>
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
 testcases/kernel/syscalls/ioctl/ioctl09.c      | 8 +++++---
 testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl09.c b/testcases/kernel/syscalls/ioctl/ioctl09.c
index 151618df4..9e220809d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl09.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl09.c
@@ -30,13 +30,15 @@ static void change_partition(const char *const cmd[])
 
 static void check_partition(int part_num, bool value)
 {
-	int ret;
+	int ret, time_delay;
 
 	sprintf(sys_loop_partpath, "/sys/block/loop%d/loop%dp%d",
 		dev_num, dev_num, part_num);
 	sprintf(loop_partpath, "%sp%d", dev_path, part_num);
 
-	ret = access(sys_loop_partpath, F_OK);
+	value ? (time_delay = 30) : (time_delay = 1);
+
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(sys_loop_partpath, F_OK), TST_RETVAL_EQ0, time_delay);
 	if (ret == 0)
 		tst_res(value ? TPASS : TFAIL, "access %s succeeds",
 			sys_loop_partpath);
@@ -44,7 +46,7 @@ static void check_partition(int part_num, bool value)
 		tst_res(value ? TFAIL : TPASS, "access %s fails",
 			sys_loop_partpath);
 
-	ret = access(loop_partpath, F_OK);
+	ret = TST_RETRY_FN_EXP_BACKOFF(access(loop_partpath, F_OK), TST_RETVAL_EQ0, time_delay);
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

