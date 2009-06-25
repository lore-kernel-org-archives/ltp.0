Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlmt-0000Xe-Tx
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:02:35 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJlmq-0004jf-1C
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:02:35 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5PA13mV014722
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 04:01:03 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5PA2RMq062350
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 04:02:29 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5PA2QqE031792
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 04:02:27 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <A850D9FA-3282-440E-8B85-4A5BC5B4B067@gmail.com>
References: <A850D9FA-3282-440E-8B85-4A5BC5B4B067@gmail.com>
Date: Thu, 25 Jun 2009 14:40:38 +0530
Message-Id: <1245921038.5542.46.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Goals and milestones
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
To: Garrett Cooper <yanegomi@gmail.com>, Nathan Straz <nstraz@redhat.com>, Mike Frysinger <vapier@gentoo.org>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Great to hear back from you. Your plan looks good to me. However, i
would like to complete the Makefiles stuff this year itself. I know its
quite tedious. May be i would also pitch in to help you post my Linux
Symposium 2009 in July 2009.

On Wed, 2009-06-24 at 02:38 -0700, Garrett Cooper wrote: 
> Hi Subrata,
>      After being away from FOSS for a while I'm going to jump back in  
> a bit to get some work done in my personal time that aligns itself  
> with deliverables at Cisco. Here's the breakdown in terms of priorities:
> 1. Ltp crosscompile makefile push completion - need this to resolve  
> several issues with the current hacked make system and expedite  
> upgrades on our end. Hard goal: before July snapshot is released  
> (several items are dependent on a functioning upgrade). I will commit  
> in small, discrete patches to get the work done quicker, but I'll need  
> a makefile reviewer.

Nathan has already been helping us. So, we would get help from him and
Mike as well. I need to bring back Mike as well for more LTP
involvement. Mike, what do you say ;-)

Regards--
Subrata

> 2. Catepault work. This aligns itself with 1., but isn't directly tied  
> into 1.'s deliverable. Maybe October.
> 3. tst_res -> testreport replacement. Needs to take place somewhere  
> around 2.'s deliverable because we need a more license neutral and  
> equivalent, if not cleaner, means of doing test reporting to improve  
> whitebox testing inhouse. I'd say before Thanksgiving.
> 4. Upstart whitebox tests - I originally suggested this thinking that  
> there would be one Upstart release train, but Scott's maintaining  
> several, so I think it may be a better idea to omit these tests and  
> focus instead on exporting the graybox tests I'm working on inhouse at  
> Cisco as they are more portable and have more overall value. I'm  
> thinking maybe January or february of next year.
> 
> Hope that better describes where I'm at and what goals i'm trying to  
> accomplish.
> 
> Thanks,
> -Garrett 


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
