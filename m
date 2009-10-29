Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N3Zn4-0001p9-8a
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:32:06 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N3Zn1-0001yo-UQ
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:32:06 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9TIUKLS008036
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 14:30:20 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9TIVvht082720
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 14:31:58 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9TIVvv6012943
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 14:31:57 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091028093749.19484.92103.sendpatchset@localhost.localdomain>
References: <20091028093749.19484.92103.sendpatchset@localhost.localdomain>
Date: Fri, 30 Oct 2009 00:01:50 +0530
Message-Id: <1256841110.5210.24.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 1/2]Fix failures messages on multi
	socket	hyper	threaded system
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
Cc: ltp-list@lists.sourceforge.net

On Wed, 2009-10-28 at 15:07 +0530, Poornima Nayak wrote: 
> Patch to fix unwanted failure messages
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks. Applied.

Regards--
Subrata

> 
> diff -uprN ltp/testcases/kernel/power_management/runpwtests.sh ltp_fixed/testcases/kernel/power_management/runpwtests.sh
> --- ltp/testcases/kernel/power_management/runpwtests.sh	2009-10-13 06:03:40.000000000 -0400
> +++ ltp_fixed/testcases/kernel/power_management/runpwtests.sh	2009-10-28 00:57:23.000000000 -0400
> @@ -169,22 +169,24 @@ if [ $? -ne 0 ] ; then
>  	tst_resm TCONF "Python is not installed, CPU Consoldation\
>  test cannot run"
>  else
> -	get_sched_values sched_mc; max_sched_mc=$?
> -    echo "max sched mc $max_sched_mc"
> -	for sched_mc in `seq 0 $max_sched_mc`; do
> -		: $(( TST_COUNT+=1))
> -		sched_domain.py -c $sched_mc; RC=$?
> -		analyze_sched_domain_result $sched_mc $RC 
> -		if [ $hyper_threaded -eq $YES ]; then
> -			get_sched_values sched_smt; max_sched_smt=$?
> -			for sched_smt in `seq 0 $max_sched_smt`; do
> -				# Testcase to validate sched_domain tree
> -				: $(( TST_COUNT+=1))
> -				sched_domain.py -c $sched_mc -t $sched_smt; RC=$?
> -				analyze_sched_domain_result $sched_mc $RC $sched_smt ;
> -			done
> -		fi
> -	done
> +	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
> +		get_sched_values sched_mc; max_sched_mc=$?
> +    	echo "max sched mc $max_sched_mc"
> +		for sched_mc in `seq 0 $max_sched_mc`; do
> +			: $(( TST_COUNT+=1))
> +			sched_domain.py -c $sched_mc; RC=$?
> +			analyze_sched_domain_result $sched_mc $RC 
> +			if [ $hyper_threaded -eq $YES -a -f /sys/devices/system/cpu/sched_smt_power_savings ]; then
> +				get_sched_values sched_smt; max_sched_smt=$?
> +				for sched_smt in `seq 0 $max_sched_smt`; do
> +					# Testcase to validate sched_domain tree
> +					: $(( TST_COUNT+=1))
> +					sched_domain.py -c $sched_mc -t $sched_smt; RC=$?
> +					analyze_sched_domain_result $sched_mc $RC $sched_smt ;
> +				done
> +			fi
> +		done
> +	fi
>  fi
> 
>  : $(( TST_COUNT+=1))
> 
> ------------------------------------------------------------------------------
> Come build with us! The BlackBerry(R) Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay 
> ahead of the curve. Join us from November 9 - 12, 2009. Register now!
> http://p.sf.net/sfu/devconference
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
