Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@linux.vnet.ibm.com>) id 1MUN3N-0007pm-SK
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 15:51:25 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUN3J-0006ZQ-Fb
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 15:51:25 +0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Fri, 24 Jul 2009 11:51:13 -0400
Message-Id: <1248450673.3628.9.camel@dyn9002018117.watson.ibm.com>
Mime-Version: 1.0
Subject: [LTP] [PATCH] ltp: IMA cross platform fixes
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
To: ltp-list <ltp-list@lists.sf.net>
Cc: Mike Frysinger <vapier@gentoo.org>, waqar afridi <afridi.waqar@gmail.com>, Shaz <shazalive@gmail.com>

- Replace bashisms: source, uid, substr, '&>' - redirection, '=='.
- To create a file using 'sudo -u', some platforms require 'user' to exist.
- Document verifying PCR-10 fails on Ubuntu on reboot due to kexec.
- Determine if the entire boot-aggregate hash value is zero, not just the 
  first couple of characters.
- Add a space before the continuation mark on wrapped lines.
- Explicity verify file open return codes, making sure that only one open 
  succeeded (tpm_policy.sh: test02).

Signed-off-by: Mimi Zohar <zohar@us.ibm.com>

Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -35,9 +35,10 @@ init()
 	export TST_TOTAL=3
 	export TCID="init"
         export TST_COUNT=0
+	RC=0
 
 	# check that sha1sum is installed
-	which sha1sum &> /dev/null || RC=$?
+	which sha1sum >/dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]; then
 		tst_brkm TBROK NULL "$TCID: sha1sum not found"
 		return $RC
@@ -45,7 +46,7 @@ init()
 
 	# verify using default policy
 	if [ ! -f $IMA_DIR/policy ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: not using default policy"
 	fi
 	return $RC
@@ -65,7 +66,7 @@ test01()
 	`date` - this is a test file
 	EOF
 	if [ $RC -ne 0 ]; then
-		tst_brkm TBROK $LTPTMP/imalog.$$\
+		tst_brkm TBROK $LTPTMP/imalog.$$ \
 		 "$TCID: Unable to create test file"
 		return $RC
 	fi
@@ -82,11 +83,11 @@ test01()
 	sleep 1
 	`grep $hash $LTPIMA/measurements > /dev/null` || RC=$?
 	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: TPM ascii measurement list does not contain sha1sum"
 		return $RC
 	else
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: TPM ascii measurement list contains sha1sum"
 	fi
 	return $RC
@@ -114,13 +115,13 @@ test02()
 	`grep $hash $LTPIMA/measurements > /dev/null` || RC=$?
 
 	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: Modified file not measured"
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: iversion not supported; or not mounted with iversion"
 		return $RC
 	else
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: Modified file measured"
 	fi
 	return $RC
@@ -137,12 +138,13 @@ test03()
 
 	# create file user-test.txt
 	mkdir -m 0700 $LTPIMA/user
-	chown 99.99 $LTPIMA/user
+	chown nobody.nobody $LTPIMA/user
 	cd $LTPIMA/user
 	hash=0
 
-	# As user 99, create and cat the new file
-	sudo -u \#99 sh -c "echo `date` - create test.txt > ./test.txt;
+	# As user nobody, create and cat the new file
+	# (The LTP tests assumes existence of 'nobody'.)
+	sudo -u nobody sh -c "echo `date` - create test.txt > ./test.txt;
 				cat ./test.txt > /dev/null"
 
 	# Calculating the hash will add the measurement to the measurement
@@ -157,11 +159,11 @@ test03()
 	grep $hash $LTPIMA/measurements > /dev/null || RC=$?
 	if [ $RC -ne 0 ]; then
 		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: user file test.txt not measured"
 	else
 		RC=1
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: user file test.txt measured"
 	fi
 	return $RC
@@ -176,9 +178,8 @@ test03()
 #
 RC=0
 EXIT_VAL=0
-source `dirname $0`\/ima_setup.sh
+. `dirname $0`\/ima_setup.sh
 setup || exit $RC
-
 init
 test01 || EXIT_VAL=$RC
 test02 || EXIT_VAL=$RC
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
@@ -39,21 +39,21 @@ init()
 	# verify using default policy
 	IMA_POLICY=$IMA_DIR/policy
 	if [ ! -f $IMA_POLICY ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: default policy already replaced"
 		  RC=1
 	fi
 
 	VALID_POLICY=`dirname $0`\/..\/policy/measure.policy
 	if [ ! -f $VALID_POLICY ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: missing $VALID_POLICY"
 		  RC=1
 	fi
 
 	INVALID_POLICY=`dirname $0`\/..\/policy/measure.policy-invalid
 	if [ ! -f $INVALID_POLICY ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: missing $INVALID_POLICY"
 		  RC=1
 	fi
@@ -70,7 +70,7 @@ load_policy()
 	cat $1 |
 	while read line ; do
 	{
-		if [ "${line:0:1}" != "#" ] ; then
+		if [ "${line#\#}" = "${line}" ] ; then
 			echo $line >&4 2> /dev/null
 			if [ $? -ne 0 ]; then
 				exec 4>&-
@@ -95,11 +95,11 @@ test01()
 	wait "$p1"; RC=$?
 	if [ $RC -ne 0 ]; then
 		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: didn't load invalid policy"
 	else
 		RC=1
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: loaded invalid policy"
 	fi
 	return $RC
@@ -118,16 +118,15 @@ test02()
 	load_policy $VALID_POLICY & p2=$!  # forked process 2
 	wait "$p1"; RC1=$?
 	wait "$p2"; RC2=$?
-	RC=$((`expr $RC1 + $RC2`))
-	if [ $RC -eq 1 ]; then
+	if [ $RC1 -eq 0 ] && [ $RC2 -eq 0 ]; then
+		tst_res TFAIL $LTPTMP/imalog.$$ \
+		 "$TCID: measurement policy opened concurrently"
+	elif [ $RC1 -eq 0 ] || [ $RC2 -eq 0 ]; then
 		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: replaced default measurement policy"
-	elif [ $RC -eq 0 ]; then
-		tst_res TFAIL $LTPTMP/imalog.$$\
-		 "$TCID: measurement policy opened concurrently"
 	else
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: problems opening measurement policy"
 	fi
 	return 0
@@ -145,7 +144,7 @@ test03()
 	wait "$p1"; RC=$?
 	if [ $RC -ne 0 ]; then
 		RC=0
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: didn't replace valid policy"
 	else
 		RC=1
@@ -164,7 +163,7 @@ test03()
 RC=0    # Return value from setup, init, and test functions.
 EXIT_VAL=0
 
-source `dirname $0`\/ima_setup.sh
+. `dirname $0`\/ima_setup.sh
 setup || exit $RC
 
 init || exit $RC
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -46,7 +46,7 @@ mount_sysfs()
 mount_securityfs()
 {
 	SECURITYFS=`mount | grep securityfs` || RC=$?
-	if [ $RC == 1 ]; then
+	if [ $RC -eq 1 ]; then
 		SECURITYFS=$SYSFS/kernel/security
 		`mkdir -p $SECURITYFS`
 		`mount -t securityfs securityfs $SECURITYFS`
@@ -77,7 +77,8 @@ setup()
 	fi
 
 	# Must be root
-	if [ $UID -ne 0 ]; then
+	userid=`id -u`
+	if [ $userid -ne 0 ]; then
 		tst_brkm TBROK $LTPTMP/imalog.$$ \
 		 "$TCID: Must be root to execute test"
 		return 1
@@ -92,7 +93,7 @@ setup()
 	# create the temporary directory used by this testcase
 	LTPIMA=$LTPTMP/ima
 	umask 077
-	mkdir $LTPIMA &>/dev/null || RC=$?
+	mkdir $LTPIMA > /dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]; then
 		tst_brk TBROK "$TCID: Unable to create temporary directory"
 		return $RC
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -37,17 +37,17 @@ init()
 	RC=0
 
 	# verify ima_boot_aggregate is available
-	which ima_boot_aggregate &> /dev/null || RC=$?
+	which ima_boot_aggregate >/dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: ima_tpm.sh test requires openssl-devel, skipping"
 		return $RC
 	fi
 
 	# verify ima_measure is available
-	which ima_measure &> /dev/null || RC=$?
+	which ima_measure > /dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: ima_tpm.sh test requires openssl-devel, skipping"
 	fi
 	return $RC
@@ -60,34 +60,36 @@ test01()
 	TCID="test01"
 	TST_COUNT=1
 	RC=0
+	zero="0000000000000000000000000000000000000000"
 
 	# IMA boot aggregate
 	ima_measurements=$SECURITYFS/ima/ascii_runtime_measurements
 	read line < $ima_measurements
+	ima_aggr=`expr substr "${line}" 49 40`
 
 	# verify TPM is available and enabled.
 	tpm_bios=$SECURITYFS/tpm0/binary_bios_measurements
 	if [ ! -f $tpm_bios ]; then
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: no TPM, TPM not builtin kernel, or TPM not enabled"
 
-		[ "${line:49:40}" -eq 0 ] || RC=$?
+		[ "${ima_aggr}" = "${zero}" ] || RC=$?
 		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$\
+			tst_res TPASS $LTPTMP/imalog.$$ \
 			 "$TCID: bios boot aggregate is 0."
 		else
-			tst_res TFAIL $LTPTMP/imalog.$$\
+			tst_res TFAIL $LTPTMP/imalog.$$ \
 			 "$TCID: bios boot aggregate is not 0."
 		fi
 	else
 		boot_aggregate=`ima_boot_aggregate $tpm_bios`
-
-		[ "${line:48:40}" == "${boot_aggregate:15:40}" ] ||  RC=$?
+		boot_aggr=`expr substr $boot_aggregate 16 40`
+		[ ${ima_aggr} = ${boot_aggr} ] || RC=$?
 		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$\
+			tst_res TPASS $LTPTMP/imalog.$$ \
 			 "$TCID: bios aggregate matches IMA boot aggregate."
 		else
-			tst_res TFAIL $LTPTMP/imalog.$$\
+			tst_res TFAIL $LTPTMP/imalog.$$ \
 			 "$TCID: bios aggregate does not match IMA boot " \
 				"aggregate."
 		fi
@@ -103,10 +105,14 @@ validate_pcr()
 	ima_measurements=$SECURITYFS/ima/binary_runtime_measurements
 	aggregate_pcr=`ima_measure $ima_measurements --validate`
 	dev_pcrs=$1
+	RC=0
+
 	while read line ; do
-		if [ "${line:0:6}" == "PCR-10" ]; then
-			[ "${line:8:59}" == "${aggregate_pcr:25:59}" ]
-				RC=$?
+		pcr=`expr substr "${line}" 1 6`
+		if [ "${pcr}" = "PCR-10" ]; then
+			aggr=`expr substr "${aggregate_pcr}" 26 59`
+			pcr=`expr substr "${line}" 9 59`
+			[ "${pcr}" = "${aggr}" ] || RC=$?
 		fi
 	done < $dev_pcrs
 	return $RC
@@ -126,15 +132,15 @@ test02()
 	if [ $RC -eq 0 ]; then
 		validate_pcr $PCRS_PATH || RC=$?
 		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$\
+			tst_res TPASS $LTPTMP/imalog.$$ \
 			 "$TCID: aggregate PCR value matches real PCR value."
 		else
-			tst_res TFAIL $LTPTMP/imalog.$$\
+			tst_res TFAIL $LTPTMP/imalog.$$ \
 			 "$TCID: aggregate PCR value does not match" \
 			 " real PCR value."
 		fi
 	else
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: TPM not enabled, no PCR value to validate"
 	fi
 	return $RC
@@ -152,10 +158,10 @@ test03()
 	aggregate_pcr=`ima_measure $ima_measurements --verify --validate` > /dev/null
 	RC=$?
 	if [ $RC -eq 0 ]; then
-		tst_res TPASS $LTPTMP/imalog.$$\
+		tst_res TPASS $LTPTMP/imalog.$$ \
 		 "$TCID: verified IMA template hash values."
 	else
-		tst_res TFAIL $LTPTMP/imalog.$$\
+		tst_res TFAIL $LTPTMP/imalog.$$ \
 		 "$TCID: error verifing IMA template hash values."
 	fi
 	return $RC
@@ -172,7 +178,7 @@ RC=0    # Return value from setup, and t
 EXIT_VAL=0
 
 # set the testcases/bin directory
-source `dirname $0`\/ima_setup.sh
+. `dirname $0`\/ima_setup.sh
 setup || exit $RC
 
 init || exit $RC
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
@@ -64,12 +64,17 @@ init()
 	export TST_COUNT=0
 	RC=0
 
-	service auditd status &> /dev/null || RC=$?
+	if [ -f /etc/init.d/auditd ]; then
+		service auditd status > /dev/null 2>&1 || RC=$?
+	else
+		RC=$?
+	fi
+
 	if [ $RC -ne 0 ]; then
 		log=/var/log/messages
 	else
 		log=/var/log/audit/audit.log
-		tst_res TINFO $LTPTMP/imalog.$$\
+		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: requires integrity auditd patch"
 	fi
 }
@@ -96,13 +101,16 @@ test01()
 		tail $log | grep test.txt-$$ | \
 			grep 1>/dev/null 'open_writers' || RC=$?
 		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$\
-			 "$TCID: open_writers violation added"
+			tst_res TPASS $LTPTMP/imalog.$$ \
+			 "$TCID: open_writers violation added(test.txt-$$)"
 			return $RC
+		else
+			tst_res TINFO $LTPTMP/imalog.$$ \
+			 "$TCID: (message ratelimiting?)"
 		fi
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$\
-	 "$TCID: open_writers violation not added"
+	tst_res TFAIL $LTPTMP/imalog.$$ \
+	 "$TCID: open_writers violation not added(test.txt-$$)"
 	return $RC
 }
 
@@ -128,12 +136,16 @@ test02()
 		tail $log | grep test.txt-$$ | \
 			grep 'ToMToU' 1>/dev/null || RC=$?
 		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$\
-			 "$TCID: ToMToU violation added"
+			tst_res TPASS $LTPTMP/imalog.$$ \
+			 "$TCID: ToMToU violation added(test.txt-$$)"
 			return $RC
+		else
+			tst_res TINFO $LTPTMP/imalog.$$ \
+			 "$TCID: (message ratelimiting?)"
 		fi
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$ "$TCID: ToMToU violation not added"
+	tst_res TFAIL $LTPTMP/imalog.$$ \
+	 "$TCID: ToMToU violation not added(test.txt-$$)"
 	return $RC
 }
 
@@ -160,13 +172,16 @@ test03()
 		tail $log | grep test.txtb-$$ | \
 			grep 1>/dev/null 'open_writers' || RC=$?
 		if [ $RC -eq 0 ]; then
-			tst_res TPASS $LTPTMP/imalog.$$\
-			 "$TCID: mmapped open_writers violation added"
+			tst_res TPASS $LTPTMP/imalog.$$ \
+			 "$TCID: mmapped open_writers violation added(test.txtb-$$)"
 			return $RC
+		else
+			tst_res TINFO $LTPTMP/imalog.$$ \
+			 "$TCID: (message ratelimiting?)"
 		fi
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$\
-	 "$TCID: mmapped open_writers violation not added"
+	tst_res TFAIL $LTPTMP/imalog.$$ \
+	 "$TCID: mmapped open_writers violation not added(test.txtb-$$)"
 	close_file_read
 	return $RC
 }
@@ -181,9 +196,8 @@ test03()
 RC=0    # Return value from setup, init, and test functions.
 EXIT_VAL=0
 
-source `dirname $0`\/ima_setup.sh
+. `dirname $0`\/ima_setup.sh
 setup || exit $RC
-
 init || exit $RC
 test01 || EXIT_VAL=$RC
 test02 || EXIT_VAL=$RC
Index: ltp-full-20090531/testcases/kernel/security/integrity/ima/README
===================================================================
--- ltp-full-20090531.orig/testcases/kernel/security/integrity/ima/README
+++ ltp-full-20090531/testcases/kernel/security/integrity/ima/README
@@ -52,11 +52,16 @@ open for read by root. If the default po
 another measurement policy will fail, as the policy may only be replaced
 once per boot. Some of the policy dependency tests might also fail as well.
 
+ima_tpm.sh: test02, verifying the PCR-10 value, requires a hard reboot.
+[On Ubuntu, before running the ltp tests, disable /etc/init.d/kexec-load
+and reboot.]
+
 Run tests
 ---------
 After doing 'make' and 'make install' from the top-level,
 - execute './ltp-full-<version>/runltp -f ima' to run the entire testsuite.
-- To run individual tests, cd into the IMA directory:
+- To run individual tests, cd into the IMA directory, and add testcases/bin
+  to PATH:
   ./ltp-full-<version>/testcases/kernel/security/integrity/ima/tests/
   and execute the individual scripts.
 



------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
