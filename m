From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Mar 2020 18:47:58 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] syscalls: Use TTERRNO after TEST()
Message-ID: <20200319174758.20532-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixed commits in new mount API tests
https://patchwork.ozlabs.org/project/ltp/list/?series=163944&state=*

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/syscalls/fsconfig/fsconfig01.c      | 18 +++++++++---------
 .../kernel/syscalls/fsconfig/fsconfig02.c      |  2 +-
 testcases/kernel/syscalls/fsmount/fsmount02.c  |  6 +++---
 testcases/kernel/syscalls/fsopen/fsopen01.c    | 10 +++++-----
 testcases/kernel/syscalls/fspick/fspick01.c    |  6 +++---
 .../kernel/syscalls/move_mount/move_mount01.c  | 10 +++++-----
 .../kernel/syscalls/move_mount/move_mount02.c  |  8 ++++----
 .../kernel/syscalls/open_tree/open_tree01.c    | 16 ++++++++--------
 .../kernel/syscalls/open_tree/open_tree02.c    | 12 ++++++------
 9 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
index aea6db822..34f5481e4 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -24,22 +24,22 @@ static void run(void)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "fsopen() failed");
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+		tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+		tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "sync", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		if (TST_ERR == EOPNOTSUPP)
 			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_PATH not supported");
 		else
-			tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+			tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_PATH_EMPTY, "sync", tst_device->dev, 0));
@@ -47,7 +47,7 @@ static void run(void)
 		if (TST_ERR == EOPNOTSUPP)
 			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported");
 		else
-			tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+			tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_FD, "sync", NULL, 0));
@@ -55,23 +55,23 @@ static void run(void)
 		if (TST_ERR == EOPNOTSUPP)
 			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_FD not supported");
 		else
-			tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+			tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TERRNO, "fsconfig() failed");
+		tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
 
 	TEST(fsmfd = fsmount(fd, 0, 0));
 	if (fsmfd == -1)
-		tst_brk(TBROK | TERRNO, "fsmount() failed");
+		tst_brk(TBROK | TTERRNO, "fsmount() failed");
 
 	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
 			MOVE_MOUNT_F_EMPTY_PATH));
 	SAFE_CLOSE(fsmfd);
 
 	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "move_mount() failed");
+		tst_brk(TBROK | TTERRNO, "move_mount() failed");
 
 	if (tst_is_mounted_at_tmpdir(MNTPOINT)) {
 		SAFE_UMOUNT(MNTPOINT);
diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
index 586524f14..20d77917f 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig02.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
@@ -53,7 +53,7 @@ static void setup(void)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "fsopen() failed");
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
 
 	temp_fd = open("testfile", O_RDWR | O_CREAT, 01444);
 	if (temp_fd == -1)
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index e34192009..6f90519ff 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -35,15 +35,15 @@ static void setup(void)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "fsopen() failed");
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
 }
 
 static void run(unsigned int n)
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
index d486361dc..02e6d270e 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen01.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -27,25 +27,25 @@ static void run(unsigned int n)
 
 	TEST(fd = fsopen(tst_device->fs_type, tc->flags));
 	if (fd == -1) {
-		tst_res(TFAIL | TERRNO, "fsopen() failed");
+		tst_res(TFAIL | TTERRNO, "fsopen() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		goto out;
 	}
 
 	TEST(fsmfd = fsmount(fd, 0, 0));
 	if (fsmfd == -1) {
-		tst_res(TFAIL | TERRNO, "fsmount() failed");
+		tst_res(TFAIL | TTERRNO, "fsmount() failed");
 		goto out;
 	}
 
@@ -55,7 +55,7 @@ static void run(unsigned int n)
 	SAFE_CLOSE(fsmfd);
 
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "move_mount() failed");
+		tst_res(TFAIL | TTERRNO, "move_mount() failed");
 		goto out;
 	}
 
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index 4e1daeaee..3b3635b20 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -27,19 +27,19 @@ static void run(unsigned int n)
 
 	TEST(fspick_fd = fspick(AT_FDCWD, MNTPOINT, tc->flags));
 	if (fspick_fd == -1) {
-		tst_res(TFAIL | TERRNO, "fspick() failed");
+		tst_res(TFAIL | TTERRNO, "fspick() failed");
 		return;
 	}
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_STRING, "sync", "false", 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		goto out;
 	}
 
diff --git a/testcases/kernel/syscalls/move_mount/move_mount01.c b/testcases/kernel/syscalls/move_mount/move_mount01.c
index abd73d132..ede88946a 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount01.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount01.c
@@ -30,21 +30,21 @@ static void run(unsigned int n)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1) {
-		tst_res(TFAIL | TERRNO, "fsopen() failed");
+		tst_res(TFAIL | TTERRNO, "fsopen() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		return;
 	}
 
@@ -52,7 +52,7 @@ static void run(unsigned int n)
 	SAFE_CLOSE(fd);
 
 	if (fsmfd == -1) {
-		tst_res(TFAIL | TERRNO, "fsmount() failed");
+		tst_res(TFAIL | TTERRNO, "fsmount() failed");
 		return;
 	}
 
@@ -61,7 +61,7 @@ static void run(unsigned int n)
 	SAFE_CLOSE(fsmfd);
 
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "move_mount() failed");
+		tst_res(TFAIL | TTERRNO, "move_mount() failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
index dfb48a1b3..74c287b0a 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount02.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -34,21 +34,21 @@ static void run(unsigned int n)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1) {
-		tst_res(TFAIL | TERRNO, "fsopen() failed");
+		tst_res(TFAIL | TTERRNO, "fsopen() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		return;
 	}
 
@@ -56,7 +56,7 @@ static void run(unsigned int n)
 	SAFE_CLOSE(fd);
 
 	if (fsmfd == -1) {
-		tst_res(TFAIL | TERRNO, "fsmount() failed");
+		tst_res(TFAIL | TTERRNO, "fsmount() failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
index 5fd8b9b7c..905d16a03 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree01.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -42,21 +42,21 @@ static void run(unsigned int n)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1) {
-		tst_res(TFAIL | TERRNO, "fsopen() failed");
+		tst_res(TFAIL | TTERRNO, "fsopen() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
 		return;
 	}
 
@@ -64,7 +64,7 @@ static void run(unsigned int n)
 	SAFE_CLOSE(fd);
 
 	if (fsmfd == -1) {
-		tst_res(TFAIL | TERRNO, "fsmount() failed");
+		tst_res(TFAIL | TTERRNO, "fsmount() failed");
 		return;
 	}
 
@@ -73,18 +73,18 @@ static void run(unsigned int n)
 	SAFE_CLOSE(fsmfd);
 
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "move_mount() failed");
+		tst_res(TFAIL | TTERRNO, "move_mount() failed");
 		return;
 	}
 
 	if (!tst_is_mounted_at_tmpdir(MNTPOINT)) {
-		tst_res(TFAIL | TERRNO, "device not mounted");
+		tst_res(TFAIL | TTERRNO, "device not mounted");
 		return;
 	}
 
 	TEST(otfd = open_tree(AT_FDCWD, MNTPOINT, tc->flags | OPEN_TREE_CLONE));
 	if (otfd == -1) {
-		tst_res(TFAIL | TERRNO, "open_tree() failed");
+		tst_res(TFAIL | TTERRNO, "open_tree() failed");
 		goto out;
 	}
 
@@ -93,7 +93,7 @@ static void run(unsigned int n)
 	SAFE_CLOSE(otfd);
 
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TERRNO, "move_mount() failed");
+		tst_res(TFAIL | TTERRNO, "move_mount() failed");
 		goto out;
 	}
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
index 691169383..58c71da20 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree02.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -37,35 +37,35 @@ static void setup(void)
 
 	TEST(fd = fsopen(tst_device->fs_type, 0));
 	if (fd == -1)
-		tst_brk(TBROK | TERRNO, "fsopen() failed");
+		tst_brk(TBROK | TTERRNO, "fsopen() failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
 	}
 
 	TEST(fsmfd = fsmount(fd, 0, 0));
 	SAFE_CLOSE(fd);
 
 	if (fsmfd == -1)
-		tst_brk(TBROK | TERRNO, "fsmount() failed");
+		tst_brk(TBROK | TTERRNO, "fsmount() failed");
 
 	TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
 			MOVE_MOUNT_F_EMPTY_PATH));
 	SAFE_CLOSE(fsmfd);
 
 	if (TST_RET == -1)
-		tst_brk(TBROK | TERRNO, "move_mount() failed");
+		tst_brk(TBROK | TTERRNO, "move_mount() failed");
 
 	if (!tst_is_mounted_at_tmpdir(MNTPOINT))
-		tst_brk(TBROK | TERRNO, "device not mounted");
+		tst_brk(TBROK | TTERRNO, "device not mounted");
 
 	ismounted = 1;
 }
-- 
2.25.1

