From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Aug 2020 11:08:21 +0200
Subject: [LTP] [LTP v4 2/5] IMA/ima_keys.sh: Require template=ima-buf,
 fix grep pattern
In-Reply-To: <20200820090824.3033-1-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
Message-ID: <20200820090824.3033-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

test1 (and following test2 which will be added) require ima-buf template
which contains 'buf' identifier (the buffer data that was used to
generate the hash without size limitations). For simplicity we ignore
custom templates (ima_template_fmt kernel command line parameter), which
could also define it.

Also fix grep format for searching in the policy: add missing '.'
Searching for lines with specified templates *and* keyrings in the
measurement, but there is algorithm and hash in between, thus '.*'.
Previously template was just ignored due using just '*'.

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New commit (maybe I should have split them into 2 commits).

 .../kernel/security/integrity/ima/tests/ima_keys.sh    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 53c289054..015a3c115 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -17,13 +17,15 @@ TST_NEEDS_DEVICE=1
 test1()
 {
 	local keyrings keycheck_lines keycheck_line templates
-	local pattern="func=KEY_CHECK"
+	local func='func=KEY_CHECK'
+	local buf='template=ima-buf'
+	local pattern="($func.*$buf|$buf.*$func)"
 	local test_file="file.txt"
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	require_ima_policy_content "$pattern"
-	keycheck_lines=$(check_ima_policy_content "$pattern" "")
+	require_ima_policy_content "$pattern" '-Eq'
+	keycheck_lines=$(check_ima_policy_content "$pattern" '-E')
 	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
 
 	if [ -z "$keycheck_line" ]; then
@@ -39,7 +41,7 @@ test1()
 	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
 		cut -d'=' -f2)
 
-	grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line
+	grep -E "($templates).*($keyrings)" $ASCII_MEASUREMENTS | while read line
 	do
 		local digest expected_digest algorithm
 
-- 
2.28.0

