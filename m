From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 09:28:36 +0200
Subject: [LTP] [RFC PATCH v6 3/5] tst_test.sh: Filter out commented out
	lines from warnings
In-Reply-To: <20180601072838.13196-1-pvorel@suse.cz>
References: <20180601072838.13196-1-pvorel@suse.cz>
Message-ID: <20180601072838.13196-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index de5d65039..098ff7bd2 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -244,13 +244,21 @@ _tst_rescmp()
 	fi
 }
 
+_tst_get_used_var()
+{
+	local _tst_pattern="$1"
+
+	grep $_tst_pattern "$TST_TEST_PATH" | grep -v '^[[:space:]]*#' | \
+		sed "s/.*${_tst_pattern}//;"' s/[="} \t\/:`].*//'
+}
+
 tst_run()
 {
 	local _tst_i
 	local _tst_name
 
 	if [ -n "$TST_TEST_PATH" ]; then
-		for _tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(_tst_get_used_var "TST_"); do
 			case "$_tst_i" in
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
@@ -261,7 +269,7 @@ tst_run()
 			esac
 		done
 
-		for _tst_i in $(grep _tst_ "$TST_TEST_PATH" | sed 's/.*_tst_//; s/[="} \t\/:`].*//'); do
+		for _tst_i in $(_tst_get_used_var "_tst_"); do
 			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
 		done
 	fi
-- 
2.16.3

