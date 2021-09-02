From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  2 Sep 2021 12:37:40 +0200
Subject: [LTP] [PATCH 4/4] doc: Update for vendored checkbashisms.pl
In-Reply-To: <20210902103740.19446-1-pvorel@suse.cz>
References: <20210902103740.19446-1-pvorel@suse.cz>
Message-ID: <20210902103740.19446-5-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/maintainer-patch-review-checklist.txt | 3 +--
 doc/test-writing-guidelines.txt           | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
index c8ace80f7..c7bb47810 100644
--- a/doc/maintainer-patch-review-checklist.txt
+++ b/doc/maintainer-patch-review-checklist.txt
@@ -49,8 +49,7 @@ New test should
 
 ### Shell tests
 * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
-* Check coding style with
-  https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl[checkbashism.pl]
+* Check coding style with `make check`
   (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#132-shell-coding-style[Shell coding style])
 * If a test is a regression test it should include related kernel or glibc commits as a comment
 
diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 8053f0cb0..b87446d1b 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -150,9 +150,13 @@ to 'dash' by default or install 'dash' on your favorite distribution and use
 it to run the tests. If your distribution lacks 'dash' package you can always
 compile it from http://gondor.apana.org.au/~herbert/dash/files/[source].
 
-Debian also has nice devscript
+Run `make check` in the test's directory and/or use `make check-$TCID.sh`,
+it uses (among other checks) our vendored version of
 https://salsa.debian.org/debian/devscripts/raw/master/scripts/checkbashisms.pl[checkbashism.pl]
-that can be used to check for non-portable shell code.
+from Debian, that is used to check for non-portable shell code.
+
+NOTE: If `make check` does not report any problems, the code still may be wrong
+      as `checkbashisms.pl` used for checking only looks for common mistakes.
 
 Here are some common sense style rules for shell
 
-- 
2.33.0

