From: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
Date: Fri, 16 Mar 2018 15:12:56 +0800
Subject: [LTP] [PATCH 2/2] Make use of SAFE_GETGRNAM()
In-Reply-To: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1521184376-3649-1-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <1521184376-3649-2-git-send-email-huangjh.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/chmod/chmod05.c       |  4 +---
 testcases/kernel/syscalls/chmod/chmod07.c       |  3 +--
 testcases/kernel/syscalls/creat/creat08.c       | 16 +++++-----------
 testcases/kernel/syscalls/fchmod/fchmod02.c     |  4 +---
 testcases/kernel/syscalls/fchmod/fchmod05.c     |  5 +----
 testcases/kernel/syscalls/open/open10.c         | 14 ++++----------
 testcases/kernel/syscalls/setregid/setregid02.c |  5 +----
 testcases/kernel/syscalls/setregid/setregid03.c |  5 +----
 testcases/kernel/syscalls/setregid/setregid04.c |  6 ++----
 9 files changed, 17 insertions(+), 45 deletions(-)

diff --git a/testcases/kernel/syscalls/chmod/chmod05.c b/testcases/kernel/syscalls/chmod/chmod05.c
index 3cf4db5..c3bea4e 100644
--- a/testcases/kernel/syscalls/chmod/chmod05.c
+++ b/testcases/kernel/syscalls/chmod/chmod05.c
@@ -187,9 +187,7 @@ void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "getpwnam(\"nobody\") failed");
 
-	bin_group = getgrnam("bin");
-	if (bin_group == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "getgrnam(\"bin\") failed");
+	bin_group = SAFE_GETGRNAM(cleanup, "bin");
 
 	/*
 	 * Create a test directory under temporary directory with specified
diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 6a39388..ae52b21 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -174,8 +174,7 @@ void setup(void)
 	user1_uid = ltpuser->pw_uid;
 
 	/* Get the group id of guest user - ltpuser1 */
-	if ((ltpgroup = getgrnam(LTPGRP)) == NULL)
-		tst_brkm(TBROK, cleanup, "getgrnam failed");
+	ltpgroup = SAFE_GETGRNAM(cleanup, LTPGRP);
 	group1_gid = ltpgroup->gr_gid;
 
 	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
diff --git a/testcases/kernel/syscalls/creat/creat08.c b/testcases/kernel/syscalls/creat/creat08.c
index 50f2b39..377dff1 100644
--- a/testcases/kernel/syscalls/creat/creat08.c
+++ b/testcases/kernel/syscalls/creat/creat08.c
@@ -119,18 +119,12 @@ int main(int ac, char **av)
 		/*
 		 * Get the group IDs of group1 and group2.
 		 */
-		if ((group = getgrnam("nobody")) == NULL) {
-			if ((group = getgrnam("nogroup")) == NULL) {
-				tst_brkm(TBROK | TERRNO, cleanup,
-					 "getgrnam(\"nobody\") and "
-					 "getgrnam(\"nogroup\") failed");
-			}
-		}
+		group = getgrnam("nobody");
+		if (group == NULL)
+			group = SAFE_GETGRNAM(cleanup, "nogroup");
+
 		group1_gid = group->gr_gid;
-		if ((group = getgrnam("bin")) == NULL) {
-			tst_brkm(TBROK | TERRNO, cleanup,
-				 "getgrnam(\"bin\") failed");
-		}
+		group = SAFE_GETGRNAM(cleanup, "bin");
 		group2_gid = group->gr_gid;
 
 /*--------------------------------------------------------------*/
diff --git a/testcases/kernel/syscalls/fchmod/fchmod02.c b/testcases/kernel/syscalls/fchmod/fchmod02.c
index ea2bdb4..f9f8ab3 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod02.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod02.c
@@ -177,9 +177,7 @@ void setup(void)
 	user1_uid = ltpuser->pw_uid;
 
 	/* Get the group id of guest user - ltpuser1 */
-	if ((ltpgroup = getgrnam(LTPGRP)) == NULL) {
-		tst_brkm(TBROK, cleanup, "%s not in /etc/group", LTPGRP);
-	}
+	ltpgroup = SAFE_GETGRNAM(cleanup, LTPGRP);
 	group1_gid = ltpgroup->gr_gid;
 
 	/*
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index cdd3d07..93b4fc5 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -178,10 +178,7 @@ void setup(void)
 		tst_brkm(TBROK, cleanup,
 			 "Couldn't find uid of nobody: %s", strerror(errno));
 
-	bin_group = getgrnam("bin");
-	if (!bin_group)
-		tst_brkm(TBROK, cleanup,
-			 "Couldn't find gid of bin: %s", strerror(errno));
+	bin_group = SAFE_GETGRNAM(cleanup, "bin");
 
 	/*
 	 * Create a test directory under temporary directory with specified
diff --git a/testcases/kernel/syscalls/open/open10.c b/testcases/kernel/syscalls/open/open10.c
index 613f228..2c1a588 100644
--- a/testcases/kernel/syscalls/open/open10.c
+++ b/testcases/kernel/syscalls/open/open10.c
@@ -42,6 +42,7 @@
 #include <grp.h>
 #include <pwd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "open10";
 int TST_TOTAL = 1;
@@ -106,18 +107,11 @@ int main(int ac, char *av[])
 		 * Get the group IDs of group1 and group2.
 		 */
 		group = getgrnam("nobody");
-		if (group == NULL) {
-			group = getgrnam("nogroup");
-			if (group == NULL) {
-				tst_brkm(TBROK, cleanup,
-					 "nobody/nogroup not in /etc/group");
-			}
-		}
-		group1_gid = group->gr_gid;
-		group = getgrnam("bin");
 		if (group == NULL)
-			tst_brkm(TBROK, cleanup, "bin not in /etc/group");
+			group = SAFE_GETGRNAM(cleanup, "nogroup");
 
+		group1_gid = group->gr_gid;
+		group = SAFE_GETGRNAM(cleanup, "bin");
 		group2_gid = group->gr_gid;
 
 		/*
diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 21d1c82..d7e141d 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -148,10 +148,7 @@ static void setup(void)
 
 static struct group get_group_by_name(const char *name)
 {
-	struct group *ret = getgrnam(name);
-
-	if (ret == NULL)
-		tst_brkm(TBROK|TERRNO, NULL, "getgrnam(\"%s\") failed", name);
+	struct group *ret = SAFE_GETGRNAM(NULL, name);
 
 	GID16_CHECK(ret->gr_gid, setregid, NULL);
 
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index a51719e..6cadee5 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -186,10 +186,7 @@ static void setup(void)
 	nobody = *(getpwnam("nobody"));
 
 #define GET_GID(group) do { \
-	junk = getgrnam(#group); \
-	if (junk == NULL) { \
-		tst_brkm(TBROK, NULL, "%s must be a valid group", #group); \
-	} \
+	junk = SAFE_GETGRNAM(NULL, #group); \
 	GID16_CHECK(junk->gr_gid, setregid, NULL); \
 	group = *(junk); \
 } while (0)
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 0e0aae7..71f3c8b 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -30,6 +30,7 @@
 
 #include "test.h"
 #include "compat_16.h"
+#include "safe_macros.h"
 
 TCID_DEFINE(setregid04);
 
@@ -111,10 +112,7 @@ int main(int ac, char **av)
 }
 
 #define SAFE_GETGROUP(GROUPNAME)	\
-	if (getgrnam(#GROUPNAME) == NULL) { \
-		tst_brkm(TBROK, NULL, "Couldn't find the `" #GROUPNAME "' group"); \
-	} \
-	GROUPNAME ## _gr = *(getgrnam(#GROUPNAME));
+	GROUPNAME ## _gr = *(SAFE_GETGRNAM(NULL, #GROUPNAME));
 
 static void setup(void)
 {
-- 
1.8.3.1



