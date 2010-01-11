Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ego@linux.vnet.ibm.com>) id 1NUBr9-0003Vp-CU
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 04:26:19 +0000
Received: from e28smtp01.in.ibm.com ([122.248.162.1])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NUBr6-0006R8-MN
	for ltp-list@lists.sourceforge.net; Mon, 11 Jan 2010 04:26:19 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp01.in.ibm.com (8.14.3/8.13.1) with ESMTP id o0B4Pvcq001869
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 09:55:57 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o0B4Pv5p3547174
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 09:55:57 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o0B4PuD8020200
	for <ltp-list@lists.sourceforge.net>; Mon, 11 Jan 2010 15:25:56 +1100
Date: Mon, 11 Jan 2010 09:55:56 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
Message-ID: <20100111042556.GA1428@in.ibm.com>
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
	<20091224181542.12571.16299.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20091224181542.12571.16299.sendpatchset@localhost.localdomain>
Subject: Re: [LTP] [Patch 2/4]Reusable functions modified to learn topology
	from	sysfs
Reply-To: ego@in.ibm.com
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
Cc: ltp-list@lists.sourceforge.net, svaidy@linux.vnet.ibm.com, arun@linux.vnet.ibm.com

On Thu, Dec 24, 2009 at 11:45:42PM +0530, Poornima Nayak wrote:
> Patch to learn topology of system through sysfs.
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
> 
> diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/power_management/pm_include.sh ltp-intermediate-20091209.fixes/testcases/kernel/power_management/pm_include.sh
> --- ltp-intermediate-20091209.orig/testcases/kernel/power_management/pm_include.sh	2009-12-09 13:18:25.000000000 +0530
> +++ ltp-intermediate-20091209.fixes/testcases/kernel/power_management/pm_include.sh	2009-12-24 23:17:37.798995821 +0530
> @@ -69,9 +69,24 @@ get_supporting_govr() {
>  }
> 
>  is_hyper_threaded() {
> -	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> -	[ $siblings -gt $cpu_cores ]; return $?
> +	entries=`cat /sys/devices/system/cpu/cpu0/topology/thread_siblings`
> +	count=`echo $entries | awk -F"," '{ print NF }'`
> +	cpucount=0
> +	for ((i=1;i<=$count;i++))
> +	do
> +        
> +    	cpumask=`echo $entries | awk -v x=$i 'BEGIN{FS=","} {print $x}'`
> +		while [ $cpumask -gt 0 ]
> +		do
> +			((cpucount=cpucount+1))
> +			((cpumask=$cpumask>>1))
> +		done
> +	done
> +	if [ $cpucount -gt 1 ]; then
> +		return 0
> +	else
> +		return 1
> +	fi
>  }
> 
>  check_input() {
> @@ -110,26 +125,38 @@ is_multi_socket() {
>  	[ $no_of_sockets -gt 1 ] ; return $?
>  }
> 
> +get_core_sibling_count() {
> +	entries=`cat /sys/devices/system/cpu/cpu0/topology/core_siblings`
> +	count=`echo $entries | awk -F"," '{ print NF }'`
> +	cpucount=0
> +	for ((i=1;i<=$count;i++))
> +	do
> +		cpumask=`echo $entries | awk -v x=$i 'BEGIN{FS=","} {print $x}'`
> +		while [ $cpumask -gt 0 ]
> +		do
> +			((cpucount=cpucount+1))
> +			((cpumask=$cpumask>>1))
> +		done
> +	done
> +	echo $cpucount
> +}

I find code duplication here.

Cant we have, 
get_entity_count() {
	ENTITY=$1
	entries=`cat /sys/devices/system/cpu/cpu0/topology/$ENTITY_SIBLINGS`
	.
	.
	.
	.
	.
	echo $cpucount
}

get_core_siblings_count() {
	get_entity_count "core"
}

get_thread_siblings_count() {
	get_entity_count "thread"
}

is_hyperthreaded() {
	nr_threads = get_thread_siblings_count()
	if [$nr_threads -gt 1 ]; then
		return 0
	else
		return 1
	fi
}

and so on ?

}
> +
>  is_multi_core() {
> -	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -	cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> -	if [ $siblings -eq $cpu_cores ]; then
> -		[ $cpu_cores -gt 1 ]; return $?
> -	else
> -		: $(( num_of_cpus = siblings / cpu_cores ))
> -		[ $num_of_cpus -gt 1 ]; return $?
> +	sibling_cnt=$(get_core_sibling_count)
> +    if [ $sibling_cnt -gt 1 ]; then
> +		return 0
> +    else
> +		return 1
>  	fi
>  }		
> 
>  is_dual_core() {
> -	siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 -d':'`
> -        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut -f2 -d':'`
> -        if [ $siblings -eq $cpu_cores ]; then
> -                [ $cpu_cores -eq 2 ]; return $?
> -        else
> -                : $(( num_of_cpus = siblings / cpu_cores ))
> -                [ $num_of_cpus -eq 2 ]; return $?
> -        fi
> +	sibling_cnt=$(get_core_sibling_count)
> +	if [ $sibling_cnt -eq 2 ]; then
> +		return 0
> +	else
> +		return 1
> +	fi
>  }
> 
>  get_kernel_version() {

-- 
Thanks and Regards
gautham

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
