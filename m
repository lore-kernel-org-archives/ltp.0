From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 14:25:38 +0200
Subject: [LTP] [RFC PATCH 1/1] lib, commands: Add tst_verify_cmd() and use it
Message-ID: <20180329122538.7088-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

draft of function somehow similar to
EXPECT_PASS()/ EXPECT_FAIL() or tst_check_cmds()
More tests using very similar code:
testcases/commands/which/which01.sh
testcases/commands/wc/wc01.sh
testcases/commands/unshare/unshare01.sh
testcases/commands/mkswap/mkswap01.sh
testcases/commands/mkfs/mkfs01.sh
testcases/commands/du/du01.sh

The question is how to add reqexp pattern (env. variable or getopts?)
and what would be the best default regexp.

Kind regards,
Petr
---
 testcases/commands/df/df01.sh | 51 ++++++-------------------------------------
 testcases/lib/tst_test.sh     | 32 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 44 deletions(-)

diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 139230396..2444a110c 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -79,10 +79,7 @@ df_test()
 {
 	cmd="$1 -P"
 
-	df_verify $cmd
-	if [ $? -ne 0 ]; then
-		return
-	fi
+	tst_verify_cmd -o output -n $cmd || return
 
 	df_check $cmd
 	if [ $? -ne 0 ]; then
@@ -92,10 +89,7 @@ df_test()
 
 	ROD_SILENT dd if=/dev/zero of=mntpoint/testimg bs=1024 count=1024
 
-	df_verify $cmd
-	if [ $? -ne 0 ]; then
-		return
-	fi
+	tst_verify_cmd -o output -n $cmd || return
 
 	df_check $cmd
 	if [ $? -eq 0 ]; then
@@ -110,22 +104,6 @@ df_test()
 	sync
 }
 
-df_verify()
-{
-	$@ >output 2>&1
-	if [ $? -ne 0 ]; then
-		grep -q -E "unrecognized option | invalid option" output
-		if [ $? -eq 0 ]; then
-			tst_res TCONF "'$1' not supported."
-			return 32
-		else
-			tst_res TFAIL "'$1' failed."
-			cat output
-			return 1
-		fi
-	fi
-}
-
 df_check()
 {
 	if [ "$(echo $@)" = "df -i -P" ]; then
@@ -184,44 +162,29 @@ test7()
 
 test8()
 {
-	df_verify "df -h"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df -h' passed."
-	fi
+	tst_verify_cmd "df -h" || return
 }
 
 test9()
 {
-	df_verify "df -H"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df -H' passed."
-	fi
+	tst_verify_cmd "df -H" || return
 }
 
 test10()
 {
-	df_verify "df -m"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df -m' passed."
-	fi
+	tst_verify_cmd "df -m" || return
 }
 
 test11()
 {
-	df_verify "df --version"
-	if [ $? -eq 0 ]; then
-		tst_res TPASS "'df --version' passed."
-	fi
+	tst_verify_cmd "df --version" || return
 }
 
 test12()
 {
 	cmd="df -x ${DF_FS_TYPE} -P"
 
-	df_verify $cmd
-	if [ $? -ne 0 ]; then
-		return
-	fi
+	tst_verify_cmd -o output -n $cmd || return
 
 	grep ${TST_DEVICE} output | grep -q mntpoint
 	if [ $? -ne 0 ]; then
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 48afb9cc4..6a14a43c8 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -211,6 +211,38 @@ tst_check_cmds()
 	done
 }
 
+tst_verify_cmd()
+{
+	local pattern="${TST_VERIFY_CMD_PATTERN:-unrecognized option|invalid option|unknown option|invalid option|Usage}"
+	local opt OPTIND dont_pass output
+
+	while getopts "no:" opt; do
+		case $opt in
+			'n') dont_pass=1;;
+			'o') output="$OPTARG";;
+			*);;
+		esac
+	done
+	[ ! "$output" ] && output=$(mktemp "./LTP_$TST_ID.XXXXXXXXXX")
+
+	shift $((OPTIND - 1))
+
+	$@ >$output 2>&1
+	if [ $? -ne 0 ]; then
+		grep -q -E "$pattern" $output
+		if [ $? -eq 0 ]; then
+			tst_res TCONF "'$1' not supported."
+			return 32
+		fi
+		tst_res TFAIL "'$1' failed."
+		cat $output
+		return 1
+	fi
+	if [ ! "$dont_pass" ]; then
+		tst_res TPASS "'$1' passed."
+	fi
+}
+
 tst_is_int()
 {
 	[ "$1" -eq "$1" ] 2>/dev/null
-- 
2.16.2

