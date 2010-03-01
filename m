Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nlz8C-0004Jc-A6
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 06:29:28 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nlz8B-0007x4-0N
	for ltp-list@lists.sourceforge.net; Mon, 01 Mar 2010 06:29:28 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o216QTDA005391
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 23:26:29 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o216TKnQ089176
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 23:29:20 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1SNTJnB022198
	for <ltp-list@lists.sourceforge.net>; Sun, 28 Feb 2010 16:29:20 -0700
Date: Mon, 1 Mar 2010 11:59:17 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100301062917.GD3860@linux.vnet.ibm.com>
References: <364299f41002242307i6256a0f1v9fbc4a2197049270@mail.gmail.com>
	<364299f41002242311j2c97cf8fm2894f00b3640d1ef@mail.gmail.com>
	<41c7690d1002250109r5e35b35cw2b10c0e270bc273a@mail.gmail.com>
	<20100225093304.GA23984@linux.vnet.ibm.com>
	<364299f41002250148q42f2d468y5c21919eeed3ce51@mail.gmail.com>
	<41c7690d1002251906w7b54d7a8w13fa60dcea22a4b3@mail.gmail.com>
	<41c7690d1002252055t5956a652ta173641c1860eedd@mail.gmail.com>
	<20100226053452.GA3800@linux.vnet.ibm.com>
	<20100226085136.GA9407@linux.vnet.ibm.com>
	<20100226091119.GB9407@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100226091119.GB9407@linux.vnet.ibm.com>
Subject: Re: [LTP] [PATCH-v2] RTC Device Driver Tests
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
To: Silesh C V <saileshcv@gmail.com>, ltp-list@lists.sourceforge.net, Garrett Cooper <yanegomi@gmail.com>, Arun.sudhilal@lntinfotech.com, Mohamed.Rasheed@lntinfotech.com

On Fri, Feb 26, 2010 at 02:41:19PM +0530, Rishikesh K Rajak wrote:
> On Fri, Feb 26, 2010 at 02:21:36PM +0530, Rishikesh K Rajak wrote:
> > > >Hi, 
> > 
> > Looks like some issue with your code, can you please relook once again ?
> 
> I have other system Which has SLES11 and i could see it has 
> 
> mls41:/home/test/ltp-full-20100131/testcases/kernel/device-drivers/rtc #
> ls -l /dev/rtc*
> lrwxrwxrwx 1 root root      4 2010-02-26 13:04 /dev/rtc -> rtc0
> crw-r--r-- 1 root root 252, 0 2010-02-26 13:04 /dev/rtc0
> mls41:/home/test/ltp-full-20100131/testcases/kernel/device-drivers/rtc # 
> 
> And here testcase passes. So can you check what could be the reason for
> failing on RHEL5.4 where it has only.
> 
> [root@mx3655 ~]# ls -l /dev/rtc*
> crw-r--r-- 1 root root 10, 135 Feb 18 06:42 /dev/rtc
> [root@mx3655 ~]# 
> 
> Thanks for your support.

HI Silesh,

Any input here, so that i can push this to upstream.

Thanks
Rishi

> 
> -- 
> Thanks & Regards
> Rishi
> LTP Maintainer
> IBM, LTC, Bangalore
> Please join IRC #ltp @ irc.freenode.net
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
