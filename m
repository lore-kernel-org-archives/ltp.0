From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri,  8 Dec 2017 14:07:37 +0000
Subject: [LTP] [PATCH v4 1/2] syscalls/mount03: Copy setuid_test to execute
	instead of 'TEST FILE'
Message-ID: <20171208140738.7985-1-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When testing the MS_NOSUID mount flag, mount03 forgets to copy
setuid_test into the new filesystem. Instead it writes 'TEST FILE' into
a new file and attempts to execute it with S_ISUID. This fails, but not
for the reasons ltp expects.

Fix this by copying the test helper binary instead.

While we're touching the test, also rename the helper to
mount03_setuid_test so as to follow current ltp convention.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
Changes since v3:
* Dropped the duplicate TST_RESOURCE_COPY()
* Moved setting SUID_MODE to setup()

 testcases/kernel/syscalls/mount/mount03.c          | 26 +++++++++++++---------
 .../mount/{setuid_test.c => mount03_setuid_test.c} |  0
 2 files changed, 15 insertions(+), 11 deletions(-)
 rename testcases/kernel/syscalls/mount/{setuid_test.c => mount03_setuid_test.c} (100%)

diff --git a/testcases/kernel/syscalls/mount/mount03.c b/testcases/kernel/syscalls/mount/mount03.c
index bf78c797f..6603fb77a 100644
--- a/testcases/kernel/syscalls/mount/mount03.c
+++ b/testcases/kernel/syscalls/mount/mount03.c
@@ -261,15 +261,7 @@ int test_rwflag(int i, int cnt)
 	case 5:
 		/* Validate MS_NOSUID flag of mount call */
 
-		snprintf(file, PATH_MAX, "%ssetuid_test", path_name);
-		SAFE_FILE_PRINTF(cleanup, file, "TEST FILE");
-
-		SAFE_STAT(cleanup, file, &file_stat);
-
-		if (file_stat.st_mode != SUID_MODE &&
-		    chmod(file, SUID_MODE) < 0)
-			tst_brkm(TBROK, cleanup,
-				 "setuid for setuid_test failed");
+		snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
 
 		pid = fork();
 		switch (pid) {
@@ -291,9 +283,8 @@ int test_rwflag(int i, int cnt)
 				/* reset the setup_uid */
 				if (status)
 					return 0;
-				else
-					return 1;
 			}
+			return 1;
 		}
 	case 6:
 		/* Validate MS_NOATIME flag of mount call */
@@ -346,6 +337,7 @@ int test_rwflag(int i, int cnt)
 static void setup(void)
 {
 	char path[PATH_MAX];
+	struct stat file_stat;
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
@@ -373,6 +365,18 @@ static void setup(void)
 	strncpy(path, path_name, PATH_MAX);
 	snprintf(path_name, PATH_MAX, "%s/%s/", path, mntpoint);
 
+	SAFE_MOUNT(cleanup, device, mntpoint, fs_type, 0, NULL);
+	TST_RESOURCE_COPY(cleanup, "mount03_setuid_test", path_name);
+
+	snprintf(file, PATH_MAX, "%smount03_setuid_test", path_name);
+	SAFE_STAT(cleanup, file, &file_stat);
+
+	if (file_stat.st_mode != SUID_MODE &&
+	    chmod(file, SUID_MODE) < 0)
+		tst_brkm(TBROK, cleanup,
+			 "setuid for setuid_test failed");
+	SAFE_UMOUNT(cleanup, mntpoint);
+
 	TEST_PAUSE;
 }
 
diff --git a/testcases/kernel/syscalls/mount/setuid_test.c b/testcases/kernel/syscalls/mount/mount03_setuid_test.c
similarity index 100%
rename from testcases/kernel/syscalls/mount/setuid_test.c
rename to testcases/kernel/syscalls/mount/mount03_setuid_test.c
-- 
2.15.0

