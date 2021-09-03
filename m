From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:42 +0200
Subject: [LTP] [PATCH 1/7] chmod05,
 fchmod05: Use free GID instead of "bin" group
In-Reply-To: <20210903154848.18705-1-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
Message-ID: <20210903154848.18705-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The bin user group does not exist on some systems which will cause test
failure. Set test directory ownership to any unused GID instead.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/chmod/chmod05.c   | 7 ++++---
 testcases/kernel/syscalls/fchmod/fchmod05.c | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 6a6a0ae21..f5b9d51e7 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -37,6 +37,7 @@
 #include <pwd.h>
 
 #include "tst_test.h"
+#include "tst_uid.h"
 
 #define MODE_RWX	(mode_t)(S_IRWXU | S_IRWXG | S_IRWXO)
 #define DIR_MODE	(mode_t)(S_ISVTX | S_ISGID | S_IFDIR)
@@ -69,10 +70,10 @@ static void test_chmod(void)
 static void setup(void)
 {
 	struct passwd *nobody_u;
-	struct group *bin_gr;
+	gid_t free_gid;
 
 	nobody_u = SAFE_GETPWNAM("nobody");
-	bin_gr = SAFE_GETGRNAM("bin");
+	free_gid = tst_get_free_gid(nobody_u->pw_gid);
 
 	/*
 	 * Create a test directory under temporary directory with specified
@@ -83,7 +84,7 @@ static void setup(void)
 	if (setgroups(1, &nobody_u->pw_gid) == -1)
 		tst_brk(TBROK | TERRNO, "setgroups to nobody's gid failed");
 
-	SAFE_CHOWN(TESTDIR, nobody_u->pw_uid, bin_gr->gr_gid);
+	SAFE_CHOWN(TESTDIR, nobody_u->pw_uid, free_gid);
 
 	/* change to nobody:nobody */
 	SAFE_SETEGID(nobody_u->pw_gid);
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index f75b9bf36..0c731d601 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -20,6 +20,7 @@
 #include <errno.h>
 
 #include "tst_test.h"
+#include "tst_uid.h"
 #include "fchmod.h"
 
 #define PERMS_DIR	043777
@@ -50,10 +51,10 @@ static void verify_fchmod(void)
 static void setup(void)
 {
 	struct passwd *ltpuser;
-	struct group *ltpgroup;
+	gid_t free_gid;
 
 	ltpuser = SAFE_GETPWNAM("nobody");
-	ltpgroup = SAFE_GETGRNAM("bin");
+	free_gid = tst_get_free_gid(ltpuser->pw_gid);
 
 	SAFE_MKDIR(TESTDIR, DIR_MODE);
 
@@ -62,7 +63,7 @@ static void setup(void)
 			tst_strerrno(TST_ERR));
 	}
 
-	SAFE_CHOWN(TESTDIR, ltpuser->pw_uid, ltpgroup->gr_gid);
+	SAFE_CHOWN(TESTDIR, ltpuser->pw_uid, free_gid);
 
 	SAFE_SETEGID(ltpuser->pw_gid);
 	SAFE_SETEUID(ltpuser->pw_uid);
-- 
2.33.0

