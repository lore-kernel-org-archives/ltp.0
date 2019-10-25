From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 25 Oct 2019 09:59:40 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: skip new error tests if
 cross-fs isn't supported
Message-ID: <1571968780-4810-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We should not skip the whole error test if cross-fs isn't support because
old errors should be tested on all version. Even we use .mount_device = 1
and .mntpoint = MNTPOINT, the src and dest file are still in tmp directory
instead of mntpoint.

ps: I doubt whether we should skip new error test because it indeed exposed this
unreasonable copy_file_range behavior of the user.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 .../copy_file_range/copy_file_range02.c       | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
index a55de4111..e4159cad7 100644
--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -55,6 +55,7 @@ static int need_unlink;
 
 static int chattr_i_nsup;
 static int swap_nsup;
+static int cross_sup;
 static int loop_devn;
 
 static struct tcase {
@@ -63,21 +64,22 @@ static struct tcase {
 	int	exp_err;
 	loff_t     len;
 	const char *tname;
+	int     new_error;
 } tcases[] = {
-	{&fd_rdonly,	0,	EBADF,		CONTSIZE,	"readonly file"},
-	{&fd_dir,	0,	EISDIR,		CONTSIZE,	"directory"},
-	{&fd_append,	0,	EBADF,		CONTSIZE,	"append to file"},
-	{&fd_closed,	0,	EBADF,		CONTSIZE,	"closed file descriptor"},
-	{&fd_dest,	-1,	EINVAL,		CONTSIZE,	"invalid flags"},
-	{&fd_immutable,	0,	EPERM,		CONTSIZE,	"immutable file"},
-	{&fd_swapfile,	0,	ETXTBSY,	CONTSIZE,	"swap file"},
-	{&fd_dup,	0,	EINVAL,		CONTSIZE/2,	"overlaping range"},
-	{&fd_blkdev,	0,	EINVAL,		CONTSIZE,	"block device"},
-	{&fd_chrdev,	0,	EINVAL,		CONTSIZE,	"char device"},
-	{&fd_fifo,	0,	EINVAL,		CONTSIZE,	"fifo"},
-	{&fd_pipe[0],	0,	EINVAL,		CONTSIZE,	"pipe"},
-	{&fd_copy,	0,	EOVERFLOW,	ULLONG_MAX,	"max length lenght"},
-	{&fd_copy,	0,	EFBIG,		MIN_OFF,	"max file size"},
+	{&fd_rdonly,	0,	EBADF,		CONTSIZE,	"readonly file",	0},
+	{&fd_dir,	0,	EISDIR,		CONTSIZE,	"directory",	0},
+	{&fd_append,	0,	EBADF,		CONTSIZE,	"append to file",	0},
+	{&fd_closed,	0,	EBADF,		CONTSIZE,	"closed file descriptor",	0},
+	{&fd_dest,	-1,	EINVAL,		CONTSIZE,	"invalid flags",	0},
+	{&fd_immutable,	0,	EPERM,		CONTSIZE,	"immutable file",	1},
+	{&fd_swapfile,	0,	ETXTBSY,	CONTSIZE,	"swap file",	1},
+	{&fd_dup,	0,	EINVAL,		CONTSIZE/2,	"overlaping range",	1},
+	{&fd_blkdev,	0,	EINVAL,		CONTSIZE,	"block device", 	0},
+	{&fd_chrdev,	0,	EINVAL,		CONTSIZE,	"char device",	0},
+	{&fd_fifo,	0,	EINVAL,		CONTSIZE,	"fifo", 	0},
+	{&fd_pipe[0],	0,	EINVAL,		CONTSIZE,	"pipe", 	0},
+	{&fd_copy,	0,	EOVERFLOW,	ULLONG_MAX,	"max length lenght", 	1},
+	{&fd_copy,	0,	EFBIG,		MIN_OFF,	"max file size", 	1},
 };
 
 static int run_command(char *command, char *option, char *file)
@@ -105,6 +107,11 @@ static void verify_copy_file_range(unsigned int n)
 
 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);
 
+	if (tc->new_error && !cross_sup) {
+		tst_res(TCONF,
+			"copy_file_range() doesn't support cross-device, skip it");
+		return;
+	}
 	if (tc->copy_to_fd == &fd_immutable && chattr_i_nsup) {
 		tst_res(TCONF, "filesystem doesn't support chattr +i, skip it");
 		return;
@@ -178,9 +185,7 @@ static void setup(void)
 	syscall_info();
 	char dev_path[1024];
 
-	if (!verify_cross_fs_copy_support(FILE_SRC_PATH, FILE_MNTED_PATH))
-		tst_brk(TCONF,
-			"copy_file_range() doesn't support cross-device, skip it");
+	cross_sup = verify_cross_fs_copy_support(FILE_SRC_PATH, FILE_MNTED_PATH);
 
 	if (access(FILE_DIR_PATH, F_OK) == -1)
 		SAFE_MKDIR(FILE_DIR_PATH, 0777);
-- 
2.18.0



