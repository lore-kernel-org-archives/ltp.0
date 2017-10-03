From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:42 +0200
Subject: [LTP] [COMMITTED] [PATCH 09/40] Make use of SAFE_SETGID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-9-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chmod/chmod07.c       | 4 +---
 testcases/kernel/syscalls/fchmod/fchmod02.c     | 4 +---
 testcases/kernel/syscalls/mknod/mknod02.c       | 5 +----
 testcases/kernel/syscalls/mknod/mknod03.c       | 5 +----
 testcases/kernel/syscalls/mknod/mknod04.c       | 5 +----
 testcases/kernel/syscalls/mknod/mknod08.c       | 5 +----
 testcases/kernel/syscalls/setregid/setregid02.c | 7 ++-----
 7 files changed, 8 insertions(+), 27 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 1cfec3bd0..340bdba3e 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -187,9 +187,7 @@ void setup(void)
 	if (chown(TESTFILE, user1_uid, group1_gid) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "chown(%s) failed", TESTFILE);
 
-	if (setgid(group1_gid) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "setgid(%d) failed",
-			 group1_gid);
+	SAFE_SETGID(cleanup, group1_gid);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index 207bbab8c..39519c872 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -198,9 +198,7 @@ void setup(void)
 	}
 
 	/* Set the effective gid of the process to that of user */
-	if (setgid(group1_gid) < 0) {
-		tst_brkm(TBROK, cleanup, "setgid(2) to %d failed", group1_gid);
-	}
+	SAFE_SETGID(cleanup, group1_gid);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/mknod/mknod02.c b/testcases/kernel/syscalls/mknod/mknod02.c
index a0b0937a0..d1b166cdb 100644
--- a/testcases/kernel/syscalls/mknod/mknod02.c
+++ b/testcases/kernel/syscalls/mknod/mknod02.c
@@ -265,10 +265,7 @@ void setup(void)
 	 * Set the effective group id and user id of the test process
 	 * to that of guest user.
 	 */
-	if (setgid(group1_gid) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to set process gid to that of ltpuser");
-	}
+	SAFE_SETGID(cleanup, group1_gid);
 	if (setreuid(-1, user1_uid) < 0) {
 		tst_brkm(TBROK, cleanup,
 			 "Unable to set process uid to that of ltp user");
diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
index 3cf0af398..4541b93e5 100644
--- a/testcases/kernel/syscalls/mknod/mknod03.c
+++ b/testcases/kernel/syscalls/mknod/mknod03.c
@@ -265,10 +265,7 @@ void setup(void)
 	 * Set the effective group id and user id of the test process
 	 * to that of guest user (nobody)
 	 */
-	if (setgid(group1_gid) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to set process gid to that of ltp user");
-	}
+	SAFE_SETGID(cleanup, group1_gid);
 	if (setreuid(-1, user1_uid) < 0) {
 		tst_brkm(TBROK, cleanup,
 			 "Unable to set process uid to that of ltp user");
diff --git a/testcases/kernel/syscalls/mknod/mknod04.c b/testcases/kernel/syscalls/mknod/mknod04.c
index 46273bb3f..8cbc5401b 100644
--- a/testcases/kernel/syscalls/mknod/mknod04.c
+++ b/testcases/kernel/syscalls/mknod/mknod04.c
@@ -267,10 +267,7 @@ void setup(void)
 	 * Set the effective group id and user id of the test process
 	 * to that of guest user (nobody)
 	 */
-	if (setgid(group1_gid) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to set process gid to that of ltp user");
-	}
+	SAFE_SETGID(cleanup, group1_gid);
 	if (setreuid(-1, user1_uid) < 0) {
 		tst_brkm(TBROK, cleanup,
 			 "Unable to set process uid to that of ltp user");
diff --git a/testcases/kernel/syscalls/mknod/mknod08.c b/testcases/kernel/syscalls/mknod/mknod08.c
index 76bb27f17..97d4fd0b6 100644
--- a/testcases/kernel/syscalls/mknod/mknod08.c
+++ b/testcases/kernel/syscalls/mknod/mknod08.c
@@ -260,10 +260,7 @@ void setup(void)
 	 * Set the effective group id and user id of the test process
 	 * to that of guest user.
 	 */
-	if (setgid(group1_gid) < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to set process gid to that of ltp user");
-	}
+	SAFE_SETGID(cleanup, group1_gid);
 	if (setreuid(-1, user1_uid) < 0) {
 		tst_brkm(TBROK, cleanup,
 			 "Unable to set process uid to that of ltp user");
diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 9359fcb0a..0eb3c408c 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -32,6 +32,7 @@
 #include <string.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 TCID_DEFINE(setregid02);
@@ -135,11 +136,7 @@ static void setup(void)
 	if (ltpuser == NULL)
 		tst_brkm(TBROK, NULL, "getpwnam(\"nobody\") failed");
 
-	if (setgid(ltpuser->pw_gid) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL,
-			 "setgid failed to set the effective gid to %d",
-			 ltpuser->pw_gid);
-	}
+	SAFE_SETGID(NULL, ltpuser->pw_gid);
 	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "setuid failed to to set the effective uid to %d",
-- 
2.13.5

