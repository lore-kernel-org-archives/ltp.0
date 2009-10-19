Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mzju9-0001F5-Gl
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 04:31:33 +0000
Received: from mail-pz0-f196.google.com ([209.85.222.196])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mzju8-0000Zw-8d
	for ltp-list@lists.sourceforge.net; Mon, 19 Oct 2009 04:31:33 +0000
Received: by pzk34 with SMTP id 34so3319362pzk.11
	for <ltp-list@lists.sourceforge.net>;
	Sun, 18 Oct 2009 21:31:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40910141840t15b6489s38e232575652677f@mail.gmail.com>
References: <364299f40910141840t15b6489s38e232575652677f@mail.gmail.com>
Date: Sun, 18 Oct 2009 21:31:26 -0700
Message-ID: <364299f40910182131y7e223d0cp99c63f3af51d62c5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Re: [Issue 15] ima testcases issues
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Oct 14, 2009 at 6:40 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> =A0 =A0The ima testcases should check and see whether or not the /sys
> directory that they're testing in exists before continuing. Otherwise
> there's a lot of unnecessary noise that shows up in the logs:
>
> mkdir: cannot create directory `/sys/kernel/security': No such file or di=
rectory
>
> Usage: mount -V =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : print version
>
> =A0 =A0 =A0 mount -h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : print this help
>
> =A0 =A0 =A0 mount =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: list mounted f=
ilesystems
>
> =A0 =A0 =A0 mount -l =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : idem, including vo=
lume labels
>
> So far the informational part. Next the mounting.
>
> The command is `mount [-t fstype] something somewhere'.
>
> Details found in /etc/fstab may be omitted.
>
> =A0 =A0 =A0 mount -a [-t|-O] ... =A0 =A0 : mount all stuff from /etc/fstab
>
> =A0 =A0 =A0 mount device =A0 =A0 =A0 =A0 =A0 =A0 : mount device at the kn=
own place
>
> =A0 =A0 =A0 mount directory =A0 =A0 =A0 =A0 =A0: mount known device here
>
> =A0 =A0 =A0 mount -t type dev dir =A0 =A0: ordinary mount command
>
> Note that one does not really mount a device, one mounts
>
> a filesystem (of the given type) found on the device.
>
> One can also mount an already visible directory tree elsewhere:
>
> =A0 =A0 =A0 mount --bind olddir newdir
>
> or move a subtree:
>
> =A0 =A0 =A0 mount --move olddir newdir
>
> A device can be given by name, say /dev/hda1 or /dev/cdrom,
>
> or by label, using =A0-L label =A0or by uuid, using =A0-U uuid .
>
> Other options: [-nfFrsvw] [-o options] [-p passwdfd].
>
> For many more details, say =A0man 8 mount .
>
> setup =A0 =A0 =A0 1 =A0TBROK =A0: =A0setup: cannot mount securityfs
>
> setup =A0 =A0 =A0 0 =A0TINFO =A0: =A0CLEAN: removing /tmp/ltp-JJyTa10956/=
ima

The attached patch fixes my issues, but I can't easily verify whether
or not it fixes the positive behavior of the testcase itself under all
conditions:

<<<test_start>>>
tag=3Dima01 stime=3D1255926150
cmdline=3D"  ima_measurements.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setup       1  TBROK  :  Failed to mkdir /sys/kernel/security
setup       1  TBROK  :  Cannot mount securityfs
setup       0  TINFO  :  CLEAN: removing /tmp/ltp-VdWwjzuH1v/ima
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D0
<<<test_end>>>
<<<test_start>>>
tag=3Dima02 stime=3D1255926150
cmdline=3D"  ima_policy.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setup       1  TBROK  :  Failed to mkdir /sys/kernel/security
setup       1  TBROK  :  Cannot mount securityfs
setup       0  TINFO  :  CLEAN: removing /tmp/ltp-VdWwjzuH1v/ima
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D2
<<<test_end>>>
<<<test_start>>>
tag=3Dima03 stime=3D1255926150
cmdline=3D"  ima_tpm.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setup       1  TBROK  :  Failed to mkdir /sys/kernel/security
setup       1  TBROK  :  Cannot mount securityfs
setup       0  TINFO  :  CLEAN: removing /tmp/ltp-VdWwjzuH1v/ima
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D1 cstime=3D1
<<<test_end>>>
<<<test_start>>>
tag=3Dima04 stime=3D1255926150
cmdline=3D"  ima_violations.sh"
contacts=3D""
analysis=3Dexit
<<<test_output>>>
setup       1  TBROK  :  Failed to mkdir /sys/kernel/security
setup       1  TBROK  :  Cannot mount securityfs
setup       0  TINFO  :  CLEAN: removing /tmp/ltp-VdWwjzuH1v/ima
incrementing stop
<<<execution_status>>>
initiation_status=3D"ok"
duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno
cutime=3D0 cstime=3D1
<<<test_end>>>

Either way, it's a positive move forward so I'm checking this into cvs now.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: ima_measurements.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/tests/im=
a_measurements.sh,v
retrieving revision 1.2
diff -u -r1.2 ima_measurements.sh
--- ima_measurements.sh	30 Jul 2009 15:37:59 -0000	1.2
+++ ima_measurements.sh	19 Oct 2009 04:30:04 -0000
@@ -37,15 +37,10 @@
         export TST_COUNT=3D0
 	RC=3D0

-	# check that sha1sum is installed
-	which sha1sum >/dev/null 2>&1 || RC=3D$?
-	if [ $RC -ne 0 ]; then
-		tst_brkm TBROK NULL "$TCID: sha1sum not found"
-		return $RC
-	fi
+	exists sha1sum

 	# verify using default policy
-	if [ ! -f $IMA_DIR/policy ]; then
+	if [ ! -f "$IMA_DIR/policy" ]; then
 		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: not using default policy"
 	fi
@@ -66,7 +61,7 @@
 	`date` - this is a test file
 	EOF
 	if [ $RC -ne 0 ]; then
-		tst_brkm TBROK $LTPTMP/imalog.$$ \
+		tst_res TBROK $LTPTMP/imalog.$$ "" \
 		 "$TCID: Unable to create test file"
 		return $RC
 	fi
@@ -74,7 +69,7 @@
 	# Calculating the sha1sum of $LTPTMP/test.txt should add
 	# the measurement to the measurement list.
 	# (Assumes SHA1 IMA measurements.)
-	hash=3D`cat $LTPIMA/test.txt | sha1sum | sed 's/  -//'`
+	hash=3D$(sha1sum < "$LTPIMA/test.txt" | sed 's/  -//')

 	# Check if the file is measured
 	# (i.e. contained in the ascii measurement list.)
@@ -178,9 +173,10 @@
 #
 RC=3D0
 EXIT_VAL=3D0
-. `dirname $0`\/ima_setup.sh
-setup || exit $RC
-init
+
+. $(dirname "$0")/ima_setup.sh
+setup || exit $?
+init || exit $?
 test01 || EXIT_VAL=3D$RC
 test02 || EXIT_VAL=3D$RC
 test03 || EXIT_VAL=3D$RC
Index: ima_policy.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/tests/im=
a_policy.sh,v
retrieving revision 1.2
diff -u -r1.2 ima_policy.sh
--- ima_policy.sh	30 Jul 2009 15:37:59 -0000	1.2
+++ ima_policy.sh	19 Oct 2009 04:30:04 -0000
@@ -163,10 +163,9 @@
 RC=3D0    # Return value from setup, init, and test functions.
 EXIT_VAL=3D0

-. `dirname $0`\/ima_setup.sh
-setup || exit $RC
-
-init || exit $RC
+. $(dirname "$0")/ima_setup.sh
+setup || exit $?
+init || exit $?
 test01 || EXIT_VAL=3D$RC
 test02 || EXIT_VAL=3D$RC
 test03 || EXIT_VAL=3D$RC
Index: ima_setup.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/tests/im=
a_setup.sh,v
retrieving revision 1.2
diff -u -r1.2 ima_setup.sh
--- ima_setup.sh	30 Jul 2009 15:37:59 -0000	1.2
+++ ima_setup.sh	19 Oct 2009 04:30:04 -0000
@@ -30,33 +30,49 @@
 ##########################################################################=
######
 mount_sysfs()
 {
-	SYSFS=3D`mount | grep sysfs` || RC=3D$?
-	if [ $RC -eq 1 ]; then
+
+	SYSFS=3D$(mount 2>/dev/null | awk '$5 =3D=3D "sysfs" { print $3 }')
+	if [ "x$SYSFS" =3D x ] ; then
+
 		SYSFS=3D/sys
-		mkdir -p $SYSFS
-		`mount -t sysfs sysfs $SYSFS`
-		RC=3D$?
-		return $RC
-	else
-		SYSFS=3D`echo $SYSFS |  sed 's/sysfs on //' | sed 's/ type .*//'`
+
+		test -d $SYSFS || mkdir -p $SYSFS 2>/dev/null
+		if [ $? -ne 0 ] ; then
+			tst_resm TBROK "Failed to mkdir $SYSFS"
+			return 1
+		fi
+		if ! mount -t sysfs sysfs $SYSFS 2>/dev/null ; then
+			tst_resm TBROK "Failed to mount $SYSFS"
+			return 1
+		fi
+
 	fi
+
 	return 0
 }

 mount_securityfs()
 {
-	SECURITYFS=3D`mount | grep securityfs` || RC=3D$?
-	if [ $RC -eq 1 ]; then
-		SECURITYFS=3D$SYSFS/kernel/security
-		`mkdir -p $SECURITYFS`
-		`mount -t securityfs securityfs $SECURITYFS`
-		RC=3D$?
-		return $RC
-	else
-		SECURITYFS=3D`echo $SECURITYFS |  sed 's/securityfs on //' \
-			| sed 's/ type .*//'`
+
+	SECURITYFS=3D$(mount 2>/dev/null | awk '$5 =3D=3D "securityfs" { print $3=
 }')
+	if [ "x$SECURITYFS" =3D x ] ; then
+
+		SECURITYFS=3D"$SYSFS/kernel/security"
+
+		test -d $SECURITYFS || mkdir -p $SECURITYFS 2>/dev/null
+		if [ $? -ne 0 ] ; then
+			tst_resm TBROK "Failed to mkdir $SECURITYFS"
+			return 1
+		fi
+		if ! mount -t securityfs securityfs $SECURITYFS 2>/dev/null ; then
+			tst_resm TBROK "Failed to mount $SECURITYFS"
+			return 1
+		fi
+
 	fi
+
 	return 0
+
 }

 setup()
@@ -65,62 +81,55 @@
 	export TCID=3D"setup"
         export TST_COUNT=3D0

+	LTPBIN=3D
+	LTPIMA=3D
+
 	trap "cleanup" 0
-	if [ -z $TMP ]; then
+	if [ -z "$TMPDIR" ]; then
 		LTPTMP=3D/tmp
 	else
-		LTPTMP=3D${TMP}
+		LTPTMP=3D${TMPDIR}
 	fi
-	if [ -z $LTPBIN ]; then
+	if [ -z "$LTPBIN" ]; then
 		LTPBIN=3D../../../../../bin
 		PATH=3D$PATH:$LTPBIN
 	fi

 	# Must be root
-	userid=3D`id -u`
-	if [ $userid -ne 0 ]; then
-		tst_brkm TBROK $LTPTMP/imalog.$$ \
-		 "$TCID: Must be root to execute test"
+	if ! is_root; then
+		tst_resm TCONF "You must be root to execute this test"
 		return 1
 	fi

-	if [ -z $TMP ]; then
-		LTPTMP=3D/tmp
-	else
-		LTPTMP=3D${TMP}
-	fi
-
 	# create the temporary directory used by this testcase
 	LTPIMA=3D$LTPTMP/ima
 	umask 077
 	mkdir $LTPIMA > /dev/null 2>&1 || RC=3D$?
 	if [ $RC -ne 0 ]; then
-		tst_brk TBROK "$TCID: Unable to create temporary directory"
+		tst_resm TBROK "Unable to create temporary directory"
 		return $RC
 	fi

 	# mount sysfs if it is not already mounted
 	mount_sysfs || RC=3D$?
 	if [ $RC -ne 0 ]; then
-		tst_brkm TBROK $LTPTMP/imalog.$$ "$TCID: cannot mount sysfs"
+		tst_resm TBROK "Cannot mount sysfs"
 		return $RC
 	fi

 	# mount securityfs if it is not already mounted
 	mount_securityfs || RC=3D$?
 	if [ $RC -ne 0 ]; then
-		tst_brkm TBROK $LTPTMP/imalog.$$ "$TCID: cannot mount securityfs"
+		tst_resm TBROK "Cannot mount securityfs"
 		return $RC
 	fi

-	SECURITYFS=3D`echo $SECURITYFS |  sed 's/securityfs on //' \
-		| sed 's/ type .*//'`
+	mount

 	# IMA must be configured in the kernel
 	IMA_DIR=3D$SECURITYFS/ima
-	if [ ! -d $IMA_DIR ]; then
-		tst_brkm TBROK $LTPTMP/imalog.$$\
-		 "INIT: IMA not enabled in kernel"
+	if [ ! -d "$IMA_DIR" ]; then
+		tst_resm TCONF "IMA not enabled in kernel"
 		RC=3D1
 	fi
 	return $RC
@@ -135,6 +144,8 @@
 cleanup()
 {
 	tst_resm TINFO "CLEAN: removing $LTPIMA"
-	rm -rf $LTPIMA || RC $?
+	rm -rf "$LTPIMA" || RC=3D$?
 	return $RC
 }
+
+. cmdlib.sh
Index: ima_tpm.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/tests/im=
a_tpm.sh,v
retrieving revision 1.2
diff -u -r1.2 ima_tpm.sh
--- ima_tpm.sh	30 Jul 2009 15:37:59 -0000	1.2
+++ ima_tpm.sh	19 Oct 2009 04:30:04 -0000
@@ -37,20 +37,8 @@
 	RC=3D0

 	# verify ima_boot_aggregate is available
-	which ima_boot_aggregate >/dev/null 2>&1 || RC=3D$?
-	if [ $RC -ne 0 ]; then
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: ima_tpm.sh test requires openssl-devel, skipping"
-		return $RC
-	fi
+	exists ima_boot_aggregate ima_measure

-	# verify ima_measure is available
-	which ima_measure > /dev/null 2>&1 || RC=3D$?
-	if [ $RC -ne 0 ]; then
-		tst_res TINFO $LTPTMP/imalog.$$ \
-		 "$TCID: ima_tpm.sh test requires openssl-devel, skipping"
-	fi
-	return $RC
 }

 # Function:     test01
@@ -69,7 +57,7 @@

 	# verify TPM is available and enabled.
 	tpm_bios=3D$SECURITYFS/tpm0/binary_bios_measurements
-	if [ ! -f $tpm_bios ]; then
+	if [ ! -f "$tpm_bios" ]; then
 		tst_res TINFO $LTPTMP/imalog.$$ \
 		 "$TCID: no TPM, TPM not builtin kernel, or TPM not enabled"

@@ -84,7 +72,7 @@
 	else
 		boot_aggregate=3D`ima_boot_aggregate $tpm_bios`
 		boot_aggr=3D`expr substr $boot_aggregate 16 40`
-		[ ${ima_aggr} =3D ${boot_aggr} ] || RC=3D$?
+		[ "x${ima_aggr}" =3D "x${boot_aggr}" ] || RC=3D$?
 		if [ $RC -eq 0 ]; then
 			tst_res TPASS $LTPTMP/imalog.$$ \
 			 "$TCID: bios aggregate matches IMA boot aggregate."
@@ -103,7 +91,7 @@
 validate_pcr()
 {
 	ima_measurements=3D$SECURITYFS/ima/binary_runtime_measurements
-	aggregate_pcr=3D`ima_measure $ima_measurements --validate`
+	aggregate_pcr=3D$(ima_measure $ima_measurements --validate)
 	dev_pcrs=3D$1
 	RC=3D0

@@ -127,7 +115,7 @@
 	TST_COUNT=3D2
 	RC=3D0

-#	Would be nice to know where the PCRs are located.  Is this safe?
+	# Would be nice to know where the PCRs are located.  Is this safe?
 	PCRS_PATH=3D`find /$SYSFS/devices/ | grep pcrs` || RC=3D$?
 	if [ $RC -eq 0 ]; then
 		validate_pcr $PCRS_PATH || RC=3D$?
@@ -177,11 +165,9 @@
 RC=3D0    # Return value from setup, and test functions.
 EXIT_VAL=3D0

-# set the testcases/bin directory
-. `dirname $0`\/ima_setup.sh
-setup || exit $RC
-
-init || exit $RC
+. $(dirname "$0")/ima_setup.sh
+setup || exit $?
+init || exit $?
 test01 || EXIT_VAL=3D$RC
 test02 || EXIT_VAL=3D$RC
 test03 || EXIT_VAL=3D$RC
Index: ima_violations.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/integrity/ima/tests/im=
a_violations.sh,v
retrieving revision 1.2
diff -u -r1.2 ima_violations.sh
--- ima_violations.sh	30 Jul 2009 15:37:59 -0000	1.2
+++ ima_violations.sh	19 Oct 2009 04:30:04 -0000
@@ -196,9 +196,9 @@
 RC=3D0    # Return value from setup, init, and test functions.
 EXIT_VAL=3D0

-. `dirname $0`\/ima_setup.sh
-setup || exit $RC
-init || exit $RC
+. $(dirname "$0")/ima_setup.sh
+setup || exit $?
+init || exit $?
 test01 || EXIT_VAL=3D$RC
 test02 || EXIT_VAL=3D$RC
 test03 || EXIT_VAL=3D$RC

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
