From: Alex Henrie <alexh@vpitech.com>
Date: Tue, 14 Sep 2021 10:15:03 -0600
Subject: [LTP] [PATCH ltp v3 2/2] IMA: Add tests for uid, gid, fowner,
 and fgroup options
In-Reply-To: <20210914161503.97495-1-alexh@vpitech.com>
References: <20210914161503.97495-1-alexh@vpitech.com>
Message-ID: <20210914161503.97495-2-alexh@vpitech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Requires "ima: add gid support".

Signed-off-by: Alex Henrie <alexh@vpitech.com>
---
v3:
- Put new tests in their own function
- Don't require sudo or CONFIG_IMA_READ_POLICY=y for all tests
- Increase kernel version requirement for new tests to 5.16
- Delete test file and recreate it with correct ownership for each test
---
 .../integrity/ima/tests/ima_measurements.sh   | 49 ++++++++++++++++++-
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 1927e937c..5d22d12d3 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -8,7 +8,7 @@
 
 TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
-TST_CNT=3
+TST_CNT=4
 TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
@@ -103,7 +103,7 @@ test3()
 	local file="$dir/test.txt"
 
 	# Default policy does not measure user files
-	tst_res TINFO "verify not measuring user files"
+	tst_res TINFO "verify not measuring user files by default"
 	tst_check_cmds sudo || return
 
 	if ! id $user >/dev/null 2>/dev/null; then
@@ -121,4 +121,49 @@ test3()
 	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
 }
 
+test4()
+{
+	local user="nobody"
+
+	tst_check_cmds chgrp chown sg sudo || return
+
+	# try to write to the policy, then check whether it can be written again
+	cat $IMA_POLICY > $IMA_POLICY 2> /dev/null
+	require_policy_writable
+
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via uid"
+	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) uid test" \> $TEST_FILE
+	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
+	ima_check
+
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via fowner"
+	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
+	ROD echo "$(date) fowner test" \> $TEST_FILE
+	chown $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+
+	if tst_kvcmp -lt 5.16; then
+		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
+	fi
+
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via gid"
+	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) gid test" \> $TEST_FILE
+	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
+	ima_check
+
+	ROD rm -f $TEST_FILE
+	tst_res TINFO "verify measuring user files when requested via fgroup"
+	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
+	ROD echo "$(date) fgroup test" \> $TEST_FILE
+	chgrp $user $TEST_FILE
+	cat $TEST_FILE > /dev/null
+	ima_check
+}
+
 tst_run
-- 
2.33.0

