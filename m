From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 12:58:23 +0200
Subject: [LTP] [PATCH 1/2] doc/user-guide: Shorten the description
Message-ID: <20200929105824.28793-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/user-guide.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/user-guide.txt b/doc/user-guide.txt
index 13865bc88..5cb8322cf 100644
--- a/doc/user-guide.txt
+++ b/doc/user-guide.txt
@@ -1,7 +1,7 @@
 LTP User Guidelines
 ===================
 
-For compiling and installing and running the tests see `README.md`.
+For compiling, installing and running the tests see `README.md`.
 For running LTP network tests see `testcases/network/README.md`.
 
 1. Library environment variables
@@ -18,8 +18,8 @@ For running LTP network tests see `testcases/network/README.md`.
                           Variable is also used in shell tests, but ceiled to int.
 | 'PATH'                | It's required to addjust path:
                           `PATH="$PATH:$LTPROOT/testcases/bin"`
-| 'TMPDIR'              | Base directory for template directory, which is required by C tests
-                          `tst_test->needs_tmpdir=1` (or others) or shell 'TST_NEEDS_TMPDIR=1').
+| 'TMPDIR'              | Base directory for template directory (C: '.needs_tmpdir = 1'
+                          and others, which imply it, shell: 'TST_NEEDS_TMPDIR=1').
 | 'TST_NO_CLEANUP'      | Disable running test cleanup (defined in 'TST_CLEANUP').
 |==============================================================================
 
-- 
2.28.0

