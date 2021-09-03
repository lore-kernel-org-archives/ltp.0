From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  3 Sep 2021 17:48:47 +0200
Subject: [LTP] [PATCH 6/7] syscalls/setregid02-04: Simplify GID handling
In-Reply-To: <20210903154848.18705-1-mdoucha@suse.cz>
References: <20210903154848.18705-1-mdoucha@suse.cz>
Message-ID: <20210903154848.18705-7-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/setregid/setregid02.c     | 48 +++++++---------
 .../kernel/syscalls/setregid/setregid03.c     | 57 ++++++++-----------
 .../kernel/syscalls/setregid/setregid04.c     | 42 +++++++-------
 3 files changed, 61 insertions(+), 86 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 310eb3a21..2174f81f9 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -19,12 +19,10 @@
 #include "tst_test.h"
 #include "compat_tst_16.h"
 
-static gid_t neg_one = -1;
+static gid_t root_gid, nobody_gid, other_gid, neg_one = -1;
 
 static struct passwd *ltpuser;
 
-static struct group ltpgroup, root, bin;
-
 /*
  * The following structure contains all test data.  Each structure in the array
  * is used for a separate test.  The tests are executed in the for loop below.
@@ -34,50 +32,41 @@ static struct tcase {
 	gid_t *real_gid;
 	gid_t *eff_gid;
 	int exp_errno;
-	struct group *exp_real_usr;
-	struct group *exp_eff_usr;
+	gid_t *exp_real_usr;
+	gid_t *exp_eff_usr;
 	char *test_msg;
 } tcases[] = {
 	{
-	&neg_one, &root.gr_gid, EPERM, &ltpgroup, &ltpgroup,
+	&neg_one, &root_gid, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(-1, root),"}, {
-	&neg_one, &bin.gr_gid, EPERM, &ltpgroup, &ltpgroup,
+	&neg_one, &other_gid, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(-1, bin)"}, {
-	&root.gr_gid, &neg_one, EPERM, &ltpgroup, &ltpgroup,
+	&root_gid, &neg_one, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(root,-1),"}, {
-	&bin.gr_gid, &neg_one, EPERM, &ltpgroup, &ltpgroup,
+	&other_gid, &neg_one, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(bin, -1),"}, {
-	&root.gr_gid, &bin.gr_gid, EPERM, &ltpgroup, &ltpgroup,
+	&root_gid, &other_gid, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(root, bin)"}, {
-	&bin.gr_gid, &root.gr_gid, EPERM, &ltpgroup, &ltpgroup,
+	&other_gid, &root_gid, EPERM, &nobody_gid, &nobody_gid,
 		    "After setregid(bin, root),"}
 };
 
-static struct group get_group_by_name(const char *name)
+static gid_t get_group_by_name(const char *name)
 {
 	struct group *ret = SAFE_GETGRNAM(name);
 
 	GID16_CHECK(ret->gr_gid, setregid);
 
-	return *ret;
-}
-
-static struct group get_group_by_gid(gid_t gid)
-{
-	struct group *ret = SAFE_GETGRGID(gid);
-
-	GID16_CHECK(ret->gr_gid, setregid);
-
-	return *ret;
+	return ret->gr_gid;
 }
 
-void gid_verify(struct group *rg, struct group *eg, char *when)
+void gid_verify(gid_t rg, gid_t eg, char *when)
 {
-	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
+	if ((getgid() != rg) || (getegid() != eg)) {
 		tst_res(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
 		tst_res(TINFO, "Expected: real gid = %d; effective gid = %d",
-			 rg->gr_gid, eg->gr_gid);
+			 rg, eg);
 		return;
 	}
 
@@ -107,7 +96,7 @@ static void run(unsigned int n)
 			"setregid(%d, %d) did not fail (ret: %ld) as expected (ret: -1).",
 			*tc->real_gid, *tc->eff_gid, TST_RET);
 	}
-	gid_verify(tc->exp_real_usr, tc->exp_eff_usr, tc->test_msg);
+	gid_verify(*tc->exp_real_usr, *tc->exp_eff_usr, tc->test_msg);
 }
 
 static void setup(void)
@@ -117,9 +106,10 @@ static void setup(void)
 	SAFE_SETGID(ltpuser->pw_gid);
 	SAFE_SETUID(ltpuser->pw_uid);
 
-	root = get_group_by_name("root");
-	ltpgroup = get_group_by_gid(ltpuser->pw_gid);
-	bin = get_group_by_name("bin");
+	nobody_gid = ltpuser->pw_gid;
+	GID16_CHECK(nobody_gid, setregid);
+	root_gid = get_group_by_name("root");
+	other_gid = get_group_by_name("bin");
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index e25a7ec72..35aa92b8e 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -16,72 +16,61 @@
 
 static int fail = -1;
 static int pass;
-static gid_t neg_one = -1;
+static gid_t primary_gid, secondary_gid, neg_one = -1;
 
-struct group nobody_gr, daemon_gr, root_gr, bin_gr;
 struct passwd nobody;
 
 struct tcase {
 	gid_t *real_gid;
 	gid_t *eff_gid;
 	int *exp_ret;
-	struct group *exp_real_usr;
-	struct group *exp_eff_usr;
+	gid_t *exp_real_usr;
+	gid_t *exp_eff_usr;
 	char *test_msg;
 } tcases[] = {
 	{
-	&daemon_gr.gr_gid, &bin_gr.gr_gid, &pass, &daemon_gr, &bin_gr,
+	&primary_gid, &secondary_gid, &pass, &primary_gid, &secondary_gid,
 		    "After setregid(daemon, bin),"}, {
-	&neg_one, &daemon_gr.gr_gid, &pass, &daemon_gr, &daemon_gr,
+	&neg_one, &primary_gid, &pass, &primary_gid, &primary_gid,
 		    "After setregid(-1, daemon)"}, {
-	&neg_one, &bin_gr.gr_gid, &pass, &daemon_gr, &bin_gr,
+	&neg_one, &secondary_gid, &pass, &primary_gid, &secondary_gid,
 		    "After setregid(-1, bin),"}, {
-	&bin_gr.gr_gid, &neg_one, &pass, &bin_gr, &bin_gr,
+	&secondary_gid, &neg_one, &pass, &secondary_gid, &secondary_gid,
 		    "After setregid(bin, -1),"}, {
-	&neg_one, &neg_one, &pass, &bin_gr, &bin_gr,
+	&neg_one, &neg_one, &pass, &secondary_gid, &secondary_gid,
 		    "After setregid(-1, -1),"}, {
-	&neg_one, &bin_gr.gr_gid, &pass, &bin_gr, &bin_gr,
+	&neg_one, &secondary_gid, &pass, &secondary_gid, &secondary_gid,
 		    "After setregid(-1, bin),"}, {
-	&bin_gr.gr_gid, &neg_one, &pass, &bin_gr, &bin_gr,
+	&secondary_gid, &neg_one, &pass, &secondary_gid, &secondary_gid,
 		    "After setregid(bin, -1),"}, {
-	&bin_gr.gr_gid, &bin_gr.gr_gid, &pass, &bin_gr, &bin_gr,
+	&secondary_gid, &secondary_gid, &pass, &secondary_gid, &secondary_gid,
 		    "After setregid(bin, bin),"}, {
-	&daemon_gr.gr_gid, &neg_one, &fail, &bin_gr, &bin_gr,
+	&primary_gid, &neg_one, &fail, &secondary_gid, &secondary_gid,
 		    "After setregid(daemon, -1)"}, {
-	&neg_one, &daemon_gr.gr_gid, &fail, &bin_gr, &bin_gr,
+	&neg_one, &primary_gid, &fail, &secondary_gid, &secondary_gid,
 		    "After setregid(-1, daemon)"}, {
-	&daemon_gr.gr_gid, &daemon_gr.gr_gid, &fail, &bin_gr, &bin_gr,
+	&primary_gid, &primary_gid, &fail, &secondary_gid, &secondary_gid,
 		    "After setregid(daemon, daemon)"},};
 
 
-static struct group get_group_fallback(const char *gr1, const char *gr2)
-{
-	struct group *junk;
-
-	junk = SAFE_GETGRNAM_FALLBACK(gr1, gr2);
-	GID16_CHECK(junk->gr_gid, setregid);
-	return *junk;
-}
-
-static struct group get_group(const char *group)
+static gid_t get_group(const char *group)
 {
 	struct group *junk;
 
 	junk = SAFE_GETGRNAM(group);
 	GID16_CHECK(junk->gr_gid, setregid);
-	return *junk;
+	return junk->gr_gid;
 }
 
 static void setup(void)
 {
 	nobody = *SAFE_GETPWNAM("nobody");
 
-	nobody_gr = get_group_fallback("nobody", "nogroup");
-	daemon_gr = get_group("daemon");
-	bin_gr = get_group("bin");
+	primary_gid = get_group("daemon");
+	secondary_gid = get_group("bin");
 
 	/* set the appropriate ownership values */
-	SAFE_SETREGID(daemon_gr.gr_gid, bin_gr.gr_gid);
+	SAFE_SETREGID(primary_gid, secondary_gid);
 	SAFE_SETEUID(nobody.pw_uid);
 }
 
@@ -109,13 +98,13 @@ static void test_failure(struct tcase *tc)
 			*tc->real_gid, *tc->eff_gid);
 }
 
-static void gid_verify(struct group *rg, struct group *eg, char *when)
+static void gid_verify(gid_t rg, gid_t eg, char *when)
 {
-	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
+	if ((getgid() != rg) || (getegid() != eg)) {
 		tst_res(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
 		tst_res(TINFO, "Expected: real gid = %d; effective gid = %d",
-			 rg->gr_gid, eg->gr_gid);
+			 rg, eg);
 	} else {
 		tst_res(TPASS,
 			"real or effective gid was modified as expected");
@@ -134,7 +123,7 @@ static void run(unsigned int i)
 	else
 		test_failure(tc);
 
-	gid_verify(tc->exp_real_usr, tc->exp_eff_usr, tc->test_msg);
+	gid_verify(*tc->exp_real_usr, *tc->exp_eff_usr, tc->test_msg);
 }
 
 void run_all(void)
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 9490ae173..6b9e3f524 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -12,9 +12,7 @@
 #include "tst_test.h"
 #include "compat_tst_16.h"
 
-static gid_t neg_one = -1;
-
-static struct group nobody_gr, daemon_gr, root_gr, bin_gr;
+static gid_t first_gid, second_gid, root_gid, neg_one = -1;
 
 /*
  * The following structure contains all test data.  Each structure in the array
@@ -24,45 +22,44 @@ static struct group nobody_gr, daemon_gr, root_gr, bin_gr;
 struct test_data_t {
 	gid_t *real_gid;
 	gid_t *eff_gid;
-	struct group *exp_real_usr;
-	struct group *exp_eff_usr;
+	gid_t *exp_real_usr;
+	gid_t *exp_eff_usr;
 	const char *test_msg;
 } test_data[] = {
 	{
-	&root_gr.gr_gid, &root_gr.gr_gid, &root_gr, &root_gr,
+	&root_gid, &root_gid, &root_gid, &root_gid,
 		    "After setregid(root, root),"}, {
-	&nobody_gr.gr_gid, &neg_one, &nobody_gr, &root_gr,
+	&first_gid, &neg_one, &first_gid, &root_gid,
 		    "After setregid(nobody, -1)"}, {
-	&root_gr.gr_gid, &neg_one, &root_gr, &root_gr,
+	&root_gid, &neg_one, &root_gid, &root_gid,
 		    "After setregid(root,-1),"}, {
-	&neg_one, &neg_one, &root_gr, &root_gr,
+	&neg_one, &neg_one, &root_gid, &root_gid,
 		    "After setregid(-1, -1),"}, {
-	&neg_one, &root_gr.gr_gid, &root_gr, &root_gr,
+	&neg_one, &root_gid, &root_gid, &root_gid,
 		    "After setregid(-1, root)"}, {
-	&root_gr.gr_gid, &neg_one, &root_gr, &root_gr,
+	&root_gid, &neg_one, &root_gid, &root_gid,
 		    "After setregid(root, -1),"}, {
-	&daemon_gr.gr_gid, &nobody_gr.gr_gid, &daemon_gr, &nobody_gr,
+	&second_gid, &first_gid, &second_gid, &first_gid,
 		    "After setregid(daemon, nobody)"}, {
-	&neg_one, &neg_one, &daemon_gr, &nobody_gr,
+	&neg_one, &neg_one, &second_gid, &first_gid,
 		    "After setregid(-1, -1)"}, {
-	&neg_one, &nobody_gr.gr_gid, &daemon_gr, &nobody_gr,
+	&neg_one, &first_gid, &second_gid, &first_gid,
 		    "After setregid(-1, nobody)"}
 };
 
-static void gid_verify(struct group *rg, struct group *eg, const char *when)
+static void gid_verify(gid_t rg, gid_t eg, const char *when)
 {
-	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
+	if ((getgid() != rg) || (getegid() != eg)) {
 		tst_res(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
 		tst_res(TINFO, "Expected: real gid = %d; effective gid = %d",
-			 rg->gr_gid, eg->gr_gid);
+			 rg, eg);
 	} else {
 		tst_res(TPASS,
 			"real or effective gid was modified as expected");
 	}
 }
 
-
 static void run(unsigned int i)
 {
 	/* Set the real or effective group id */
@@ -74,16 +71,15 @@ static void run(unsigned int i)
 		return;
 	}
 
-	gid_verify(test_data[i].exp_real_usr, test_data[i].exp_eff_usr,
+	gid_verify(*test_data[i].exp_real_usr, *test_data[i].exp_eff_usr,
 		   test_data[i].test_msg);
 }
 
 static void setup(void)
 {
-	root_gr = *SAFE_GETGRNAM("root");
-	nobody_gr = *SAFE_GETGRNAM_FALLBACK("nobody", "nogroup");
-	daemon_gr = *SAFE_GETGRNAM("daemon");
-	bin_gr = *SAFE_GETGRNAM("bin");
+	root_gid = SAFE_GETGRNAM("root")->gr_gid;
+	first_gid = SAFE_GETGRNAM_FALLBACK("nobody", "nogroup")->gr_gid;
+	second_gid = SAFE_GETGRNAM("daemon")->gr_gid;
 }
 
 static struct tst_test test = {
-- 
2.33.0

