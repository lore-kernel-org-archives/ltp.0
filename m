From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:50 +0200
Subject: [LTP] [COMMITTED] [PATCH 17/40] Make use of SAFE_CHOWN()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-17-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_tmpdir.c                                | 6 +-----
 testcases/kernel/syscalls/chmod/chmod05.c       | 4 +---
 testcases/kernel/syscalls/chmod/chmod07.c       | 3 +--
 testcases/kernel/syscalls/fchmod/fchmod02.c     | 4 +---
 testcases/kernel/syscalls/fchmod/fchmod05.c     | 4 +---
 testcases/kernel/syscalls/mknod/mknod02.c       | 4 +---
 testcases/kernel/syscalls/mknod/mknod03.c       | 4 +---
 testcases/kernel/syscalls/mknod/mknod04.c       | 4 +---
 testcases/kernel/syscalls/mknod/mknod05.c       | 4 +---
 testcases/kernel/syscalls/mknod/mknod08.c       | 4 +---
 testcases/kernel/syscalls/readlink/readlink04.c | 3 +--
 11 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/lib/tst_tmpdir.c b/lib/tst_tmpdir.c
index 5cd554361..09b7b6e22 100644
--- a/lib/tst_tmpdir.c
+++ b/lib/tst_tmpdir.c
@@ -271,11 +271,7 @@ void tst_tmpdir(void)
 		return;
 	}
 
-	if (chown(TESTDIR, -1, getgid()) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "chown(%s, -1, %d) failed", TESTDIR, getgid());
-		return;
-	}
+	SAFE_CHOWN(NULL, TESTDIR, -1, getgid());
 
 	SAFE_CHMOD(NULL, TESTDIR, DIR_MODE);
 
diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 028aa5d6d..3cf4db5d0 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -202,9 +202,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "setgroups to nobody's gid failed");
 
-	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "chowning testdir to nobody:bin failed");
+	SAFE_CHOWN(cleanup, TESTDIR, nobody_u->pw_uid, bin_group->gr_gid);
 
 	/* change to nobody:nobody */
 	if (setegid(nobody_u->pw_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 340bdba3e..42272414a 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -184,8 +184,7 @@ void setup(void)
 			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
 			 TESTFILE, FILE_MODE);
 	SAFE_CLOSE(cleanup, fd);
-	if (chown(TESTFILE, user1_uid, group1_gid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "chown(%s) failed", TESTFILE);
+	SAFE_CHOWN(cleanup, TESTFILE, user1_uid, group1_gid);
 
 	SAFE_SETGID(cleanup, group1_gid);
 }
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index 39519c872..ea2bdb4b8 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -193,9 +193,7 @@ void setup(void)
 			 TESTFILE, FILE_MODE, errno, strerror(errno));
 	}
 
-	if (chown(TESTFILE, user1_uid, group1_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", TESTFILE);
-	}
+	SAFE_CHOWN(cleanup, TESTFILE, user1_uid, group1_gid);
 
 	/* Set the effective gid of the process to that of user */
 	SAFE_SETGID(cleanup, group1_gid);
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 290e2560a..0ab2f935d 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -195,9 +195,7 @@ void setup(void)
 			 "Couldn't change supplementary group Id: %s",
 			 strerror(errno));
 
-	if (chown(TESTDIR, nobody_u->pw_uid, bin_group->gr_gid) == -1)
-		tst_brkm(TBROK, cleanup, "Couldn't change owner of testdir: %s",
-			 strerror(errno));
+	SAFE_CHOWN(cleanup, TESTDIR, nobody_u->pw_uid, bin_group->gr_gid);
 
 	/* change to nobody:nobody */
 	if (setegid(nobody_u->pw_gid) == -1 || seteuid(nobody_u->pw_uid) == -1)
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index d1b166cdb..7ac8db5ef 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -238,9 +238,7 @@ void setup(void)
 	 * user and the test process.
 	 */
 	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
 
 	/*
 	 * Verify that test directory created with expected permission modes
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 919327a65..8fd58a732 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -235,9 +235,7 @@ void setup(void)
 	 * user and the test process.
 	 */
 	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
 	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_SGID);
 
 	/*
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 205bdcb36..9615c15a6 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -237,9 +237,7 @@ void setup(void)
 	 * user and the test process.
 	 */
 	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
 	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_SGID);
 
 	/*
diff --git a/testcases/kernel/syscalls/mknod/mknod05.c b/testcases/kernel/syscalls/mknod/mknod05.c
index a7a5ea8ee..57f097b9e 100644
--- a/testcases/kernel/syscalls/mknod/mknod05.c
+++ b/testcases/kernel/syscalls/mknod/mknod05.c
@@ -229,9 +229,7 @@ void setup(void)
 	 * user and the test process.
 	 */
 	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
 	SAFE_CHMOD(cleanup, DIR_TEMP, MODE_SGID);
 
 	/*
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index 97d4fd0b6..39c024833 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -233,9 +233,7 @@ void setup(void)
 	 * user and the test process.
 	 */
 	SAFE_MKDIR(cleanup, DIR_TEMP, MODE_RWX);
-	if (chown(DIR_TEMP, user1_uid, group2_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "chown(2) of %s failed", DIR_TEMP);
-	}
+	SAFE_CHOWN(cleanup, DIR_TEMP, user1_uid, group2_gid);
 
 	/*
 	 * Verify that test directory created with expected permission modes
diff --git a/testcases/kernel/syscalls/readlink/readlink04.c b/testcases/kernel/syscalls/readlink/readlink04.c
index 8e1582142..9c6c58914 100644
--- a/testcases/kernel/syscalls/readlink/readlink04.c
+++ b/testcases/kernel/syscalls/readlink/readlink04.c
@@ -123,8 +123,7 @@ static void setup(void)
 		tst_brkm(TBROK, cleanup, "getpwname() failed");
 
 	/* make the tmp directory belong to bin */
-	if (chown(tmp_dir, pwent->pw_uid, pwent->pw_gid) == -1)
-		tst_brkm(TBROK, cleanup, "chown() failed");
+	SAFE_CHOWN(cleanup, tmp_dir, pwent->pw_uid, pwent->pw_gid);
 
 	if (chmod(tmp_dir, 0711) != 0)
 		tst_brkm(TBROK|TERRNO, cleanup, "chmod(%s) failed", tmp_dir);
-- 
2.13.5

