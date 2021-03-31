From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 31 Mar 2021 12:03:40 +0200
Subject: [LTP] [PATCH 1/1] chdir01: Skip nobody when problems on umask 0070
Message-ID: <20210331100340.28034-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

FAT and exFAT from Samsung have EACCES for nobody on umask 0070.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/chdir/chdir01.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/chdir/chdir01.c b/testcases/kernel/syscalls/chdir/chdir01.c
index 23cd455d6..57b92f3f8 100644
--- a/testcases/kernel/syscalls/chdir/chdir01.c
+++ b/testcases/kernel/syscalls/chdir/chdir01.c
@@ -27,7 +27,7 @@
 #define LINK_NAME2 "symloop2"
 
 static char *workdir;
-static int skip_symlinks, skip_blocked;
+static int skip_symlinks, skip_blocked, skip_umask;
 static struct passwd *ltpuser;
 
 static struct test_case {
@@ -57,6 +57,11 @@ static void setup(void)
 	SAFE_CHDIR(workdir);
 
 	mode_t sys_umask = umask(0);
+
+	/* FAT and exFAT from Samsung have EACCES for nobody on umask 0070 */
+	if (sys_umask & S_IRWXG)
+		skip_umask = 1;
+
 	SAFE_MKDIR(DIR_NAME, 0755);
 	SAFE_MKDIR(BLOCKED_NAME, 0644);
 	umask(sys_umask);
@@ -118,8 +123,7 @@ static void run(unsigned int n)
 	check_result("root", tc->name, tc->root_ret, tc->root_err);
 
 	if (tc->nobody_err == EACCES && skip_blocked) {
-		tst_res(TCONF, "Skipping unprivileged permission test, "
-			"FS mangles dir mode");
+		tst_res(TCONF, "Skipping unprivileged permission test, FS mangles dir mode");
 		return;
 	}
 
@@ -127,6 +131,12 @@ static void run(unsigned int n)
 	SAFE_SETEUID(ltpuser->pw_uid);
 	TEST(chdir(tc->name));
 	SAFE_SETEUID(0);
+
+	if (skip_blocked && skip_umask && TST_ERR == EACCES) {
+		tst_res(TCONF, "Skipping unprivileged permission test, FS mangles dir mode on umask");
+		return;
+	}
+
 	check_result("nobody", tc->name, tc->nobody_ret, tc->nobody_err);
 }
 
-- 
2.30.2

