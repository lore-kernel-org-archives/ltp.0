From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  3 Nov 2020 20:13:22 +0100
Subject: [LTP] [PATCH v2 06/11] syscalls: Move needs_drivers inside of the
 tst_test struct
In-Reply-To: <20201103191327.11081-1-pvorel@suse.cz>
References: <20201103191327.11081-1-pvorel@suse.cz>
Message-ID: <20201103191327.11081-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Cyril Hrubis <chrubis@suse.cz>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fsetxattr/fsetxattr02.c | 10 ++++------
 testcases/kernel/syscalls/ioctl/ioctl08.c         |  9 ++++-----
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
index 205e80c95..3aea4b59e 100644
--- a/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
+++ b/testcases/kernel/syscalls/fsetxattr/fsetxattr02.c
@@ -241,11 +241,6 @@ static void cleanup(void)
 	}
 }
 
-static const char *const needed_drivers[] = {
-	"brd",
-	NULL,
-};
-
 static struct tst_test test = {
 	.setup = setup,
 	.test = verify_fsetxattr,
@@ -254,7 +249,10 @@ static struct tst_test test = {
 	.needs_devfs = 1,
 	.mntpoint = MNTPOINT,
 	.needs_root = 1,
-	.needs_drivers = needed_drivers,
+	.needs_drivers = (const char *const[]) {
+		"brd",
+		NULL,
+	},
 };
 
 #else /* HAVE_SYS_XATTR_H */
diff --git a/testcases/kernel/syscalls/ioctl/ioctl08.c b/testcases/kernel/syscalls/ioctl/ioctl08.c
index dca898a65..f7d11815d 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl08.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
@@ -112,10 +112,6 @@ static void setup(void)
 			sizeof(struct file_dedupe_range_info));
 }
 
-static const char *const needed_drivers[] = {
-	"btrfs",
-	NULL,
-};
 
 static struct tst_test test = {
 	.test = verify_ioctl,
@@ -127,7 +123,10 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.dev_fs_type = "btrfs",
-	.needs_drivers = needed_drivers,
+	.needs_drivers = (const char *const[]) {
+		"btrfs",
+		NULL,
+	},
 };
 #else
 	TST_TEST_TCONF(
-- 
2.29.1

