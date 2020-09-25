From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Sep 2020 20:50:30 +0200
Subject: [LTP] [PATCH v2 0/4] TPM 2.0 fixes in IMA tests
Message-ID: <20200925185034.24155-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

v2 to fix bugs related to legacy ima_boot_aggregate:
* exit with TPASS to keep API happy
* add missing ! in algorithm condition
* missing -f $tpm_bios parameter
* reintroduce check for ima_boot_aggregate presence

Sorry for the noise

Kind regards,
Petr

diff --git testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
index 318d9c299..67f97ea04 100644
--- testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
+++ testcases/kernel/security/integrity/ima/src/ima_boot_aggregate.c
@@ -117,8 +117,9 @@ static void do_test(void)
 	}
 	SHA1_Final(boot_aggregate, &c);
 
-	printf("boot_aggregate:");
+	printf("sha1:");
 	display_sha1_digest(boot_aggregate);
+	tst_res(TPASS, "found sha1 hash");
 }
 
 static struct tst_option options[] = {
diff --git testcases/kernel/security/integrity/ima/tests/ima_tpm.sh testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 300c96f64..78e81ed64 100755
--- testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -31,7 +31,7 @@ setup()
 
 	if ! check_evmctl $EVMCTL_REQUIRED; then
 		MISSING_EVMCTL=1
-		if [ "$ALGORITHM" = "sha1" ]; then
+		if [ "$ALGORITHM" != "sha1" ]; then
 			tst_brk TCONF "algorithm not sha1 ($ALGORITHM), $ERRMSG_EVMCTL"
 		fi
 	fi
@@ -159,7 +159,8 @@ test1()
 			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
 			return
 		fi
-		cmd="ima_boot_aggregate"
+		tst_check_cmds ima_boot_aggregate || return
+		cmd="ima_boot_aggregate -f $tpm_bios"
 	fi
 	tst_res TINFO "using command: $cmd"
 

Petr Vorel (4):
  IMA: Move get_algorithm_digest(), set_digest_index() to ima_setup.sh
  IMA: Rewrite ima_boot_aggregate.c to new API
  ima_tpm.sh: Fix calculating boot aggregate
  ima_tpm.sh: Fix calculating PCR aggregate

 .../integrity/ima/src/ima_boot_aggregate.c    | 113 ++++-----
 .../integrity/ima/tests/ima_measurements.sh   |  62 +----
 .../security/integrity/ima/tests/ima_setup.sh |  70 +++++
 .../security/integrity/ima/tests/ima_tpm.sh   | 239 +++++++++++++-----
 4 files changed, 314 insertions(+), 170 deletions(-)

-- 
2.28.0

