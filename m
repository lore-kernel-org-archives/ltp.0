From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Nov 2020 14:04:25 +0100
Subject: [LTP] [PATCH 2/2] syscalls: quotactl04,
 statx05: Fix TWARN on missing mkfs
Message-ID: <20201124130425.4264-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When mkfs.ext4 was missing we would get TWARN because the setup will fail to
parse the mkfs version followed by TCONF from the library function that
attempts format the device.

Fix this by requiring the mkfs.ext4 in the tst_test structure which will exit
the test before we attempt to parse the mkfs version.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl04.c | 4 ++++
 testcases/kernel/syscalls/statx/statx05.c       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
index 3cc2b974f..8b17b1fbc 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl04.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
@@ -170,4 +170,8 @@ static struct tst_test test = {
 	.needs_device = 1,
 	.dev_fs_type = "ext4",
 	.mntpoint = MNTPOINT,
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4",
+		NULL
+	}
 };
diff --git a/testcases/kernel/syscalls/statx/statx05.c b/testcases/kernel/syscalls/statx/statx05.c
index d7ac24418..81a5bcbf2 100644
--- a/testcases/kernel/syscalls/statx/statx05.c
+++ b/testcases/kernel/syscalls/statx/statx05.c
@@ -135,4 +135,8 @@ static struct tst_test test = {
 	.needs_device = 1,
 	.mntpoint = MNTPOINT,
 	.dev_fs_type = "ext4",
+	.needs_cmds = (const char *[]) {
+		"mkfs.ext4",
+		NULL
+	}
 };
-- 
2.26.2

