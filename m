From: Petr Vorel <pvorel@suse.cz>
Date: Mon,  8 Oct 2018 11:33:22 +0200
Subject: [LTP] [PATCH 1/1] syscalls/statx04: TCONF on BTRFS for kernel < 4.13
Message-ID: <20181008093322.8624-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BTRFS support for statx flags was added in 4.13:
04a87e347282 ("Btrfs: add statx support")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/statx/statx04.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/testcases/kernel/syscalls/statx/statx04.c b/testcases/kernel/syscalls/statx/statx04.c
index 8caf092db..2e1dc8569 100644
--- a/testcases/kernel/syscalls/statx/statx04.c
+++ b/testcases/kernel/syscalls/statx/statx04.c
@@ -32,6 +32,7 @@
 #define MOUNT_POINT "mntpoint"
 #define TESTDIR_FLAGGED MOUNT_POINT"/test_dir1"
 #define TESTDIR_UNFLAGGED MOUNT_POINT"/test_dir2"
+#define BTRFS_STATX_SUPPORT "4.13.0"
 
 static int fd, clear_flags;
 
@@ -152,6 +153,17 @@ static void setup(void)
 	SAFE_MKDIR(TESTDIR_FLAGGED, 0777);
 	SAFE_MKDIR(TESTDIR_UNFLAGGED, 0777);
 
+	if (!strcmp(tst_device->fs_type, "btrfs")) {
+		int v1, v2, v3;
+		if (tst_parse_kver(BTRFS_STATX_SUPPORT, &v1, &v2, &v3))
+			tst_res(TWARN,
+					"Invalid kernel version %s, expected %%d.%%d.%%d",
+					BTRFS_STATX_SUPPORT);
+		if (tst_kvercmp(v1, v2, v3) < 0)
+			tst_brk(TCONF, "BTRFS supports statx from kernel %s ",
+					BTRFS_STATX_SUPPORT);
+	}
+
 	caid_flags_setup();
 }
 
-- 
2.19.0

