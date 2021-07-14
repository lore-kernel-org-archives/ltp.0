From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Jul 2021 08:11:54 +0100
Subject: [LTP] [PATCH v2 4/8] doc: Remind authors and maintainers to run
 make check
In-Reply-To: <20210714071158.15868-1-rpalethorpe@suse.com>
References: <20210714071158.15868-1-rpalethorpe@suse.com>
Message-ID: <20210714071158.15868-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 doc/maintainer-patch-review-checklist.txt | 2 +-
 doc/test-writing-guidelines.txt           | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
index f6682b574..970779acc 100644
--- a/doc/maintainer-patch-review-checklist.txt
+++ b/doc/maintainer-patch-review-checklist.txt
@@ -39,7 +39,7 @@ New test should
 * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#22-writing-a-test-in-c[C API]
 * Test binaries are added into corresponding '.gitignore' files
 * Check coding style with
-  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl]
+  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl[checkpatch.pl] and `make check`
   (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#131-c-coding-style[C coding style])
 * Docparse documentation
 * If a test is a regression test it should include tags
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 74e8ad7ee..e3268852a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -308,6 +308,7 @@ NOTE: See also
 3. The runtest entires are in place
 4. Test binaries are added into corresponding '.gitignore' files
 5. Patches apply over the latest git
+6. 'make check' does not emit any warnings
 
 6.1 About .gitignore files
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-- 
2.31.1

