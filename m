From: Martin Doucha <mdoucha@suse.cz>
Date: Tue,  7 Sep 2021 13:32:22 +0200
Subject: [LTP] [PATCH v2 5/5] syscalls/setregid02-04: Eliminate named group
 lookups
In-Reply-To: <20210907113222.5156-1-mdoucha@suse.cz>
References: <20210907113222.5156-1-mdoucha@suse.cz>
Message-ID: <20210907113222.5156-5-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Group names like "bin" or "daemon" may not exist on some systems. Find and use
any unprivieged group IDs instead of specific named groups.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Update to new tst_uid API

 .../kernel/syscalls/setregid/setregid02.c     | 33 +++++++--------
 .../kernel/syscalls/setregid/setregid03.c     | 40 +++++++++----------
 .../kernel/syscalls/setregid/setregid04.c     | 16 +++++---
 3 files changed, 43 insertions(+), 46 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 2174f81f9..0210f485a 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 
 #include "tst_test.h"
+#include "tst_uid.h"
 #include "compat_tst_16.h"
 
 static gid_t root_gid, nobody_gid, other_gid, neg_one = -1;
@@ -40,26 +41,17 @@ static struct tcase {
 	&neg_one, &root_gid, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(-1, root),"}, {
 	&neg_one, &other_gid, EPERM, &nobody_gid, &nobody_gid,
-		    "After setregid(-1, bin)"}, {
+		    "After setregid(-1, other)"}, {
 	&root_gid, &neg_one, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(root,-1),"}, {
 	&other_gid, &neg_one, EPERM, &nobody_gid, &nobody_gid,
-		    "After setregid(bin, -1),"}, {
+		    "After setregid(other, -1),"}, {
 	&root_gid, &other_gid, EPERM, &nobody_gid, &nobody_gid,
-		    "After setregid(root, bin)"}, {
+		    "After setregid(root, other)"}, {
 	&other_gid, &root_gid, EPERM, &nobody_gid, &nobody_gid,
-		    "After setregid(bin, root),"}
+		    "After setregid(other, root),"}
 };
 
-static gid_t get_group_by_name(const char *name)
-{
-	struct group *ret = SAFE_GETGRNAM(name);
-
-	GID16_CHECK(ret->gr_gid, setregid);
-
-	return ret->gr_gid;
-}
-
 void gid_verify(gid_t rg, gid_t eg, char *when)
 {
 	if ((getgid() != rg) || (getegid() != eg)) {
@@ -101,15 +93,20 @@ static void run(unsigned int n)
 
 static void setup(void)
 {
+	gid_t test_groups[3];
+
 	ltpuser = SAFE_GETPWNAM("nobody");
+	nobody_gid = test_groups[0] = ltpuser->pw_gid;
+	root_gid = test_groups[1] = getgid();
+	tst_get_gids(test_groups, 2, 3);
+	other_gid = test_groups[2];
+
+	GID16_CHECK(root_gid, setregid);
+	GID16_CHECK(nobody_gid, setregid);
+	GID16_CHECK(other_gid, setregid);
 
 	SAFE_SETGID(ltpuser->pw_gid);
 	SAFE_SETUID(ltpuser->pw_uid);
-
-	nobody_gid = ltpuser->pw_gid;
-	GID16_CHECK(nobody_gid, setregid);
-	root_gid = get_group_by_name("root");
-	other_gid = get_group_by_name("bin");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index 35aa92b8e..334aceb04 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -12,6 +12,7 @@
 #include <pwd.h>
 
 #include "tst_test.h"
+#include "tst_uid.h"
 #include "compat_tst_16.h"
 
 static int fail = -1;
@@ -30,44 +31,39 @@ struct tcase {
 } tcases[] = {
 	{
 	&primary_gid, &secondary_gid, &pass, &primary_gid, &secondary_gid,
-		    "After setregid(daemon, bin),"}, {
+		    "After setregid(primary, secondary),"}, {
 	&neg_one, &primary_gid, &pass, &primary_gid, &primary_gid,
-		    "After setregid(-1, daemon)"}, {
+		    "After setregid(-1, primary)"}, {
 	&neg_one, &secondary_gid, &pass, &primary_gid, &secondary_gid,
-		    "After setregid(-1, bin),"}, {
+		    "After setregid(-1, secondary),"}, {
 	&secondary_gid, &neg_one, &pass, &secondary_gid, &secondary_gid,
-		    "After setregid(bin, -1),"}, {
+		    "After setregid(secondary, -1),"}, {
 	&neg_one, &neg_one, &pass, &secondary_gid, &secondary_gid,
 		    "After setregid(-1, -1),"}, {
 	&neg_one, &secondary_gid, &pass, &secondary_gid, &secondary_gid,
-		    "After setregid(-1, bin),"}, {
+		    "After setregid(-1, secondary),"}, {
 	&secondary_gid, &neg_one, &pass, &secondary_gid, &secondary_gid,
-		    "After setregid(bin, -1),"}, {
+		    "After setregid(secondary, -1),"}, {
 	&secondary_gid, &secondary_gid, &pass, &secondary_gid, &secondary_gid,
-		    "After setregid(bin, bin),"}, {
+		    "After setregid(secondary, secondary),"}, {
 	&primary_gid, &neg_one, &fail, &secondary_gid, &secondary_gid,
-		    "After setregid(daemon, -1)"}, {
+		    "After setregid(primary, -1)"}, {
 	&neg_one, &primary_gid, &fail, &secondary_gid, &secondary_gid,
-		    "After setregid(-1, daemon)"}, {
+		    "After setregid(-1, primary)"}, {
 	&primary_gid, &primary_gid, &fail, &secondary_gid, &secondary_gid,
-		    "After setregid(daemon, daemon)"},};
-
-
-static gid_t get_group(const char *group)
-{
-	struct group *junk;
-
-	junk = SAFE_GETGRNAM(group);
-	GID16_CHECK(junk->gr_gid, setregid);
-	return junk->gr_gid;
-}
+		    "After setregid(primary, primary)"},};
 
 static void setup(void)
 {
+	gid_t test_groups[2];
+
 	nobody = *SAFE_GETPWNAM("nobody");
 
-	primary_gid = get_group("daemon");
-	secondary_gid = get_group("bin");
+	tst_get_gids(test_groups, 0, 2);
+	primary_gid = test_groups[0];
+	secondary_gid = test_groups[1];
+	GID16_CHECK(primary_gid, setregid);
+	GID16_CHECK(secondary_gid, setregid);
 
 	/* set the appropriate ownership values */
 	SAFE_SETREGID(primary_gid, secondary_gid);
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 6b9e3f524..dbeb98ae6 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -10,6 +10,7 @@
  */
 
 #include "tst_test.h"
+#include "tst_uid.h"
 #include "compat_tst_16.h"
 
 static gid_t first_gid, second_gid, root_gid, neg_one = -1;
@@ -30,7 +31,7 @@ struct test_data_t {
 	&root_gid, &root_gid, &root_gid, &root_gid,
 		    "After setregid(root, root),"}, {
 	&first_gid, &neg_one, &first_gid, &root_gid,
-		    "After setregid(nobody, -1)"}, {
+		    "After setregid(first, -1)"}, {
 	&root_gid, &neg_one, &root_gid, &root_gid,
 		    "After setregid(root,-1),"}, {
 	&neg_one, &neg_one, &root_gid, &root_gid,
@@ -40,11 +41,11 @@ struct test_data_t {
 	&root_gid, &neg_one, &root_gid, &root_gid,
 		    "After setregid(root, -1),"}, {
 	&second_gid, &first_gid, &second_gid, &first_gid,
-		    "After setregid(daemon, nobody)"}, {
+		    "After setregid(second, first)"}, {
 	&neg_one, &neg_one, &second_gid, &first_gid,
 		    "After setregid(-1, -1)"}, {
 	&neg_one, &first_gid, &second_gid, &first_gid,
-		    "After setregid(-1, nobody)"}
+		    "After setregid(-1, first)"}
 };
 
 static void gid_verify(gid_t rg, gid_t eg, const char *when)
@@ -77,9 +78,12 @@ static void run(unsigned int i)
 
 static void setup(void)
 {
-	root_gid = SAFE_GETGRNAM("root")->gr_gid;
-	first_gid = SAFE_GETGRNAM_FALLBACK("nobody", "nogroup")->gr_gid;
-	second_gid = SAFE_GETGRNAM("daemon")->gr_gid;
+	gid_t test_groups[3];
+
+	root_gid = test_groups[0] = getgid();
+	tst_get_gids(test_groups, 1, 3);
+	first_gid = test_groups[1];
+	second_gid = test_groups[2];
 }
 
 static struct tst_test test = {
-- 
2.33.0

