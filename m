From: Sandeep Patil <sspatil@google.com>
Date: Tue, 27 Mar 2018 10:36:22 -0700
Subject: [LTP] [PATCH v2] setregid: use common user and group names.
Message-ID: <20180327173622.175056-1-sspatil@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Android systems do not have groups names 'users' 'sys' etc. Replace them
with 'nobody' and 'daemon' for the purposes of setregid0[34] tests and
make the nomenclature across both of these tests more consistent.

This was made possible due to following commit in 'system/core' project
that adds the 'daemon' user to Android

  8e8648463 ("libcutils: Add "daemon" and "bin" users for testing only")

After this change, both setregid03 and setregid04 can run
on Android systems.

Signed-off-by: Sandeep Patil <sspatil@google.com>
---

v1->v2
-------
- Add description of the change that adds the new user in Android in
  commit message


 .../kernel/syscalls/setregid/setregid03.c     | 51 ++++++++++---------
 .../kernel/syscalls/setregid/setregid04.c     | 18 +++----
 2 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid03.c b/testcases/kernel/syscalls/setregid/setregid03.c
index a51719e80..97102e0ee 100644
--- a/testcases/kernel/syscalls/setregid/setregid03.c
+++ b/testcases/kernel/syscalls/setregid/setregid03.c
@@ -41,7 +41,7 @@ static gid_t neg_one = -1;
 /* flag to tell parent if child passed or failed. */
 static int flag;
 
-struct group users, sys, root, bin;
+struct group nobody_gr, daemon_gr, root_gr, bin_gr;
 struct passwd nobody;
 /*
  * The following structure contains all test data.  Each structure in the array
@@ -57,27 +57,28 @@ struct test_data_t {
 	char *test_msg;
 } test_data[] = {
 	{
-	&sys.gr_gid, &bin.gr_gid, &pass, &sys, &bin,
-		    "After setregid(sys, bin),"}, {
-	&neg_one, &sys.gr_gid, &pass, &sys, &sys, "After setregid(-1, sys)"},
-	{
-	&neg_one, &bin.gr_gid, &pass, &sys, &bin, "After setregid(-1, bin),"},
-	{
-	&bin.gr_gid, &neg_one, &pass, &bin, &bin, "After setregid(bin, -1),"},
-	{
-	&neg_one, &neg_one, &pass, &bin, &bin, "After setregid(-1, -1),"}, {
-	&neg_one, &bin.gr_gid, &pass, &bin, &bin, "After setregid(-1, bin),"},
-	{
-	&bin.gr_gid, &neg_one, &pass, &bin, &bin, "After setregid(bin, -1),"},
-	{
-	&bin.gr_gid, &bin.gr_gid, &pass, &bin, &bin,
+	&daemon_gr.gr_gid, &bin_gr.gr_gid, &pass, &daemon_gr, &bin_gr,
+		    "After setregid(daemon, bin),"}, {
+	&neg_one, &daemon_gr.gr_gid, &pass, &daemon_gr, &daemon_gr,
+		    "After setregid(-1, daemon)"}, {
+	&neg_one, &bin_gr.gr_gid, &pass, &daemon_gr, &bin_gr,
+		    "After setregid(-1, bin),"}, {
+	&bin_gr.gr_gid, &neg_one, &pass, &bin_gr, &bin_gr,
+		    "After setregid(bin, -1),"}, {
+	&neg_one, &neg_one, &pass, &bin_gr, &bin_gr,
+		    "After setregid(-1, -1),"}, {
+	&neg_one, &bin_gr.gr_gid, &pass, &bin_gr, &bin_gr,
+		    "After setregid(-1, bin),"}, {
+	&bin_gr.gr_gid, &neg_one, &pass, &bin_gr, &bin_gr,
+		    "After setregid(bin, -1),"}, {
+	&bin_gr.gr_gid, &bin_gr.gr_gid, &pass, &bin_gr, &bin_gr,
 		    "After setregid(bin, bin),"}, {
-	&sys.gr_gid, &neg_one, &fail, &bin, &bin, "After setregid(sys, -1)"},
-	{
-	&neg_one, &sys.gr_gid, &fail, &bin, &bin, "After setregid(-1, sys)"},
-	{
-	&sys.gr_gid, &sys.gr_gid, &fail, &bin, &bin,
-		    "After setregid(sys, sys)"},};
+	&daemon_gr.gr_gid, &neg_one, &fail, &bin_gr, &bin_gr,
+		    "After setregid(daemon, -1)"}, {
+	&neg_one, &daemon_gr.gr_gid, &fail, &bin_gr, &bin_gr,
+		    "After setregid(-1, daemon)"}, {
+	&daemon_gr.gr_gid, &daemon_gr.gr_gid, &fail, &bin_gr, &bin_gr,
+		    "After setregid(daemon, daemon)"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
@@ -102,7 +103,7 @@ int main(int ac, char **av)
 		tst_count = 0;
 
 		/* set the appropriate ownership values */
-		if (SETREGID(NULL, sys.gr_gid, bin.gr_gid) == -1)
+		if (SETREGID(NULL, daemon_gr.gr_gid, bin_gr.gr_gid) == -1)
 			tst_brkm(TBROK, NULL, "Initial setregid failed");
 
 		SAFE_SETEUID(NULL, nobody.pw_uid);
@@ -191,11 +192,11 @@ static void setup(void)
 		tst_brkm(TBROK, NULL, "%s must be a valid group", #group); \
 	} \
 	GID16_CHECK(junk->gr_gid, setregid, NULL); \
-	group = *(junk); \
+	group ## _gr = *(junk); \
 } while (0)
 
-	GET_GID(users);
-	GET_GID(sys);
+	GET_GID(nobody);
+	GET_GID(daemon);
 	GET_GID(bin);
 
 	TEST_PAUSE;
diff --git a/testcases/kernel/syscalls/setregid/setregid04.c b/testcases/kernel/syscalls/setregid/setregid04.c
index 0e0aae782..73f8bcb03 100644
--- a/testcases/kernel/syscalls/setregid/setregid04.c
+++ b/testcases/kernel/syscalls/setregid/setregid04.c
@@ -35,7 +35,7 @@ TCID_DEFINE(setregid04);
 
 static gid_t neg_one = -1;
 
-static struct group users_gr, daemon_gr, root_gr, bin_gr;
+static struct group nobody_gr, daemon_gr, root_gr, bin_gr;
 
 /*
  * The following structure contains all test data.  Each structure in the array
@@ -52,8 +52,8 @@ struct test_data_t {
 	{
 	&root_gr.gr_gid, &root_gr.gr_gid, &root_gr, &root_gr,
 		    "After setregid(root, root),"}, {
-	&users_gr.gr_gid, &neg_one, &users_gr, &root_gr,
-		    "After setregid(users, -1)"}, {
+	&nobody_gr.gr_gid, &neg_one, &nobody_gr, &root_gr,
+		    "After setregid(nobody, -1)"}, {
 	&root_gr.gr_gid, &neg_one, &root_gr, &root_gr,
 		    "After setregid(root,-1),"}, {
 	&neg_one, &neg_one, &root_gr, &root_gr,
@@ -62,12 +62,12 @@ struct test_data_t {
 		    "After setregid(-1, root)"}, {
 	&root_gr.gr_gid, &neg_one, &root_gr, &root_gr,
 		    "After setregid(root, -1),"}, {
-	&daemon_gr.gr_gid, &users_gr.gr_gid, &daemon_gr, &users_gr,
-		    "After setregid(daemon, users)"}, {
-	&neg_one, &neg_one, &daemon_gr, &users_gr,
+	&daemon_gr.gr_gid, &nobody_gr.gr_gid, &daemon_gr, &nobody_gr,
+		    "After setregid(daemon, nobody)"}, {
+	&neg_one, &neg_one, &daemon_gr, &nobody_gr,
 		    "After setregid(-1, -1)"}, {
-	&neg_one, &users_gr.gr_gid, &daemon_gr, &users_gr,
-		    "After setregid(-1, users)"}
+	&neg_one, &nobody_gr.gr_gid, &daemon_gr, &nobody_gr,
+		    "After setregid(-1, nobody)"}
 };
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
@@ -123,7 +123,7 @@ static void setup(void)
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
 	SAFE_GETGROUP(root);
-	SAFE_GETGROUP(users);
+	SAFE_GETGROUP(nobody);
 	SAFE_GETGROUP(daemon);
 	SAFE_GETGROUP(bin);
 
-- 
2.17.0.rc0.231.g781580f067-goog

