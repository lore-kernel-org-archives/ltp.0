Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gux.fnst@cn.fujitsu.com>) id 1XJZeF-0006VF-8r
	for ltp-list@lists.sourceforge.net; Tue, 19 Aug 2014 02:59:47 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XJZe6-0001Wr-CV
	for ltp-list@lists.sourceforge.net; Tue, 19 Aug 2014 02:59:47 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s7J2xTrk017092
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Aug 2014 10:59:29 +0800
Message-ID: <53F2BD21.3070501@cn.fujitsu.com>
Date: Tue, 19 Aug 2014 10:57:37 +0800
From: "gux.fnst" <gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
References: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1404291667-13198-1-git-send-email-gux.fnst@cn.fujitsu.com>
In-Reply-To: <1404291667-13198-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 1/2] hotplug/cpu_hotplug: rename files in
 include and tools directories
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

Ping.

Regards,
Xing Gu

On 07/02/2014 05:01 PM, Xing Gu wrote:
> Signed-off-by: Xing Gu <gux.fnst@cn.fujitsu.com>
> ---
>   testcases/kernel/hotplug/cpu_hotplug/ChangeLog     |   6 +-
>   testcases/kernel/hotplug/cpu_hotplug/README        |   6 +-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug01.sh |  12 +-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug02.sh |   6 +-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug03.sh |  23 ++-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug04.sh |   4 +-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug05.sh |   4 +-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug06.sh |   4 +-
>   .../hotplug/cpu_hotplug/functional/cpuhotplug07.sh |   6 +-
>   .../cpu_hotplug/include/cpuhotplug_hotplug.sh      | 203 +++++++++++++++++++++
>   .../cpu_hotplug/include/cpuhotplug_testsuite.sh    | 171 +++++++++++++++++
>   .../kernel/hotplug/cpu_hotplug/include/hotplug.fns | 202 --------------------
>   .../hotplug/cpu_hotplug/include/testsuite.fns      | 170 -----------------
>   .../tools/cpuhotplug_do_disk_write_loop            |  19 ++
>   .../cpu_hotplug/tools/cpuhotplug_do_kcompile_loop  |  21 +++
>   .../cpu_hotplug/tools/cpuhotplug_do_spin_loop      |   8 +
>   .../tools/cpuhotplug_report_proc_interrupts        |  53 ++++++
>   .../hotplug/cpu_hotplug/tools/do_disk_write_loop   |  19 --
>   .../hotplug/cpu_hotplug/tools/do_kcompile_loop     |  21 ---
>   .../kernel/hotplug/cpu_hotplug/tools/do_spin_loop  |   8 -
>   .../cpu_hotplug/tools/report_proc_interrupts       |  53 ------
>   21 files changed, 514 insertions(+), 505 deletions(-)
>   create mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
>   create mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
>   delete mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
>   delete mode 100644 testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns
>   create mode 100644 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop
>   create mode 100644 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop
>   create mode 100644 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop
>   create mode 100644 testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts
>   delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop
>   delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop
>   delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop
>   delete mode 100755 testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts
>
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/ChangeLog b/testcases/kernel/hotplug/cpu_hotplug/ChangeLog
> index 5e6b9df..bf1d979 100644
> --- a/testcases/kernel/hotplug/cpu_hotplug/ChangeLog
> +++ b/testcases/kernel/hotplug/cpu_hotplug/ChangeLog
> @@ -1,15 +1,15 @@
>   2006-09-14  Bryce Harrington  <bryce@osdl.org>
>   	* hotplug03.sh:  Fixing bug in return value of psr command, that
>   	  was getting lost due to a subsequent command
> -	* hotplug07.sh:  Fixing path issue for do_kcompile_loop
> +	* hotplug07.sh:  Fixing path issue for cpuhotplug_do_kcompile_loop
>   	* hotplug07.sh:  Automatic kernel source tree detection
>   	* hotplug07.sh:  Reordering statements to suppress a warning
> -	* do_kcompile_loop:  Adding support for chdir to kernel dir
> +	* cpuhotplug_do_kcompile_loop:  Adding support for chdir to kernel dir
>
>   2006-07-06  Bryce Harrington  <bryce@osdl.org>
>   	* hotplug07.sh:  Fixing permissions
>   	* hotplug07.sh:  Updating includes
> -	* include/hotplug.fns:  Fixing error where files in
> +	* include/cpuhotplug_hotplug.sh:  Fixing error where files in
>   	  /sys/devices/system/cpu were detected as (invalid) cpus.
>
>   2006-03-09  Bryce Harrington  <bryce@osdl.org>
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/README b/testcases/kernel/hotplug/cpu_hotplug/README
> index 0199a36..54fbd1a 100644
> --- a/testcases/kernel/hotplug/cpu_hotplug/README
> +++ b/testcases/kernel/hotplug/cpu_hotplug/README
> @@ -23,15 +23,15 @@ can be run in place using the above script.
>   About Hotplug CPU
>   =================
>   The logic used to operate the hotplug features in Linux are implemented
> -in the file includes/hotplug.fns.  These include functions for onlining
> -and offlining CPUs, determining if a given CPU is valid and/or online,
> +in the file includes/cpuhotplug_hotplug.sh. These include functions for
> +onlining and offlining CPUs, determining if a given CPU is valid and/or online,
>   getting lists of CPUs that are available, online, and offline, and
>   managing IRQ's and affinities as they relate to CPUs.
>
>
>   About the Test Suite
>   ====================
> -See includes/testsuite.fns for some general purpose routines for
> +See includes/cpuhotplug_testsuite.sh for some general purpose routines for
>   implementing a test suite.  These include process management, timing,
>   and interupt handling and cleanup.
>
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> index 07379dc..9e05cce 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> @@ -18,8 +18,8 @@ fi
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> @@ -38,7 +38,8 @@ TM_OFFLINE=${HOTPLUG01_TM_OFFLINE:-1}
>   TM_DLY=${HOTPLUG01_TM_DLY:-6}
>
>   if ! type -P perl > /dev/null; then
> -	tst_brk TCONF "analysis script - report_proc_interrupts - requires perl"
> +	tst_brk TCONF "analysis script - cpuhotplug_report_proc_interrupts - \
> +					requires perl"
>   	exit 1
>   fi
>
> @@ -123,7 +124,7 @@ do_online()
>   }
>
>   # Start up a process that writes to disk; keep track of its PID
> -$LHCS_PATH/tools/do_disk_write_loop > /dev/null 2>&1 &
> +$LHCS_PATH/tools/cpuhotplug_do_disk_write_loop > /dev/null 2>&1 &
>   WRL_ID=$!
>
>   RC=0
> @@ -172,7 +173,8 @@ do
>   	# Print out a report showing the changes in IRQs
>   	echo
>   	echo
> -	$LHCS_PATH/tools/report_proc_interrupts "$IRQ_START" "$IRQ_END"
> +	$LHCS_PATH/tools/cpuhotplug_report_proc_interrupts "$IRQ_START" \
> +		"$IRQ_END"
>   	echo
>
>   	if [ $RC -eq 0 ] ; then
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> index 3f9400b..56eead9 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug02.sh
> @@ -16,8 +16,8 @@ fi
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> @@ -27,7 +27,7 @@ Desc:   What happens to a process when its CPU is offlined?
>   EOF
>
>   # Start up a process that just uses CPU cycles
> -$LHCS_PATH/tools/do_spin_loop > /dev/null&
> +$LHCS_PATH/tools/cpuhotplug_do_spin_loop > /dev/null&
>   SPIN_LOOP_PID=$!
>
>   # Validate the specified CPU exists
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
> index 516a21f..60343d5 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug03.sh
> @@ -16,8 +16,8 @@ fi
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> @@ -85,13 +85,13 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>   	# so we can kill them later.
>   	: $(( number_of_cpus *= 2 ))
>   	until [ $number_of_cpus -eq 0 ]; do
> -		$LHCS_PATH/tools/do_spin_loop > /dev/null 2>&1 &
> +		$LHCS_PATH/tools/cpuhotplug_do_spin_loop > /dev/null 2>&1 &
>   		echo $! >> /var/run/hotplug4_$$.pid
>   		: $(( number_of_cpus -= 1 ))
>   	done
>
>   	ps aux | head -n 1
> -	ps aux | grep do_spin_loop
> +	ps aux | grep cpuhotplug_do_spin_loop
>
>   	# Online the CPU
>   	tst_resm TINFO "Onlining CPU ${CPU_TO_TEST}"
> @@ -105,15 +105,20 @@ until [ $TST_COUNT -gt $TST_TOTAL ]; do
>   	sleep 1
>
>   	# Verify at least one process has migrated to the new CPU
> -	ps -o psr -o command --no-headers -C do_spin_loop
> +	ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop
>   	RC=$?
> -	NUM=`ps -o psr -o command --no-headers -C do_spin_loop | sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | wc -l`
> +	NUM=`ps -o psr -o command --no-headers -C cpuhotplug_do_spin_loop | \
> +		sed -e "s/^ *//" | cut -d' ' -f 1 | grep "^${CPU_TO_TEST}$" | \
> +		wc -l`
>   	if [ $RC -ne 0 ]; then
> -		tst_resm TBROK "No do_spin_loop processes found on any processor"
> +		tst_resm TBROK "No cpuhotplug_do_spin_loop processes found on \
> +			any processor"
>   	elif [ $NUM -lt 1 ]; then
> -		tst_resm TFAIL "No do_spin_loop processes found on CPU${CPU_TO_TEST}"
> +		tst_resm TFAIL "No cpuhotplug_do_spin_loop processes found on \
> +			CPU${CPU_TO_TEST}"
>   	else
> -		tst_resm TPASS "$NUM do_spin_loop processes found on CPU${CPU_TO_TEST}"
> +		tst_resm TPASS "$NUM cpuhotplug_do_spin_loop processes found \
> +			on CPU${CPU_TO_TEST}"
>   	fi
>
>   	do_clean
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
> index 3e84354..0204d66 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug04.sh
> @@ -10,8 +10,8 @@ export TST_TOTAL=${HOTPLUG04_LOOPS:-1}
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> index e64b91c..9b1cdbc 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug05.sh
> @@ -17,8 +17,8 @@ fi
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> index 0778fa0..bb80746 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug06.sh
> @@ -16,8 +16,8 @@ fi
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> index cd45677..c77ccfb 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug07.sh
> @@ -12,8 +12,8 @@ export TST_TOTAL=${HOTPLUG07_LOOPS:-1}
>
>   # Includes:
>   LHCS_PATH=${LHCS_PATH:-${LTPROOT:+$LTPROOT/testcases/bin/cpu_hotplug}}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. $LHCS_PATH/include/cpuhotplug_testsuite.sh
> +. $LHCS_PATH/include/cpuhotplug_hotplug.sh
>
>   cat <<EOF
>   Name:   $TCID
> @@ -39,7 +39,7 @@ do_clean()
>   	kill_pid ${KCOMPILE_LOOP_PID}
>   }
>
> -$LHCS_PATH/tools/do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
> +$LHCS_PATH/tools/cpuhotplug_do_kcompile_loop $KERNEL_DIR > /dev/null 2>&1 &
>   KCOMPILE_LOOP_PID=$!
>
>   tst_resm TINFO "initial CPU affinity for kernel compile is: $(get_affinity_mask ${KCOMPILE_LOOP_PID})"
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> new file mode 100644
> index 0000000..8ded6bb
> --- /dev/null
> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_hotplug.sh
> @@ -0,0 +1,203 @@
> +#!/bin/sh
> +
> +# cpuhotplug_hotplug.sh - Collection of functions for hotplugging
> +# operations.
> +
> +# Routines in this library are set up to allow timing to be done
> +# by defining $TIME to a timing command.
> +TIME=${TIME:-""}
> +
> +# get_all_irqs()
> +#
> +#  Gets list of all available IRQs in the system
> +#
> +get_all_irqs()
> +{
> +    echo `egrep [0-9]+: /proc/interrupts | cut -d ':' -f 1`
> +    return
> +}
> +
> +# migrate_irq(CPU, IRQS)
> +#
> +#  Sets the smp_affinity for the list of $IRQS to the given
> +#  CPU number
> +#
> +migrate_irq()
> +{
> +    CPU=${1#cpu}
> +    MASK=$((1<<${CPU}))
> +    IRQS=$2
> +    for irq in ${IRQS}
> +      do
> +      echo $MASK > /proc/irq/${irq}/smp_affinity || \
> +        tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
> +    done
> +}
> +
> +
> +# get_affinity(PID)
> +#
> +#  Echos the CPU affinity for the given process ID to stdout
> +#
> +get_affinity_mask()
> +{
> +    AFFINITY=`taskset -p ${1}`
> +    echo ${AFFINITY}
> +    return
> +}
> +
> +# set_affinity(PID, CPU)
> +#
> +#  Sets the affinity for the given PID to the specified CPU.
> +#
> +set_affinity()
> +{
> +    PID="$1"
> +    CPU="$2"
> +    MASK=$((1<<${CPU_TO_TEST}))
> +    `taskset -p ${MASK} ${PID} > /dev/null 2>&1`
> +    return $?
> +}
> +
> +# online_cpu(CPU)
> +#
> +#  Onlines the given CPU.  Returns a true value if it was able
> +#  to perform the online operation successfully, false otherwise.
> +#
> +#  $CPU should either be a specific number like 4, or the cpu name,
> +#  as in 'cpu4'.
> +#
> +online_cpu()
> +{
> +    CPU=${1#cpu}
> +    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
> +        return 1
> +    fi
> +    $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
> +    RC=$?
> +    report_timing "Online cpu ${CPU}"
> +    return $RC
> +}
> +
> +
> +# offline_cpu(CPU)
> +#
> +#  Offlines the given CPU.  Returns a true value if it was able
> +#  to perform the offline operation successfully, false otherwise.
> +#
> +offline_cpu()
> +{
> +    CPU=${1#cpu}
> +    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
> +        return 1
> +    fi
> +    $TIME echo 0 > /sys/devices/system/cpu/cpu${CPU}/online
> +    RC=$?
> +    report_timing "Offline cpu ${CPU}"
> +    return $RC
> +}
> +
> +
> +# get_all_cpus()
> +#
> +#  Prints a list of all available CPUs, regardless of whether they're
> +#  currently online or offline.
> +#
> +#  This routine will work even if the CPUs are not hotpluggable, however
> +#  it requires you have sysfs enabled in the kernel.
> +#
> +get_all_cpus()
> +{
> +    [ -d /sys/devices/system/cpu/cpu0 ] || return 1
> +    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
> +        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
> +}
> +
> +
> +# get_all_cpu_states()
> +#
> +#  Collects the current online/offline state of CPUs in the
> +#  system, printing it in a format that can be passed to
> +#  set_all_cpu_states() later.
> +#
> +get_all_cpu_states()
> +{
> +    echo `cd /sys/devices/system/cpu/ && grep '' */online | \
> +		sed -e 's/\/online//'`
> +    return
> +}
> +
> +# set_all_cpu_states(STATES)
> +#
> +#  Sets all of the CPU states according to $STATE, which must be
> +#  of the form "cpuX:Y", where X is the CPU number and Y its state.
> +#  Each must be on a separate line.
> +#
> +set_all_cpu_states()
> +{
> +    for cpu_state in $STATE; do
> +        cpu=`echo $c | cut -d: -f 1`
> +        state=`echo $c | cut -d: -f 1`
> +        if [ $state = 1 ]; then
> +            echo "# Re-onlining $cpu"
> +            online_cpu $cpu
> +        else
> +            echo "# Re-offlining $cpu"
> +            offline_cpu $cpu
> +        fi
> +    done
> +}
> +
> +
> +# get_online_cpus()
> +#
> +#  Prints a list of all CPUs currently online.  This function only
> +#  works if the system's CPUs have hotplug capabilities
> +#
> +get_online_cpus()
> +{
> +    echo `cd /sys/devices/system/cpu/ && grep 1 */online | cut -d '/' -f 1`
> +    return
> +}
> +
> +
> +# get_offline_cpus()
> +#
> +#  Prints a list of all CPUs currently offline.  This function only
> +#  works if the system's CPUs have hotplug capabilities
> +#
> +get_offline_cpus()
> +{
> +    echo `cd /sys/devices/system/cpu/ && grep 0 */online | cut -d '/' -f 1`
> +    return
> +}
> +
> +# cpu_is_valid(CPU)
> +#
> +#  Checks to see if the given CPU number is available for hotplugging
> +#  in the system.  Returns 0 if the CPU is available, 1 otherwise.
> +#
> +cpu_is_valid()
> +{
> +    CPU=${1#cpu}
> +    echo "CPU is $CPU"
> +    cat /sys/devices/system/cpu/cpu${CPU}/online > /dev/null 2>&1
> +    return $?
> +}
> +
> +
> +# cpu_is_online(CPU)
> +#
> +#  Returns a 0 value if the given CPU number is currently online,
> +#  1 otherwise.  This function requires the system's CPUs have
> +#  hotplug capabilities.
> +#
> +cpu_is_online()
> +{
> +    CPU=${1#cpu}
> +    if [ `cat /sys/devices/system/cpu/cpu${CPU}/online` = "1" ]; then
> +        return 0
> +    else
> +        return 1
> +    fi
> +}
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
> new file mode 100644
> index 0000000..2d0166c
> --- /dev/null
> +++ b/testcases/kernel/hotplug/cpu_hotplug/include/cpuhotplug_testsuite.sh
> @@ -0,0 +1,171 @@
> +#!/bin/sh
> +############################################################
> +## Convenience functions for reporting, asserting, etc.   ##
> +############################################################
> +
> +# warn(TEXT)
> +#
> +#  Issues a warning message to stderr
> +#
> +warn()
> +{
> +    echo $1 1>&2
> +}
> +
> +# assert()
> +#
> +#  Basic assertion support.  Use it like this:
> +#
> +#   a=5
> +#   b=4
> +#   condition="$a -lt $b"     # Error message and exit from script.
> +#                             #  Try setting "condition" to something else,
> +#                             #+ and see what happens.
> +#
> +#   assert "$condition" $LINENO
> +#
> +# Note that $LINENO is a built-in
> +#
> +assert ()                 #  If condition false,
> +{                         #+ exit from script with error message.
> +  E_PARAM_ERR=98
> +  E_ASSERT_FAILED=99
> +
> +
> +  if [ -z "$2" ]          # Not enough parameters passed.
> +  then
> +    return $E_PARAM_ERR   # No damage done.
> +  fi
> +
> +  lineno=$2
> +
> +  if [ ! $1 ]
> +  then
> +    echo "Assertion failed:  \"$1\""
> +    echo "File \"$0\", line $lineno"
> +    exit $E_ASSERT_FAILED
> +  # else
> +  #   return
> +  #   and continue executing script.
> +  fi
> +}
> +
> +############################################################
> +## Process management                                     ##
> +############################################################
> +
> +# pid_is_valid(PID)
> +#
> +#  Checks if the given $PID is still running.  Returns a true value if
> +#  it is, false otherwise.
> +#
> +pid_is_valid()
> +{
> +    PID=$1
> +    ps --pid ${PID} --no-header | grep ${PID}
> +    return $?
> +}
> +
> +# kill_pid(PID)
> +#
> +#  Forcibly kills the process ID and prevents it from
> +#  displaying any messages (to stdout, stderr, or otherwise)
> +#
> +kill_pid()
> +{
> +    PID=$1
> +    disown $PID
> +    kill -9 $PID > /dev/null 2>&1
> +}
> +
> +############################################################
> +## Timing                                                 ##
> +############################################################
> +
> +# Routines in this library are set up to allow timing to be done
> +# by defining $TIME to a timing command.  You can define your
> +# own handler by defining $TIME before or after including this
> +# library.
> +TIME=${TIME:-""}
> +
> +# Allows overriding the filename to use for storing time
> +# measurements.  Required in order to
> +TIME_TMP_FILE=${TIME_TMP_FILE:-"${TMP:-/tmp}/cpu_$$"}
> +
> +# perform_timings()
> +#
> +#  This turns on timings for operations that support timing
> +#  via the $TIME variable.  It does this by setting $TIME to
> +#  a general purpose time command.
> +set_timing_on()
> +{
> +    TIME="/usr/bin/time -o $TIME_TMP_FILE -f \"%e\""
> +}
> +
> +report_timing()
> +{
> +    MSG=${1:-"perform operation"}
> +    if [ ! -z "${TIME}" ]; then
> +        TM=`cat $TIME_TMP_FILE`
> +        echo "Time to ${MSG} : $TM"
> +    fi
> +}
> +
> +############################################################
> +## Interrupt handling and cleanup                         ##
> +############################################################
> +
> +# do_clean()
> +#
> +#  Virtual function called by do_intr().  Override this to
> +#  provide custom cleanup handling.
> +#
> +do_clean()
> +{
> +    return 0
> +}
> +
> +# do_testsuite_clean()
> +#
> +#  Internal routine to do cleanup specific to other routines
> +#  in this testsuite.  You may override this routine if you
> +#  do not want this behavior.
> +#
> +do_testsuite_clean()
> +{
> +    /bin/rm -rf $TIME_TMP_FILE
> +}
> +
> +# exit_clean(EXIT_CODE)
> +#
> +#  Replacement for exit command.  Prints the date, then calls do_clean
> +#  and exits with the given $EXIT_CODE, or 0 if none specified.
> +#
> +exit_clean()
> +{
> +    EXIT_CODE=${1:-0}
> +    date
> +    do_clean
> +    exit $EXIT_CODE
> +}
> +
> +# do_intr()
> +#
> +#  Handler for trapped interrupts (i.e., signals 1 2 15).
> +#
> +#  This will result in a call do do_clean() when the user
> +#  interrupts the test, allowing you to do whatever final
> +#  cleanup work is needed (removing tmp files, restoring
> +#  resources to initial states, etc.)  This routine will
> +#  exit with error code 1 when done.
> +#
> +do_intr()
> +{
> +    echo "## Cleaning up... user interrupt"
> +    do_testsuite_clean
> +    do_clean
> +    exit 1
> +}
> +
> +trap "do_intr" 1 2 15
> +
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns b/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
> deleted file mode 100644
> index 6b3c933..0000000
> --- a/testcases/kernel/hotplug/cpu_hotplug/include/hotplug.fns
> +++ /dev/null
> @@ -1,202 +0,0 @@
> -#!/bin/sh
> -
> -# hotplug.fns - Collection of functions for hotplugging
> -# operations.
> -
> -# Routines in this library are set up to allow timing to be done
> -# by defining $TIME to a timing command.
> -TIME=${TIME:-""}
> -
> -# get_all_irqs()
> -#
> -#  Gets list of all available IRQs in the system
> -#
> -get_all_irqs()
> -{
> -    echo `egrep [0-9]+: /proc/interrupts | cut -d ':' -f 1`
> -    return
> -}
> -
> -# migrate_irq(CPU, IRQS)
> -#
> -#  Sets the smp_affinity for the list of $IRQS to the given
> -#  CPU number
> -#
> -migrate_irq()
> -{
> -    CPU=${1#cpu}
> -    MASK=$((1<<${CPU}))
> -    IRQS=$2
> -    for irq in ${IRQS}
> -      do
> -      echo $MASK > /proc/irq/${irq}/smp_affinity || \
> -        tst_resm TINFO "It is NOT permitted to change the IRQ $irq smp_affinity"
> -    done
> -}
> -
> -
> -# get_affinity(PID)
> -#
> -#  Echos the CPU affinity for the given process ID to stdout
> -#
> -get_affinity_mask()
> -{
> -    AFFINITY=`taskset -p ${1}`
> -    echo ${AFFINITY}
> -    return
> -}
> -
> -# set_affinity(PID, CPU)
> -#
> -#  Sets the affinity for the given PID to the specified CPU.
> -#
> -set_affinity()
> -{
> -    PID="$1"
> -    CPU="$2"
> -    MASK=$((1<<${CPU_TO_TEST}))
> -    `taskset -p ${MASK} ${PID} > /dev/null 2>&1`
> -    return $?
> -}
> -
> -# online_cpu(CPU)
> -#
> -#  Onlines the given CPU.  Returns a true value if it was able
> -#  to perform the online operation successfully, false otherwise.
> -#
> -#  $CPU should either be a specific number like 4, or the cpu name,
> -#  as in 'cpu4'.
> -#
> -online_cpu()
> -{
> -    CPU=${1#cpu}
> -    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
> -        return 1
> -    fi
> -    $TIME echo 1 > /sys/devices/system/cpu/cpu${CPU}/online
> -    RC=$?
> -    report_timing "Online cpu ${CPU}"
> -    return $RC
> -}
> -
> -
> -# offline_cpu(CPU)
> -#
> -#  Offlines the given CPU.  Returns a true value if it was able
> -#  to perform the offline operation successfully, false otherwise.
> -#
> -offline_cpu()
> -{
> -    CPU=${1#cpu}
> -    if [ ! -w /sys/devices/system/cpu/cpu${CPU}/online ]; then
> -        return 1
> -    fi
> -    $TIME echo 0 > /sys/devices/system/cpu/cpu${CPU}/online
> -    RC=$?
> -    report_timing "Offline cpu ${CPU}"
> -    return $RC
> -}
> -
> -
> -# get_all_cpus()
> -#
> -#  Prints a list of all available CPUs, regardless of whether they're
> -#  currently online or offline.
> -#
> -#  This routine will work even if the CPUs are not hotpluggable, however
> -#  it requires you have sysfs enabled in the kernel.
> -#
> -get_all_cpus()
> -{
> -    [ -d /sys/devices/system/cpu/cpu0 ] || return 1
> -    ls -dr /sys/devices/system/cpu/cpu[0-9]* | \
> -        sed "s/\/sys\/devices\/system\/cpu\///g" || return 2
> -}
> -
> -
> -# get_all_cpu_states()
> -#
> -#  Collects the current online/offline state of CPUs in the
> -#  system, printing it in a format that can be passed to
> -#  set_all_cpu_states() later.
> -#
> -get_all_cpu_states()
> -{
> -    echo `cd /sys/devices/system/cpu/ && grep '' */online | sed -e 's/\/online//'`
> -    return
> -}
> -
> -# set_all_cpu_states(STATES)
> -#
> -#  Sets all of the CPU states according to $STATE, which must be
> -#  of the form "cpuX:Y", where X is the CPU number and Y its state.
> -#  Each must be on a separate line.
> -#
> -set_all_cpu_states()
> -{
> -    for cpu_state in $STATE; do
> -        cpu=`echo $c | cut -d: -f 1`
> -        state=`echo $c | cut -d: -f 1`
> -        if [ $state = 1 ]; then
> -            echo "# Re-onlining $cpu"
> -            online_cpu $cpu
> -        else
> -            echo "# Re-offlining $cpu"
> -            offline_cpu $cpu
> -        fi
> -    done
> -}
> -
> -
> -# get_online_cpus()
> -#
> -#  Prints a list of all CPUs currently online.  This function only
> -#  works if the system's CPUs have hotplug capabilities
> -#
> -get_online_cpus()
> -{
> -    echo `cd /sys/devices/system/cpu/ && grep 1 */online | cut -d '/' -f 1`
> -    return
> -}
> -
> -
> -# get_offline_cpus()
> -#
> -#  Prints a list of all CPUs currently offline.  This function only
> -#  works if the system's CPUs have hotplug capabilities
> -#
> -get_offline_cpus()
> -{
> -    echo `cd /sys/devices/system/cpu/ && grep 0 */online | cut -d '/' -f 1`
> -    return
> -}
> -
> -# cpu_is_valid(CPU)
> -#
> -#  Checks to see if the given CPU number is available for hotplugging
> -#  in the system.  Returns 0 if the CPU is available, 1 otherwise.
> -#
> -cpu_is_valid()
> -{
> -    CPU=${1#cpu}
> -    echo "CPU is $CPU"
> -    cat /sys/devices/system/cpu/cpu${CPU}/online > /dev/null 2>&1
> -    return $?
> -}
> -
> -
> -# cpu_is_online(CPU)
> -#
> -#  Returns a 0 value if the given CPU number is currently online,
> -#  1 otherwise.  This function requires the system's CPUs have
> -#  hotplug capabilities.
> -#
> -cpu_is_online()
> -{
> -    CPU=${1#cpu}
> -    if [ `cat /sys/devices/system/cpu/cpu${CPU}/online` = "1" ]; then
> -        return 0
> -    else
> -        return 1
> -    fi
> -}
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns b/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns
> deleted file mode 100644
> index 59103c2..0000000
> --- a/testcases/kernel/hotplug/cpu_hotplug/include/testsuite.fns
> +++ /dev/null
> @@ -1,170 +0,0 @@
> -############################################################
> -## Convenience functions for reporting, asserting, etc.   ##
> -############################################################
> -
> -# warn(TEXT)
> -#
> -#  Issues a warning message to stderr
> -#
> -warn()
> -{
> -    echo $1 1>&2
> -}
> -
> -# assert()
> -#
> -#  Basic assertion support.  Use it like this:
> -#
> -#   a=5
> -#   b=4
> -#   condition="$a -lt $b"     # Error message and exit from script.
> -#                             #  Try setting "condition" to something else,
> -#                             #+ and see what happens.
> -#
> -#   assert "$condition" $LINENO
> -#
> -# Note that $LINENO is a built-in
> -#
> -assert ()                 #  If condition false,
> -{                         #+ exit from script with error message.
> -  E_PARAM_ERR=98
> -  E_ASSERT_FAILED=99
> -
> -
> -  if [ -z "$2" ]          # Not enough parameters passed.
> -  then
> -    return $E_PARAM_ERR   # No damage done.
> -  fi
> -
> -  lineno=$2
> -
> -  if [ ! $1 ]
> -  then
> -    echo "Assertion failed:  \"$1\""
> -    echo "File \"$0\", line $lineno"
> -    exit $E_ASSERT_FAILED
> -  # else
> -  #   return
> -  #   and continue executing script.
> -  fi
> -}
> -
> -############################################################
> -## Process management                                     ##
> -############################################################
> -
> -# pid_is_valid(PID)
> -#
> -#  Checks if the given $PID is still running.  Returns a true value if
> -#  it is, false otherwise.
> -#
> -pid_is_valid()
> -{
> -    PID=$1
> -    ps --pid ${PID} --no-header | grep ${PID}
> -    return $?
> -}
> -
> -# kill_pid(PID)
> -#
> -#  Forcibly kills the process ID and prevents it from
> -#  displaying any messages (to stdout, stderr, or otherwise)
> -#
> -kill_pid()
> -{
> -    PID=$1
> -    disown $PID
> -    kill -9 $PID > /dev/null 2>&1
> -}
> -
> -############################################################
> -## Timing                                                 ##
> -############################################################
> -
> -# Routines in this library are set up to allow timing to be done
> -# by defining $TIME to a timing command.  You can define your
> -# own handler by defining $TIME before or after including this
> -# library.
> -TIME=${TIME:-""}
> -
> -# Allows overriding the filename to use for storing time
> -# measurements.  Required in order to
> -TIME_TMP_FILE=${TIME_TMP_FILE:-"${TMP:-/tmp}/cpu_$$"}
> -
> -# perform_timings()
> -#
> -#  This turns on timings for operations that support timing
> -#  via the $TIME variable.  It does this by setting $TIME to
> -#  a general purpose time command.
> -set_timing_on()
> -{
> -    TIME="/usr/bin/time -o $TIME_TMP_FILE -f \"%e\""
> -}
> -
> -report_timing()
> -{
> -    MSG=${1:-"perform operation"}
> -    if [ ! -z "${TIME}" ]; then
> -        TM=`cat $TIME_TMP_FILE`
> -        echo "Time to ${MSG} : $TM"
> -    fi
> -}
> -
> -############################################################
> -## Interrupt handling and cleanup                         ##
> -############################################################
> -
> -# do_clean()
> -#
> -#  Virtual function called by do_intr().  Override this to
> -#  provide custom cleanup handling.
> -#
> -do_clean()
> -{
> -    return 0
> -}
> -
> -# do_testsuite_clean()
> -#
> -#  Internal routine to do cleanup specific to other routines
> -#  in this testsuite.  You may override this routine if you
> -#  do not want this behavior.
> -#
> -do_testsuite_clean()
> -{
> -    /bin/rm -rf $TIME_TMP_FILE
> -}
> -
> -# exit_clean(EXIT_CODE)
> -#
> -#  Replacement for exit command.  Prints the date, then calls do_clean
> -#  and exits with the given $EXIT_CODE, or 0 if none specified.
> -#
> -exit_clean()
> -{
> -    EXIT_CODE=${1:-0}
> -    date
> -    do_clean
> -    exit $EXIT_CODE
> -}
> -
> -# do_intr()
> -#
> -#  Handler for trapped interrupts (i.e., signals 1 2 15).
> -#
> -#  This will result in a call do do_clean() when the user
> -#  interrupts the test, allowing you to do whatever final
> -#  cleanup work is needed (removing tmp files, restoring
> -#  resources to initial states, etc.)  This routine will
> -#  exit with error code 1 when done.
> -#
> -do_intr()
> -{
> -    echo "## Cleaning up... user interrupt"
> -    do_testsuite_clean
> -    do_clean
> -    exit 1
> -}
> -
> -trap "do_intr" 1 2 15
> -
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop
> new file mode 100644
> index 0000000..9e28591
> --- /dev/null
> +++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_disk_write_loop
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +
> +TMP_FILE=${TMP:-/tmp}/cpu_$$
> +TM_DLY=1    # Time delay before start of entire new cycle.
> +
> +
> +CNT=0
> +while :
> +do
> +
> +	: $(( CNT += 1 ))
> +	echo "Loop Count $CNT"
> +
> +	echo 1 > $TMP_FILE
> +	# TODO:  Verify writes are complete and correct
> +
> +	sleep $TM_DLY
> +
> +done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop
> new file mode 100644
> index 0000000..d4b32c2
> --- /dev/null
> +++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_kcompile_loop
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +
> +# Must be run from a kernel source code directory
> +
> +echo $$
> +
> +KERNEL_DIR=${1:-/usr/src/linux}
> +
> +if [ ! -d $KERNEL_DIR ]; then
> +	echo "${0##*/}: ERROR: kernel directory - $KERNEL_DIR - does not exist"
> +	exit 1
> +fi
> +
> +cd $KERNEL_DIR || exit $?
> +
> +while :
> +do
> +	make mrproper
> +	make defconfig
> +	make -j20 bzImage
> +done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop
> new file mode 100644
> index 0000000..a5c05cb
> --- /dev/null
> +++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_do_spin_loop
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +
> +echo $$
> +
> +while :
> +do
> +	NOOP=1
> +done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts
> new file mode 100644
> index 0000000..59a6bbd
> --- /dev/null
> +++ b/testcases/kernel/hotplug/cpu_hotplug/tools/cpuhotplug_report_proc_interrupts
> @@ -0,0 +1,53 @@
> +#!/usr/bin/perl
> +
> +use strict;
> +
> +sub compare_proc_interrupts {
> +    my ($run1, $run2) = @_;
> +
> +    my $printed_header;
> +    foreach my $irq (sort keys %{$run1}) {
> +        if (! $printed_header) {
> +            printf "%-8s ", "IRQ";
> +            foreach my $cpu (sort keys %{$run1->{$irq}}) {
> +                printf "%-5s ", $cpu;
> +            }
> +            print "\n";
> +            $printed_header = 1;
> +        }
> +        printf "%-8s ", $irq;
> +        foreach my $cpu (sort keys %{$run1->{$irq}}) {
> +            printf "%-5s ", $run2->{$irq}->{$cpu} - $run1->{$irq}->{$cpu};
> +        }
> +        print "\n";
> +    }
> +}
> +
> +
> +sub parse_proc_interrupts {
> +    my $content = shift;
> +    my @cpus;
> +    my %run;
> +
> +    foreach my $line (split /\n/, $content) {
> +        $line =~ s/^\s+//;
> +        $line =~ s/\s+$//;
> +
> +        if (! @cpus) {
> +            @cpus = split /\s+/, $line;
> +        } else {
> +            my @items = split /\s+/, $line;
> +            my $irq = shift @items;
> +            $irq =~ s/:$//;
> +            foreach my $cpu (@cpus) {
> +                $run{"IRQ$irq"}->{"$cpu"} = shift @items;
> +            }
> +        }
> +    }
> +    return \%run;
> +}
> +
> +my $run1 = parse_proc_interrupts(shift @ARGV);
> +my $run2 = parse_proc_interrupts(shift @ARGV);
> +
> +compare_proc_interrupts($run1, $run2);
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop
> deleted file mode 100755
> index 9e28591..0000000
> --- a/testcases/kernel/hotplug/cpu_hotplug/tools/do_disk_write_loop
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -#!/bin/sh
> -
> -TMP_FILE=${TMP:-/tmp}/cpu_$$
> -TM_DLY=1    # Time delay before start of entire new cycle.
> -
> -
> -CNT=0
> -while :
> -do
> -
> -	: $(( CNT += 1 ))
> -	echo "Loop Count $CNT"
> -
> -	echo 1 > $TMP_FILE
> -	# TODO:  Verify writes are complete and correct
> -
> -	sleep $TM_DLY
> -
> -done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop
> deleted file mode 100755
> index d4b32c2..0000000
> --- a/testcases/kernel/hotplug/cpu_hotplug/tools/do_kcompile_loop
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -#!/bin/sh
> -
> -# Must be run from a kernel source code directory
> -
> -echo $$
> -
> -KERNEL_DIR=${1:-/usr/src/linux}
> -
> -if [ ! -d $KERNEL_DIR ]; then
> -	echo "${0##*/}: ERROR: kernel directory - $KERNEL_DIR - does not exist"
> -	exit 1
> -fi
> -
> -cd $KERNEL_DIR || exit $?
> -
> -while :
> -do
> -	make mrproper
> -	make defconfig
> -	make -j20 bzImage
> -done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop b/testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop
> deleted file mode 100755
> index a5c05cb..0000000
> --- a/testcases/kernel/hotplug/cpu_hotplug/tools/do_spin_loop
> +++ /dev/null
> @@ -1,8 +0,0 @@
> -#!/bin/sh
> -
> -echo $$
> -
> -while :
> -do
> -	NOOP=1
> -done
> diff --git a/testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts b/testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts
> deleted file mode 100755
> index 59a6bbd..0000000
> --- a/testcases/kernel/hotplug/cpu_hotplug/tools/report_proc_interrupts
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -#!/usr/bin/perl
> -
> -use strict;
> -
> -sub compare_proc_interrupts {
> -    my ($run1, $run2) = @_;
> -
> -    my $printed_header;
> -    foreach my $irq (sort keys %{$run1}) {
> -        if (! $printed_header) {
> -            printf "%-8s ", "IRQ";
> -            foreach my $cpu (sort keys %{$run1->{$irq}}) {
> -                printf "%-5s ", $cpu;
> -            }
> -            print "\n";
> -            $printed_header = 1;
> -        }
> -        printf "%-8s ", $irq;
> -        foreach my $cpu (sort keys %{$run1->{$irq}}) {
> -            printf "%-5s ", $run2->{$irq}->{$cpu} - $run1->{$irq}->{$cpu};
> -        }
> -        print "\n";
> -    }
> -}
> -
> -
> -sub parse_proc_interrupts {
> -    my $content = shift;
> -    my @cpus;
> -    my %run;
> -
> -    foreach my $line (split /\n/, $content) {
> -        $line =~ s/^\s+//;
> -        $line =~ s/\s+$//;
> -
> -        if (! @cpus) {
> -            @cpus = split /\s+/, $line;
> -        } else {
> -            my @items = split /\s+/, $line;
> -            my $irq = shift @items;
> -            $irq =~ s/:$//;
> -            foreach my $cpu (@cpus) {
> -                $run{"IRQ$irq"}->{"$cpu"} = shift @items;
> -            }
> -        }
> -    }
> -    return \%run;
> -}
> -
> -my $run1 = parse_proc_interrupts(shift @ARGV);
> -my $run2 = parse_proc_interrupts(shift @ARGV);
> -
> -compare_proc_interrupts($run1, $run2);
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

