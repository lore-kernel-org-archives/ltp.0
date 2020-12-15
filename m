From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Tue, 15 Dec 2020 17:56:50 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_loop05.c: skip test on overlay
 filesystem
Message-ID: <20201215155650.6496-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The undelrying device can't be properly detected and causes failure
when running in an overlay filesystem.

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl_loop05.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
index e3c14faab..f8fa413a9 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -101,6 +101,9 @@ static void setup(void)
 	if (tst_fs_type(".") == TST_TMPFS_MAGIC)
 		tst_brk(TCONF, "tmpfd doesn't support O_DIRECT flag");
 
+	if (tst_fs_type(".") == TST_OVERLAYFS_MAGIC)
+		tst_brk(TCONF, "device isn't properly detected in overlay fs");
+
 	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
 	if (dev_num < 0)
 		tst_brk(TBROK, "Failed to find free loop device");
-- 
2.26.2

