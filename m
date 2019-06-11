From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 Jun 2019 21:30:20 +0200
Subject: [LTP] [PATCH v3 3/4] ima/ima_measurements.sh: Require builtin IMA
	tcb policy
In-Reply-To: <20190611193021.17651-1-pvorel@suse.cz>
References: <20190611193021.17651-1-pvorel@suse.cz>
Message-ID: <20190611193021.17651-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Although custom policy which contains tcb can be loaded via dracut,
systemd or later manually from user space, detecting it would require
IMA_READ_POLICY=y. In order to simplify the check and avoid false
positives lets ignore this option and require builtin IMA tcb policy.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_measurements.sh    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 328affc43..a3aa24d8a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -57,7 +57,8 @@ setup()
 	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
 		"Cannot find digest index (template: '$template')"
 
-	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tcb)"
+	grep -q -e ima_policy=[a-z_]*tcb -e ima_tcb -e ima_appraise_tcb /proc/cmdline || \
+		tst_brk TCONF "IMA measurement tests require builtin IMA tcb policy (ima_policy=tcb or ima_policy=appraise_tcb kernel parameter)"
 }
 
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
-- 
2.21.0

