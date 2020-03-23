From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Mar 2020 12:41:59 +0530
Subject: [LTP] [PATCH 2/2] syscalls/open_tree: Set .mount_device to get rid
 of mounting related code
In-Reply-To: <aa66c041b2eca3f874056de72ca3dcdf8825a6b5.1584947466.git.viresh.kumar@linaro.org>
References: <aa66c041b2eca3f874056de72ca3dcdf8825a6b5.1584947466.git.viresh.kumar@linaro.org>
Message-ID: <c1cee81b06a1195635eca1791e0af9c22798e9f7.1584947466.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We don't necessarily need to work with the fsmount() related syscalls to
initially mount the device, we can set .mount_device instead and get rid
of a lot of code.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/open_tree/open_tree01.c   | 53 ++----------------
 .../kernel/syscalls/open_tree/open_tree02.c   | 54 +------------------
 2 files changed, 6 insertions(+), 101 deletions(-)

diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
index ddaabed810bd..f217866bbb2b 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree01.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -38,54 +38,12 @@ static void setup(void)
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	int fd, fsmfd, otfd;
-
-	TEST(fd = fsopen(tst_device->fs_type, 0));
-	if (fd == -1) {
-		tst_res(TFAIL | TTERRNO, "fsopen() failed");
-		return;
-	}
-
-	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
-	if (TST_RET == -1) {
-		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
-		return;
-	}
-
-	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
-	if (TST_RET == -1) {
-		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
-		return;
-	}
-
-	TEST(fsmfd = fsmount(fd, 0, 0));
-	SAFE_CLOSE(fd);
-
-	if (fsmfd == -1) {
-		tst_res(TFAIL | TTERRNO, "fsmount() failed");
-		return;
-	}
-
-	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
-			MOVE_MOUNT_F_EMPTY_PATH));
-	SAFE_CLOSE(fsmfd);
-
-	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "move_mount() failed");
-		return;
-	}
-
-	if (!tst_is_mounted_at_tmpdir(MNTPOINT)) {
-		tst_res(TFAIL | TTERRNO, "device not mounted");
-		return;
-	}
+	int otfd;
 
 	TEST(otfd = open_tree(AT_FDCWD, MNTPOINT, tc->flags | OPEN_TREE_CLONE));
 	if (otfd == -1) {
 		tst_res(TFAIL | TTERRNO, "open_tree() failed");
-		goto out;
+		return;
 	}
 
 	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT,
@@ -94,16 +52,13 @@ static void run(unsigned int n)
 
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "move_mount() failed");
-		goto out;
+		return;
 	}
 
 	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {
 		SAFE_UMOUNT(OT_MNTPOINT);
 		tst_res(TPASS, "%s: open_tree() passed", tc->name);
 	}
-
-out:
-	SAFE_UMOUNT(MNTPOINT);
 }
 
 static struct tst_test test = {
@@ -112,7 +67,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.format_device = 1,
+	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.dev_fs_flags = TST_FS_SKIP_FUSE,
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
index 76a750ae412b..32ad1aefe556 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree02.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -21,55 +21,6 @@ static struct tcase {
 	{"invalid-flags", AT_FDCWD, MNTPOINT, 0xFFFFFFFF, EINVAL},
 };
 
-static int ismounted;
-
-static void cleanup(void)
-{
-	if (ismounted)
-		SAFE_UMOUNT(MNTPOINT);
-}
-
-static void setup(void)
-{
-	int fd, fsmfd;
-
-	fsopen_supported_by_kernel();
-
-	TEST(fd = fsopen(tst_device->fs_type, 0));
-	if (fd == -1)
-		tst_brk(TBROK | TTERRNO, "fsopen() failed");
-
-	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
-	if (TST_RET == -1) {
-		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
-	}
-
-	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
-	if (TST_RET == -1) {
-		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
-	}
-
-	TEST(fsmfd = fsmount(fd, 0, 0));
-	SAFE_CLOSE(fd);
-
-	if (fsmfd == -1)
-		tst_brk(TBROK | TTERRNO, "fsmount() failed");
-
-	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
-			MOVE_MOUNT_F_EMPTY_PATH));
-	SAFE_CLOSE(fsmfd);
-
-	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "move_mount() failed");
-
-	if (!tst_is_mounted_at_tmpdir(MNTPOINT))
-		tst_brk(TBROK | TTERRNO, "device not mounted");
-
-	ismounted = 1;
-}
-
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
@@ -95,10 +46,9 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = run,
-	.setup = setup,
-	.cleanup = cleanup,
+	.setup = fsopen_supported_by_kernel,
 	.needs_root = 1,
-	.format_device = 1,
+	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
 	.dev_fs_flags = TST_FS_SKIP_FUSE,
-- 
2.21.0.rc0.269.g1a574e7a288b

