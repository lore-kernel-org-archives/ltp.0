Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nkab4-00022r-Gp
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 10:05:30 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nkab3-00013r-CU
	for ltp-list@lists.sourceforge.net; Thu, 25 Feb 2010 10:05:30 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1P9vdWx007032
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 02:57:39 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o1PA5C0m176342
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 03:05:13 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1PA5AMH020103
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Feb 2010 03:05:10 -0700
Date: Thu, 25 Feb 2010 15:35:07 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100225100507.GB23984@linux.vnet.ibm.com>
References: <4B728073.3070209@cn.fujitsu.com>
	<4B7B9EC2.1010004@linux.vnet.ibm.com>
	<364299f41002170914u3a0d0b02o936a81d1ee601ecc@mail.gmail.com>
	<4B823884.4000100@cn.fujitsu.com>
	<364299f41002241922h31f32a1em6f12a2999fd931f8@mail.gmail.com>
	<20100225090027.GC3377@linux.vnet.ibm.com>
	<364299f41002250152u78dfacc3mab2d355b1f50baa9@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <364299f41002250152u78dfacc3mab2d355b1f50baa9@mail.gmail.com>
Subject: Re: [LTP] [PATCH] timers: support clockid of
 CLOCK_REALTIME_COARSE/CLOCK_MONOTONIC_COARSE
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Thu, Feb 25, 2010 at 01:52:23AM -0800, Garrett Cooper wrote:
> 
>     What version of Linux is this? I specifically took out the #ifndef
> ... #define ... #endif blocks because I'm trying to avoid these ad hoc
> #define's scattered around the tree.

The kernel version: 2.6.9-89.ELsmp , which RHEL4.8GA.

-Rishi

> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Download Intel&#174; Parallel Studio Eval
> Try the new software tools for yourself. Speed compiling, find bugs
> proactively, and fine-tune applications for parallel performance.
> See why Intel Parallel Studio got high marks during beta.
> http://p.sf.net/sfu/intel-sw-dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
