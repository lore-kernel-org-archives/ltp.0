From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:46 +0200
Subject: [LTP] [PATCH 5/7] syscalls/mkdir04: Simplify test and use any
 existing users
In-Reply-To: <20210903154848.18705-1-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
Message-ID: <20210903154848.18705-6-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

mkdir04 does not need to fork() in setup(). Usernames such as "bin" may not
exist on some systems. Find and use any two unprivileged users instead of
specific named users.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/mkdir/mkdir04.c | 30 ++++++-----------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/mkdir/mkdir04.c b/testcases/kernel/syscalls/mkdir/mkdir04.c
index 87512a4be..3880611d7 100644
--- a/testcases/kernel/syscalls/mkdir/mkdir04.c
+++ b/testcases/kernel/syscalls/mkdir/mkdir04.c
@@ -7,20 +7,16 @@
  * user with restrictive permissions and that the errno is set to EACCESS.
  */
 
+#define _XOPEN_SOURCE 500
 #include <errno.h>
-#include <sys/stat.h>
 #include <sys/types.h>
 #include <pwd.h>
-#include <sys/wait.h>
-#include <unistd.h>
-#include <stdlib.h>
 #include "tst_test.h"
+#include "tst_uid.h"
 
 #define TESTDIR	 "testdir"
 #define TESTSUBDIR "testdir/testdir"
 
-static uid_t nobody_uid, bin_uid;
-
 static void verify_mkdir(void)
 {
 	if (mkdir(TESTSUBDIR, 0777) != -1) {
@@ -39,24 +35,15 @@ static void verify_mkdir(void)
 
 static void setup(void)
 {
-	struct passwd *pw;
-	pid_t pid;
-
-	pw = SAFE_GETPWNAM("nobody");
-	nobody_uid = pw->pw_uid;
-	pw = SAFE_GETPWNAM("bin");
-	bin_uid = pw->pw_uid;
+	uid_t test_users[2];
 
-	pid = SAFE_FORK();
-	if (pid == 0) {
-		SAFE_SETREUID(nobody_uid, nobody_uid);
-		SAFE_MKDIR(TESTDIR, 0700);
-		exit(0);
-	}
+	tst_get_uids(2, test_users);
+	endpwent();
 
-	tst_reap_children();
+	SAFE_MKDIR(TESTDIR, 0700);
+	SAFE_CHOWN(TESTDIR, test_users[0], getgid());
 
-	SAFE_SETREUID(bin_uid, bin_uid);
+	SAFE_SETREUID(test_users[1], test_users[1]);
 }
 
 static struct tst_test test = {
@@ -64,5 +51,4 @@ static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.setup = setup,
-	.forks_child = 1,
 };
-- 
2.33.0

