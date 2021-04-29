From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Thu, 29 Apr 2021 20:53:22 +0800
Subject: [LTP] [PATCH 1/4] syscalls/writev: Replace TINFO with TPASS or TFAIL
Message-ID: <20210429125322.31559-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1)remove fail flag
2)remove redundant log
3)replace TINFO with TPASS or TFAIL

For those:
	testcases/kernel/syscalls/writev/writev02.c
	testcases/kernel/syscalls/writev/writev05.c
	testcases/kernel/syscalls/writev/writev06.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 testcases/kernel/syscalls/writev/writev02.c |  1 -
 testcases/kernel/syscalls/writev/writev05.c | 16 +---------------
 testcases/kernel/syscalls/writev/writev06.c | 15 +--------------
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/testcases/kernel/syscalls/writev/writev02.c b/testcases/kernel/syscalls/writev/writev02.c
index 60d9e8978..3d51733f0 100644
--- a/testcases/kernel/syscalls/writev/writev02.c
+++ b/testcases/kernel/syscalls/writev/writev02.c
@@ -87,7 +87,6 @@ void sighandler(int);
 void l_seek(int, off_t, int);
 void setup(void);
 void cleanup(void);
-int fail;

 int main(int argc, char **argv)
 {
diff --git a/testcases/kernel/syscalls/writev/writev05.c b/testcases/kernel/syscalls/writev/writev05.c
index 910fa23b8..b9c25f8de 100644
--- a/testcases/kernel/syscalls/writev/writev05.c
+++ b/testcases/kernel/syscalls/writev/writev05.c
@@ -82,7 +82,6 @@ void sighandler(int);
 long l_seek(int, long, int);
 void setup(void);
 void cleanup(void);
-int fail;

 #if !defined(UCLINUX)

@@ -154,36 +153,24 @@ int main(int argc, char **argv)
 		 * or not.
 		 */
 //block1:
-		tst_resm(TINFO, "Enter block 1");
-		fail = 0;
-
 		l_seek(fd[0], 0, 0);
 		TEST(writev(fd[0], wr_iovec, 2));
 		if (TEST_RETURN < 0) {
 			if (TEST_ERRNO == EFAULT) {
-				tst_resm(TINFO, "Received EFAULT as expected");
+				tst_resm(TPASS, "Received EFAULT as expected");
 			} else {
 				tst_resm(TFAIL, "Expected EFAULT, got %d",
 					 TEST_ERRNO);
-				fail = 1;
 			}
 			l_seek(fd[0], K_1, 0);
 			if ((nbytes = read(fd[0], buf_list[0], CHUNK)) != 0) {
 				tst_resm(TFAIL, "Expected nbytes = 0, got "
 					 "%d", nbytes);
-				fail = 1;
 			}
 		} else {
 			tst_resm(TFAIL, "Error writev returned a positive "
 				 "value");
-			fail = 1;
-		}
-		if (fail) {
-			tst_resm(TINFO, "block 1 FAILED");
-		} else {
-			tst_resm(TINFO, "block 1 PASSED");
 		}
-		tst_resm(TINFO, "Exit block 1");
 	}
 	close(fd[0]);
 	close(fd[1]);
@@ -283,7 +270,6 @@ long l_seek(int fdesc, long offset, int whence)
 {
 	if (lseek(fdesc, offset, whence) < 0) {
 		tst_resm(TFAIL, "lseek Failed : errno = %d", errno);
-		fail = 1;
 	}
 	return 0;
 }
diff --git a/testcases/kernel/syscalls/writev/writev06.c b/testcases/kernel/syscalls/writev/writev06.c
index 6fe7206e8..d8a0feb67 100644
--- a/testcases/kernel/syscalls/writev/writev06.c
+++ b/testcases/kernel/syscalls/writev/writev06.c
@@ -73,7 +73,6 @@ int TST_TOTAL = 1;
 void sighandler(int);
 void setup(void);
 void cleanup(void);
-int fail;

 int main(int argc, char **argv)
 {
@@ -117,32 +116,20 @@ int main(int argc, char **argv)
 		 * so all bytes must be successfully written.
 		 */
 //block1:
-
-		tst_resm(TINFO, "Enter block 1");
-		fail = 0;
-
 		TEST(writev(fd[0], wr_iovec, 2));
 		if (TEST_RETURN >= 0) {
 			if (TEST_RETURN == 2) {
-				tst_resm(TINFO,
+				tst_resm(TPASS,
 					 "writev returned %d as expected", 2);
 			} else {
 				tst_resm(TFAIL, "Expected nbytes = %d, got "
 					 "%ld", 2, TEST_RETURN);
-				fail = 1;
 			}
 		} else {
 			tst_resm(TFAIL | TTERRNO,
 				 "Error writev return value = %ld",
 				 TEST_RETURN);
-			fail = 1;
-		}
-		if (fail) {
-			tst_resm(TINFO, "block 1 FAILED");
-		} else {
-			tst_resm(TINFO, "block 1 PASSED");
 		}
-		tst_resm(TINFO, "Exit block 1");
 	}
 	cleanup();
 	tst_exit();
--
2.17.1

