From: Song Jian <songjian15@huawei.com>
Date: Mon, 22 Jul 2019 10:29:01 +0800
Subject: [LTP] [PATCH]syscalls/ioctl: bugfix for syscalls/ioctl/ioctl_ns05.c
 syscalls/ioctl/ioctl_ns06.c
Message-ID: <1563762541-89314-1-git-send-email-songjian15@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

fix ioctl_ns05, ioctl_ns06 timeout.
signal() will return 0 if success, so it have no chance to equal
nr_wake=1, use another api to to repalce the current api to ensure that
nr_wark = 0.

Signed-off-by: Song Jian <songjian15@huawei.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_ns05.c | 2 +-
 testcases/kernel/syscalls/ioctl/ioctl_ns06.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
index a8dee07..8162012 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns05.c
@@ -80,7 +80,7 @@ static void run(void)
 	SAFE_CLOSE(my_fd);
 	SAFE_CLOSE(child_fd);
 	SAFE_CLOSE(parent_fd);
-	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAKE2(0, 0);
 }
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
index 805a0a0..d5010d0 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_ns06.c
@@ -75,7 +75,7 @@ static void run(void)
 	SAFE_CLOSE(my_fd);
 	SAFE_CLOSE(parent_fd);
 	SAFE_CLOSE(child_fd);
-	TST_CHECKPOINT_WAKE(0);
+	TST_CHECKPOINT_WAKE2(0, 0);
 }
 static struct tst_test test = {
2.6.2

