Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XqLdv-0006KY-2p
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:42:55 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XqLdt-0004Ug-IG
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:42:55 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAHCgWhu022926
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 20:42:32 +0800
Message-ID: <1416228049.10929.5.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 17 Nov 2014 20:40:49 +0800
In-Reply-To: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
References: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/5] ima_tpm.sh: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Use 'tst_check_cmds' instead of 'exists'.

* Use 'test_resm' instead of 'tst_res'.

* Use '$()' instead of '``'.

* Delete some unuseful comments.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../kernel/security/integrity/ima/tests/ima_tpm.sh | 114 +++++++--------------
 1 file changed, 39 insertions(+), 75 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 3e125cb..77e7f2f 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -29,60 +29,45 @@
 # Return        - zero on success
 #               - non zero on failure. return value from commands ($RC)
 ################################################################################
+export TST_TOTAL=3
+export TCID="ima_tpm"
+export TST_COUNT=0
+
 init()
 {
-	export TST_TOTAL=3
-	export TCID="init"
-	export TST_COUNT=0
-	RC=0
-
-	# verify ima_boot_aggregate is available
-	exists ima_boot_aggregate ima_measure
-
+	tst_check_cmds ima_boot_aggregate ima_measure
 }
 
 # Function:     test01
 # Description   - Verify boot aggregate value is correct
 test01()
 {
-	TCID="test01"
-	TST_COUNT=1
-	RC=0
 	zero="0000000000000000000000000000000000000000"
 
 	# IMA boot aggregate
 	ima_measurements=$SECURITYFS/ima/ascii_runtime_measurements
 	read line < $ima_measurements
-	ima_aggr=`expr substr "${line}" 49 40`
+	ima_aggr=$(expr substr "${line}" 49 40)
 
 	# verify TPM is available and enabled.
 	tpm_bios=$SECURITYFS/tpm0/binary_bios_measurements
 	if [ ! -f "$tpm_bios" ]; then
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: no TPM, TPM not builtin kernel, or TPM not enabled"
+		tst_brkm TCONF "TPM not builtin kernel, or TPM not enabled"
 
-		[ "${ima_aggr}" = "${zero}" ] || RC=$?
-		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$ \
-			 "$TCID: bios boot aggregate is 0."
+		if [ "${ima_aggr}" = "${zero}" ]; then
+			tst_resm TPASS "bios boot aggregate is 0."
 		else
-			tst_res TFAIL $LTPTMP/imalog.$$ \
-			 "$TCID: bios boot aggregate is not 0."
+			tst_resm TFAIL "bios boot aggregate is not 0."
 		fi
 	else
-		boot_aggregate=`ima_boot_aggregate $tpm_bios`
-		boot_aggr=`expr substr $boot_aggregate 16 40`
-		[ "x${ima_aggr}" = "x${boot_aggr}" ] || RC=$?
-		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$ \
-			 "$TCID: bios aggregate matches IMA boot aggregate."
+		boot_aggregate=$(ima_boot_aggregate $tpm_bios)
+		boot_aggr=$(expr substr $boot_aggregate 16 40)
+		if [ "x${ima_aggr}" = "x${boot_aggr}" ]; then
+			tst_resm TPASS "bios aggregate matches IMA boot aggregate."
 		else
-			tst_res TFAIL $LTPTMP/imalog.$$ \
-			 "$TCID: bios aggregate does not match IMA boot " \
-				"aggregate."
+			tst_resm TFAIL "bios aggregate does not match IMA boot aggregate."
 		fi
 	fi
-	return $RC
 }
 
 # Probably cleaner to programmatically read the PCR values directly
@@ -96,11 +81,12 @@ validate_pcr()
 	RC=0
 
 	while read line ; do
-		pcr=`expr substr "${line}" 1 6`
+		pcr=$(expr substr "${line}" 1 6)
 		if [ "${pcr}" = "PCR-10" ]; then
-			aggr=`expr substr "${aggregate_pcr}" 26 59`
-			pcr=`expr substr "${line}" 9 59`
+			aggr=$(expr substr "${aggregate_pcr}" 26 59)
+			pcr=$(expr substr "${line}" 9 59)
 			[ "${pcr}" = "${aggr}" ] || RC=$?
+			[ "${pcr}" = "${aggr}" ]
 		fi
 	done < $dev_pcrs
 	return $RC
@@ -111,64 +97,42 @@ validate_pcr()
 #		  actual PCR value.
 test02()
 {
-	TCID="test02"
-	TST_COUNT=2
-	RC=0
 
 	# Would be nice to know where the PCRs are located.  Is this safe?
-	PCRS_PATH=`find /$SYSFS/devices/ | grep pcrs` || RC=$?
-	if [ $RC -eq 0 ]; then
-		validate_pcr $PCRS_PATH || RC=$?
-		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$ \
-			 "$TCID: aggregate PCR value matches real PCR value."
+	PCRS_PATH=$(find /$SYSFS/devices/ | grep pcrs)
+	if [ $? -eq 0 ]; then
+		validate_pcr $PCRS_PATH
+		if [ $? -eq 0 ]; then
+			tst_resm TPASS "aggregate PCR value matches real PCR value."
 		else
-			tst_res TFAIL $LTPTMP/imalog.$$ \
-			 "$TCID: aggregate PCR value does not match" \
-			 " real PCR value."
+			tst_resm TFAIL "aggregate PCR value does not match real PCR value."
 		fi
 	else
-		tst_res TFAIL $LTPTMP/imalog.$$ \
-		 "$TCID: TPM not enabled, no PCR value to validate"
+		tst_resm TFAIL "TPM not enabled, no PCR value to validate"
 	fi
-	return $RC
 }
 
 # Function:     test03
 # Description 	- Verify template hash value for IMA entry is correct.
 test03()
 {
-	TCID="test03"
-	TST_COUNT=3
-	RC=0
 
 	ima_measurements=$SECURITYFS/ima/binary_runtime_measurements
-	aggregate_pcr=`ima_measure $ima_measurements --verify --validate` > /dev/null
-	RC=$?
-	if [ $RC -eq 0 ]; then
-		tst_res TPASS $LTPTMP/imalog.$$ \
-		 "$TCID: verified IMA template hash values."
+	aggregate_pcr=$(ima_measure $ima_measurements --verify --validate) > /dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "verified IMA template hash values."
 	else
-		tst_res TFAIL $LTPTMP/imalog.$$ \
-		 "$TCID: error verifing IMA template hash values."
+		tst_resm TFAIL "error verifing IMA template hash values."
 	fi
-	return $RC
 }
 
-# Function:     main
-#
-# Description:  - Execute all tests, exit with test status.
-#
-# Exit:         - zero on success
-#               - non-zero on failure.
-#
-RC=0    # Return value from setup, and test functions.
-EXIT_VAL=0
+. ima_setup.sh
+TST_CLEANUP=cleanup
+
+setup
+init
+test01
+test02
+test03
 
-. $(dirname "$0")/ima_setup.sh
-setup || exit $?
-init || exit $?
-test01 || EXIT_VAL=$RC
-test02 || EXIT_VAL=$RC
-test03 || EXIT_VAL=$RC
-exit $EXIT_VAL
+tst_exit
-- 
1.8.3.1




------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
