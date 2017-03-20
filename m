From: maxin.john@gmail.com <maxin.john@gmail.com>
Date: Mon, 20 Mar 2017 16:32:37 +0200
Subject: [LTP] [PATCH] setxattr: prefer not to run tests in tmpfs
Message-ID: <1490020357-8073-1-git-send-email-maxin.john@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Maxin B. John" <maxin.john@gmail.com>

1. Even though tmpfs supports extended attributes, running these tests
   on other filesystems will be relatively better for testing xattrs.

2. setxattr01 doesn't need root privileges to run

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
---
 testcases/kernel/syscalls/setxattr/setxattr01.c |  7 ++-----
 testcases/kernel/syscalls/setxattr/setxattr02.c | 10 +++++++---
 testcases/kernel/syscalls/setxattr/setxattr03.c |  5 ++---
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/kernel/syscalls/setxattr/setxattr01.c b/testcases/kernel/syscalls/setxattr/setxattr01.c
index 478f994..e4f35dd 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr01.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr01.c
@@ -179,10 +179,6 @@ static void setup(void)
 {
 	int fd;
 
-	tst_require_root();
-
-	tst_tmpdir();
-
 	/* Test for xattr support */
 	fd = creat("testfile", 0644);
 	if (fd == -1)
@@ -219,7 +215,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	unlink("testfile");
+	unlink("setxattr01testfile");
 }
 #else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
diff --git a/testcases/kernel/syscalls/setxattr/setxattr02.c b/testcases/kernel/syscalls/setxattr/setxattr02.c
index 73c464c..286f483 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr02.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr02.c
@@ -182,8 +182,6 @@ static void setup(void)
 
 	tst_require_root();
 
-	tst_tmpdir();
-
 	/* Test for xattr support */
 	fd = creat("testfile", 0644);
 	if (fd == -1)
@@ -232,7 +230,13 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	tst_rmdir();
+	unlink(FILENAME);
+	unlink(SYMLINK);
+	unlink(FIFO);
+	unlink(CHR);
+	unlink(BLK);
+	unlink(SOCK);
+	rmdir(DIRNAME);
 }
 #else /* HAVE_SYS_XATTR_H */
 int main(int argc, char *argv[])
diff --git a/testcases/kernel/syscalls/setxattr/setxattr03.c b/testcases/kernel/syscalls/setxattr/setxattr03.c
index c09211e..ce71c67 100644
--- a/testcases/kernel/syscalls/setxattr/setxattr03.c
+++ b/testcases/kernel/syscalls/setxattr/setxattr03.c
@@ -164,8 +164,6 @@ static void setup(void)
 
 	tst_require_root();
 
-	tst_tmpdir();
-
 	/* Test for xattr support */
 	fd = creat("testfile", 0644);
 	if (fd == -1)
@@ -208,7 +206,8 @@ static void cleanup(void)
 	close(immu_fd);
 	close(append_fd);
 
-	tst_rmdir();
+	unlink(IMMU_FILE);
+	unlink(APPEND_FILE);
 }
 #else
 int main(void)
-- 
2.4.0

