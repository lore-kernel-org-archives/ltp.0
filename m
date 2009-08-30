Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MhoKv-0001Vi-BM
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:37:05 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MhoKq-0001rp-Jm
	for ltp-list@lists.sourceforge.net; Sun, 30 Aug 2009 17:37:05 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7UHUKpp007262
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:30:20 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7UHatHA225792
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:36:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7UHasQW027542
	for <ltp-list@lists.sourceforge.net>; Sun, 30 Aug 2009 13:36:54 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090828101449.12177.9632.sendpatchset@localhost.localdomain>
References: <20090828101440.12177.32012.sendpatchset@localhost.localdomain>
	<20090828101449.12177.9632.sendpatchset@localhost.localdomain>
Date: Sun, 30 Aug 2009 23:06:34 +0530
Message-Id: <1251653796.12120.20.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 2/8] Power management master script modified
	to	integrate ILB testcase
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
To: Poornima Nayak <mpnayak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, ego@in.ibm.com, arun@linux.vnet.ibm.com

On Fri, 2009-08-28 at 15:44 +0530, Poornima Nayak wrote: 
> Power management master script modified to integrate ILB testcases
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Ok.

Regards--
Subrata

> 
> diff -uprN ltp_orig/testcases/kernel/power_management/runpwtests.sh ltp/testcases/kernel/power_management/runpwtests.sh
> --- ltp_orig/testcases/kernel/power_management/runpwtests.sh	2009-08-28 10:54:59.000000000 +0530
> +++ ltp/testcases/kernel/power_management/runpwtests.sh	2009-08-28 12:29:52.000000000 +0530
> @@ -69,7 +69,7 @@ is_dual_core; dual_core=$?
>  #Checking sched_mc sysfs interface
>  #check_config.sh config_sched_mc || RC=$?
>  TST_COUNT=1
> -if [ $multi_socket -eq $YES -a $dual_core -eq $YES ] ; then
> +if [ $multi_socket -eq $YES -a $multi_core -eq $YES ] ; then
>  	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
>  		if test_sched_mc.sh ; then
>  			tst_resm TPASS "SCHED_MC sysfs tests"
> @@ -232,7 +232,7 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
>  			if [ $hyper_threaded -eq $YES ]; then
>  				for sched_smt in `seq 0 $max_sched_smt`; do
>  					for work_load in ${work_loads_list}; do
> -                   		: $(( TST_COUNT += 1 ))
> +                   				: $(( TST_COUNT += 1 ))
>  						sched_mc_smt_pass_cnt=0
>  						for repeat_test in `seq 1  10`; do
>  							# Testcase to validate CPU consolidation for
> @@ -260,6 +260,60 @@ if [ $# -gt 0 -a "$1" = "-exclusive" ]; 
>  		done
>  		analyze_core_consolidation_result $sched_smt $work_load $sched_smt_pass_cnt
>  	fi
> +        # Verify ILB runs in same package as workload
> +        if [ $multi_socket -eq $YES -a $multi_core -eq $YES ]; then
> +		work_loads_list="ebizzy kernbench"	
> +		for sched_mc in `seq 0 $max_sched_mc`; do
> +			for work_load in ${work_loads_list}
> +			do
> +				: $(( TST_COUNT += 1 ))
> +                                ilb_test.py -c $sched_mc -w $work_load; RC=$?
> +				if [ $RC -eq 0 ]; then
> +					tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
> +				else
> +					if [ $sched_mc -eq 0 ]; then
> +						tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
> +					else
> +						tst_resm TFAIL "ILB did not run in same package"
> +					fi
> +				fi
> +			done
> +			if [ $hyper_threaded -eq $YES ]; then
> +				for sched_smt in `seq 0 $max_sched_smt`; do
> +					for work_load in ${work_loads_list}; do
> +						: $(( TST_COUNT += 1 ))
> +						ilb_test.py -c $sched_mc -t sched_smt -w $work_load; RC=$?
> + 						if [ $RC -eq 0 ]; then
> +							tst_resm TPASS "ILB & workload in same package for sched_mc=$sched_mc"
> +						else
> +							if [ $sched_mc -eq 0 ]; then
> +								tst_resm TPASS "ILB & workload is not in same package when sched_mc=0"
> +							else
> +								tst_resm TFAIL "ILB did not run in same package"    
> +							fi
> +						fi
> +					done
> +				done
> +			fi
> +		done
> +	fi
> +	if [ $multi_socket -eq $YES -a $hyper_threaded -eq $YES -a $multi_core -eq $YES ]; then
> +		for sched_smt in `seq 0 $max_sched_smt`; do
> +			for work_load in ${work_loads_list}; do
> +				: $(( TST_COUNT += 1 ))
> +				ilb_test.py -t $sched_smt -w $work_load; RC=$?
> +				if [ $RC -eq 0 ]; then
> +					tst_resm TPASS "ILB & workload not load not in same package for sched_smt=$sched_smt"
> +				else
> +					if [ $sched_smt -eq 0 ]; then
> +						tst_resm TPASS "Its oky if ILB is not in same package when sched_smt=0"
> +					else
> +						tst_resm TFAIL "ILB did not run in same package"
> +					fi
> +				fi
> +			done
> +		done
> +	fi
>  fi
> 
>  exit $RC
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
