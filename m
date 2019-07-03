From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  3 Jul 2019 17:47:09 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ioctl08: Require btrfs
Message-ID: <20190703154709.20863-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test requires btrfs otherwise it fails:
WARNING: failed to open /dev/btrfs-control, skipping device
registration: No such file or directory
safe_macros.c:757: BROK: tst_test.c:752: mount(/dev/loop0, mnt_point,
btrfs, 0, (nil)) failed: ENODEV

Cc: Christian Amann <camann@suse.com>
Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Amir,

thanks a lot for a report and sorry for longer time to reply (vacation).
Could you please test it? (I don't have any VM with kernel >= 4.5 && !btrfs).

Kind regards,
Petr

 testcases/kernel/syscalls/ioctl/ioctl08.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 8de80048c..dca898a65 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -112,6 +112,11 @@ static void setup(void)
 			sizeof(struct file_dedupe_range_info));
 }
 
+static const char *const needed_drivers[] = {
+	"btrfs",
+	NULL,
+};
+
 static struct tst_test test = {
 	.test = verify_ioctl,
 	.tcnt = ARRAY_SIZE(tcases),
@@ -122,6 +127,7 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.dev_fs_type = "btrfs",
+	.needs_drivers = needed_drivers,
 };
 #else
 	TST_TEST_TCONF(
-- 
2.21.0

