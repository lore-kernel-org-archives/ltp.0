From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 26 Jan 2018 14:09:53 +0100
Subject: [LTP] [RFC PATCH 1/2] security/ima: Rewrite tests into new API
 + fixes
In-Reply-To: <20180111202821.31639-2-pvorel@suse.cz>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <20180111202821.31639-2-pvorel@suse.cz>
Message-ID: <20180126130953.GA12731@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +# Verify that measurements are added to the measurement list based on policy.
> +
> +TST_TESTFUNC="test"
> +TST_CNT=3
> +. ima_setup.sh
> +
> +TEST_FILE="test.txt"
> +HASH_COMMAND="sha1sum"
> +POLICY="$IMA_DIR/policy"
>  
>  init()
>  {
> -	tst_check_cmds sha1sum
> -
> -	# verify using default policy
> -	if [ ! -f "$IMA_DIR/policy" ]; then
> -		tst_resm TINFO "not using default policy"
> -	fi
> +	grep -q '^CONFIG_IMA_DEFAULT_HASH_SHA256=y' /boot/config-$(uname -r) && \
> +		HASH_COMMAND="sha256sum"

Grepping /boot/config-$foo is really broken, isn't there some sysfs
or ioctl interface where we can figure out this info?

> +	tst_res TINFO "detected IMA algoritm: ${HASH_COMMAND%sum}"
> +	tst_check_cmds $HASH_COMMAND
> +	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
>  }
>  
> -# Function:     test01
> -# Description   - Verify reading a file causes a new measurement to
> -#		  be added to the IMA measurement list.
> -test01()
> +ima_check()
>  {
> -	# Create file test.txt
> -	cat > test.txt <<-EOF
> -	$(date) - this is a test file
> -	EOF
> -	if [ $? -ne 0 ]; then
> -		tst_brkm TBROK "Unable to create test file"
> -	fi
> -
> -	# Calculating the sha1sum of test.txt should add
> -	# the measurement to the measurement list.
> -	# (Assumes SHA1 IMA measurements.)
> -	hash=$(sha1sum "test.txt" | sed 's/  -//')
> -
> -	# Check if the file is measured
> -	# (i.e. contained in the ascii measurement list.)
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
> -	sleep 1
> -	$(grep $hash measurements > /dev/null)
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "TPM ascii measurement list does not contain sha1sum"
> -	else
> -		tst_resm TPASS "TPM ascii measurement list contains sha1sum"
> -	fi
> +	EXPECT_PASS grep -q $($HASH_COMMAND $TEST_FILE) $ASCII_MEASUREMENTS
>  }
>  
> -# Function:     test02
> -# Description	- Verify modifying, then reading, a file causes a new
> -# 		  measurement to be added to the IMA measurement list.
> -test02()
> +test1()
>  {
> -	# Modify test.txt
> -	echo $(date) - file modified >> test.txt
> +	tst_res TINFO "verify adding record to the IMA measurement list"
> +	ROD echo "$(date) this is a test file" \> $TEST_FILE
> +	ima_check
> +}
>  
> -	# Calculating the sha1sum of test.txt should add
> -	# the new measurement to the measurement list
> -	hash=$(sha1sum test.txt | sed 's/  -//')
> +test2()
> +{
> +	local device
>  
> -	# Check if the new measurement exists
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
> -	$(grep $hash measurements > /dev/null)
> +	tst_res TINFO "verify updating record in the IMA measurement list"
>  
> -	if [ $? -ne 0 ]; then
> -		tst_resm TFAIL "Modified file not measured"
> -		tst_resm TINFO "iversion not supported; or not mounted with iversion"
> +	device="$(df . | sed -e 1d | cut -f1 -d ' ')"
> +	if grep -q $device /proc/mounts; then
> +		if grep -q "${device}.*ext[2-4]" /proc/mounts; then
> +			grep -q "${device}.*ext[2-4].*i_version" /proc/mounts || \
> +				tst_res TINFO "device '$device' is not mounted with iversion"
> +		fi
>  	else
> -		tst_resm TPASS "Modified file measured"
> +		tst_res TWARN "could not find mount info for device '$device'"
>  	fi
> +
> +	ROD echo "$(date) modified file" \> $TEST_FILE
> +	ima_check
>  }
>  
> -# Function:     test03
> -# Description 	- Verify files are measured based on policy
> -#		(Default policy does not measure user files.)
> -test03()
> +test3()
>  {
> -	# create file user-test.txt
> -	mkdir -m 0700 user
> -	chown nobody.nobody user
> -	cd user
> -	hash=0
> -
> -	# As user nobody, create and cat the new file
> -	# (The LTP tests assumes existence of 'nobody'.)
> -	sudo -n -u nobody sh -c "echo $(date) - create test.txt > ./test.txt;
> -				 cat ./test.txt > /dev/null"
> -
> -	# Calculating the hash will add the measurement to the measurement
> -	# list, so only calc the hash value after getting the measurement
> -	# list.
> -	cat /sys/kernel/security/ima/ascii_runtime_measurements > measurements
> -	hash=$(sha1sum test.txt | sed 's/  -//')
> -	cd - >/dev/null
> -
> -	# Check if the file is measured
> -	grep $hash measurements > /dev/null
> -	if [ $? -ne 0 ]; then
> -		tst_resm TPASS "user file test.txt not measured"
> -	else
> -		tst_resm TFAIL "user file test.txt measured"
> -	fi
> -}
> +	local dir="user"
> +	local user="nobody"
>  
> -. ima_setup.sh
> +	tst_res TINFO "verify measuring user files"
>  
> -setup
> -TST_CLEANUP=cleanup
> +	id $user >/dev/null 2>/dev/null || tst_brk TCONF "missing system user $user (wrong installation)"
> +	tst_check_cmds sudo
>  
> -init
> -test01
> -test02
> -test03
> +	mkdir -m 0700 $dir
> +	chown $user $dir
> +	cd $dir
> +
> +	sudo -n -u $user sh -c "echo $(date) user file > $TEST_FILE;
> +		cat $TEST_FILE > /dev/null"
>  
> -tst_exit
> +	ima_check
> +	cd ..
> +}
> +
> +init
   ^
   Any reason we don't pass this as TST_SETUP ?
> +tst_run
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> index ad5900975..162d323a1 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> @@ -1,127 +1,114 @@
>  #!/bin/sh
> -################################################################################
> -##                                                                            ##
> -## Copyright (C) 2009 IBM Corporation                                         ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -################################################################################
> +# Copyright (c) 2009 IBM Corporation
> +# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
>  #
> -# File :        ima_policy.sh
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
>  #
> -# Description:  This file tests replacing the default integrity measurement
> -#		policy.
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
>  #
> -# Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
> -################################################################################
> -export TST_TOTAL=3
> -export TCID="ima_policy"
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
> +#
> +# Test replacing the default integrity measurement policy.
> +
> +TST_TESTFUNC="test"
> +TST_CNT=3
> +. ima_setup.sh
>  
>  init()
>  {
> -	# verify using default policy
> -	IMA_POLICY=$IMA_DIR/policy
> -	if [ ! -f $IMA_POLICY ]; then
> -		tst_resm TINFO "default policy already replaced"
> -	fi
> +	IMA_POLICY="$IMA_DIR/policy"
> +	[ -f $IMA_POLICY ] || \
> +		tst_brk TCONF "IMA policy already loaded and kernel not configured to enable multiple writes it"
>  
> -	VALID_POLICY=$LTPROOT/testcases/data/ima_policy/measure.policy
> -	if [ ! -f $VALID_POLICY ]; then
> -		tst_resm TINFO "missing $VALID_POLICY"
> -	fi
> +	VALID_POLICY="$LTPROOT/testcases/data/ima_policy/measure.policy"
                               ^
			       $TST_DATAROOT
> +	[ -f $VALID_POLICY ] || tst_brk TCONF "missing $VALID_POLICY"
>  
> -	INVALID_POLICY=$LTPROOT/testcases/data/ima_policy/measure.policy-invalid
> -	if [ ! -f $INVALID_POLICY ]; then
> -		tst_resm TINFO "missing $INVALID_POLICY"
> -	fi
> +	INVALID_POLICY="$LTPROOT/testcases/data/ima_policy/measure.policy-invalid"
> +	[ -f $INVALID_POLICY ] || tst_brk TCONF "missing $INVALID_POLICY"
>  }
>  
>  load_policy()
>  {
> +	local ret
> +
>  	exec 2>/dev/null 4>$IMA_POLICY
> -	if [ $? -ne 0 ]; then
> -		exit 1
> -	fi
> +	[ $? -eq 0 ] || exit 1
>  
>  	cat $1 |
> -	while read line ; do
> -	{
> -		if [ "${line#\#}" = "${line}" ] ; then
> -			echo $line >&4 2> /dev/null
> +	while read line; do
> +		if [ "${line#\#}" = "${line}" ]; then
> +			echo "$line" >&4 2> /dev/null
>  			if [ $? -ne 0 ]; then
>  				exec 4>&-
>  				return 1
>  			fi
>  		fi
> -	}
>  	done
> -}
> +	ret=$?
>  
> +	[ $ret -eq 0 ] && \
> +		tst_res TINFO "IMA policy updated, please reboot after testing to restore settings"
>  
> -# Function:     test01
> -# Description   - Verify invalid policy doesn't replace default policy.
> -test01()
> +	return $ret
> +}
> +
> +test1()
>  {
> +	tst_res TINFO "verify that invalid policy doesn't replace default policy"
> +
> +	local p1
> +
>  	load_policy $INVALID_POLICY & p1=$!
>  	wait "$p1"
>  	if [ $? -ne 0 ]; then
> -		tst_resm TPASS "didn't load invalid policy"
> +		tst_res TPASS "didn't load invalid policy"
>  	else
> -		tst_resm TFAIL "loaded invalid policy"
> +		tst_res TFAIL "loaded invalid policy"
>  	fi
>  }
>  
> -# Function:     test02
> -# Description	- Verify policy file is opened sequentially, not concurrently
> -#		  and install new policy
> -test02()
> +test2()
>  {
> +	tst_res TINFO "verify that policy file is opened sequentially and installs new policy"
> +
> +	local p1 p2 rc1 rc2
> +
>  	load_policy $VALID_POLICY & p1=$!  # forked process 1
>  	load_policy $VALID_POLICY & p2=$!  # forked process 2
> -	wait "$p1"; RC1=$?
> -	wait "$p2"; RC2=$?
> -	if [ $RC1 -eq 0 ] && [ $RC2 -eq 0 ]; then
> -		tst_resm TFAIL "measurement policy opened concurrently"
> -	elif [ $RC1 -eq 0 ] || [ $RC2 -eq 0 ]; then
> -		tst_resm TPASS "replaced default measurement policy"
> +	wait "$p1"; rc1=$?
> +	wait "$p2"; rc2=$?
> +	if [ $rc1 -eq 0 ] && [ $rc2 -eq 0 ]; then
> +		tst_res TFAIL "measurement policy opened concurrently"
> +	elif [ $rc1 -eq 0 ] || [ $rc2 -eq 0 ]; then
> +		tst_res TPASS "replaced default measurement policy"
>  	else
> -		tst_resm TFAIL "problems opening measurement policy"
> +		tst_res TFAIL "problems opening measurement policy"
>  	fi
>  }
>  
> -# Function:     test03
> -# Description 	- Verify can't load another measurement policy.
> -test03()
> +test3()
>  {
> +	tst_res TINFO "verify that valid policy isn't replaced"
> +
> +	local p1
> +
>  	load_policy $INVALID_POLICY & p1=$!
>  	wait "$p1"
>  	if [ $? -ne 0 ]; then
> -		tst_resm TPASS "didn't replace valid policy"
> +		tst_res TPASS "didn't replace valid policy"
>  	else
> -		tst_resm TFAIL "replaced valid policy"
> +		tst_res TFAIL "replaced valid policy"
>  	fi
>  }
>  
> -. ima_setup.sh
> -
> -setup
> -TST_CLEANUP=cleanup
> -
>  init
> -test01
> -test02
> -test03
> -
> -tst_exit
> +tst_run
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> old mode 100755
> new mode 100644
> index 0ff38d23b..7e19e3959
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -1,86 +1,67 @@
>  #!/bin/sh
> -################################################################################
> -##                                                                            ##
> -## Copyright (C) 2009 IBM Corporation                                         ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software Foundation,   ##
> -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
> -##                                                                            ##
> -################################################################################
> +# Copyright (c) 2009 IBM Corporation
> +# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
>  #
> -# File :        ima_setup.sh
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
>  #
> -# Description:  setup/cleanup routines for the integrity tests.
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
>  #
> -# Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
> -################################################################################
> -. test.sh
> -mount_sysfs()
> -{
> -	SYSFS=$(mount 2>/dev/null | awk '$5 == "sysfs" { print $3 }')
> -	if [ "x$SYSFS" = x ] ; then
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
> +#
> +# Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
>  
> -		SYSFS=/sys
> +TST_CLEANUP="cleanup"
> +TST_NEEDS_TMPDIR=1
> +TST_NEEDS_ROOT=1
> +. tst_test.sh
>  
> -		test -d $SYSFS || mkdir -p $SYSFS 2>/dev/null
> -		if [ $? -ne 0 ] ; then
> -			tst_brkm TBROK "Failed to mkdir $SYSFS"
> -		fi
> -		if ! mount -t sysfs sysfs $SYSFS 2>/dev/null ; then
> -			tst_brkm TBROK "Failed to mount $SYSFS"
> -		fi
> +export TCID="${TCID:-$(basename $0 | cut -d. -f1)}"
>  
> -	fi
> -}
> +UMOUNT=
>  
> -mount_securityfs()
> +mount_helper()
>  {
> -	SECURITYFS=$(mount 2>/dev/null | awk '$5 == "securityfs" { print $3 }')
> -	if [ "x$SECURITYFS" = x ] ; then
> -
> -		SECURITYFS="$SYSFS/kernel/security"
> +	local type="$1"
> +	local default_dir="$2"
> +	local dir
>  
> -		test -d $SECURITYFS || mkdir -p $SECURITYFS 2>/dev/null
> -		if [ $? -ne 0 ] ; then
> -			tst_brkm TBROK "Failed to mkdir $SECURITYFS"
> -		fi
> -		if ! mount -t securityfs securityfs $SECURITYFS 2>/dev/null ; then
> -			tst_brkm TBROK "Failed to mount $SECURITYFS"
> -		fi
> +	dir="$(grep ^$type /proc/mounts | cut -d ' ' -f2 | head -1)"
> +	[ -n "$dir" ] && { echo "$dir"; return; }
>  
> +	if ! mkdir -p $default_dir; then
> +		tst_brk TBROK "Failed to create $default_dir"
> +	fi
> +	if ! mount -t $type $type $default_dir; then
> +		tst_brk TBROK "Failed to mount $type"
>  	fi
> +	UMOUNT="$default_dir $UMOUNT"
> +	echo $default_dir
>  }
>  
>  setup()
>  {
> -	tst_require_root
> +	SYSFS="$(mount_helper sysfs /sys)"

Do we really still need to mount /sys as far as I can tell it's
mounted automatically for more than 10 years now.

> +	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
>  
> -	tst_tmpdir
> -
> -	mount_sysfs
> -
> -	# mount securityfs if it is not already mounted
> -	mount_securityfs
> -
> -	# IMA must be configured in the kernel
> -	IMA_DIR=$SECURITYFS/ima
> -	if [ ! -d "$IMA_DIR" ]; then
> -		tst_brkm TCONF "IMA not enabled in kernel"
> -	fi
> +	IMA_DIR="$SECURITYFS/ima"
> +	[ -d "$IMA_DIR" ] || tst_brk TCONF "IMA not enabled in kernel"
> +	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
> +	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
>  }
>  
>  cleanup()
>  {
> -	tst_rmdir
> +	local dir
> +	for dir in $UMOUNT; do
> +		umount $dir
> +	done
>  }
> +
> +setup
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 333bf5f8a..a3d1739cd 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -1,70 +1,61 @@
>  #!/bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (C) 2009 IBM Corporation                                         ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -################################################################################
> +# Copyright (c) 2009 IBM Corporation
> +# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
>  #
> -# File :        ima_tpm.sh
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
>  #
> -# Description:  This file verifies the boot and PCR aggregates
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
>  #
> -# Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
> +# Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
>  #
> -# Return        - zero on success
> -#               - non zero on failure. return value from commands ($RC)
> -################################################################################
> -export TST_TOTAL=3
> -export TCID="ima_tpm"
> +# Verify the boot and PCR aggregates.
> +
> +TST_TESTFUNC="test"
> +TST_CNT=3
> +. ima_setup.sh
>  
>  init()
>  {
>  	tst_check_cmds ima_boot_aggregate ima_measure
>  }
>  
> -# Function:     test01
> -# Description   - Verify boot aggregate value is correct
> -test01()
> +test1()
>  {
> -	zero="0000000000000000000000000000000000000000"
> +	tst_res TINFO "verify boot aggregate"
> +
> +	local zero="0000000000000000000000000000000000000000"
> +	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
> +	local ima_measurements="$ASCII_MEASUREMENTS"
> +	local ima_aggr line
>  
>  	# IMA boot aggregate
> -	ima_measurements=$SECURITYFS/ima/ascii_runtime_measurements
>  	read line < $ima_measurements
>  	ima_aggr=$(expr substr "${line}" 49 40)
>  
> -	# verify TPM is available and enabled.
> -	tpm_bios=$SECURITYFS/tpm0/binary_bios_measurements
>  	if [ ! -f "$tpm_bios" ]; then
> -		tst_brkm TCONF "TPM not builtin kernel, or TPM not enabled"
> +		tst_brk TCONF "TPM not builtin kernel, or TPM not enabled"
>  
>  		if [ "${ima_aggr}" = "${zero}" ]; then
> -			tst_resm TPASS "bios boot aggregate is 0."
> +			tst_res TPASS "bios boot aggregate is 0"
>  		else
> -			tst_resm TFAIL "bios boot aggregate is not 0."
> +			tst_res TFAIL "bios boot aggregate is not 0"
>  		fi
>  	else
>  		boot_aggregate=$(ima_boot_aggregate $tpm_bios)
>  		boot_aggr=$(expr substr $boot_aggregate 16 40)
>  		if [ "x${ima_aggr}" = "x${boot_aggr}" ]; then
> -			tst_resm TPASS "bios aggregate matches IMA boot aggregate."
> +			tst_res TPASS "bios aggregate matches IMA boot aggregate"
>  		else
> -			tst_resm TFAIL "bios aggregate does not match IMA boot aggregate."
> +			tst_res TFAIL "bios aggregate does not match IMA boot aggregate"
>  		fi
>  	fi
>  }
> @@ -74,64 +65,54 @@ test01()
>  # the PCR values from /sys/devices.
>  validate_pcr()
>  {
> -	ima_measurements=$SECURITYFS/ima/binary_runtime_measurements
> -	aggregate_pcr=$(ima_measure $ima_measurements --validate)
> -	dev_pcrs=$1
> -	RC=0
> +	tst_res TINFO "verify PCR (Process Control Register)"
>  
> -	while read line ; do
> +	local ima_measurements="$BINARY_MEASUREMENTS"
> +	local aggregate_pcr="$(ima_measure $ima_measurements --validate)"
> +	local dev_pcrs="$1"
> +	local ret=0
> +
> +	while read line; do
>  		pcr=$(expr substr "${line}" 1 6)
>  		if [ "${pcr}" = "PCR-10" ]; then
>  			aggr=$(expr substr "${aggregate_pcr}" 26 59)
>  			pcr=$(expr substr "${line}" 9 59)
> -			[ "${pcr}" = "${aggr}" ] || RC=$?
> +			[ "${pcr}" = "${aggr}" ] || ret=$?
>  		fi
>  	done < $dev_pcrs
> -	return $RC
> +	return $ret
>  }
>  
> -# Function:     test02
> -# Description	- Verify ima calculated aggregate PCR values matches
> -#		  actual PCR value.
> -test02()
> +test2()
>  {
> +	tst_res TINFO "verify PCR values"
>  
> -	# Would be nice to know where the PCRs are located.  Is this safe?
> -	PCRS_PATH=$(find /$SYSFS/devices/ | grep pcrs)
> +	# Would be nice to know where the PCRs are located. Is this safe?
> +	local pcrs_path="$(find $SYSFS/devices/ | grep pcrs)"
>  	if [ $? -eq 0 ]; then
> -		validate_pcr $PCRS_PATH
> +		validate_pcr $pcrs_path
>  		if [ $? -eq 0 ]; then
> -			tst_resm TPASS "aggregate PCR value matches real PCR value."
> +			tst_res TPASS "aggregate PCR value matches real PCR value"
>  		else
> -			tst_resm TFAIL "aggregate PCR value does not match real PCR value."
> +			tst_res TFAIL "aggregate PCR value does not match real PCR value"
>  		fi
>  	else
> -		tst_resm TFAIL "TPM not enabled, no PCR value to validate"
> +		tst_res TFAIL "TPM not enabled, no PCR value to validate"
>  	fi
>  }
>  
> -# Function:     test03
> -# Description 	- Verify template hash value for IMA entry is correct.
> -test03()
> +test3()
>  {
> +	tst_res TINFO "verify template hash value"
>  
> -	ima_measurements=$SECURITYFS/ima/binary_runtime_measurements
> -	aggregate_pcr=$(ima_measure $ima_measurements --verify --validate) > /dev/null
> +	local ima_measurements="$BINARY_MEASUREMENTS"
> +	ima_measure $ima_measurements --verify --validate
>  	if [ $? -eq 0 ]; then
> -		tst_resm TPASS "verified IMA template hash values."
> +		tst_res TPASS "verified IMA template hash values"
>  	else
> -		tst_resm TFAIL "error verifing IMA template hash values."
> +		tst_res TFAIL "error verifing IMA template hash values"
>  	fi
>  }
>  
> -. ima_setup.sh
> -
> -setup
> -TST_CLEANUP=cleanup
> -
>  init

Here as well.

> -test01
> -test02
> -test03
> -
> -tst_exit
> +tst_run
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 1b86b5f1a..80a01a546 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -1,44 +1,45 @@
>  #!/bin/sh
> -################################################################################
> -##                                                                            ##
> -## Copyright (C) 2009 IBM Corporation                                         ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -################################################################################
> +# Copyright (c) 2009 IBM Corporation
> +# Copyright (c) 2018 Petr Vorel <pvorel@suse.cz>
>  #
> -# File :        ima_violations.sh
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation; either version 2 of
> +# the License, or (at your option) any later version.
>  #
> -# Description:  This file tests ToMToU and open_writer violations invalidate
> -#		the PCR and are logged.
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
>  #
> -# Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
> +# You should have received a copy of the GNU General Public License
> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
>  #
> -# Return        - zero on success
> -#               - non zero on failure. return value from commands ($RC)
> -################################################################################
> +# Author: Mimi Zohar, zohar@ibm.vnet.ibm.com
> +#
> +# Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
>  
> -export TST_TOTAL=3
> -export TCID="ima_violations"
> +TST_TESTFUNC="test"
> +TST_CNT=3
> +. ima_setup.sh
>  
> -open_file_read()
> +FILE="test.txt"
> +IMA_VIOLATIONS="$SECURITYFS/ima/violations"
> +
> +init()
>  {
> -	exec 3< $1
> -	if [ $? -ne 0 ]; then
> -		exit 1
> +	LOG="/var/log/messages"
> +	SLEEP="500ms"
> +	if service auditd status > /dev/null 2>&1; then

Here we depend on service being installed, which unfortunately is not
the case for all currently supported distributions. Have a look at
testcases/lib/daemonlib.sh and status_daemon() function there.

> +		LOG="/var/log/audit/audit.log"
> +		tst_res TINFO "requires integrity auditd patch"
>  	fi
> +	tst_res TINFO "using log $LOG"
> +}
> +
> +open_file_read()
> +{
> +	exec 3< $FILE || exit 1
>  }
>  
>  close_file_read()
> @@ -48,11 +49,8 @@ close_file_read()
>  
>  open_file_write()
>  {
> -	exec 4> $1
> -	if [ $? -ne 0 ]; then
> -		exit 1
> -	echo 'testing, testing, ' >&4
> -	fi
> +	exec 4> $FILE || exit 1
> +	echo 'test writing' >&4
>  }
>  
>  close_file_write()
> @@ -60,103 +58,89 @@ close_file_write()
>  	exec 4>&-
>  }
>  
> -init()
> +get_count()
>  {
> -	service auditd status > /dev/null 2>&1
> -	if [ $? -ne 0 ]; then
> -		log=/var/log/messages
> -	else
> -		log=/var/log/audit/audit.log
> -		tst_resm TINFO "requires integrity auditd patch"
> -	fi
> -
> -	ima_violations=$SECURITYFS/ima/violations
> +	local search="$1"
> +	echo $(grep -c "${search}.*${FILE}" $LOG)
>  }
>  
> -# Function:     test01
> -# Description	- Verify open writers violation
> -test01()
> +validate()
>  {
> -	read num_violations < $ima_violations
> -
> -	TMPFN=test.txt
> -	open_file_write $TMPFN
> -	open_file_read $TMPFN
> -	close_file_read
> -	close_file_write
> -	read num_violations_new < $ima_violations
> -	num=$(($(expr $num_violations_new - $num_violations)))
> -	if [ $num -gt 0 ]; then
> -		tail $log | grep test.txt | grep -q 'open_writers'
> -		if [ $? -eq 0 ]; then
> -			tst_resm TPASS "open_writers violation added(test.txt)"
> +	local num_violations="$1"
> +	local count="$2"
> +	local search="$3"
> +	local count2="$(get_count $search)"
> +	local num_violations_new
> +
> +	[ -n "$SLEEP" ] && tst_sleep $SLEEP
> +
> +	read num_violations_new < $IMA_VIOLATIONS
> +	if [ $(($num_violations_new - $num_violations)) -gt 0 ]; then
> +		if [ $count2 -gt $count ]; then
> +			tst_res TPASS "$search violation added"
>  		else
> -			tst_resm TFAIL "(message ratelimiting?)"
> +			tst_res TFAIL "$search not found in $LOG"
>  		fi
>  	else
> -		tst_resm TFAIL "open_writers violation not added(test.txt)"
> +		tst_res TFAIL "$search violation not added"
>  	fi
>  }
>  
> -# Function:     test02
> -# Description   - Verify ToMToU violation
> -test02()
> +test1()
>  {
> -	read num_violations < $ima_violations
> +	tst_res TINFO "verify open writers violation"
>  
> -	TMPFN=test.txt
> -	open_file_read $TMPFN
> -	open_file_write $TMPFN
> -	close_file_write
> +	local search="open_writers"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_write
> +	open_file_read
>  	close_file_read
> -	read num_violations_new < $ima_violations
> -	num=$(($(expr $num_violations_new - $num_violations)))
> -	if [ $num -gt 0 ]; then
> -		tail $log | grep test.txt | grep -q 'ToMToU'
> -		if [ $? -eq 0 ]; then
> -			tst_resm TPASS "ToMToU violation added(test.txt)"
> -		else
> -			tst_resm TFAIL "(message ratelimiting?)"
> -		fi
> -	else
> -		tst_resm TFAIL "ToMToU violation not added(test.txt)"
> -	fi
> +	close_file_write
> +
> +	validate $num_violations $count $search
>  }
>  
> -# Function:     test03
> -# Description 	- verify open_writers using mmapped files
> -test03()
> +test2()
>  {
> -	read num_violations < $ima_violations
> -
> -	TMPFN=test.txtb
> -	echo 'testing testing ' > $TMPFN
> -	ima_mmap $TMPFN & p1=$!
> -	sleep 1		# got to wait for ima_mmap to mmap the file
> -	open_file_read $TMPFN
> -	read num_violations_new < $ima_violations
> -	num=$(($(expr $num_violations_new - $num_violations)))
> -	if [ $num -gt 0 ]; then
> -		tail $log | grep test.txtb | grep -q 'open_writers'
> -		if [ $? -eq 0 ]; then
> -			tst_resm TPASS "mmapped open_writers violation added(test.txtb)"
> -		else
> -			tst_resm TFAIL "(message ratelimiting?)"
> -		fi
> -	else
> -		tst_resm TFAIL "mmapped open_writers violation not added(test.txtb)"
> -	fi
> +	tst_res TINFO "verify ToMToU violation"
> +
> +	local search="ToMToU"
> +	local count num_violations
> +
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	open_file_read
> +	open_file_write
> +	close_file_write
>  	close_file_read
> +
> +	validate $num_violations $count $search
>  }
>  
> -. ima_setup.sh
> +test3()
> +{
> +	tst_res TINFO "verify open_writers using mmapped files"
>  
> -setup
> -TST_CLEANUP=cleanup
> +	local search="open_writers"
> +	local count num_violations
>  
> -init
> -test01
> -test02
> -test03
> +	read num_violations < $IMA_VIOLATIONS
> +	count="$(get_count $search)"
> +
> +	echo 'testing testing ' > $FILE
> +	ima_mmap $FILE &
> +	sleep 1

What do we sleep here for?

> +	open_file_read
> +	close_file_read
> +
> +	validate $num_violations $count $search
> +}
> +
> +init
> +tst_run
> -- 
> 2.15.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
