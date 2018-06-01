From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 09:28:34 +0200
Subject: [LTP] [RFC PATCH v6 1/5] tst_test.sh: Hide "private" variables with
	"_tst_" prefix
In-Reply-To: <20180601072838.13196-1-pvorel@suse.cz>
References: <20180601072838.13196-1-pvorel@suse.cz>
Message-ID: <20180601072838.13196-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Variables in tst_run and out of functions are visible to the test.
Adding prefix "_tst_" manifest they're private.

NOTE: kept $res from tst_run() as it's going to be moved into separate
function in new commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 57 +++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 779383392..337d33ca4 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -32,7 +32,7 @@ export TST_TMPDIR_RHOST=0
 
 . tst_ansi_color.sh
 
-tst_do_exit()
+_tst_do_exit()
 {
 	local ret=0
 
@@ -79,7 +79,7 @@ tst_do_exit()
 	exit $ret
 }
 
-tst_inc_res()
+_tst_inc_res()
 {
 	case "$1" in
 	TPASS) TST_PASS=$((TST_PASS+1));;
@@ -100,7 +100,7 @@ tst_res()
 	tst_color_enabled
 	local color=$?
 
-	tst_inc_res "$res"
+	_tst_inc_res "$res"
 
 	printf "$TST_ID $TST_COUNT "
 	tst_print_colored $res "$res: "
@@ -113,7 +113,7 @@ tst_brk()
 	shift
 
 	tst_res "$res" "$@"
-	tst_do_exit
+	_tst_do_exit
 }
 
 ROD_SILENT()
@@ -230,14 +230,14 @@ tst_usage()
 	echo "-i n    Execute test n times"
 }
 
-tst_resstr()
+_tst_resstr()
 {
 	echo "$TST_PASS$TST_FAIL$TST_CONF"
 }
 
-tst_rescmp()
+_tst_rescmp()
 {
-	local res=$(tst_resstr)
+	local res=$(_tst_resstr)
 
 	if [ "$1" = "$res" ]; then
 		tst_brk TBROK "Test didn't report any results"
@@ -246,31 +246,30 @@ tst_rescmp()
 
 tst_run()
 {
-	local tst_i
+	local _tst_i
+	local _tst_name
 
 	if [ -n "$TST_TEST_PATH" ]; then
-		for tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
-			case "$tst_i" in
+		for _tst_i in $(grep TST_ "$TST_TEST_PATH" | sed 's/.*TST_//; s/[="} \t\/:`].*//'); do
+			case "$_tst_i" in
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
 			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
 			NEEDS_ROOT|NEEDS_TMPDIR|NEEDS_DEVICE|DEVICE);;
 			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
 			IPV6);;
-			*) tst_res TWARN "Reserved variable TST_$tst_i used!";;
+			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
 			esac
 		done
 	fi
 
-	local name
-
 	OPTIND=1
 
-	while getopts "hi:$TST_OPTS" name $TST_ARGS; do
-		case $name in
+	while getopts "hi:$TST_OPTS" _tst_name $TST_ARGS; do
+		case $_tst_name in
 		'h') tst_usage; exit 0;;
 		'i') TST_ITERATIONS=$OPTARG;;
 		'?') tst_usage; exit 2;;
-		*) $TST_PARSE_ARGS "$name" "$OPTARG";;
+		*) $TST_PARSE_ARGS "$_tst_name" "$OPTARG";;
 		esac
 	done
 
@@ -350,35 +349,35 @@ tst_run()
 	while [ $TST_ITERATIONS -gt 0 ]; do
 		if [ -n "$TST_CNT" ]; then
 			if type ${TST_TESTFUNC}1 > /dev/null 2>&1; then
-				for tst_i in $(seq $TST_CNT); do
-					local res=$(tst_resstr)
-					$TST_TESTFUNC$tst_i
-					tst_rescmp "$res"
+				for _tst_i in $(seq $TST_CNT); do
+					local _tst_res=$(_tst_resstr)
+					$TST_TESTFUNC$_tst_i
+					_tst_rescmp "$_tst_res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			else
-				for tst_i in $(seq $TST_CNT); do
-					local res=$(tst_resstr)
-					$TST_TESTFUNC $tst_i
-					tst_rescmp "$res"
+				for _tst_i in $(seq $TST_CNT); do
+					local _tst_res=$(_tst_resstr)
+					$TST_TESTFUNC $_tst_i
+					_tst_rescmp "$_tst_res"
 					TST_COUNT=$((TST_COUNT+1))
 				done
 			fi
 		else
-			local res=$(tst_resstr)
+			local _tst_res=$(_tst_resstr)
 			$TST_TESTFUNC
-			tst_rescmp "$res"
+			_tst_rescmp "$_tst_res"
 			TST_COUNT=$((TST_COUNT+1))
 		fi
 		TST_ITERATIONS=$((TST_ITERATIONS-1))
 	done
 
-	tst_do_exit
+	_tst_do_exit
 }
 
 if [ -z "$TST_ID" ]; then
-	filename=$(basename $0)
-	TST_ID=${filename%%.*}
+	_tst_filename=$(basename $0)
+	TST_ID=${_tst_filename%%.*}
 fi
 export TST_ID="$TST_ID"
 
-- 
2.16.3

