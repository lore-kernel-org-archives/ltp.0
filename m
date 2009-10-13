Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxeNk-0000dW-Ua
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:13:28 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxeNe-0003g6-UR
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 10:13:28 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DABC7F004524
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:11:12 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DADDH4161452
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:13:13 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DADCQ9000618
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 04:13:13 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
References: <20091013074337.22414.20968.sendpatchset@localhost.localdomain>
Date: Tue, 13 Oct 2009 15:42:46 +0530
Message-Id: <1255428766.8438.15.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 1/6] Fix issues in cpu consolidation
	verification	functions
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
Cc: ltp-list@lists.sourceforge.net, arun@linux.vnet.ibm.com, svaidy@linux.vnet.ibm.com, ego@in.ibm.com

On Tue, 2009-10-13 at 13:13 +0530, Poornima Nayak wrote: 
> Arguments passed for cpu consolidation was not used appropriatly. Provided
> TINFO messages to indicate dependency test failures.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks.

Regards--
Subrata

> 
> diff -uprN ltp-full-20090930/testcases/kernel/power_management/pm_include.sh ltp-full-20090930_patched/testcases/kernel/power_management/pm_include.sh
> --- ltp-full-20090930/testcases/kernel/power_management/pm_include.sh	2009-10-05 02:10:56.000000000 -0400
> +++ ltp-full-20090930_patched/testcases/kernel/power_management/pm_include.sh	2009-10-12 22:46:12.000000000 -0400
> @@ -71,7 +71,7 @@ get_supporting_govr() {
>  is_hyper_threaded() {
>  	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
>  	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> -	[ $siblings > $cpu_cores ]; return $?
> +	[ $siblings -gt $cpu_cores ]; return $?
>  }
> 
>  check_input() {
> @@ -148,8 +148,8 @@ get_valid_input() {
>  		
>  analyze_result_hyperthreaded() {
>  	sched_mc=$1
> -    pass_count=$3
> -    sched_smt=$4
> +    pass_count=$2
> +    sched_smt=$3
> 
>  	case "$sched_mc" in
>  	0)
> @@ -165,7 +165,7 @@ $sched_mc & sched_smt=$sched_smt"
>  			fi
>  			;;
>  		*)
> -           	if [ $pass_count -lt 5 ]; then
> +			if [ $pass_count -lt 5 ]; then
>                 	tst_resm TFAIL "cpu consolidation for sched_mc=\
>  $sched_mc & sched_smt=$sched_smt"
>             	else
> @@ -190,10 +190,16 @@ $sched_mc & sched_smt=$sched_smt"
> 
>  analyze_package_consolidation_result() {
>  	sched_mc=$1
> -    pass_count=$3
> -	sched_smt=$4
> +    pass_count=$2
> +
> +	if [ $# -gt 2 ]
> +	then
> +		sched_smt=$3
> +	else
> +		sched_smt=-1
> +	fi
> 
> -	if [ $hyper_threaded -eq $YES -a $sched_smt ]; then
> +	if [ $hyper_threaded -eq $YES -a $sched_smt -gt -1 ]; then
>  		analyze_result_hyperthreaded $sched_mc $pass_count $sched_smt
>  	else
>  		case "$sched_mc" in
> @@ -209,10 +215,10 @@ $sched_mc"
>      	*)
>  			if [ $pass_count -lt 5 ]; then
>  				tst_resm TFAIL "Consolidation at package level failed for \
> -sched_mc=$sched_mc & sched_smt=$sched_smt"
> +sched_mc=$sched_mc"
>  			else
>  				tst_resm TPASS "Consolidation at package level passed for \
> -sched_mc=$sched_mc & sched_smt=$sched_smt"
> +sched_mc=$sched_mc"
>  			fi	
>          	;;
>      	esac
> @@ -221,7 +227,7 @@ sched_mc=$sched_mc & sched_smt=$sched_sm
> 
>  analyze_core_consolidation_result() {
>  	sched_smt=$1
> -	pass_count=$3
> +	pass_count=$2
> 
>  	case "$sched_smt" in
>  	0)
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
