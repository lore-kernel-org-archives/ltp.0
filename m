From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sun, 25 Apr 2021 09:22:40 +0800
Subject: [LTP] [PATCH v2] syscalls/getdents01: Add close() and open() at the
 end of run()
Message-ID: <20210425012240.6328-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When the test run with the option of '-i', we need call close
and open at the end of run(), otherwist the test will fail,as follows:

$ getdents01 -i 2

tst_buffers.c:55: TINFO: Test is using guarded buffers
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:148: TINFO: Testing the SYS_getdents syscall
getdents01.c:109: TINFO: Found '.'
getdents01.c:109: TINFO: Found '..'
getdents01.c:109: TINFO: Found 'symlink'
getdents01.c:109: TINFO: Found 'file'
getdents01.c:109: TINFO: Found 'dir'
getdents01.c:149: TPASS: All entries found
getdents01.c:97: TFAIL: getdents failed - returned end of directory
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:151: TINFO: Testing the SYS_getdents64 syscall
getdents01.c:109: TINFO: Found '.'
getdents01.c:109: TINFO: Found '..'
getdents01.c:109: TINFO: Found 'dir'
getdents01.c:109: TINFO: Found 'symlink'
getdents01.c:109: TINFO: Found 'file'
getdents01.c:149: TPASS: All entries found
getdents01.c:97: TFAIL: getdents failed - returned end of directory
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:157: TCONF: libc getdents() is not implemented
tst_test.c:1291: TINFO: Timeout per run is 0h 05m 00s
getdents.h:162: TINFO: Testing libc getdents64()
getdents01.c:109: TINFO: Found '.'
getdents01.c:109: TINFO: Found '..'
getdents01.c:109: TINFO: Found 'dir'
getdents01.c:109: TINFO: Found 'symlink'
getdents01.c:109: TINFO: Found 'file'
getdents01.c:149: TPASS: All entries found
getdents01.c:97: TFAIL: getdents failed - returned end of directory

Summary:
passed   3
failed   3
broken   0
skipped  1
warnings 0

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
v1->v2: opened the fd at the start of the run() and closed it at the
end instead of opening it in setup() and reopening it for each iteration

 testcases/kernel/syscalls/getdents/getdents01.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/getdents/getdents01.c b/testcases/kernel/syscalls/getdents/getdents01.c
index ef8f4e864..f36f8869a 100644
--- a/testcases/kernel/syscalls/getdents/getdents01.c
+++ b/testcases/kernel/syscalls/getdents/getdents01.c
@@ -61,6 +61,8 @@ static void run(void)
 {
 	int rval;

+	fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY);
+
 	rval = tst_getdents(fd, dirp, BUFSIZE);

 	if (rval < 0) {
@@ -92,6 +94,8 @@ static void run(void)
 	} while (rval > 0);

 	check_flags();
+
+	SAFE_CLOSE(fd);
 }

 static void reset_flags(void)
@@ -162,21 +166,12 @@ static void setup(void)
 			}
 		}
 	}
-
-	fd = SAFE_OPEN(".", O_RDONLY|O_DIRECTORY);
-}
-
-static void cleanup(void)
-{
-	if (fd != 0)
-		SAFE_CLOSE(fd);
 }

 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.test_all = run,
 	.setup = setup,
-	.cleanup = cleanup,
 	.bufs = (struct tst_buffers []) {
 		{&dirp, .size = BUFSIZE},
 		{},
--
2.17.1

