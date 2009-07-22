Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@linux.vnet.ibm.com>) id 1MTjEl-0005Fl-04
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 21:20:31 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTjEi-0003I8-Km
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 21:20:30 +0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
In-Reply-To: <364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
	<364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
Date: Wed, 22 Jul 2009 17:20:19 -0400
Message-Id: <1248297619.3714.10.camel@dyn9002018117.watson.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] ltp: IMA cross platform fixes
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: waqar afridi <afridi.waqar@gmail.com>, ltp-list <ltp-list@lists.sf.net>, Shaz <shazalive@gmail.com>, Mike Frysinger <vapier@gentoo.org>

On Sat, 2009-07-18 at 22:15 -0700, Garrett Cooper wrote:
> On Thu, Jul 16, 2009 at 3:59 AM, Mimi Zohar<zohar@linux.vnet.ibm.com> wrote:
> > - Instead of using the default platform shell, explicitly use bash.
> > - To create a file using 'sudo -u', some platforms require 'user' to exist.
> > - Document verifying PCR-10 fails on Ubuntu on reboot due to kexec.
> >
> > Signed-off-by: Mimi Zohar <zohar@us.ibm.com>
> >

< snip >
> 
> Hi Mimi,
>     The change to
> testcases/kernel/security/integrity/ima/tests/ima_measurements.sh,
> minus the shebang change looks ok.
>     /bin/sh should remain the standard, but a number of changes need
> to happen to the .sh scripts to make them POSIX compatible, e.g.
> backticks execution should become $(), etc. Let's not make things
> bash-only...
> Thanks,
> -Garrett

Ok. I've removed the bash specific code to make it Posix compliant and
ran Ubuntu's checkbashisms tool to make sure.

Mimi

ltp: IMA cross platform fixes

- Replace bashisms: source, uid, substr, '&>' - redirection
- To create a file using 'sudo -u', some platforms require 'user' to exist.
- Document verifying PCR-10 fails on Ubuntu on reboot due to kexec.

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
@@ -70,7 +70,8 @@ load_policy()
 	cat $1 |
 	while read line ; do
 	{
-		if [ "${line:0:1}" != "#" ] ; then
+		firstch=`expr substr "${line}" 1 1`
+		if [ "${firstch}" != "#" ] ; then
 			echo $line >&4 2> /dev/null
 			if [ $? -ne 0 ]; then
 				exec 4>&-
@@ -118,14 +119,13 @@ test02()
 	load_policy $VALID_POLICY & p2=$!  # forked process 2
 	wait "$p1"; RC1=$?
 	wait "$p2"; RC2=$?
-	RC=$((`expr $RC1 + $RC2`))
-	if [ $RC -eq 1 ]; then
+	if [ $RC1 -eq 0 ] && [ $RC2 -eq 0 ]; then
+		tst_res TFAIL $LTPTMP/imalog.$$\
+		 "$TCID: measurement policy opened concurrently"
+	elif [ $RC1 -eq 0 ] || [ $RC2 -eq 0 ]; then
 		RC=0
 		tst_res TPASS $LTPTMP/imalog.$$\
 		 "$TCID: replaced default measurement policy"
-	elif [ $RC -eq 0 ]; then
-		tst_res TFAIL $LTPTMP/imalog.$$\
-		 "$TCID: measurement policy opened concurrently"
 	else
 		tst_res TFAIL $LTPTMP/imalog.$$\
 		 "$TCID: problems opening measurement policy"
@@ -164,7 +164,7 @@ test03()
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
@@ -37,7 +37,7 @@ init()
 	RC=0
 
 	# verify ima_boot_aggregate is available
-	which ima_boot_aggregate &> /dev/null || RC=$?
+	which ima_boot_aggregate >/dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]; then
 		tst_res TINFO $LTPTMP/imalog.$$\
 		 "$TCID: ima_tpm.sh test requires openssl-devel, skipping"
@@ -45,7 +45,7 @@ init()
 	fi
 
 	# verify ima_measure is available
-	which ima_measure &> /dev/null || RC=$?
+	which ima_measure > /dev/null 2>&1 || RC=$?
 	if [ $RC -ne 0 ]; then
 		tst_res TINFO $LTPTMP/imalog.$$\
 		 "$TCID: ima_tpm.sh test requires openssl-devel, skipping"
@@ -60,10 +60,12 @@ test01()
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
@@ -71,7 +73,7 @@ test01()
 		tst_res TINFO $LTPTMP/imalog.$$\
 		 "$TCID: no TPM, TPM not builtin kernel, or TPM not enabled"
 
-		[ "${line:49:40}" -eq 0 ] || RC=$?
+		[ "${ima_aggr}" = "${zero}" ] || RC=$?
 		if [ $RC -eq 0 ]; then
 			tst_res TPASS $LTPTMP/imalog.$$\
 			 "$TCID: bios boot aggregate is 0."
@@ -81,8 +83,8 @@ test01()
 		fi
 	else
 		boot_aggregate=`ima_boot_aggregate $tpm_bios`
-
-		[ "${line:48:40}" == "${boot_aggregate:15:40}" ] ||  RC=$?
+		boot_aggr=`expr substr $boot_aggregate 16 40`
+		[ ${ima_aggr} = ${boot_aggr} ] || RC=$?
 		if [ $RC -eq 0 ]; then
 			tst_res TPASS $LTPTMP/imalog.$$\
 			 "$TCID: bios aggregate matches IMA boot aggregate."
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
@@ -64,7 +64,12 @@ init()
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
@@ -97,12 +102,15 @@ test01()
 			grep 1>/dev/null 'open_writers' || RC=$?
 		if [ $RC -eq 0 ]; then
 			tst_res TPASS $LTPTMP/imalog.$$\
-			 "$TCID: open_writers violation added"
+			 "$TCID: open_writers violation added(test.txt-$$)"
 			return $RC
+		else
+			tst_res TINFO $LTPTMP/imalog.$$\
+			 "$TCID: (message ratelimiting?)"
 		fi
 	fi
 	tst_res TFAIL $LTPTMP/imalog.$$\
-	 "$TCID: open_writers violation not added"
+	 "$TCID: open_writers violation not added(test.txt-$$)"
 	return $RC
 }
 
@@ -129,11 +137,15 @@ test02()
 			grep 'ToMToU' 1>/dev/null || RC=$?
 		if [ $RC -eq 0 ]; then
 			tst_res TPASS $LTPTMP/imalog.$$\
-			 "$TCID: ToMToU violation added"
+			 "$TCID: ToMToU violation added(test.txt-$$)"
 			return $RC
+		else
+			tst_res TINFO $LTPTMP/imalog.$$\
+			 "$TCID: (message ratelimiting?)"
 		fi
 	fi
-	tst_res TFAIL $LTPTMP/imalog.$$ "$TCID: ToMToU violation not added"
+	tst_res TFAIL $LTPTMP/imalog.$$\
+	 "$TCID: ToMToU violation not added(test.txt-$$)"
 	return $RC
 }
 
@@ -161,12 +173,15 @@ test03()
 			grep 1>/dev/null 'open_writers' || RC=$?
 		if [ $RC -eq 0 ]; then
 			tst_res TPASS $LTPTMP/imalog.$$\
-			 "$TCID: mmapped open_writers violation added"
+			 "$TCID: mmapped open_writers violation added(test.txtb-$$)"
 			return $RC
+		else
+			tst_res TINFO $LTPTMP/imalog.$$\
+			 "$TCID: (message ratelimiting?)"
 		fi
 	fi
 	tst_res TFAIL $LTPTMP/imalog.$$\
-	 "$TCID: mmapped open_writers violation not added"
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
@@ -56,7 +56,8 @@ Run tests
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
