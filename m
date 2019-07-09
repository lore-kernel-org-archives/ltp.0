From: Christian Amann <camann@suse.com>
Date: Tue,  9 Jul 2019 09:32:28 +0200
Subject: [LTP] [PATCH v1] syscalls/ioctl08: Add check for btrfs
Message-ID: <20190709073228.18707-1-camann@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This test used to fail on systems with missing btrfs support. Now it
ends with TCONF.

Reported-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Amann <camann@suse.com>
---
 testcases/kernel/syscalls/ioctl/ioctl08.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index 8de80048c..c39423b8b 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -112,9 +112,15 @@ static void setup(void)
 			sizeof(struct file_dedupe_range_info));
 }
 
+static const char *kconfigs[] = {
+	"CONFIG_BTRFS_FS",
+	NULL
+};
+
 static struct tst_test test = {
 	.test = verify_ioctl,
 	.tcnt = ARRAY_SIZE(tcases),
+	.needs_kconfigs = kconfigs,
 	.setup = setup,
 	.cleanup = cleanup,
 	.min_kver = "4.5",
-- 
2.16.4

