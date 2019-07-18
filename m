From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 18 Jul 2019 10:39:42 +0200
Subject: [LTP] [PATCH 1/2] shell: Use $LTP_TIMEOUT_MUL also in retry
 functions
Message-ID: <20190718083943.7687-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

in TST_RETRY_FN_EXP_BACKOFF() and thus in TST_RETRY_FUNC() in new shell API.

This function should also address possibility of slow machine.

Because using on 2 places moved the default definition to the beginning
of the script.
+ use $((...)) instead of expr.
+ move expression using $3 after check whether we have enough parameters

+ document LTP_TIMEOUT_MUL environment variable in wiki.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I can squash these 2 commits.

General question about Test Writing Guidelines in wiki [1]:
1) we have separate section for C and shell API, which is probably a good
choice, but we're trying to sync them. That leads to things like retry
function documented under chapter for shell API (2.3).

+ That page is too long and without table of contents (not easy to
navigate in it; I tried to add TOC, but without success). Maybe adding
TOC or split the page to 3: 1) general info 2) C API 3) shell API would
help. WDYT?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
[2] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#retry-a-function-in-limited-time

 doc/test-writing-guidelines.txt | 2 ++
 testcases/lib/tst_test.sh       | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 869e6ed35..782e14f32 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -1881,6 +1881,8 @@ simply by setting right '$TST_NEEDS_FOO'.
                        the test (see below).
 | 'TST_NEEDS_MODULE' | Test module name needed for the test (see below).
 | 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
+| 'LTP_TIMEOUT_MUL'  | Multiply timeout (> 1 is useful for slow machines to
+                       avoid unexpected timeout).
 |=============================================================================
 
 Checking for presence of commands
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 31b3a3951..60d765424 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -17,6 +17,8 @@ export TST_ITERATIONS=1
 export TST_TMPDIR_RHOST=0
 export TST_LIB_LOADED=1
 
+export LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
+
 . tst_ansi_color.sh
 . tst_security.sh
 
@@ -164,12 +166,13 @@ TST_RETRY_FN_EXP_BACKOFF()
 {
 	local tst_fun="$1"
 	local tst_exp=$2
-	local tst_sec=$(expr $3 \* 1000000)
 	local tst_delay=1
+	local tst_sec
 
 	if [ $# -ne 3 ]; then
 		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF expects 3 parameters"
 	fi
+	tst_sec=$(($3 * LTP_TIMEOUT_MUL * 1000000))
 
 	if ! tst_is_int "$tst_sec"; then
 		tst_brk TBROK "TST_RETRY_FN_EXP_BACKOFF: tst_sec must be integer ('$tst_sec')"
@@ -185,7 +188,7 @@ TST_RETRY_FN_EXP_BACKOFF()
 			tst_sleep ${tst_delay}us
 			tst_delay=$((tst_delay*2))
 		else
-			tst_brk TBROK "\"$tst_fun\" timed out"
+			tst_brk TBROK "\"$tst_fun\" timed out! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
 		fi
 	done
 
@@ -374,8 +377,6 @@ _tst_rescmp()
 
 _tst_setup_timer()
 {
-	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
-
 	local sec=$((300 * LTP_TIMEOUT_MUL))
 	local h=$((sec / 3600))
 	local m=$((sec / 60 % 60))
-- 
2.22.0

