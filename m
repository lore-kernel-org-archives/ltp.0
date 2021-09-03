From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:45 +0200
Subject: [LTP] [PATCH 4/7] syscalls/kill05: Use any two unprivileged users
In-Reply-To: <20210903154848.18705-1-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
Message-ID: <20210903154848.18705-5-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Usernames such as "bin" may not exist on some systems. Find and use any two
unprivileged user IDs for the test instead of specific named users.

Includes minor code style cleanup in wait_for_flag().

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/kill/kill05.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/kill/kill05.c b/testcases/kernel/syscalls/kill/kill05.c
index e694126f6..1dfdda58f 100644
--- a/testcases/kernel/syscalls/kill/kill05.c
+++ b/testcases/kernel/syscalls/kill/kill05.c
@@ -17,15 +17,18 @@
  *	This test must be run as root.
  */
 
+#define _XOPEN_SOURCE 500
 #include <sys/wait.h>
+#include <sys/types.h>
 #include <pwd.h>
 #include <stdlib.h>
 #include "tst_test.h"
 #include "libnewipc.h"
 #include "tst_safe_sysv_ipc.h"
 #include "tst_safe_macros.h"
+#include "tst_uid.h"
 
-static uid_t nobody_uid, bin_uid;
+static uid_t test_users[2];
 static int *flag;
 static int shm_id = -1;
 static key_t shm_key;
@@ -35,8 +38,8 @@ static void wait_for_flag(int value)
 	while (1) {
 		if (*flag == value)
 			break;
-		else
-			usleep(100);
+
+		usleep(100);
 	}
 }
 
@@ -47,14 +50,14 @@ static void do_master_child(void)
 	*flag = 0;
 	pid1 = SAFE_FORK();
 	if (pid1 == 0) {
-		SAFE_SETREUID(nobody_uid, nobody_uid);
+		SAFE_SETREUID(test_users[0], test_users[0]);
 		*flag = 1;
 		wait_for_flag(2);
 
 		exit(0);
 	}
 
-	SAFE_SETREUID(bin_uid, bin_uid);
+	SAFE_SETREUID(test_users[1], test_users[1]);
 	wait_for_flag(1);
 	TEST(kill(pid1, SIGKILL));
 
@@ -85,17 +88,11 @@ static void verify_kill(void)
 
 static void setup(void)
 {
-	struct passwd *pw;
-
 	shm_key = GETIPCKEY();
 	shm_id = SAFE_SHMGET(shm_key, getpagesize(), 0666 | IPC_CREAT);
 	flag = SAFE_SHMAT(shm_id, 0, 0);
-
-	pw = SAFE_GETPWNAM("nobody");
-	nobody_uid = pw->pw_uid;
-
-	pw = SAFE_GETPWNAM("bin");
-	bin_uid = pw->pw_uid;
+	tst_get_uids(2, test_users);
+	endpwent();
 }
 
 static void cleanup(void)
-- 
2.33.0

