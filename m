From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 31 Aug 2021 13:25:53 +0100
Subject: [LTP] [PATCH 1/2] docs: rm explicit reference to checkpatch.pl
Message-ID: <20210831122554.14590-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is included in `make check` now.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/maintainer-patch-review-checklist.txt | 3 +--
 doc/test-writing-guidelines.txt           | 5 ++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
index 58662bed1..c8ace80f7 100644
--- a/doc/maintainer-patch-review-checklist.txt
+++ b/doc/maintainer-patch-review-checklist.txt
@@ -38,8 +38,7 @@ New test should
 ### C tests
 * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
 * Test binaries are added into corresponding '.gitignore' files
-* Check coding style with
-  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl] and `make check`
+* Check coding style with `make check`
   (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#21-c-coding-style[C coding style])
 * Docparse documentation
 * If a test is a regression test it should include tags
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 340c80cc6..e95373e84 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -305,12 +305,11 @@ NOTE: See also
       https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist[Maintainer Patch Review Checklist].
 
 1. Test compiles and runs fine (check with `-i 10` too)
-2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
-   does not report any errors
+2. `make check` does not emit any warnings for the test you are working on
+   (hint: run it in the test's directory and/or use `make check-$TCID`)
 3. The runtest entires are in place
 4. Test binaries are added into corresponding '.gitignore' files
 5. Patches apply over the latest git
-6. 'make check' does not emit any warnings
 
 6.1 About .gitignore files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.31.1

