From: Nicolas Joly <njoly@pasteur.fr>
Date: Sat, 24 Oct 2015 12:36:12 +0200
Subject: [LTP] [PATCH] Cleanup syscalls/flock test messages
Message-ID: <20151024103612.GA29118@issan.sis.pasteur.fr>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

Please find a small patch that cleanup flock(2) syscalls tests to use
TTERRNO/TERRNO in messages instead of home made versions with
TEST_ERRNO/errno.

Regards.

-- 
Nicolas Joly

Cluster & Computing Group
Biology IT Center
Institut Pasteur, Paris.
-------------- next part --------------
commit ab1d7c59b56be8b3361ee8654b69ab55520c08da
Author: Nicolas Joly <njoly@pasteur.fr>
Date:   Sat Oct 24 11:52:19 2015 +0200

    syscalls/flock: Cleanup.
    
    Use TERRNO/TTERRNO in messages instead of home made versions.
    
    Signed-off-by: Nicolas Joly <njoly@pasteur.fr>

diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
index 742c9f4..a7ecba1 100644
--- a/testcases/kernel/syscalls/flock/flock01.c
+++ b/testcases/kernel/syscalls/flock/flock01.c
@@ -83,10 +83,10 @@ struct test_case_t {
 	int operation;
 	char *opt;
 } test_cases[] = {
-	{
-	LOCK_SH, "Shared Lock"}, {
-	LOCK_UN, "Unlock"}, {
-LOCK_EX, "Exclusive Lock"},};
+	{ LOCK_SH, "Shared Lock" },
+	{ LOCK_UN, "Unlock"},
+	{ LOCK_EX, "Exclusive Lock"}
+};
 
 int main(int argc, char **argv)
 {
@@ -108,17 +108,15 @@ int main(int argc, char **argv)
 
 			/* Testing system call */
 			TEST(flock(fd, test_cases[i].operation));
-
 			if (TEST_RETURN == -1) {
-				tst_resm(TFAIL,
-					 "flock() failed to get %s, error number=%d : %s",
-					 test_cases[i].opt, TEST_ERRNO,
-					 strerror(TEST_ERRNO));
+				tst_resm(TFAIL | TTERRNO,
+					 "flock() failed to get %s",
+					 test_cases[i].opt);
 				continue;	/*next loop for MTKERNEL  */
 			} else {
 				tst_resm(TPASS,
-					 "flock() succeeded with %s, returned error number=%d",
-					 test_cases[i].opt, TEST_ERRNO);
+					 "flock() succeeded with %s",
+					 test_cases[i].opt);
 			}
 
 		}
diff --git a/testcases/kernel/syscalls/flock/flock03.c b/testcases/kernel/syscalls/flock/flock03.c
index 1e519b7..e53b3b7 100644
--- a/testcases/kernel/syscalls/flock/flock03.c
+++ b/testcases/kernel/syscalls/flock/flock03.c
@@ -77,19 +77,18 @@ int main(int argc, char **argv)
 		fd = open(FILE_NAME, O_RDWR);
 
 		if (fd == -1)
-			tst_brkm(TFAIL, cleanup, "parent failed to open the"
-				 "file, errno %d", errno);
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "parent failed to open the file");
 
 		pid = FORK_OR_VFORK();
 
 		if (pid == -1)
-			tst_brkm(TFAIL, cleanup, "fork() failed, errno %d",
-				 errno);
+			tst_brkm(TFAIL | TERRNO, cleanup, "fork() failed");
 		if (pid == 0) {
 #ifdef UCLINUX
 			if (self_exec(argv[0], "ds", fd, FILE_NAME) < 0)
-				tst_brkm(TFAIL, cleanup, "self_exec failed, "
-					 "errno &d", errno);
+				tst_brkm(TFAIL | TERRNO, cleanup,
+					 "self_exec failed");
 #else
 			childfunc(fd);
 #endif
@@ -98,9 +97,8 @@ int main(int argc, char **argv)
 		TEST(flock(fd, LOCK_EX | LOCK_NB));
 
 		if (TEST_RETURN != 0)
-			tst_resm(TFAIL,
-				 "Parent: Initial attempt to flock() failed, "
-				 "errno %d", TEST_ERRNO);
+			tst_resm(TFAIL | TTERRNO,
+				 "Parent: Initial attempt to flock() failed");
 		else
 			tst_resm(TPASS,
 				 "Parent: Initial attempt to flock() passed");
diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
index 8b8ac43..d9c1d2d 100644
--- a/testcases/kernel/syscalls/flock/flock06.c
+++ b/testcases/kernel/syscalls/flock/flock06.c
@@ -93,20 +93,20 @@ int main(int argc, char **argv)
 
 		fd1 = open(filename, O_RDWR);
 		if (fd1 == -1)
-			tst_brkm(TFAIL, cleanup, "failed to open the"
-				 "file, errno %d", errno);
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "failed to open the file");
 
 		TEST(flock(fd1, LOCK_EX | LOCK_NB));
 		if (TEST_RETURN != 0)
-			tst_resm(TFAIL, "First attempt to flock() failed, "
-				 "errno %d", TEST_ERRNO);
+			tst_resm(TFAIL | TTERRNO,
+				 "First attempt to flock() failed");
 		else
 			tst_resm(TPASS, "First attempt to flock() passed");
 
 		fd2 = open(filename, O_RDWR);
 		if (fd2 == -1)
-			tst_brkm(TFAIL, cleanup, "failed to open the"
-				 "file, errno %d", errno);
+			tst_brkm(TFAIL | TERRNO, cleanup,
+				 "failed to open the file");
 
 		TEST(flock(fd2, LOCK_EX | LOCK_NB));
 		if (TEST_RETURN == -1)
@@ -116,8 +116,7 @@ int main(int argc, char **argv)
 
 		TEST(flock(fd1, LOCK_UN));
 		if (TEST_RETURN == -1)
-			tst_resm(TFAIL, "Failed to unlock fd1, errno %d",
-				 TEST_ERRNO);
+			tst_resm(TFAIL | TTERRNO, "Failed to unlock fd1");
 		else
 			tst_resm(TPASS, "Unlocked fd1");
 
