From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 31 Aug 2020 17:59:53 +0200
Subject: [LTP] [PATCH 1/1] ima_keys.sh: Fix umount on tmpfs
Message-ID: <20200831155953.10899-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

write policy.txt always to $TST_TMPDIR otherwise tst_umount will fail on
/tmp being tmpfs, for which we mount loop device and cd into it:

umount: /tmp/LTP_ima_keys.hPVaEbz34L/mntpoint: target is busy.
ima_keys 1 TINFO: umount(/dev/loop0) failed, try 1 ...
ima_keys 1 TINFO: Likely gvfsd-trash is probing newly mounted  fs, kill it to speed up tests.
umount: /tmp/LTP_ima_keys.hPVaEbz34L/mntpoint: target is busy.
...
rm: cannot remove '/tmp/LTP_ima_keys.cNyaxGHAQI/mntpoint': Device or resource busy

Fixes: a277498c0 ("IMA/ima_keys.sh: Enhance policy checks")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

sorry for keeping regressions.
It looks like only ima_keys.sh is affected, but maybe I'm wrong.
Tested on tmpfs and btrfs.

Kind regards,
Petr

 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c5a6d2591..c9eef4b68 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -20,7 +20,7 @@ REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_K
 
 setup()
 {
-	require_ima_policy_content "$REQUIRED_POLICY" '-E' > policy.txt
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
 }
 
 cleanup()
@@ -32,7 +32,7 @@ check_keys_policy()
 {
 	local pattern="$1"
 
-	if ! grep -E "$pattern" policy.txt; then
+	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
 		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
 		return 1
 	fi
-- 
2.28.0

