Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1ME61g-0001XT-4L
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:24 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1ME61b-0007gc-12
	for ltp-list@lists.sourceforge.net; Tue, 09 Jun 2009 18:26:23 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e9.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n59IDuIV013010
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:13:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n59IQIwL251618
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:26:18 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n59IQITV011915
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Jun 2009 14:26:18 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906081339.54153.jpalecek@web.de>
References: <200906081339.54153.jpalecek@web.de>
Date: Tue, 09 Jun 2009 23:55:24 +0530
Message-Id: <1244571925.5497.27.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix the error handling logic in
	power_management	tests
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

On Mon, 2009-06-08 at 13:39 +0200, Jiri Palecek wrote: 
> Hello,
> 
> there is a problem with error reporting in power_management tests. Particularly, it wouldn't report failure to pan when one of the tests failed. This patch does the following:
> 
>   - make it actually fail when one of the tests fails
> 
>   - assume return values other than 1 (except 0, of course) are
>     errors, too
> 
>   - write PASS messages for successful tests
> 
> Regards
>     Jiri Palecek
> 
> Signed-off-by: Jiri Palecek <jpalecek@web.de>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/power_management/pm_include.sh |    1 +
>  testcases/kernel/power_management/runpwtests.sh |   84 ++++++++++++++---------
>  2 files changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/testcases/kernel/power_management/pm_include.sh b/testcases/kernel/power_management/pm_include.sh
> index 389387c..acbd476 100755
> --- a/testcases/kernel/power_management/pm_include.sh
> +++ b/testcases/kernel/power_management/pm_include.sh
> @@ -81,6 +81,7 @@ function check_input() {
>  		PASS="Testcase PASS"
>  		FAIL="Testcase FAIL"
>  	fi
> +	RC=0
>  	for input in ${1}
>  	do
>  		echo ${input} > ${test_file} 2>/dev/null
> diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
> index 32fb59c..e9be303 100755
> --- a/testcases/kernel/power_management/runpwtests.sh
> +++ b/testcases/kernel/power_management/runpwtests.sh
> @@ -60,8 +60,10 @@ fi
>  # Checking sched_mc sysfs interface
>  #check_config.sh config_sched_mc || RC=$?
>  if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> -	test_sched_mc.sh; RC=$?
> -	if [ $RC -eq 1 ] ; then
> +	if test_sched_mc.sh ; then
> +		tst_resm TPASS "SCHED_MC sysfs tests passed"
> +	else
> +		RC=$?
>  		tst_resm TFAIL "SCHED_MC sysfs tests failed"
>  	fi
>  	# Test CPU consolidation for corresponding sched_mc
> @@ -78,26 +80,26 @@ if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
>  					if [ $sched_smt -eq 0 -a $sched_mc -eq 0 ]; then 
>  						continue
>  					fi
> -					cpu_consolidation.py -c $sched_mc -t $sched_smt; RC=$?
> -					if [ $RC -eq 1 ] ; then
> -						tst_resm TFAIL "cpu consolidation \
> - sched_mc=$sched_mc, sched_smt=$sched_smt"
> -					else
> +					if cpu_consolidation.py -c $sched_mc -t $sched_smt ; then
>  						tst_resm TPASS "cpu consolidation sched_mc=$sched_mc,\
>   sched_smt=$sched_smt"
> +					else
> +						RC=$?
> +						tst_resm TFAIL "cpu consolidation \
> + sched_mc=$sched_mc, sched_smt=$sched_smt"
>  					fi
>  				done
>  			done
>  		else
>  			# Test CPU consolidation for sched_mc=1 & 2
>  			for sched_mc in `seq 1 2`; do
> -				cpu_consolidation.py -c $sched_mc; RC=$?
> -				if [ $RC -eq 1 ] ; then
> -					tst_resm TFAIL "cpu consolidation test\
> - sched_mc_power set to $sched_mc"
> -				else
> +				if cpu_consolidation.py -c $sched_mc ; then
>  					tst_resm TPASS "cpu consolidation test for \
>  sched_mc_power set to $sched_mc"
> +				else
> +					RC=$?
> +					tst_resm TFAIL "cpu consolidation test\
> + sched_mc_power set to $sched_mc"
>  				fi
>  			done
>  		fi
> @@ -110,24 +112,24 @@ sched_mc_power set to $sched_mc"
>                          continue
>                      fi
> 
> -					sched_domain.py -c $sched_mc -t $sched_smt; RC=$?
> -					if [ $RC -eq 1 ] ; then
> -						tst_resm TFAIL "sched domain test sched_mc=$sched_mc,\
> -sched_smt=$sched_smt "
> -					else    
> +					if sched_domain.py -c $sched_mc -t $sched_smt; then
>  						tst_resm TPASS "sched domain test sched_mc=$sched_mc,\
>  sched_smt=$sched_smt "
> +					else
> +						RC=$?
> +						tst_resm TFAIL "sched domain test sched_mc=$sched_mc,\
> +sched_smt=$sched_smt "
>  					fi
>  				done
>  			done
>  		else
>  			# Validate CPU level sched domain topology validation
>  			for sched_mc in `seq 1 2`; do
> -				sched_domain.py -c $sched_mc; RC=$?
> -				if [ $RC -eq 1 ] ; then
> -					tst_resm TFAIL "sched domain test for sched_mc=$sched_mc "
> -				else
> +				if sched_domain.py -c $sched_mc ; then
>  					tst_resm TPASS "sched domain test for sched_mc=$sched_mc "
> +				else
> +					RC=$?
> +					tst_resm TFAIL "sched domain test for sched_mc=$sched_mc "
>  				fi
>  			done
>  			
> @@ -139,26 +141,35 @@ fi
>  # Checking cpufreq sysfs interface files
>  #check_config.sh config_cpu_freq || RC=$?
>  if [ -d /sys/devices/system/cpu/cpu0/cpufreq ] ; then
> -	check_cpufreq_sysfs_files.sh; RC=$?
> -	if [ $RC -eq 1 ] ; then
> +	if check_cpufreq_sysfs_files.sh ; then
> +		tst_resm TPASS "CPUFREQ sysfs tests "
> +	else
> +		RC=$?
>  		tst_resm TFAIL "CPUFREQ sysfs tests "
>  	fi
> 
>  	# Changing governors
> -	change_govr.sh; RC=$?
> -	if [ $RC -eq 1 ] ; then
> +	if change_govr.sh ; then
> +		tst_resm TPASS "Changing governors "
> +	else
> +		RC=$?
>  		tst_resm TFAIL "Changing governors "
>  	fi
> 
>  	# Changing frequencies
> -	change_freq.sh; RC=$?
> -	if [ $RC -eq 1 ] ; then
> +	if change_freq.sh ; then
> +		tst_resm TPASS "Changing frequncies "
> +	else
> +		RC=$?
>  		tst_resm TFAIL "Changing frequncies "
>  	fi
> 
>  	# Loading and Unloading governor related kernel modules
> -	pwkm_load_unload.sh; RC=$?
> -	if [ $RC -eq 1 ] ; then
> +	if pwkm_load_unload.sh ; then
> +		tst_resm TPASS "Loading and Unloading of governor kernel \
> +		modules got failed"
> +	else
> +		RC=$?
>  		tst_resm TFAIL "Loading and Unloading of governor kernel \
>  		modules got failed"
>  	fi
> @@ -167,23 +178,30 @@ else
>  fi
> 
>  # Checking cpuidle sysfs interface files
> -check_cpuidle_sysfs_files.sh; RC=$?
> -if [ $RC -eq 1 ] ; then
> +if check_cpuidle_sysfs_files.sh ; then
> +	tst_resm TPASS "CPUIDLE sysfs tests failed"
> +else
> +	RC=$?
>  	tst_resm TFAIL "CPUIDLE sysfs tests failed"
>  fi
> 
>  # Test sched_smt_power_savings interface on HT machines
>  if [ -f /sys/devices/system/cpu/sched_smt_power_savings ] ; then
> -	test_sched_smt.sh; RC=$?
> -	if [ $RC -eq 1 ] ; then
> +	if test_sched_smt.sh ; then
> +		tst_resm TPASS "SCHED_MC sysfs tests failed"
> +	else
> +		RC=$?
>  		tst_resm TFAIL "SCHED_MC sysfs tests failed"
>  	fi
>  else
>  	hyper_threaded=$(is_hyper_threaded)
>  	if [ $hyper_threaded -eq 1 ]; then
>  		tst_resm TFAIL "Required kernel configuration for SCHED_SMT NOT set"
> +		RC=1
>  	else
>  		tst_resm TCONF "Required Hyper Threading support in the\
>  system under test"
>  	fi
>  fi
> +
> +exit $RC
> \ No newline at end of file


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
