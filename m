From: Alex Henrie <alexh@vpitech.com>
Date: Thu,  9 Sep 2021 10:51:11 -0600
Subject: [LTP] [PATCH ltp] IMA: Add tests for uid, gid, fowner,
 and fgroup options
In-Reply-To: <20210909165111.51038-1-alexh@vpitech.com>
References: <20210909165111.51038-1-alexh@vpitech.com>
Message-ID: <20210909165111.51038-2-alexh@vpitech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
 .../integrity/ima/tests/ima_measurements.sh   | 37 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1927e937c..3c1bcbf88 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -8,6 +8,7 @@
 
 TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 TST_CNT=3
 TST_NEEDS_DEVICE=1
 
@@ -20,6 +21,13 @@ setup()
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
 	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
+
+	cat $IMA_POLICY > policy-original
+}
+
+cleanup()
+{
+	cat policy-original > $IMA_POLICY
 }
 
 ima_check()
@@ -103,7 +111,7 @@ test3()
 	local file="$dir/test.txt"
 
 	# Default policy does not measure user files
-	tst_res TINFO "verify not measuring user files"
+	tst_res TINFO "verify not measuring user files by default"
 	tst_check_cmds sudo || return
 
 	if ! id $user >/dev/null 2>/dev/null; then
@@ -116,9 +124,34 @@ test3()
 	cd $dir
 	# need to read file to get updated $ASCII_MEASUREMENTS
 	sudo -n -u $user sh -c "echo $(date) user file > $file; cat $file > /dev/null"
+	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
 	cd ..
 
-	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
+	tst_res TINFO "verify measuring user files when requested via uid"
+	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) uid test" \> $TEST_FILE
+	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
+	ima_check
+
+	tst_res TINFO "verify measuring user files when requested via gid"
+	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) gid test" \> $TEST_FILE
+	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
+	ima_check
+
+	tst_res TINFO "verify measuring user files when requested via fowner"
+	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) fowner test" \> $TEST_FILE
+	chown $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+
+	tst_res TINFO "verify measuring user files when requested via fgroup"
+	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) fgroup test" \> $TEST_FILE
+	chgrp $(id -g $user) $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
 }
 
 tst_run
-- 
2.33.0

