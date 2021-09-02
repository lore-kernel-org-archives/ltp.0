From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Sep 2021 12:37:37 +0200
Subject: [LTP] [PATCH 1/4] doc: Mention make check
In-Reply-To: <20210902103740.19446-1-pvorel@suse.cz>
References: <20210902103740.19446-1-pvorel@suse.cz>
Message-ID: <20210902103740.19446-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

and our version of checkpatch.pl instead of suggesting to use upstream
on remaining places (just to be consistent).

Fixes: 4c1e61cc7 ("docs: rm explicit reference to checkpatch.pl")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-tutorial-simple.txt  | 21 ++++++++++-----------
 doc/test-writing-guidelines.txt | 10 +++++-----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
index aa6d19f8d..bacf2f1d9 100644
--- a/doc/c-test-tutorial-simple.txt
+++ b/doc/c-test-tutorial-simple.txt
@@ -228,12 +228,12 @@ the lines starting with a +++.
 --------------------------------------------------------------------------------
  statvfs01 statvfs01
  statvfs02 statvfs02
- 
+
 +statx01 statx01
 +
  stime01 stime01
  stime02 stime02
- 
+
 --------------------------------------------------------------------------------
 
 The +runtest+ files are in a two column format. The first column is the test
@@ -306,12 +306,11 @@ Wiki]).
 
 Is your +.gitignore+ correct?
 
-3.3 Run checkpatch.pl on the source file
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+3.3 Run make check
+~~~~~~~~~~~~~~~~~~
 
-The LTP follows the Linux style guidelines where possible. Check what happens
-if you run +kernel/linux/scripts/checkpatch.pl --no-tree -f statx01.c+ and
-correct any style issues.
+Check coding style with `make check`
+ (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#21-c-coding-style[C coding style])
 
 3.4 Install the LTP and run the test with runtest
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -767,7 +766,7 @@ failing due to some faulty logic.
 6.1 What is wrong with the switch statement?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-Were you paying attention? Also see the output of +checkpatch.pl+.
+Were you paying attention? Also see the output of +make check+.
 
 6.2 Test a feature unique to statx
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -795,9 +794,9 @@ of fallback logic in the build system. We can now get our test ready for
 submission.
 
 The first thing you need to do before considering submitting your test is run
-+scripts/checkpatch.pl --no-tree -f+ on +statx01.c+. Again, we use the kernel
-style guidelines where possible. Next you should create a new branch, this
-will allow you to reshape your commit history without fear.
++make check-statx01+ or + make check+ in the test's directory. Again, we use
+the kernel style guidelines where possible. Next you should create a new
+branch, this will allow you to reshape your commit history without fear.
 
 After that we have the pleasure of doing an interactive 'rebase' to clean up
 our commit history. In its current form the test only really needs a single
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 12fe4922a..8053f0cb0 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -125,13 +125,13 @@ LTP adopted Linux kernel coding style. If you aren't familiar with its rules
 locate 'linux/Documentation/CodingStyle' in the kernel sources and read it,
 it's a well written introduction.
 
-There is also
+Run `make check` in the test's directory and/or use `make check-$TCID`,
+it uses (among other checks) our vendored version of
 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
-script from kernel git tree which can be used to check your patches before the
-submission. Please use reasonably recent one.
+script from kernel git tree.
 
-NOTE: If checkpatch.pl does not report any problems, the code still may be wrong
-      as the tool only looks for common mistakes.
+NOTE: If `make check` does not report any problems, the code still may be wrong
+      as all tools used for checking only look for common mistakes.
 
 2.2 Shell coding style
 ^^^^^^^^^^^^^^^^^^^^^^
-- 
2.33.0

