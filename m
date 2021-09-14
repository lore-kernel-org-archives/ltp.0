From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Sep 2021 10:14:02 +0200
Subject: [LTP] [PATCH 1/1] ima_tpm.sh: Check TCONF in ima_boot_aggregate
Message-ID: <20210914081402.5931-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This fixes false positive when compiling LTP without openssl headers on
system with TPM 1.2 without evmctl (or old version):

ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TINFO: using command: ima_boot_aggregate -f /sys/kernel/security/tpm0/binary_bios_measurements
tst_test.c:881: TCONF: libcrypto and openssl development packages required
ima_tpm 1 TFAIL: failed to get boot aggregate

For fixing we need to run TCONF in shell, because TCONF from C is not
propagated to shell:
tst_test.c:948: TCONF: libcrypto and openssl development packages required
ima_tpm 1 TCONF: ima_boot_aggregate -f /sys/kernel/security/tpm0/binary_bios_measurements returned TCONF

Fixes: 0f86f185a ("ima_tpm.sh: Fix calculating boot aggregate")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 71083efd8..59df20cc1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -208,7 +208,15 @@ test1_hw_tpm()
 			return
 		fi
 		tst_check_cmds ima_boot_aggregate || return
+
 		cmd="ima_boot_aggregate -f $tpm_bios"
+
+		# TCONF: libcrypto and openssl development packages required
+		$cmd
+		if [ $? -eq 32 ]; then
+			tst_res TCONF "$cmd returned TCONF"
+			return
+		fi
 	fi
 	tst_res TINFO "using command: $cmd"
 
-- 
2.33.0

