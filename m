Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YKpUv-0000tv-K7
	for ltp-list@lists.sourceforge.net; Mon, 09 Feb 2015 14:39:37 +0000
Date: Mon, 9 Feb 2015 15:39:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150209143918.GE7605@rei.suse.de>
References: <1423212090-24164-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1423212090-24164-5-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1423212090-24164-5-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 5/6] power_management: cleanup
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
> * Fix error of change_govr.sh, change_freq.sh, etc.

What error?

Can you please send fixes and cleanups as separate patches?

> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
> index b1867e6..70ea4d2 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -30,7 +30,8 @@ get_topology() {
>  	for cpu in $(seq 0 "${total_cpus}" )
>  	do
>  		cpus[$cpu]=cpu${cpu}
> -		phyid[$cpu]=$(cat /sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
> +		phyid[$cpu]=$(cat \
> +		/sys/devices/system/cpu/cpu${cpu}/topology/physical_package_id)
>  	done
>  	j=0
>  	while [ "${j}" -lt "${total_cpus}" ]
> @@ -50,18 +51,22 @@ check_cpufreq() {
>  	for cpu in $(seq 0 "${total_cpus}" )
>  	do
>  		if [ ! -d /sys/devices/system/cpu/cpu${cpu}/cpufreq ] ; then
> -			echo "NOSUPPORT: cpufreq support not found please check Kernel configuration or BIOS settings"
> +			echo "NOSUPPORT: cpufreq support not" \
> +				"found please check Kernel configuration" \
> +				"or BIOS settings"
>  			exit $NOSUPPORT

Why not just: tst_brkm TCONF "cpufreq does not found" ?

>  		fi
>  	done
>  }
>  
>  get_supporting_freq() {
> -	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies | uniq
> +	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_frequencies \
> +		| uniq
>  }
>  
>  get_supporting_govr() {
> -	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors | uniq
> +	cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_available_governors \
> +		| uniq
>  }
>  
>  is_hyper_threaded() {
> @@ -102,7 +107,9 @@ check_input() {
>  }
>  
>  is_multi_socket() {
> -	no_of_sockets=`cat /sys/devices/system/cpu/cpu?/topology/physical_package_id | uniq | wc -l`
> +	no_of_sockets=`cat \
> +		/sys/devices/system/cpu/cpu?/topology/physical_package_id \
> +		| uniq | wc -l`
>  	[ $no_of_sockets -gt 1 ] ; return $?
>  }
>  
> @@ -119,7 +126,8 @@ is_multi_core() {
>  
>  is_dual_core() {
>  	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> +        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq \
> +			| cut -f2 -d':'`
>          if [ $siblings -eq $cpu_cores ]; then
>                  [ $cpu_cores -eq 2 ]; return $?
>          else
> @@ -130,7 +138,8 @@ is_dual_core() {
>  
>  get_kernel_version() {
>  	# Get kernel minor version
> -	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' | cut -f1 -d'-'`
> +	export kernel_version=`uname -r | awk -F. '{print $1"."$2"."$3}' \
> +		| cut -f1 -d'-'`
>  }
>  
>  get_valid_input() {
> @@ -146,42 +155,46 @@ analyze_result_hyperthreaded() {
>  	sched_mc=$1
>      pass_count=$2
>      sched_smt=$3
> +	PASS="Test PASS"
> +	FAIL="Test FAIL"
>  
> +	RC=0
>  	case "$sched_mc" in
>  	0)
>  		case "$sched_smt" in
>  		0)
>  			if [ $pass_count -lt 5 ]; then
> -				tst_resm TPASS "cpu consolidation failed for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +				echo "${PASS}: cpu consolidation failed for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>  			else
>  				RC=1
> -				tst_resm TFAIL "cpu consolidation passed for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +				echo "${FAIL}: cpu consolidation passed for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
>  			fi
>  			;;
>  		*)
>  			if [ $pass_count -lt 5 ]; then
> -               	tst_resm TFAIL "cpu consolidation for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> -           	else
>  				RC=1
> -				tst_resm TPASS "cpu consolidation for sched_mc=\
> -$sched_mc & sched_smt=$sched_smt"
> +				echo "${FAIL}: cpu consolidation for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"
> +			else
> +				echo "${PASS}: cpu consolidation for" \
> +					"sched_mc=$sched_mc & sched_smt=$sched_smt"

I do not get how removing tst_resm and changing it to echo satisfies
"Use functions in test.sh, eg. tst_brkm" from the commit log.

> +++ b/testcases/kernel/power_management/runpwtests01.sh
> @@ -0,0 +1,50 @@
> +#! /bin/sh
> +#
> +# Copyright (c) International Business Machines  Corp., 2001
> +# Author: Nageswara R Sastry <nasastry@in.ibm.com>
> +#
> +# This program is free software;  you can redistribute it and#or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful, but
> +# WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
> +# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
> +# for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program;  if not, write to the Free Software Foundation,
> +# Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> +#
> +
> +export TCID="Power_Management01"
> +export TST_TOTAL=1
> +
> +. test.sh
> +. pm_check_env.sh
> +. pm_include.sh
> +
> +# Checking test environment
> +check_env
> +
> +# Checking sched_mc sysfs interface
> +is_multi_socket; multi_socket=$?
> +is_multi_core; multi_core=$?

this syntax is quite strange, what do we rather do

multi_core = $(is_multi_core)

and echo the result from the is_multi_core instead of using return.

Or even better initialize these in the sourced file automatically.

> +if [ ! -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> +	tst_brkm TCONF "Required kernel configuration for SCHED_MC" \
> +		"NOT set"
> +else
> +	if [ $multi_socket -ne 0 -a $multi_core -ne 0 ] ; then
> +		tst_brkm TCONF "sched_mc_power_savings interface in system" \
> +			"which is not a multi socket &(/) multi core"
> +	fi
> +fi
> +
> +if test_sched_mc.sh ; then

This file is called only from this test. Why isn't the code here
instead?

What about making the test_sched_mc.sh the testcase instead?

You should keep only code that is actually shared between the testcases
in separate file.

The same applies to the rest of the testcases as well.

> +	tst_resm TPASS "SCHED_MC sysfs tests"
> +else
> +	tst_resm TFAIL "SCHED_MC sysfs tests"
> +fi
> +
> +tst_exit

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
