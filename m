From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jul 2020 00:30:38 +0200
Subject: [LTP] [PATCH v5 1/4] IMA: Rename helper to
 require_ima_policy_cmdline
In-Reply-To: <20200727223041.13110-1-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
Message-ID: <20200727223041.13110-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To be clear we check /proc/cmdline. There will be another helper
function require_ima_policy_content().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5.

 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh    | 2 +-
 .../kernel/security/integrity/ima/tests/ima_measurements.sh     | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index ac209e430..9d86778b6 100755
--- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -19,7 +19,7 @@ setup()
 	[ -f "$EVM_FILE" ] || tst_brk TCONF "EVM not enabled in kernel"
 	[ $(cat $EVM_FILE) -eq 1 ] || tst_brk TCONF "EVM not enabled for this boot"
 
-	check_ima_policy "appraise_tcb"
+	require_ima_policy_cmdline "appraise_tcb"
 
 	lower="$TST_MNTPOINT/lower"
 	upper="$TST_MNTPOINT/upper"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 04d8e6353..9a7500c76 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -15,7 +15,7 @@ TST_NEEDS_DEVICE=1
 
 setup()
 {
-	check_ima_policy "tcb"
+	require_ima_policy_cmdline "tcb"
 
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 8ae477c1c..975ce9cbb 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -54,7 +54,7 @@ compute_digest()
 	return 1
 }
 
-check_ima_policy()
+require_ima_policy_cmdline()
 {
 	local policy="$1"
 	local i
-- 
2.27.0

