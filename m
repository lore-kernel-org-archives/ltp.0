From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 18 Mar 2016 16:57:08 +0300
Subject: [LTP] [PATCH] syscalls: close open files in cleanup
Message-ID: <1458309428-16300-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

NFS creates special .nfs* files when test file was removed and
left open. In that case, tst_rmdir() fails to remove test dirs.

Close left open files in cleanup and replace some of safe_open()
calls with safe_file_printf() ones for test files which fd won't
be used in a test.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/kernel/syscalls/faccessat/faccessat01.c |    8 +++++---
 testcases/kernel/syscalls/fchmodat/fchmodat01.c   |    7 +++++--
 testcases/kernel/syscalls/fstatat/fstatat01.c     |    8 +++++---
 testcases/kernel/syscalls/futimesat/futimesat01.c |    7 +++++--
 testcases/kernel/syscalls/unlinkat/unlinkat01.c   |    8 +++++---
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/faccessat/faccessat01.c b/testcases/kernel/syscalls/faccessat/faccessat01.c
index 72827ad..6f276fc 100644
--- a/testcases/kernel/syscalls/faccessat/faccessat01.c
+++ b/testcases/kernel/syscalls/faccessat/faccessat01.c
@@ -130,9 +130,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[0];
 
-
-	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
-	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
 
 	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
@@ -148,5 +147,8 @@ void setup(void)
 
 void cleanup(void)
 {
+	close(fds[0]);
+	close(fds[2]);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/fchmodat/fchmodat01.c b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
index ea08665..d4f7093 100644
--- a/testcases/kernel/syscalls/fchmodat/fchmodat01.c
+++ b/testcases/kernel/syscalls/fchmodat/fchmodat01.c
@@ -128,8 +128,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[0];
 
-	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
-	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
 
 	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 	fds[3] = 100;
@@ -144,5 +144,8 @@ void setup(void)
 
 void cleanup(void)
 {
+	close(fds[0]);
+	close(fds[2]);
+
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/fstatat/fstatat01.c b/testcases/kernel/syscalls/fstatat/fstatat01.c
index 8b279fa..c210968 100644
--- a/testcases/kernel/syscalls/fstatat/fstatat01.c
+++ b/testcases/kernel/syscalls/fstatat/fstatat01.c
@@ -129,8 +129,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[0];
 
-	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
-	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
 
 	fds[2] =  SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
@@ -146,7 +146,9 @@ void setup(void)
 
 void cleanup(void)
 {
+	close(fds[0]);
+	close(fds[2]);
+
 	free(testfile3);
 	tst_rmdir();
 }
-
diff --git a/testcases/kernel/syscalls/futimesat/futimesat01.c b/testcases/kernel/syscalls/futimesat/futimesat01.c
index 5c16dd8..f5e90b8 100644
--- a/testcases/kernel/syscalls/futimesat/futimesat01.c
+++ b/testcases/kernel/syscalls/futimesat/futimesat01.c
@@ -112,8 +112,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[0];
 
-	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
-	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
 
 	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
@@ -128,6 +128,9 @@ void setup(void)
 
 void cleanup(void)
 {
+	close(fds[0]);
+	close(fds[2]);
+
 	free(testfile3);
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/unlinkat/unlinkat01.c b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
index 47cba25..0abede6 100644
--- a/testcases/kernel/syscalls/unlinkat/unlinkat01.c
+++ b/testcases/kernel/syscalls/unlinkat/unlinkat01.c
@@ -119,9 +119,8 @@ void setup(void)
 	fds[0] = SAFE_OPEN(cleanup, pathname, O_DIRECTORY);
 	fds[1] = fds[4] = fds[6] = fds[0];
 
-	SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0600);
-
-	SAFE_OPEN(cleanup, testfile2, O_CREAT | O_RDWR, 0600);
+	SAFE_FILE_PRINTF(cleanup, testfile, testfile);
+	SAFE_FILE_PRINTF(cleanup, testfile2, testfile2);
 
 	fds[2] = SAFE_OPEN(cleanup, testfile3, O_CREAT | O_RDWR, 0600);
 
@@ -138,6 +137,9 @@ void setup(void)
 
 void cleanup(void)
 {
+	close(fds[0]);
+	close(fds[2]);
+
 	free(testfile3);
 	tst_rmdir();
 }
-- 
1.7.1

