From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 28 Jul 2020 00:30:40 +0200
Subject: [LTP] [PATCH v5 3/4] IMA/ima_keys.sh: Fix policy readability check
In-Reply-To: <20200727223041.13110-1-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
Message-ID: <20200727223041.13110-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Using a proper check with cat, because file attributes were fixed in
ffb122de9a60 ("ima: Reflect correct permissions for policy") in v4.18.

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* use require_ima_policy_content
* moved helper function to previous commit

 .../kernel/security/integrity/ima/tests/ima_keys.sh    | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 2f6c2b027..5a77deec1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -19,15 +19,7 @@ test1()
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
-
-	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
-
-	keycheck_lines=$(grep "func=KEY_CHECK" $IMA_POLICY)
-	if [ -z "$keycheck_lines" ]; then
-		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
-	fi
-
+	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
 	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
 
 	if [ -z "$keycheck_line" ]; then
-- 
2.27.0

