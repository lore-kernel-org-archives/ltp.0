From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jul 2016 15:55:25 +0100
Subject: [LTP] [PATCH] syscalls/mmap16: close open files in cleanup path
Message-ID: <1467384925-24792-1-git-send-email-peter.maydell@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If the mmap16 test fails while the do_test() function
still has its filedescriptor open, the cleanup function's
attempt to unmount will fail with EBUSY, resulting in a
lot of noise in the test log, a leaked mounted filesystem
and unnecessary test failures later in the run.

Make the do_test() file descriptor global so we can
close it in the cleanup function if necessary.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I noticed this because QEMU linux-user mode happens to fail
this test at the moment, so it exercises the broken failure path.

 testcases/kernel/syscalls/mmap/mmap16.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap16.c b/testcases/kernel/syscalls/mmap/mmap16.c
index ca1f47d..5d943a0 100644
--- a/testcases/kernel/syscalls/mmap/mmap16.c
+++ b/testcases/kernel/syscalls/mmap/mmap16.c
@@ -48,6 +48,7 @@ static const char *device;
 static const char *fs_type = "ext4";
 static int mount_flag;
 static int chdir_flag;
+static int parentfd;
 
 static int page_size;
 static int bug_reproduced;
@@ -91,7 +92,7 @@ int main(int ac, char **av)
 
 static void do_test(void)
 {
-	int fd, ret, status;
+	int ret, status;
 	pid_t child;
 	char buf[FS_BLOCKSIZE];
 
@@ -105,12 +106,12 @@ static void do_test(void)
 	case 0:
 		do_child();
 	default:
-		fd = SAFE_OPEN(cleanup, "testfilep", O_RDWR);
+		parentfd = SAFE_OPEN(cleanup, "testfilep", O_RDWR);
 		memset(buf, 'a', FS_BLOCKSIZE);
 
 		TST_SAFE_CHECKPOINT_WAIT(cleanup, 0);
 		while (1) {
-			ret = write(fd, buf, FS_BLOCKSIZE);
+			ret = write(parentfd, buf, FS_BLOCKSIZE);
 			if (ret < 0) {
 				if (errno == ENOSPC) {
 					break;
@@ -120,7 +121,7 @@ static void do_test(void)
 				}
 			}
 		}
-		SAFE_CLOSE(cleanup, fd);
+		SAFE_CLOSE(cleanup, parentfd);
 		TST_SAFE_CHECKPOINT_WAKE(cleanup, 0);
 	}
 
@@ -231,6 +232,8 @@ static void do_child(void)
 
 static void cleanup(void)
 {
+	if (parentfd > 0)
+		close(parentfd);
 	if (chdir_flag && chdir(".."))
 		tst_resm(TWARN | TERRNO, "chdir('..') failed");
 	if (mount_flag && tst_umount(MNTPOINT) < 0)
-- 
1.9.1

