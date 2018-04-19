From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 19 Apr 2018 21:54:56 +0200
Subject: [LTP] [RFC PATCH v3 03/10] ima/ima_policy.sh: Improve check of
	policy writability
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Message-ID: <20180419195503.7194-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

+ merge test3 into test2 as we test multiple writes already in test2.

Kernel without CONFIG_IMA_WRITE_POLICY is not possible to repeat writing
into policy. Add check to TCONF in this case.

It's not easy to detect disabled CONFIG_IMA_WRITE_POLICY for different
behavior across kernel versions.
On older kernels (before CONFIG_IMA_WRITE_POLICY enabled) or on new ones
with enabled both CONFIG_IMA_READ_POLICY and CONFIG_IMA_WRITE_POLICY
policy file after writing disappears.

Kernels with enabled CONFIG_IMA_READ_POLICY and (regardless of
CONFIG_IMA_WRITE_POLICY) keeps policy file with the same permissions
600. The only way to detect is is to echo empty string into policy and
detect errno:

       | OLD    | WRITE       | READ && !WRITE | !READ && !WRITE
------------------------------------------------------------------
before | ENOENT | exit code 0 | exit code 0    | exit code 0
after  | EACCES | exit code 0 | EBUSY	       | EACCES

OLD: kernels before CONFIG_IMA_WRITE_POLICY introduced (kernel < 4.5)
READ: CONFIG_IMA_READ_POLICY
WRITE: CONFIG_IMA_WRITE_POLICY

Signed-off-by: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_policy.sh     | 38 ++++++++++------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
index 2efa90038..35eb4055b 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -20,15 +20,24 @@
 # Test replacing the default integrity measurement policy.
 
 TST_SETUP="setup"
-TST_CNT=3
+TST_CNT=2
 
 . ima_setup.sh
 
+check_policy_writable()
+{
+	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
+
+	[ -f /sys/kernel/security/ima/policy ] || tst_brk TCONF "$err"
+	# CONFIG_IMA_READ_POLICY
+	echo "" 2> log > $IMA_POLICY
+	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
+}
+
 setup()
 {
 	IMA_POLICY="$IMA_DIR/policy"
-	[ -f $IMA_POLICY ] || \
-		tst_brk TCONF "IMA policy already loaded and kernel not configured to enable multiple writes it"
+	check_policy_writable
 
 	VALID_POLICY="$TST_DATAROOT/measure.policy"
 	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
@@ -68,6 +77,7 @@ test1()
 
 	local p1
 
+	check_policy_writable
 	load_policy $INVALID_POLICY & p1=$!
 	wait "$p1"
 	if [ $? -ne 0 ]; then
@@ -79,10 +89,11 @@ test1()
 
 test2()
 {
-	tst_res TINFO "verify that policy file is not opened concurrently"
+	tst_res TINFO "verify that policy file is not opened concurrently and able to loaded multiple times"
 
 	local p1 p2 rc1 rc2
 
+	check_policy_writable
 	load_policy $VALID_POLICY & p1=$!
 	load_policy $VALID_POLICY & p2=$!
 	wait "$p1"; rc1=$?
@@ -90,24 +101,9 @@ test2()
 	if [ $rc1 -eq 0 ] && [ $rc2 -eq 0 ]; then
 		tst_res TFAIL "policy opened concurrently"
 	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
-		tst_res TPASS "policy was loaded just by one process"
-	else
-		tst_res TFAIL "problem loading policy"
-	fi
-}
-
-test3()
-{
-	tst_res TINFO "verify that invalid policy isn't loaded"
-
-	local p1
-
-	load_policy $INVALID_POLICY & p1=$!
-	wait "$p1"
-	if [ $? -ne 0 ]; then
-		tst_res TPASS "didn't replace valid policy"
+		tst_res TPASS "policy was loaded just by one process and able to loaded multiple times"
 	else
-		tst_res TFAIL "replaced valid policy"
+		tst_res TFAIL "problem with loading policy (policy should be able to load multiple times)"
 	fi
 }
 
-- 
2.16.3

