Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MxicL-00074Y-UC
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:49 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxicF-0005TE-Kw
	for ltp-list@lists.sourceforge.net; Tue, 13 Oct 2009 14:44:49 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9DEbwoq006533
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:37:58 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9DEiFls019806
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n9DEiDe6013795
	for <ltp-list@lists.sourceforge.net>; Tue, 13 Oct 2009 08:44:15 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f40910061549k4684906eu8731521a226021c9@mail.gmail.com>
References: <364299f40910061549k4684906eu8731521a226021c9@mail.gmail.com>
Date: Tue, 13 Oct 2009 20:13:45 +0530
Message-Id: <1255445025.8438.68.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Issue 4] sched_mc_powersavings missing results in TPASS
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
To: "poornima.nayak" <poornima.nayak@in.ibm.com>, poornima nayak <mpnayak@linux.vnet.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Over to Poornima on this.

Regards--
Subrata

On Tue, 2009-10-06 at 15:49 -0700, Garrett Cooper wrote: 
> Hi,
>     I've noticed that if /sys/devices/system/cpu/sched_mc_powersavings
> is missing, the result is TPASS (even though it shouldn't be):
> 
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> Power_Management 8704  TPASS  :  sched domain test for sched_mc=67 &
> sched_smt=52
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> Power_Management 8705  TPASS  :  sched domain test for sched_mc=67 &
> sched_smt=53
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> Power_Management 8706  TPASS  :  sched domain test for sched_mc=67 &
> sched_smt=54
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> Power_Management 8707  TPASS  :  sched domain test for sched_mc=67 &
> sched_smt=55
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> Power_Management 8708  TPASS  :  sched domain test for sched_mc=67 &
> sched_smt=56
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> Power_Management 8709  TPASS  :  sched domain test for sched_mc=67 &
> sched_smt=57
> sh: /sys/devices/system/cpu/sched_mc_power_savings: No such file or directory
> 
>     It should be TCONF and only one check should be required at the
> script doing the call / loop.
> Thanks,
> -Garrett
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
