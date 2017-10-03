From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:44 +0200
Subject: [LTP] [COMMITTED] [PATCH 11/40] Make use of SAFE_GETRESGID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-11-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/setresgid/setresgid01.c | 6 ++----
 testcases/kernel/syscalls/setresgid/setresgid02.c | 6 ++----
 testcases/kernel/syscalls/setresgid/setresgid03.c | 5 +----
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/setresgid/setresgid01.c b/testcases/kernel/syscalls/setresgid/setresgid01.c
index 173ee35c3..d66c42261 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid01.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid01.c
@@ -75,6 +75,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define EXP_RET_VAL	0
@@ -163,10 +164,7 @@ static int test_functionality(uid_t exp_rgid, uid_t exp_egid, uid_t exp_sgid)
 	uid_t cur_rgid, cur_egid, cur_sgid;
 
 	/* Get current real, effective and saved group id's */
-	if (getresgid(&cur_rgid, &cur_egid, &cur_sgid) == -1) {
-		tst_brkm(TBROK, cleanup, "getresgid() failed");
-
-	}
+	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
 
 	if ((cur_rgid == exp_rgid) && (cur_egid == exp_egid)
 	    && (cur_sgid == exp_sgid)) {
diff --git a/testcases/kernel/syscalls/setresgid/setresgid02.c b/testcases/kernel/syscalls/setresgid/setresgid02.c
index ebdaec936..2c45fc27a 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid02.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid02.c
@@ -80,6 +80,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 #define EXP_RET_VAL	0
@@ -170,10 +171,7 @@ static int test_functionality(uid_t exp_rgid, uid_t exp_egid, uid_t exp_sgid)
 	uid_t cur_rgid, cur_egid, cur_sgid;
 
 	/* Get current real, effective and saved group id */
-	if (getresgid(&cur_rgid, &cur_egid, &cur_sgid) == -1) {
-		tst_brkm(TBROK, cleanup, "getresgid() failed");
-
-	}
+	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
 
 	if ((cur_rgid == exp_rgid) && (cur_egid == exp_egid)
 	    && (cur_sgid == exp_sgid)) {
diff --git a/testcases/kernel/syscalls/setresgid/setresgid03.c b/testcases/kernel/syscalls/setresgid/setresgid03.c
index b669feef7..78c89487b 100644
--- a/testcases/kernel/syscalls/setresgid/setresgid03.c
+++ b/testcases/kernel/syscalls/setresgid/setresgid03.c
@@ -168,10 +168,7 @@ static int test_functionality(uid_t exp_rgid, uid_t exp_egid, uid_t exp_sgid)
 	uid_t cur_rgid, cur_egid, cur_sgid;
 
 	/* Get current real, effective and saved group id */
-	if (getresgid(&cur_rgid, &cur_egid, &cur_sgid) == -1) {
-		tst_brkm(TBROK, cleanup, "getresgid() failed");
-
-	}
+	SAFE_GETRESGID(cleanup, &cur_rgid, &cur_egid, &cur_sgid);
 
 	if ((cur_rgid == exp_rgid) && (cur_egid == exp_egid)
 	    && (cur_sgid == exp_sgid)) {
-- 
2.13.5

