From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jul 2016 15:26:02 +0100
Subject: [LTP] [PATCH] syscalls/mount03: close files in MS_NOATIME test
	error paths
Message-ID: <1467383162-2072-1-git-send-email-peter.maydell@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The mount03 test has a bug in the error handling code paths for the
MS_NOATIME flag test: if for instance a read() fails then we return
from test_rwflag() without doing a close() on the filedescriptor.
This then causes the umount() performed by tst_release_device() to
fail with EBUSY, and then the loopback device is left mounted.
Later, other test cases that try to use the loopback device then
fail unnecessarily.

Close open file descriptors in error-exit codepaths, so that cleanup
on failure works as intended.  This brings the code for MS_NOATIME
into line with how the other test cases in the function handle this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 testcases/kernel/syscalls/mount/mount03.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index 1873f0f..a8abbff 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -308,11 +308,13 @@ int test_rwflag(int i, int cnt)
 
 		if (write(fd, "TEST_MS_NOATIME", 15) != 15) {
 			tst_resm(TWARN | TERRNO, "write %s failed", file);
+			close(fd);
 			return 1;
 		}
 
 		if (fstat(fd, &file_stat) == -1) {
 			tst_resm(TWARN | TERRNO, "stat %s failed #1", file);
+			close(fd);
 			return 1;
 		}
 
@@ -322,11 +324,13 @@ int test_rwflag(int i, int cnt)
 
 		if (read(fd, readbuf, sizeof(readbuf)) == -1) {
 			tst_resm(TWARN | TERRNO, "read %s failed", file);
+			close(fd);
 			return 1;
 		}
 
 		if (fstat(fd, &file_stat) == -1) {
 			tst_resm(TWARN | TERRNO, "stat %s failed #2", file);
+			close(fd);
 			return 1;
 		}
 		close(fd);
-- 
1.9.1

