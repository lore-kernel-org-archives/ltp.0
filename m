Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N3Zn0-0001ol-Td
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:32:02 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N3Zmw-0000Yy-1v
	for ltp-list@lists.sourceforge.net; Thu, 29 Oct 2009 18:32:02 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e3.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9TINhHV022700
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 14:23:43 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9TIVqU6099786
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 14:31:52 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9TIVqFJ031477
	for <ltp-list@lists.sourceforge.net>; Thu, 29 Oct 2009 14:31:52 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20091028093757.19484.89637.sendpatchset@localhost.localdomain>
References: <20091028093749.19484.92103.sendpatchset@localhost.localdomain>
	<20091028093757.19484.89637.sendpatchset@localhost.localdomain>
Date: Fri, 30 Oct 2009 00:01:47 +0530
Message-Id: <1256841108.5210.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Patch 2/2] to delete hardcoded cpu freq governers
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
> Patch to remove hard coded cpu governers
> 
> Signed-off-by: poornima nayak <mpnayak@linux.vnet.ibm.com>

Thanks. Applied.

Regards--
Subrata

> 
> diff -uprN ltp/testcases/kernel/power_management/pwkm_load_unload.sh ltp_fixed/testcases/kernel/power_management/pwkm_load_unload.sh
> --- ltp/testcases/kernel/power_management/pwkm_load_unload.sh	2009-03-25 02:19:22.000000000 -0400
> +++ ltp_fixed/testcases/kernel/power_management/pwkm_load_unload.sh	2009-10-28 00:54:39.000000000 -0400
> @@ -3,7 +3,7 @@
>  #Loading modules
>  RC=0
>  loaded_governor=`cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor`
> -for module in cpufreq_conservative cpufreq_powersave cpufreq_userspace
> +for module in `modprobe -l | grep cpufreq_ | cut -f8 -d"/" | cut -f1 -d"."`
>  do
>  	#echo -n "Loading $module ... "
>      if [ $module != "cpufreq_$loaded_governor" ];
> @@ -15,7 +15,7 @@ do
>  		fi
>  	fi
>  done
> -for module in cpufreq_conservative cpufreq_powersave cpufreq_userspace
> +for module in `modprobe -l | grep cpufreq_ | cut -f8 -d"/" | cut -f1 -d"."`
>  do
>  	#echo -n "Unloading $module ... "
>      if [ $module != "cpufreq_$loaded_governor" ];
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
