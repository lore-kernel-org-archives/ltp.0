From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 27 Feb 2020 17:39:22 +0100
Subject: [LTP] [PATCH 4/4] doc: Update style guide to new API
In-Reply-To: <20200227163922.317-1-pvorel@suse.cz>
References: <20200227163922.317-1-pvorel@suse.cz>
Message-ID: <20200227163922.317-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Document still needs more update, but at least don't use legacy API
examples.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Do we want to keep this document?
Wouldn't it be better to have this info in Test-Writing-Guidelines (to
have a single document)?

Kind regards,
Petr

 doc/style-guide.txt | 107 +++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 72 deletions(-)

diff --git a/doc/style-guide.txt b/doc/style-guide.txt
index 55331c8d7..25cfa369b 100644
--- a/doc/style-guide.txt
+++ b/doc/style-guide.txt
@@ -31,7 +31,7 @@ When you can use libltp please observe the following guidelines:
 No, only use libltp in non-forked processes and functions +perror(3)+ /
 +exit(3)+ otherwise. Reason being:
 
- * Calling +tst_resm()+ from multiple processes is messy.
+ * Calling +tst_res()+ from multiple processes is messy.
  * Calling cleanup can break test execution.
  * Establishing a complicated scheme of tracking the testcase state
    for teardown is undesirable.
@@ -79,10 +79,8 @@ exec'ing and descriptor inheritance, etc.
 4. Call APIs that don't require freeing up resources on failure first
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
- * +tst_require_root()+
  * +tst_sig(...)+
  * +malloc(3)+
- * +tst_tmpdir()+
 
 That way you can simplify your setup and avoid calling cleanup whenever
 possible!
@@ -91,7 +89,7 @@ possible!
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If the test need to run as root, check to make sure that you're root
-*before doing any other setup* via +tst_require_root()+.
+*before doing any other setup* via +.needs_root = 1+ (+TST_NEEDS_ROOT=1+ for shell).
 
 6. No custom reporting APIs
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -119,15 +117,15 @@ For example:
 [source,c]
 ----------------------------------------------------
 if (fork() == -1)
-	tst_brkm(TBROK, cleanup, "fork failed");
+	tst_brk(TBROK, "fork failed");
 
 /* or */
 
 if (fork() == -1)
-	tst_brkm(TBROK, cleanup, "fork # 1 failed");
+	tst_brk(TBROK, "fork # 1 failed");
 
 if (fork() == -1)
-	tst_brkm(TBROK, cleanup, "fork # 2 failed");
+	tst_brk(TBROK, "fork # 2 failed");
 ----------------------------------------------------
 
 If you can't determine where the failure has occurred in a testcase based on
@@ -137,7 +135,7 @@ failure may be impossible.
 10. Reporting errno and the TEST() macro
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Don't roll your own +errno+ / +strerror()+ printout when you use +tst_resm()+
+Don't roll your own +errno+ / +strerror()+ printout when you use +tst_res()+
 calls. Use either +TERRNO+ or +TTERRNO+. Similarly, if a testcase passed and
 it's obvious why it passed (for example a function call returns +0+ or
 +TEST_RETURN == 0+).
@@ -154,59 +152,40 @@ if (fn() == -1) {
 	 * isn't static.
 	 */
 	if (exp_errno == ENOENT)
-		tst_resm(TPASS|TERRNO,
+		tst_res(TPASS | TERRNO,
 		    "fn failed as expected");
 	/*
 	 * Using strerror(TEST_ERRNO) here is valid because
 	 * the error case isn't static.
 	 */
 	else
-		tst_resm(TFAIL|TERRNO,
+		tst_res(TFAIL | TERRNO,
 		    "fn failed unexpectedly; expected "
 		    "%d - %s",
 		    exp_errno, strerror(exp_errno));
-} else
-	tst_resm(TBROK, "fn passed unexpectedly");
+} else {
+	tst_res(TFAIL, "fn passed unexpectedly");
+}
 
 /* Example using TEST(...) macro */
 
 TEST(fn());
 if (TEST_RETURN == 0)
-	tst_resm(TPASS, "fn passed as expected");
+	tst_res(TPASS, "fn passed as expected");
 else
-	tst_resm(TFAIL|TTERRNO, "fn failed");
+	tst_res(TFAIL | TTERRNO, "fn failed");
 -------------------------------------------------------------------------------
 
 [NOTE]
 The +TEST()+ macro is not thread-safe as it saves return value and errno into
 global variable.
 
-12. Use tst_brkm() when possible
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-Use...
-[source,c]
-------------------------------
-tst_brkm(TBROK, cleanup, ...);
-------------------------------
-...instead of...
-[source,c]
-------------------------------
-tst_resm(TBROK, ...);
-cleanup();
-tst_exit();
-------------------------------
-
-[NOTE]
-As you see the +tst_brkm()+ no longer requires non +NULL+ cleanup_fn argument
-in order to call +tst_exit()+.
-
-13. Indentation
+12. Indentation
 ~~~~~~~~~~~~~~~
 
 Use hard tabs for first-level indentation, and 4 spaces for every line longer
 than 80 columns. Use a linebreak with string constants in format functions
-like +*printf()+, the +tst_resm()+ APIs, etc.
+like +*printf()+, the +tst_res()+ APIs, etc.
 
 Example:
 [source,c]
@@ -216,7 +195,7 @@ if ((this_is_a_poorly_formed_really_long_variable = function_call()) == NULL &&
 	/* Use tabs here */
 	printf("The rain in Spain falls mainly in the plain.\nThe quick brown "
 	    "fox jumped over the lazy yellow dog\n");
-	tst_resm(TPASS,
+	tst_res(TPASS,
 	    "Half would turn and fight. The other half would try to swim "
 	    "across. But my uncle told me about a few that... they'd swim "
 	    "halfway out, turn with the current, and ride it all the way out "
@@ -224,7 +203,7 @@ if ((this_is_a_poorly_formed_really_long_variable = function_call()) == NULL &&
 }
 -------------------------------------------------------------------------------
 
-14. System headers
+13. System headers
 ~~~~~~~~~~~~~~~~~~
 
 Don't use +linux/+ headers if at all possible. Usually they are replaced with
@@ -232,7 +211,7 @@ Don't use +linux/+ headers if at all possible. Usually they are replaced with
 headers get shuffled around a lot more than their +sys/+ counterparts it
 seems.
 
-15. Signal handlers
+14. Signal handlers
 ~~~~~~~~~~~~~~~~~~~~
 
 Avoid doing tricky things in signal handlers. Calling most of the libc
@@ -317,7 +296,7 @@ The only exception to this is when you define global variables.
 
 Your testcase should be runnable as root and non-root. What does that mean? It
 should fail gracefully as non-root if it has insufficient privileges, or use
-+tst_require_root()+ if root access is absolutely required.
++.needs_root = 1+ if root access is absolutely necessary.
 
 A lot of newer testcases don't honor this fact and it causes random
 unnecessary errors when run as non-privileged users.
@@ -325,15 +304,10 @@ unnecessary errors when run as non-privileged users.
 6. Do I need to create temporary directory?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Use +tst_tmpdir()+ if your testcase will:
+Use +.needs_tmpdir = 1+ (+TST_NEEDS_TMPDIR=1+ for shell) if your testcase does:
 
 * Create temporary files.
 * Dump core.
-* Etc. Otherwise, don't bother with the API.
-
-[NOTE]
-If you created temporary directory with +tst_tmpdir()+ don't forget to call
-+tst_rmdir()+ when the test is cleaning up. This is *NOT* done automatically.
 
 7. Setting up signal handlers
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -349,43 +323,33 @@ but the rest can be caught).
 The following is a basic testcase template:
 [source,c]
 ---------------------------------------------------------------------------
-#include "test.h"
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 20XX
+*/
 
-char *TCID = "testname";
-int TST_TOTAL = /* ... */
+#include "tst_test.h"
 
 static void setup(void)
 {
 	/* ... */
-
-	tst_require_root();
-
-	tst_tmpdir();
-
-	/* ... */
-
-	TEST_PAUSE;
 }
 
 static void cleanup(void)
 {
-
-	TEST_CLEANUP;
-
 	/* ... */
-
-	tst_rmdir();
 }
 
-int main(void)
+static void do_test(void)
 {
-	/* ... */
-
-	setup();	/* Optional */
-
-	cleanup();	/* Optional */
-	tst_exit();	/* DON'T FORGET THIS -- this must be last! */
+	tst_res(TPASS, "Test passed");
 }
+
+static struct tst_test test = {
+	.test_all = do_test,
+	.setup = setup,
+	.cleanup = cleanup,
+};
 ---------------------------------------------------------------------------
 
 Fixing Legacy Testcases
@@ -418,13 +382,12 @@ So *NO* Linux, BSD specific syscalls there.
 Contribution to the project
 ---------------------------
 
-Since CVS is effectively dead for LTP proper, we ask that you submit
-patches that are git friendly and patchable.
+Submit patches that are git friendly and patchable.
 
 Guidelines for submitting patches are as follows:
 
 1. Use +git commit -s+ . You know you want to ;) .. (you may need to
-   submit a correct signed-off-by line, e.g. use git config first).
+   submit a correct Signed-off-by line, e.g. use git config first).
 2. Provide a short (<= 50 character) description of the commit.
 3. Provide a little more terse (1-2 paragraph maximum, <= 72 character
    lines) description of what the commit does.
-- 
2.25.1

