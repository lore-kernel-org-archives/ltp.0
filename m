From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 Jul 2020 09:00:37 +0200
Subject: [LTP] [PATCH v4 1/2] IMA: Fix policy readability check
Message-ID: <20200724070038.29491-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Check with cat, because file attributes were fixed in
ffb122de9a60 ("ima: Reflect correct permissions for policy")
in v4.18.

Added into ima_setup.sh as it'll be used next commit in another test.

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 4 +---
 .../kernel/security/integrity/ima/tests/ima_setup.sh      | 8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 904b7515b..26b8eaf84 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -19,9 +19,7 @@ test1()
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
-
-	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
+	check_policy_readable
 
 	keycheck_lines=$(grep "func=KEY_CHECK" $IMA_POLICY)
 	if [ -z "$keycheck_lines" ]; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 8ae477c1c..458f67c30 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -111,6 +111,14 @@ print_ima_config()
 	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
+check_policy_readable()
+{
+	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
+
+	cat $IMA_POLICY > /dev/null 2>/dev/null || \
+		tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
+}
+
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
-- 
2.27.0

