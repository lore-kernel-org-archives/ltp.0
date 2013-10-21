Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VY9sD-0004WJ-Gt
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 07:25:57 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VY9s5-0007CL-E9
	for ltp-list@lists.sourceforge.net; Mon, 21 Oct 2013 07:25:57 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r9L7Pglb030263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:43 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9L7PfGu000904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:42 GMT
Received: from abhmt117.oracle.com (abhmt117.oracle.com [141.146.116.69])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r9L7Pfwh000970
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Oct 2013 07:25:41 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 21 Oct 2013 11:25:17 +0400
Message-Id: <1382340317-8510-4-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1382340317-8510-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 3/3] syscalls/setregid02: fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

It was a bug that the testcase initially changed its uid/gid
to 'nobody' user but after performing setregid() It waited for
'users' gid. Fixed this.

Also added 16-bit version check and performed minor cleanup.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/syscalls/setregid/setregid02.c |  144 +++++++----------------
 1 files changed, 41 insertions(+), 103 deletions(-)

diff --git a/testcases/kernel/syscalls/setregid/setregid02.c b/testcases/kernel/syscalls/setregid/setregid02.c
index 349a494..5674070 100644
--- a/testcases/kernel/syscalls/setregid/setregid02.c
+++ b/testcases/kernel/syscalls/setregid/setregid02.c
@@ -15,74 +15,34 @@
  *   You should have received a copy of the GNU General Public License
  *   along with this program;  if not, write to the Free Software
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ *
+ *   Ported by John George
  */
 
 /*
- * NAME
- * 	setregid02.c
- *
- * DESCRIPTION
- * 	Test that setregid() fails and sets the proper errno values when a
- *	non-root user attemps to change the real or effective group id to a
- *	value other than the current gid or the current effective gid.
- *
- * ALGORITHM
- *
- *	Setup:
- *	  Setup signal handling
- *	  Get user information.
- *	  Pause for SIGUSER1 if option specified.
- *	Setup test values.
- *	Loop if the proper options are given.
- *	For each test set execute the system call
- *	  Check return code, if system call failed (return=-1)
- *		Log the errno and Issue a FAIL message.
- *	  Otherwise,
- *		Verify the Functionality of system call
- *		if successful,
- *			Issue Functionality-Pass message.
- *		Otherwise,
- *			Issue Functionality-Fail message.
- *	Cleanup:
- *	  Print errno log and/or timing stats if options given.
- *
- * USAGE:  <for command-line>
- *	setregid02 [-c n] [-e] [-f] [-i n] [-I x] [-P x] [-t]
- *	where,  -c n : Run n copies concurrently.
- *		-e   : Turn on errno logging.
- *		-f   : Turn off functionality Testing.
- *		-i n : Execute test n times.
- *		-I x : Execute test for x seconds.
- *		-P x : Pause for x seconds between iterations.
- *		-t   : Turn on syscall timing.
- * History
- *	07/2001 John George
- *		-Ported
- *
- * Restrictions
- * 	This test must be ran as root.
- *	users must be a valid group.
+ * Test that setregid() fails and sets the proper errno values when a
+ * non-root user attemps to change the real or effective group id to a
+ * value other than the current gid or the current effective gid.
  */
 
+#include <errno.h>
 #include <pwd.h>
 #include <grp.h>
 #include <stdlib.h>
 #include <string.h>
+
 #include "test.h"
 #include "usctest.h"
-#include <errno.h>
+#include "compat_16.h"
+
+TCID_DEFINE(setregid02);
 
-char *TCID = "setregid02";
-gid_t users_gr_gid, root_gr_gid, bin_gr_gid;
-gid_t neg_one = -1;
-int exp_enos[] = { EPERM, 0 };
+static gid_t neg_one = -1;
 
-gid_t inval_user = (USHRT_MAX);
-char nobody_uid[] = "nobody";
-struct passwd *nobody;
+static gid_t inval_user = (USHRT_MAX);
+static struct passwd *ltpuser;
 
-struct group users, root, bin;
-struct passwd *nobody;
+static struct group nobody, root, bin;
 
 /*
  * The following structure contains all test data.  Each structure in the array
@@ -98,28 +58,28 @@ struct test_data_t {
 	char *test_msg;
 } test_data[] = {
 	{
-	&neg_one, &root_gr_gid, EPERM, &users, &users,
+	&neg_one, &root.gr_gid, EPERM, &nobody, &nobody,
 		    "After setregid(-1, root),"}, {
-	&neg_one, &bin_gr_gid, EPERM, &users, &users,
+	&neg_one, &bin.gr_gid, EPERM, &nobody, &nobody,
 		    "After setregid(-1, bin)"}, {
-	&root_gr_gid, &neg_one, EPERM, &users, &users,
+	&root.gr_gid, &neg_one, EPERM, &nobody, &nobody,
 		    "After setregid(root,-1),"}, {
-	&bin_gr_gid, &neg_one, EPERM, &users, &users,
+	&bin.gr_gid, &neg_one, EPERM, &nobody, &nobody,
 		    "After setregid(bin, -1),"}, {
-	&root_gr_gid, &bin_gr_gid, EPERM, &users, &users,
+	&root.gr_gid, &bin.gr_gid, EPERM, &nobody, &nobody,
 		    "After setregid(root, bin)"}, {
-	&bin_gr_gid, &root_gr_gid, EPERM, &users, &users,
+	&bin.gr_gid, &root.gr_gid, EPERM, &nobody, &nobody,
 		    "After setregid(bin, root),"}, {
-	&inval_user, &neg_one, EINVAL, &users, &users,
+	&inval_user, &neg_one, EINVAL, &nobody, &nobody,
 		    "After setregid(invalid group, -1),"}, {
-&neg_one, &inval_user, EINVAL, &users, &users,
+&neg_one, &inval_user, EINVAL, &nobody, &nobody,
 		    "After setregid(-1, invalid group),"},};
 
 int TST_TOTAL = sizeof(test_data) / sizeof(test_data[0]);
 
-void setup(void);
-void cleanup(void);
-void gid_verify(struct group *ru, struct group *eu, char *when);
+static void setup(void);
+static void cleanup(void);
+static void gid_verify(struct group *ru, struct group *eu, char *when);
 
 int main(int ac, char **av)
 {
@@ -134,12 +94,11 @@ int main(int ac, char **av)
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		int i;
 
-		/* reset tst_count in case we are looping */
 		tst_count = 0;
 
 		for (i = 0; i < TST_TOTAL; i++) {
 			/* Set the real or effective group id */
-			TEST(setregid(*test_data[i].real_gid,
+			TEST(SETREGID(cleanup, *test_data[i].real_gid,
 				      *test_data[i].eff_gid));
 
 			if (TEST_RETURN == -1) {
@@ -169,10 +128,6 @@ int main(int ac, char **av)
 					 *test_data[i].real_gid,
 					 *test_data[i].eff_gid, TEST_RETURN);
 			}
-			/*
-			 * Perform functional verification if test
-			 * executed without (-f) option.
-			 */
 			if (STD_FUNCTIONAL_TEST) {
 				gid_verify(test_data[i].exp_real_usr,
 					   test_data[i].exp_eff_usr,
@@ -184,15 +139,9 @@ int main(int ac, char **av)
 	}
 	cleanup();
 	tst_exit();
-	tst_exit();
-
 }
 
-/*
- * setup()
- *	performs all ONE TIME setup for this test
- */
-void setup(void)
+static void setup(void)
 {
 	struct group *junk;
 
@@ -200,62 +149,51 @@ void setup(void)
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-	if ((nobody = getpwnam("nobody")) == NULL) {
+	ltpuser = getpwnam("nobody");
+	if (ltpuser == NULL)
 		tst_brkm(TBROK, NULL, "getpwnam(\"nobody\") failed");
-	}
 
-	if (setgid(nobody->pw_gid) == -1) {
+	if (setgid(ltpuser->pw_gid) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "setgid failed to set the effective gid to %d",
-			 nobody->pw_gid);
+			 ltpuser->pw_gid);
 	}
-	if (setuid(nobody->pw_uid) == -1) {
+	if (setuid(ltpuser->pw_uid) == -1) {
 		tst_brkm(TBROK | TERRNO, NULL,
 			 "setuid failed to to set the effective uid to %d",
-			 nobody->pw_uid);
+			 ltpuser->pw_uid);
 	}
 
-	/* set the expected errnos... */
-	TEST_EXP_ENOS(exp_enos);
-
 #define GET_GID(group)	do {		\
 	junk = getgrnam(#group);	\
 	if (junk == NULL) {		\
 		tst_brkm(TBROK|TERRNO, NULL, "getgrnam(\"%s\") failed", #group); \
 	}				\
-	group ## _gr_gid = junk->gr_gid;\
+	GID16_CHECK(junk->gr_gid, setregid, NULL); \
+	group = *(junk); \
 } while (0)
 
 	GET_GID(root);
-	GET_GID(users);
+	GET_GID(nobody);
 	GET_GID(bin);
 
-	/* Pause if that option was specified
-	 * TEST_PAUSE contains the code to fork the test with the -c option.
-	 */
 	TEST_PAUSE;
 }
 
-/*
- * cleanup()
- *	performs all ONE TIME cleanup for this test at
- *	completion or premature exit
- */
-void cleanup(void)
+static void cleanup(void)
 {
-	/*
-	 * print timing stats if that option was specified.
-	 * print errno log if that option was specified.
-	 */
 	TEST_CLEANUP;
 }
 
 void gid_verify(struct group *rg, struct group *eg, char *when)
 {
 	if ((getgid() != rg->gr_gid) || (getegid() != eg->gr_gid)) {
-		tst_resm(TINFO, "ERROR: %s real gid = %d; effective gid = %d",
+		tst_resm(TFAIL, "ERROR: %s real gid = %d; effective gid = %d",
 			 when, getgid(), getegid());
 		tst_resm(TINFO, "Expected: real gid = %d; effective gid = %d",
 			 rg->gr_gid, eg->gr_gid);
+	} else {
+		tst_resm(TPASS, "real or effective gid was modified as expected");
+
 	}
 }
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
