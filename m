From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Nov 2018 13:47:26 +0100
Subject: [LTP] [PATCH 2/2] syscalls/execveat01: Add new testcase
In-Reply-To: <1537863535-25744-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1537863535-25744-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1537863535-25744-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20181120124726.GB22768@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1) Factor out check_execveat().
> 2) Check the basic functionality of execveat(2).

I looked into the kernel and it seems that the test is mostly
excercising common filesystem lookup code and since we have a dentry
cache I doubt that we will ever call to the filesystem driver for the
pathname lookup for the directory and file we just created. Hence AFAIK
there is no point in running the test for all filesystems.

So I've simplified the test so that it does not set .all_filesystems and
pushed, thanks!

diff --git a/testcases/kernel/syscalls/execveat/execveat01.c b/testcases/kernel/syscalls/execveat/execveat01.c
index e563a4869..5325d484b 100644
--- a/testcases/kernel/syscalls/execveat/execveat01.c
+++ b/testcases/kernel/syscalls/execveat/execveat01.c
@@ -27,9 +27,9 @@
 #include "lapi/fcntl.h"
 #include "execveat.h"
 
-#define MNTPOINT "mntpoint"
+#define TESTDIR "testdir"
 #define TEST_APP "execveat_child"
-#define TEST_REL_APP MNTPOINT"/"TEST_APP
+#define TEST_REL_APP TESTDIR"/"TEST_APP
 
 static int fd1, fd4;
 static int fd2 = AT_FDCWD, fd3 = -1;
@@ -65,12 +65,13 @@ static void setup(void)
 
 	check_execveat();
 
+	SAFE_MKDIR(TESTDIR, 0777);
 	SAFE_CP(TEST_APP, TEST_REL_APP);
 
 	SAFE_GETCWD(cur_dir_path, sizeof(cur_dir_path));
 	sprintf(app_abs_path, "%s/%s", cur_dir_path, TEST_REL_APP);
 
-	fd1 = SAFE_OPEN(MNTPOINT, O_DIRECTORY);
+	fd1 = SAFE_OPEN(TESTDIR, O_DIRECTORY);
 	fd4 = SAFE_OPEN(TEST_REL_APP, O_PATH);
 }
 
@@ -93,11 +94,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.test = verify_execveat,
 	.child_needs_reinit = 1,
-	.all_filesystems = 1,
-	.mntpoint = MNTPOINT,
-	.mount_device = 1,
 	.forks_child = 1,
-	.needs_root = 1,
 	.cleanup = cleanup,
 	.setup = setup,
 };

-- 
Cyril Hrubis
chrubis@suse.cz
