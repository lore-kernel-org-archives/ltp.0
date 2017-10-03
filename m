From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:37 +0200
Subject: [LTP] [COMMITTED] [PATCH 04/40] Make use of SAFE_RMDIR()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c | 5 +----
 testcases/kernel/syscalls/creat/creat08.c                | 9 +++------
 testcases/kernel/syscalls/getdents/getdents02.c          | 5 +----
 testcases/kernel/syscalls/mkdir/mkdir05.c                | 5 ++---
 testcases/kernel/syscalls/mkdir/mkdir08.c                | 7 ++-----
 testcases/kernel/syscalls/rename/rename03.c              | 5 +----
 testcases/kernel/syscalls/rename/rename09.c              | 8 ++------
 7 files changed, 12 insertions(+), 32 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index a7c131f49..a0e28aa30 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -237,10 +237,7 @@ static void cleanup(void)
 	for (i = 0; i < cgrp_opt_num; ++i) {
 		if (cgrp_opt[i].subdir) {
 			SAFE_CHDIR(NULL, cgrp_opt[i].dir);
-			if (rmdir(subdir_name) == -1) {
-				tst_brkm(TBROK | TERRNO, NULL,
-					"Can't remove dir");
-			}
+			SAFE_RMDIR(NULL, subdir_name);
 			SAFE_CHDIR(NULL, "..");
 		}
 		if (cgrp_opt[i].mounted) {
diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index b95404c42..5f564273e 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -52,6 +52,7 @@
 #include <grp.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "creat08";
 int TST_TOTAL = 1;
@@ -441,9 +442,7 @@ static void cleanup(void)
 	if (unlink(nosetgid_A) == -1) {
 		tst_resm(TBROK, "unlink %s failed", nosetgid_A);
 	}
-	if (rmdir(DIR_A) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "rmdir %s failed", DIR_A);
-	}
+	SAFE_RMDIR(NULL, DIR_A);
 	if (unlink(setgid_B) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "unlink %s failed", setgid_B);
 	}
@@ -454,9 +453,7 @@ static void cleanup(void)
 	if (unlink(nosetgid_B) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL, "unlink %s failed", nosetgid_B);
 	}
-	if (rmdir(DIR_B) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "rmdir %s failed", DIR_B);
-	}
+	SAFE_RMDIR(NULL, DIR_B);
 
 	tst_rmdir();
 }
diff --git a/testcases/kernel/syscalls/getdents/getdents02.c b/testcases/kernel/syscalls/getdents/getdents02.c
index 2c019e5db..7b023c53f 100644
--- a/testcases/kernel/syscalls/getdents/getdents02.c
+++ b/testcases/kernel/syscalls/getdents/getdents02.c
@@ -179,10 +179,7 @@ static void test_enoent(void)
 	SAFE_MKDIR(cleanup, TEST_DIR, DIR_MODE);
 
 	fd = SAFE_OPEN(cleanup, TEST_DIR, O_DIRECTORY);
-	if (rmdir(TEST_DIR) == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "rmdir(%s) failed", TEST_DIR);
-	}
+	SAFE_RMDIR(cleanup, TEST_DIR);
 
 	if (longsyscall)
 		getdents64(fd, &dir64, sizeof(dir64));
diff --git a/testcases/kernel/syscalls/mkdir/mkdir05.c b/testcases/kernel/syscalls/mkdir/mkdir05.c
index 6397ba56e..ee52771c8 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir05.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir05.c
@@ -31,6 +31,7 @@
 #include <unistd.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -102,9 +103,7 @@ int main(int ac, char **av)
 		tst_resm(TPASS, "mkdir() functionality is correct");
 
 		/* clean up things in case we are looping */
-		if (rmdir(tstdir1) == -1) {
-			tst_brkm(TBROK, cleanup, "could not remove directory");
-		}
+		SAFE_RMDIR(cleanup, tstdir1);
 
 	}
 
diff --git a/testcases/kernel/syscalls/mkdir/mkdir08.c b/testcases/kernel/syscalls/mkdir/mkdir08.c
index 752763a47..ead218a63 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir08.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir08.c
@@ -117,6 +117,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -159,11 +160,7 @@ int main(int ac, char **av)
 		} else {
 			tst_resm(TPASS, "mkdir(%s) returned %ld", fname,
 				 TEST_RETURN);
-			if (rmdir(fname) == -1) {
-				tst_brkm(TBROK, cleanup,
-					 "rmdir(%s) Failed, errno=%d : %s",
-					 fname, errno, strerror(errno));
-			}
+			SAFE_RMDIR(cleanup, fname);
 		}
 
 	}
diff --git a/testcases/kernel/syscalls/rename/rename03.c b/testcases/kernel/syscalls/rename/rename03.c
index b15e8fe95..4d4f78d60 100644
--- a/testcases/kernel/syscalls/rename/rename03.c
+++ b/testcases/kernel/syscalls/rename/rename03.c
@@ -169,10 +169,7 @@ int main(int ac, char **av)
 		}
 
 		/* remove the new directory */
-		if (rmdir(mdir) == -1) {
-			tst_brkm(TBROK, cleanup, "Couldn't remove directory %s",
-				 mdir);
-		}
+		SAFE_RMDIR(cleanup, mdir);
 	}
 
 	cleanup();
diff --git a/testcases/kernel/syscalls/rename/rename09.c b/testcases/kernel/syscalls/rename/rename09.c
index f1a8a20e7..15e607981 100644
--- a/testcases/kernel/syscalls/rename/rename09.c
+++ b/testcases/kernel/syscalls/rename/rename09.c
@@ -201,12 +201,8 @@ int main(int ac, char **av)
 			if (unlink(mname) == -1) {
 				tst_brkm(TBROK, cleanup, "unlink() #2 failed");
 			}
-			if (rmdir(fdir) == -1) {
-				tst_brkm(TBROK, cleanup, "rmdir() #1 failed");
-			}
-			if (rmdir(mdir) == -1) {
-				tst_brkm(TBROK, cleanup, "rmdir() #2 failed");
-			}
+			SAFE_RMDIR(cleanup, fdir);
+			SAFE_RMDIR(cleanup, mdir);
 		} else {
 			/* parent - let the second child carry on */
 			waitpid(pid1, &status, 0);
-- 
2.13.5

