From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Mar 2020 09:04:15 +0530
Subject: [LTP] [PATCH] syscalls/fsconfig: Improve print messages by adding
 fsconfig command name
Message-ID: <3a3774a67f143fd250ea6ebe0daff29beffa7cfd.1584934420.git.viresh.kumar@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add fsconfig command name to the print messages to improve readability.

Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 .../kernel/syscalls/fsconfig/fsconfig01.c      | 18 +++++++++---------
 testcases/kernel/syscalls/fsmount/fsmount01.c  |  4 ++--
 testcases/kernel/syscalls/fsmount/fsmount02.c  |  4 ++--
 testcases/kernel/syscalls/fsopen/fsopen01.c    |  4 ++--
 testcases/kernel/syscalls/fspick/fspick.h      |  4 ++--
 testcases/kernel/syscalls/fspick/fspick01.c    |  6 +++---
 .../kernel/syscalls/move_mount/move_mount01.c  |  4 ++--
 .../kernel/syscalls/move_mount/move_mount02.c  |  4 ++--
 .../kernel/syscalls/open_tree/open_tree01.c    |  4 ++--
 .../kernel/syscalls/open_tree/open_tree02.c    |  4 ++--
 10 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
index 34f5481e479a..47941136d502 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
@@ -28,39 +28,39 @@ static void run(void)
 
 	TEST(fsconfig(fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 
 	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "sync", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		if (TST_ERR == EOPNOTSUPP)
-			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_PATH not supported");
+			tst_res(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
 		else
-			tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
+			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_PATH_EMPTY, "sync", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		if (TST_ERR == EOPNOTSUPP)
-			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_PATH_EMPTY not supported");
+			tst_res(TCONF, "fsconfig(FSCONFIG_SET_PATH_EMPTY) not supported");
 		else
-			tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
+			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH_EMPTY) failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_SET_FD, "sync", NULL, 0));
 	if (TST_RET == -1) {
 		if (TST_ERR == EOPNOTSUPP)
-			tst_res(TCONF, "fsconfig(): FSCONFIG_SET_FD not supported");
+			tst_res(TCONF, "fsconfig(FSCONFIG_SET_FD) not supported");
 		else
-			tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
+			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FD) failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1)
-		tst_brk(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 
 	TEST(fsmfd = fsmount(fd, 0, 0));
 	if (fsmfd == -1)
diff --git a/testcases/kernel/syscalls/fsmount/fsmount01.c b/testcases/kernel/syscalls/fsmount/fsmount01.c
index 34d9365d4680..e8198187145b 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount01.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -52,14 +52,14 @@ static void run(unsigned int n)
 	if (TST_RET == -1) {
 		SAFE_CLOSE(sfd);
 		tst_res(TFAIL | TTERRNO,
-			"fsconfig() failed to set source to %s", tst_device->dev);
+			"fsconfig(FSCONFIG_SET_STRING) failed to set source to %s", tst_device->dev);
 		return;
 	}
 
 	TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(sfd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() created superblock");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/fsmount/fsmount02.c b/testcases/kernel/syscalls/fsmount/fsmount02.c
index 6f90519ff5f7..effc863516b6 100644
--- a/testcases/kernel/syscalls/fsmount/fsmount02.c
+++ b/testcases/kernel/syscalls/fsmount/fsmount02.c
@@ -39,11 +39,11 @@ static void setup(void)
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1)
-		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 }
 
 static void run(unsigned int n)
diff --git a/testcases/kernel/syscalls/fsopen/fsopen01.c b/testcases/kernel/syscalls/fsopen/fsopen01.c
index 02e6d270eff3..8dabd6814a93 100644
--- a/testcases/kernel/syscalls/fsopen/fsopen01.c
+++ b/testcases/kernel/syscalls/fsopen/fsopen01.c
@@ -33,13 +33,13 @@ static void run(unsigned int n)
 
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 		goto out;
 	}
 
diff --git a/testcases/kernel/syscalls/fspick/fspick.h b/testcases/kernel/syscalls/fspick/fspick.h
index ca84269ee7a9..4be296ee79da 100644
--- a/testcases/kernel/syscalls/fspick/fspick.h
+++ b/testcases/kernel/syscalls/fspick/fspick.h
@@ -29,13 +29,13 @@ static void setup(void)
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 	}
 
 	TEST(fsmfd = fsmount(fd, 0, 0));
diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index b5a35bf61e2c..c84723805cb9 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -33,19 +33,19 @@ static void run(unsigned int n)
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_STRING, "sync", "false", 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "ro", NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
 		goto out;
 	}
 
 	TEST(fsconfig(fspick_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
 	if (TST_RET == -1) {
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
 		goto out;
 	}
 
diff --git a/testcases/kernel/syscalls/move_mount/move_mount01.c b/testcases/kernel/syscalls/move_mount/move_mount01.c
index ede88946ad4c..fd785da02b14 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount01.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount01.c
@@ -37,14 +37,14 @@ static void run(unsigned int n)
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/move_mount/move_mount02.c b/testcases/kernel/syscalls/move_mount/move_mount02.c
index 74c287b0a6fb..f75991a3f5d2 100644
--- a/testcases/kernel/syscalls/move_mount/move_mount02.c
+++ b/testcases/kernel/syscalls/move_mount/move_mount02.c
@@ -41,14 +41,14 @@ static void run(unsigned int n)
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree01.c b/testcases/kernel/syscalls/open_tree/open_tree01.c
index 905d16a03697..ddaabed810bd 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree01.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
@@ -49,14 +49,14 @@ static void run(unsigned int n)
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 		return;
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_res(TFAIL | TTERRNO, "fsconfig() failed");
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 		return;
 	}
 
diff --git a/testcases/kernel/syscalls/open_tree/open_tree02.c b/testcases/kernel/syscalls/open_tree/open_tree02.c
index 58c71da20e74..76a750ae412b 100644
--- a/testcases/kernel/syscalls/open_tree/open_tree02.c
+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
@@ -42,13 +42,13 @@ static void setup(void)
 	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
 	}
 
 	TEST(fsconfig(fd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
 	if (TST_RET == -1) {
 		SAFE_CLOSE(fd);
-		tst_brk(TBROK | TTERRNO, "fsconfig() failed");
+		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_CMD_CREATE) failed");
 	}
 
 	TEST(fsmfd = fsmount(fd, 0, 0));
-- 
2.21.0.rc0.269.g1a574e7a288b

