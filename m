From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  9 Aug 2019 09:52:44 +0200
Subject: [LTP] [PATCH] tst_test.sh: Reduce false positives in reserved
 variable warnings
Message-ID: <20190809075244.17950-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

"Reserved variable TST_FOO used!" and "Private variable or function
_tst_foo used!" reports some false positive.

Filter out commented code and variables and functions not starting with
searched prefix (foo_tst_bar() or $foo_tst_bar).

NOTE: There are still some false positives (e.g. echo "echo
TST_SHOULD_NOT_BE_FOUND"), but let's not complicate the regexp too much.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 31b3a3951..f779cc471 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -402,7 +402,7 @@ tst_run()
 	local _tst_name
 
 	if [ -n "$TST_TEST_PATH" ]; then
-		for _tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
 			case "$_tst_i" in
 			DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
@@ -417,7 +417,7 @@ tst_run()
 			esac
 		done
 
-		for _tst_i in $(grep _tst_ "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
 			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
 		done
 	fi
-- 
2.22.0

