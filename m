Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wv3pg-0006Uj-09
	for ltp-list@lists.sourceforge.net; Thu, 12 Jun 2014 12:10:16 +0000
Date: Thu, 12 Jun 2014 14:10:03 +0200
From: chrubis@suse.cz
Message-ID: <20140612121002.GA20221@rei>
References: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1400502716-8969-1-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] hotplug/cpu_hotplug: add it to run default and
 cleanup
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -cpuhotplug01 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug01.sh
> -cpuhotplug02 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug02.sh
> -cpuhotplug03 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug03.sh
> -cpuhotplug04 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug04.sh
> -cpuhotplug05 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug05.sh
> -cpuhotplug06 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug06.sh
> -cpuhotplug07 export CPU_TO_TEST=1; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug07.sh
> +#cpuhotplug01; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug01.sh -c 1 -l 1 -n 1 -f 1 -e 6
> +cpuhotplug02; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug02.sh -c 1 -l 1
> +cpuhotplug03; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug03.sh -c 1 -l 1
> +cpuhotplug04; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug04.sh -l 1
> +cpuhotplug05; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug05.sh -c 1 -l 1 -d /tmp
> +cpuhotplug06; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug06.sh -c 1 -l 1
> +cpuhotplug07; $LTPROOT/testcases/bin/cpu_hotplug/functional/cpuhotplug07.sh -c 1 -l 1 -d /usr/src/linux

Ideally the cpuhotplug*.sh tests should be installed under the
testcases/bin/ so we can call them without the full path. Or is there
any good reason why they are not?

> diff --git a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> index 07379dc..acf28a9 100755
> --- a/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> +++ b/testcases/kernel/hotplug/cpu_hotplug/functional/cpuhotplug01.sh
> @@ -5,21 +5,13 @@
>  # Based on script by Ashok Raj <ashok.raj@intel.com>
>  # Modified by Mark D and Bryce, Aug '05.
>  
> -HOTPLUG01_LOOPS=${HOTPLUG01_LOOPS:-${LOOPS}}
>  export TCID="cpuhotplug01"
> -export TST_COUNT=1
> -export TST_TOTAL=${HOTPLUG01_LOOPS:-1}
> -
> -CPU_TO_TEST=${CPU_TO_TEST:-1}
> -if [ -z "${CPU_TO_TEST}" ]; then
> -	echo "usage: ${0##*/} <CPU to online>"
> -	exit 1
> -fi
> +export TST_TOTAL=1
>  
>  # Includes:
> -LHCS_PATH=${LHCS_PATH:-$LTPROOT/testcases/bin/cpu_hotplug}
> -. $LHCS_PATH/include/testsuite.fns
> -. $LHCS_PATH/include/hotplug.fns
> +. test.sh
> +. cpu_hotplug/include/testsuite.fns
> +. cpu_hotplug/include/hotplug.fns

These files should be renamed to have standard .sh extension.

>  cat <<EOF
>  Name:   $TCID
> @@ -28,39 +20,21 @@ Desc:   What happens to disk controller interrupts when offlining CPUs?
>  
>  EOF
>  
> -# Time delay after an online of cpu
> -TM_ONLINE=${HOTPLUG01_TM_ONLINE:-1}
> -
> -# Time delay after offline of cpu
> -TM_OFFLINE=${HOTPLUG01_TM_OFFLINE:-1}
> -
> -# Time delay before start of entire new cycle.
> -TM_DLY=${HOTPLUG01_TM_DLY:-6}
> -
> -if ! type -P perl > /dev/null; then
> -	tst_brk TCONF "analysis script - report_proc_interrupts - requires perl"
> -	exit 1
> -fi
> +usage()
> +{
> +	cat << EOF
> +	usage: $0 -c cpu -l loop -n timeon -f timeoff -e timed
>  
> -if ! get_all_cpus >/dev/null 2>&1; then
> -	tst_brkm TCONF "system doesn't have required CPU hotplug support"
> -	exit 1
> -fi
> +	OPTIONS
> +		-c  cpu which is specified for testing
> +		-l  number of cycle test
> +		-n	time delay after an online of cpu
> +		-f	time delay after offline of cpu
> +		-e	time delay before start of entire new cycle
>  
> -# Validate the specified CPU exists
> -if ! cpu_is_valid "${CPU_TO_TEST}" ; then
> -	tst_resm TFAIL "cpu${CPU_TO_TEST} not found"
> +EOF
>  	exit 1
> -fi
> -
> -CPU_COUNT=0
> -
> -if ! cpu_is_online "${CPU_TO_TEST}" ; then
> -	if ! online_cpu ${CPU_TO_TEST} ; then
> -		tst_resm TFAIL "Could not online cpu $CPU_TO_TEST"
> -		exit_clean 1
> -	fi
> -fi
> +}
>  
>  # do_clean()
>  #
> @@ -72,12 +46,11 @@ do_clean()
>  	kill_pid ${WRL_ID}
>  
>  	# Turns off the cpus that were off before the test start
> -	tst_resm TINFO "Return to previous state. CPU count = ${CPU_COUNT}"
>  	until [ $CPU_COUNT -eq 0 ]; do
>  		offline_cpu=$(eval "echo \$OFFLINE_CPU_${CPU_COUNT}")
>  		tst_resm TINFO "CPU = $CPU_COUNT @on = $offline_cpu"
>  		offline_cpu $offline_cpu
> -		: $(( CPU_COUNT -= 1 ))
> +		CPU_COUNT=$((CPU_COUNT-1))
>  	done
>  }
>  
> @@ -95,7 +68,7 @@ do_offline()
>  	offline_cpu ${CPU}
>  	if [ $? -ne 0 ]; then
>  		if [ "$CPU" -ne 0 ]; then
> -			: $(( CPU_COUNT += 1 ))
> +			CPU_COUNT=$((CPU_COUNT+1))
>  			eval "OFFLINE_CPU_${CPU_COUNT}=$1"
>  		fi
>  		return 1
> @@ -122,12 +95,55 @@ do_online()
>  	fi
>  }
>  
> +while getopts c:l:n:f:e: OPTION; do
> +	case $OPTION in
> +	c)
> +		CPU_TO_TEST=$OPTARG;;
> +	l)
> +		HOTPLUG01_LOOPS=$OPTARG;;
> +	n)
> +		TM_ONLINE=$OPTARG;;
> +	f)
> +		TM_OFFLINE=$OPTARG;;
> +	e)
> +		TM_DLY=$OPTARG;;
> +	?)
> +		usage;;
> +	esac
> +done
> +
> +LOOP_COUNT=1
> +
> +tst_check_cmds perl
> +
> +if ! get_all_cpus >/dev/null 2>&1; then
> +	tst_brkm TCONF "system doesn't have required CPU hotplug support"
> +fi
> +
> +if [ -z "${CPU_TO_TEST}" ]; then
> +	tst_brkm TBROK "usage: ${0##*/} <CPU to online>"
> +fi
> +
> +# Validate the specified CPU exists
> +if ! cpu_is_valid "${CPU_TO_TEST}" ; then
> +	tst_brkm TBROK "cpu${CPU_TO_TEST} not found"
> +fi
> +
> +if ! cpu_is_online "${CPU_TO_TEST}" ; then
> +	if ! online_cpu ${CPU_TO_TEST} ; then
> +		tst_brkm TBROK "Could not online cpu $CPU_TO_TEST"
> +	fi
> +fi
> +
> +TST_CLEANUP=do_clean
> +
> +CPU_COUNT=0
> +
>  # Start up a process that writes to disk; keep track of its PID
> -$LHCS_PATH/tools/do_disk_write_loop > /dev/null 2>&1 &
> +./cpu_hotplug/tools/do_disk_write_loop > /dev/null 2>&1 &

The ./ here is problematic too. It expects that the CWD for the test is
$LTPROOT/testcases/bin/ which is only true if test does not create the
test temporary directory. This will break for no apparent reason if
somebody adds tst_tmpdir() to the test setup.

The best soulution would be renaming the tools to start with
'cpuhotplug_' and installing them to testcases/bin/ directory so that
the could be executed without the leading path.

>  WRL_ID=$!
>  
> -RC=0
> -until [ $TST_COUNT -gt $TST_TOTAL -o $RC -ne 0 ]
> +until [ $LOOP_COUNT -gt $HOTPLUG01_LOOPS ]
>  do
>  
>  	tst_resm TINFO "Starting loop"
> @@ -141,16 +157,13 @@ do
>  		do_offline $cpu
>  		err=$?
>  		if [ $err -ne 0 ]; then
> -			tst_resm TBROK "offlining $cpu failed: $err"
> -			RC=2
> +			tst_brkm TBROK "offlining $cpu failed: $err"
>  		else
>  			tst_resm TINFO "offlining $cpu was ok"
>  		fi
>  		sleep $TM_OFFLINE
>  	done
>  
> -	#IRQ_MID=`cat /proc/interrupts`
> -
>  	# Attempt to online all CPUs
>  	for cpu in $( get_all_cpus ); do
>  		if [ "$cpu" = "cpu0" ]; then
> @@ -159,8 +172,7 @@ do
>  		do_online $cpu
>  		err=$?
>  		if [ $err -ne 0 ]; then
> -			tst_resm TBROK "onlining $cpu failed: $err"
> -			RC=2
> +			tst_brkm TBROK "onlining $cpu failed: $err"
>  		else
>  			tst_resm TINFO "onlining $cpu was ok"
>  		fi
> @@ -172,20 +184,14 @@ do
>  	# Print out a report showing the changes in IRQs
>  	echo
>  	echo
> -	$LHCS_PATH/tools/report_proc_interrupts "$IRQ_START" "$IRQ_END"
> +	./cpu_hotplug/tools/report_proc_interrupts "$IRQ_START" "$IRQ_END"

Here as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
