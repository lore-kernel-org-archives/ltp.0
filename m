From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Jul 2021 17:17:36 +0200
Subject: [LTP] [PATCH 2/2] Replace the xxd utility with tst_hexdump
In-Reply-To: <20210726151736.14299-1-mdoucha@suse.cz>
References: <20210726151736.14299-1-mdoucha@suse.cz>
Message-ID: <20210726151736.14299-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The xxd utility is part of Vim suite and may not be available on embedded
systems. Replace it with internal LTP helper program.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Note: I couldn't test ima_selinux.sh changes because SLES kernel don't support
measure func=CRITICAL_DATA yet. ima_keys.sh appears to work correctly.

 testcases/kernel/security/integrity/ima/tests/ima_keys.sh   | 6 +++---
 .../kernel/security/integrity/ima/tests/ima_selinux.sh      | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 3476b8007..995a55fed 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -6,7 +6,7 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="cmp cut grep sed xxd"
+TST_NEEDS_CMDS="cmp cut grep sed"
 TST_CNT=2
 TST_NEEDS_DEVICE=1
 TST_SETUP=setup
@@ -82,7 +82,7 @@ test1()
 		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
 		keyring=$(echo "$line" | cut -d' ' -f5)
 
-		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
+		echo "$line" | cut -d' ' -f6 | tst_hexdump -d > $test_file
 
 		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
 			tst_res TCONF "cannot compute digest for $algorithm"
@@ -126,7 +126,7 @@ test2()
 		tst_brk TBROK "unable to import a certificate into $keyring_name keyring"
 
 	grep $keyring_name $ASCII_MEASUREMENTS | tail -n1 | cut -d' ' -f6 | \
-		xxd -r -p > $temp_file
+		tst_hexdump -d > $temp_file
 
 	if [ ! -s $temp_file ]; then
 		tst_res TFAIL "keyring $keyring_name not found in $ASCII_MEASUREMENTS"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index c2af0e298..a4eb60b16 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -100,8 +100,6 @@ test1()
 # configuration.
 test2()
 {
-	tst_check_cmds xxd || return
-
 	local measured_data state_file="$TST_TMPDIR/selinux_state.txt"
 	local data_source_name="selinux"
 	local pattern="data_sources=[^[:space:]]*$data_source_name"
@@ -127,7 +125,7 @@ test2()
 	digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
 	algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
 
-	echo "$line" | cut -d' ' -f6 | xxd -r -p > $state_file
+	echo "$line" | cut -d' ' -f6 | tst_hexdump -d > $state_file
 
 	expected_digest="$(compute_digest $algorithm $state_file)" || \
 	tst_brk TCONF "cannot compute digest for $algorithm"
-- 
2.32.0

