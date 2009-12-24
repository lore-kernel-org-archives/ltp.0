Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NNu2L-0003ZB-GK
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 20:11:53 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NNu2G-0001Ni-9c
	for ltp-list@lists.sourceforge.net; Thu, 24 Dec 2009 20:11:53 +0000
Received: by pxi27 with SMTP id 27so4118235pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Dec 2009 12:11:42 -0800 (PST)
References: <20091224181532.12571.74576.sendpatchset@localhost.localdomain>
	<20091224181542.12571.16299.sendpatchset@localhost.localdomain>
Message-Id: <EE5C243C-700D-4870-AF51-B7CA6899C503@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20091224181542.12571.16299.sendpatchset@localhost.localdomain>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Thu, 24 Dec 2009 12:11:05 -0800
Subject: Re: [LTP] [Patch 2/4]Reusable functions modified to learn topology
	from sysfs
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, "svaidy@linux.vnet.ibm.com" <svaidy@linux.vnet.ibm.com>, "ego@in.ibm.com" <ego@in.ibm.com>, "arun@linux.vnet.ibm.com" <arun@linux.vnet.ibm.com>

On Dec 24, 2009, at 10:15 AM, Poornima Nayak  
<mpnayak@linux.vnet.ibm.com> wrote:

> Patch to learn topology of system through sysfs.
>
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>
>
> diff -uprN ltp-intermediate-20091209.orig/testcases/kernel/ 
> power_management/pm_include.sh ltp-intermediate-20091209.fixes/ 
> testcases/kernel/power_management/pm_include.sh
> --- ltp-intermediate-20091209.orig/testcases/kernel/power_management/ 
> pm_include.sh    2009-12-09 13:18:25.000000000 +0530
> +++ ltp-intermediate-20091209.fixes/testcases/kernel/ 
> power_management/pm_include.sh    2009-12-24 23:17:37.798995821 +0530
> @@ -69,9 +69,24 @@ get_supporting_govr() {
> }
>
> is_hyper_threaded() {
> -    siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 - 
> d':'`
> -    cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut - 
> f2 -d':'`
> -    [ $siblings -gt $cpu_cores ]; return $?
> +    entries=`cat /sys/devices/system/cpu/cpu0/topology/ 
> thread_siblings`
> +    count=`echo $entries | awk -F"," '{ print NF }'`

Why have an intermediate variable labeled entries if all you do is  
echo the value back out and run it through awk unquoted? You could  
just as easily do this instead:

awk [options] [script-body] /sys/devices/system/cpu/cpu0/topology/ 
thread_siblings

> +    cpucount=0
> +    for ((i=1;i<=$count;i++))
> +    do
> +
> +        cpumask=`echo $entries | awk -v x=$i 'BEGIN{FS=","} {print  
> $x}'`
> +        while [ $cpumask -gt 0 ]
> +        do
> +            ((cpucount=cpucount+1))
> +            ((cpumask=$cpumask>>1))
> +        done
> +    done
> +    if [ $cpucount -gt 1 ]; then
> +        return 0
> +    else
> +        return 1
> +    fi
> }
>
> check_input() {
> @@ -110,26 +125,38 @@ is_multi_socket() {
>    [ $no_of_sockets -gt 1 ] ; return $?
> }
>
> +get_core_sibling_count() {
> +    entries=`cat /sys/devices/system/cpu/cpu0/topology/core_siblings`
> +    count=`echo $entries | awk -F"," '{ print NF }'`
> +    cpucount=0
> +    for ((i=1;i<=$count;i++))
> +    do
> +        cpumask=`echo $entries | awk -v x=$i 'BEGIN{FS=","} {print  
> $x}'`
> +        while [ $cpumask -gt 0 ]
> +        do
> +            ((cpucount=cpucount+1))
> +            ((cpumask=$cpumask>>1))
> +        done
> +    done
> +    echo $cpucount
> +}
> +
> is_multi_core() {
> -    siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 - 
> d':'`
> -    cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | cut - 
> f2 -d':'`
> -    if [ $siblings -eq $cpu_cores ]; then
> -        [ $cpu_cores -gt 1 ]; return $?
> -    else
> -        : $(( num_of_cpus = siblings / cpu_cores ))
> -        [ $num_of_cpus -gt 1 ]; return $?
> +    sibling_cnt=$(get_core_sibling_count)
> +    if [ $sibling_cnt -gt 1 ]; then
> +        return 0
> +    else
> +        return 1
>    fi
> }
>
> is_dual_core() {
> -    siblings=`cat /proc/cpuinfo | grep siblings | uniq | cut -f2 - 
> d':'`
> -        cpu_cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq |  
> cut -f2 -d':'`
> -        if [ $siblings -eq $cpu_cores ]; then
> -                [ $cpu_cores -eq 2 ]; return $?
> -        else
> -                : $(( num_of_cpus = siblings / cpu_cores ))
> -                [ $num_of_cpus -eq 2 ]; return $?
> -        fi
> +    sibling_cnt=$(get_core_sibling_count)
> +    if [ $sibling_cnt -eq 2 ]; then
> +        return 0
> +    else
> +        return 1
> +    fi
> }
>
> get_kernel_version() {

Thanks,
-Garrett

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
