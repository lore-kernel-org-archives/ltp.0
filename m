From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 16 Aug 2018 16:45:46 +0800
Subject: [LTP] [PATCH v2 3/4] syscalls/open11.c: Fix the failure of opening
	device special files
In-Reply-To: <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20180815114220.GA26923@rei>
 <1534409147-29519-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1534409147-29519-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If temporary directory is on the mountpoint which is mounted with nodev
option(or it is mounted with with nodev option directly), open(2) has no
permission to open device special file in the temporary directory and
failed as expected.  as below:
--------------------------------------------------------------------------
open11.c:351: Open device special file O_RDONLY - expected errno 0 - Got: TEST_ERRNO=EACCES(13): Permission denied
open11.c:351: Open device special file O_WRONLY - expected errno 0 - Got: TEST_ERRNO=EACCES(13): Permission denied
open11.c:351: Open device special file O_RDWR - expected errno 0 - Got: TEST_ERRNO=EACCES(13): Permission denied
--------------------------------------------------------------------------

We prepare a suitable filesystem to test device special files by setting
.needs_devfs flag.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/open/open11.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 0469a0a..cfd04fd 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -48,6 +48,7 @@
 
 #include "tst_test.h"
 
+#define MNTPOINT "mntpoint"
 #define T_REG "t_reg"			/* regular file with content */
 #define T_REG_EMPTY "t_reg_empty"	/* empty regular file */
 #define T_LINK_REG "t_link_reg"		/* hard link to T_REG */
@@ -55,7 +56,7 @@
 #define T_SYMLINK_REG "t_symlink_reg"	/* symlink to T_REG */
 #define T_DIR "t_dir"			/* test dir */
 #define T_SYMLINK_DIR "t_symlink_dir"	/* symlink to T_DIR */
-#define T_DEV "t_dev"			/* test device special file */
+#define T_DEV MNTPOINT"/t_dev"		/* test device special file */
 
 #define T_MSG "this is a test string"
 
@@ -318,6 +319,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tc),
 	.setup = setup,
 	.test = verify_open,
-	.needs_tmpdir = 1,
+	.needs_devfs = 1,
+	.mntpoint = MNTPOINT,
 	.needs_root = 1,
 };
-- 
1.8.3.1



