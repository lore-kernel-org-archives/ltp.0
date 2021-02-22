From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Sun, 21 Feb 2021 18:34:21 -0800
Subject: [LTP] [PATCH] IMA: Check for ima-buf template is not required for
 keys tests
Message-ID: <20210222023421.12576-1-nramas@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ima-buf is the default IMA template used for all buffer measurements.
Therefore, IMA policy rule for measuring keys need not specify
an IMA template.

Update keys tests to not check for ima template in the policy rule.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
This patch is based
in https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
in branch ima/selinux.v2.draft.

 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..a3a7afbf7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
 . ima_setup.sh
 
 FUNC_KEYCHECK='func=KEY_CHECK'
-TEMPLATE_BUF='template=ima-buf'
-REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
+REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK)"
 
 setup()
 {
@@ -33,7 +32,7 @@ check_keys_policy()
 	local pattern="$1"
 
 	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
 		return 1
 	fi
 	return 0
-- 
2.30.0

