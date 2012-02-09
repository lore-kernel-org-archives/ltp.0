Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RvTXT-00041M-Ke
	for ltp-list@lists.sourceforge.net; Thu, 09 Feb 2012 12:55:51 +0000
Date: Thu, 9 Feb 2012 14:09:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120209130945.GA27782@saboteur.suse.cz>
References: <1A42CE6F5F474C41B63392A5F80372B212E02C95C4@shsmsx501.ccr.corp.intel.com>
	<CAGH67wTKz+VPzN_-+7uKfeBguhuKZK_mj-m8oy2kY6pyKNihzw@mail.gmail.com>
	<1A42CE6F5F474C41B63392A5F80372B212E050913C@shsmsx501.ccr.corp.intel.com>
	<20120125183628.GD8067@saboteur.suse.cz>
	<D908B1B9E708C047A32444772B58AE880414C8@SHSMSX101.ccr.corp.intel.com>
	<CAGH67wSw9nGvHOg_Ywp5p0CsjJgycpF1NNfXiG38pFyLyNSQTw@mail.gmail.com>
	<D908B1B9E708C047A32444772B58AE88041512@SHSMSX101.ccr.corp.intel.com>
	<20120201152611.GA29203@saboteur.suse.cz>
	<D908B1B9E708C047A32444772B58AE88043030@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D908B1B9E708C047A32444772B58AE88043030@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [LTP] [Ltp-commits] [patch] Power Management: add notification
 once 'sched_debug' not in boot cmdline
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
To: "Xu, Anhua" <anhua.xu@intel.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> commit bb43a35ce70ad638f72ae7dcd8c198ca95dac43f
> Author: Xu,Anhua <anhua.xu@intel.com>
> Date:   Wed Feb 8 11:04:33 2012 +0800
> 
>     Power Management: fix configuration check for sched_domain.py
>     
>     Add checking for "sched_debug" in kernel cmdline parameter.
>     Without this option, power policy change via sched_mc/smt_power_savings
>     will not cause any output from dmesg that is needed for sched_domain.py

The signed-off-by line is missing here. Could you please resend with it.

> diff --git a/testcases/kernel/power_management/runpwtests.sh b/testcases/kernel/power_management/runpwtests.sh
> index c4a1d39..ab4536f 100755
> --- a/testcases/kernel/power_management/runpwtests.sh
> +++ b/testcases/kernel/power_management/runpwtests.sh
> @@ -188,8 +188,11 @@ fi
>  
>  # sched_domain test
>  if ! type python > /dev/null ; then
> -	tst_resm TCONF "Python is not installed, CPU Consoldation\
> +	tst_resm TCONF "Python is not installed, CPU Consolidation\
>  test cannot run"
> +elif ! grep sched_debug -qw /proc/cmdline ; then
> +	tst_resm TCONF "Kernel cmdline parameter 'sched_debug' needed,\
> +CPU Consolidation test cannot run" 
>  else
>  	if [ -f /sys/devices/system/cpu/sched_mc_power_savings ] ; then
>      		echo "max sched mc $max_sched_mc"
> 

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
