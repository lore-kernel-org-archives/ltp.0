From: Steve Muckle <smuckle@google.com>
Date: Thu, 17 Jan 2019 15:26:40 -0800
Subject: [LTP] [PATCH] syscalls: add compat_16 tests for getresgid, getresuid
Message-ID: <20190117232640.200616-1-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 testcases/kernel/syscalls/getresgid/Makefile      |  2 +-
 testcases/kernel/syscalls/getresgid/getresgid01.c |  9 ++++-----
 testcases/kernel/syscalls/getresgid/getresgid02.c |  9 ++++-----
 testcases/kernel/syscalls/getresgid/getresgid03.c | 10 ++++------
 testcases/kernel/syscalls/getresuid/Makefile      |  2 +-
 testcases/kernel/syscalls/getresuid/getresuid01.c |  9 ++++-----
 testcases/kernel/syscalls/getresuid/getresuid02.c |  9 ++++-----
 testcases/kernel/syscalls/getresuid/getresuid03.c | 10 ++++------
 testcases/kernel/syscalls/utils/compat_16.h       | 12 ++++++++++++
 9 files changed, 38 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/getresgid/Makefile b/testcases/kernel/syscalls/getresgid/Makefile
index bd617d806..f3ab65753 100644
--- a/testcases/kernel/syscalls/getresgid/Makefile
+++ b/testcases/kernel/syscalls/getresgid/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
+include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getresgid/getresgid01.c b/testcases/kernel/syscalls/getresgid/getresgid01.c
index 51e01be7c..b5fb804ee 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid01.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid01.c
@@ -73,12 +73,11 @@
 #include <signal.h>
 
 #include "test.h"
-
-extern int getresgid(gid_t *, gid_t *, gid_t *);
+#include "compat_16.h"
 
 char *TCID = "getresgid01";
 int TST_TOTAL = 1;
-gid_t pr_gid, pe_gid, ps_gid;	/* calling process real/effective/saved gid */
+GID_T pr_gid, pe_gid, ps_gid;	/* calling process real/effective/saved gid */
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -86,7 +85,7 @@ void cleanup();			/* cleanup function for the test */
 int main(int ac, char **av)
 {
 	int lc;
-	gid_t real_gid,		/* real/eff./saved user id from getresgid() */
+	GID_T real_gid,		/* real/eff./saved user id from getresgid() */
 	 eff_gid, sav_gid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -101,7 +100,7 @@ int main(int ac, char **av)
 		 * Call getresgid() to get the real/effective/saved
 		 * user id's of the calling process.
 		 */
-		TEST(getresgid(&real_gid, &eff_gid, &sav_gid));
+		TEST(GETRESGID(cleanup, &real_gid, &eff_gid, &sav_gid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "getresgid() Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/getresgid/getresgid02.c b/testcases/kernel/syscalls/getresgid/getresgid02.c
index 16934d720..8bddf9824 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid02.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid02.c
@@ -75,14 +75,13 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "compat_16.h"
 
 #define LTPUSER		"nobody"
 
-extern int getresgid(gid_t *, gid_t *, gid_t *);
-
 char *TCID = "getresgid02";
 int TST_TOTAL = 1;
-gid_t pr_gid, pe_gid, ps_gid;	/* calling process real/effective/saved gid */
+GID_T pr_gid, pe_gid, ps_gid;	/* calling process real/effective/saved gid */
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -90,7 +89,7 @@ void cleanup();			/* cleanup function for the test */
 int main(int ac, char **av)
 {
 	int lc;
-	gid_t real_gid,		/* real/eff./saved user id from getresgid() */
+	GID_T real_gid,		/* real/eff./saved user id from getresgid() */
 	 eff_gid, sav_gid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -106,7 +105,7 @@ int main(int ac, char **av)
 		 * user id's of the calling process after
 		 * setregid() in setup.
 		 */
-		TEST(getresgid(&real_gid, &eff_gid, &sav_gid));
+		TEST(GETRESGID(cleanup, &real_gid, &eff_gid, &sav_gid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "getresgid() Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/getresgid/getresgid03.c b/testcases/kernel/syscalls/getresgid/getresgid03.c
index 6575bdc93..0785359e0 100644
--- a/testcases/kernel/syscalls/getresgid/getresgid03.c
+++ b/testcases/kernel/syscalls/getresgid/getresgid03.c
@@ -77,13 +77,11 @@
 #include <pwd.h>
 
 #include "test.h"
-
-extern int getresgid(gid_t *, gid_t *, gid_t *);
-extern int setresgid(gid_t, gid_t, gid_t);
+#include "compat_16.h"
 
 char *TCID = "getresgid03";
 int TST_TOTAL = 1;
-gid_t pr_gid, pe_gid, ps_gid;	/* calling process real/effective/saved gid */
+GID_T pr_gid, pe_gid, ps_gid;	/* calling process real/effective/saved gid */
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -91,7 +89,7 @@ void cleanup();			/* cleanup function for the test */
 int main(int ac, char **av)
 {
 	int lc;
-	gid_t real_gid,		/* real/eff./saved user id from getresgid() */
+	GID_T real_gid,		/* real/eff./saved user id from getresgid() */
 	 eff_gid, sav_gid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -107,7 +105,7 @@ int main(int ac, char **av)
 		 * user id's of the calling process after
 		 * setregid() in setup.
 		 */
-		TEST(getresgid(&real_gid, &eff_gid, &sav_gid));
+		TEST(GETRESGID(cleanup, &real_gid, &eff_gid, &sav_gid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "getresgid() Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/getresuid/Makefile b/testcases/kernel/syscalls/getresuid/Makefile
index bd617d806..f3ab65753 100644
--- a/testcases/kernel/syscalls/getresuid/Makefile
+++ b/testcases/kernel/syscalls/getresuid/Makefile
@@ -19,5 +19,5 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-
+include $(abs_srcdir)/../utils/compat_16.mk
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/getresuid/getresuid01.c b/testcases/kernel/syscalls/getresuid/getresuid01.c
index 28e970a09..07fed9c13 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid01.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid01.c
@@ -72,12 +72,11 @@
 #include <signal.h>
 
 #include "test.h"
-
-extern int getresuid(uid_t *, uid_t *, uid_t *);
+#include "compat_16.h"
 
 char *TCID = "getresuid01";
 int TST_TOTAL = 1;
-uid_t pr_uid, pe_uid, ps_uid;	/* calling process real/effective/saved uid */
+UID_T pr_uid, pe_uid, ps_uid;	/* calling process real/effective/saved uid */
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -85,7 +84,7 @@ void cleanup();			/* cleanup function for the test */
 int main(int ac, char **av)
 {
 	int lc;
-	uid_t real_uid,		/* real/eff./saved user id from getresuid() */
+	UID_T real_uid,		/* real/eff./saved user id from getresuid() */
 	 eff_uid, sav_uid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -100,7 +99,7 @@ int main(int ac, char **av)
 		 * Call getresuid() to get the real/effective/saved
 		 * user id's of the calling process.
 		 */
-		TEST(getresuid(&real_uid, &eff_uid, &sav_uid));
+		TEST(GETRESUID(cleanup, &real_uid, &eff_uid, &sav_uid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "getresuid() Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/getresuid/getresuid02.c b/testcases/kernel/syscalls/getresuid/getresuid02.c
index defd759e0..23f7944dd 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid02.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid02.c
@@ -75,14 +75,13 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "compat_16.h"
 
 #define LTPUSER		"nobody"
 
-extern int getresuid(uid_t *, uid_t *, uid_t *);
-
 char *TCID = "getresuid02";
 int TST_TOTAL = 1;
-uid_t pr_uid, pe_uid, ps_uid;	/* calling process real/effective/saved uid */
+UID_T pr_uid, pe_uid, ps_uid;	/* calling process real/effective/saved uid */
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -90,7 +89,7 @@ void cleanup();			/* cleanup function for the test */
 int main(int ac, char **av)
 {
 	int lc;
-	uid_t real_uid,		/* real/eff./saved user id from getresuid() */
+	UID_T real_uid,		/* real/eff./saved user id from getresuid() */
 	 eff_uid, sav_uid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -106,7 +105,7 @@ int main(int ac, char **av)
 		 * user id's of the calling process after
 		 * setreuid() in setup.
 		 */
-		TEST(getresuid(&real_uid, &eff_uid, &sav_uid));
+		TEST(GETRESUID(cleanup, &real_uid, &eff_uid, &sav_uid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "getresuid() Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/getresuid/getresuid03.c b/testcases/kernel/syscalls/getresuid/getresuid03.c
index a70536bd1..bf117038b 100644
--- a/testcases/kernel/syscalls/getresuid/getresuid03.c
+++ b/testcases/kernel/syscalls/getresuid/getresuid03.c
@@ -76,13 +76,11 @@
 #include <pwd.h>
 
 #include "test.h"
-
-extern int getresuid(uid_t *, uid_t *, uid_t *);
-extern int setresuid(uid_t, uid_t, uid_t);
+#include "compat_16.h"
 
 char *TCID = "getresuid03";
 int TST_TOTAL = 1;
-uid_t pr_uid, pe_uid, ps_uid;	/* calling process real/effective/saved uid */
+UID_T pr_uid, pe_uid, ps_uid;	/* calling process real/effective/saved uid */
 
 void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
@@ -90,7 +88,7 @@ void cleanup();			/* cleanup function for the test */
 int main(int ac, char **av)
 {
 	int lc;
-	uid_t real_uid,		/* real/eff./saved user id from getresuid() */
+	UID_T real_uid,		/* real/eff./saved user id from getresuid() */
 	 eff_uid, sav_uid;
 
 	tst_parse_opts(ac, av, NULL, NULL);
@@ -106,7 +104,7 @@ int main(int ac, char **av)
 		 * user id's of the calling process after
 		 * setreuid() in setup.
 		 */
-		TEST(getresuid(&real_uid, &eff_uid, &sav_uid));
+		TEST(GETRESUID(cleanup, &real_uid, &eff_uid, &sav_uid));
 
 		if (TEST_RETURN == -1) {
 			tst_resm(TFAIL, "getresuid() Failed, errno=%d : %s",
diff --git a/testcases/kernel/syscalls/utils/compat_16.h b/testcases/kernel/syscalls/utils/compat_16.h
index f0bc3265b..5b0338d38 100644
--- a/testcases/kernel/syscalls/utils/compat_16.h
+++ b/testcases/kernel/syscalls/utils/compat_16.h
@@ -35,7 +35,9 @@
 #include "lapi/syscalls.h"
 
 int setresuid(uid_t ruid, uid_t euid, uid_t suid);
+int getresuid(uid_t *ruid, uid_t *euid, uid_t *suid);
 int setresgid(gid_t rgid, gid_t egid, gid_t sgid);
+int getresgid(gid_t *rgid, gid_t *egid, gid_t *sgid);
 
 
 /* If the platform has __NR_sys_name32 defined it
@@ -136,11 +138,21 @@ int SETRESUID(void (cleanup)(void), UID_T ruid, UID_T euid, UID_T suid)
 	LTP_CREATE_SYSCALL(setresuid, cleanup, ruid, euid, suid);
 }
 
+int GETRESUID(void (cleanup)(void), UID_T *ruid, UID_T *euid, UID_T *suid)
+{
+	LTP_CREATE_SYSCALL(getresuid, cleanup, ruid, euid, suid);
+}
+
 int SETRESGID(void (cleanup)(void), GID_T rgid, GID_T egid, GID_T sgid)
 {
 	LTP_CREATE_SYSCALL(setresgid, cleanup, rgid, egid, sgid);
 }
 
+int GETRESGID(void (cleanup)(void), GID_T *rgid, GID_T *egid, GID_T *sgid)
+{
+	LTP_CREATE_SYSCALL(getresgid, cleanup, rgid, egid, sgid);
+}
+
 int FCHOWN(void (cleanup)(void), unsigned int fd, UID_T owner, GID_T group)
 {
 	LTP_CREATE_SYSCALL(fchown, cleanup, fd, owner, group);
-- 
2.20.1.321.g9e740568ce-goog

