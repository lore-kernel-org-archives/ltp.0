Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1N7j6Q-0002IZ-Hd
	for ltp-list@lists.sourceforge.net; Tue, 10 Nov 2009 05:17:14 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N7j6J-0007qq-Bk
	for ltp-list@lists.sourceforge.net; Tue, 10 Nov 2009 05:17:14 +0000
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id nAA5GqYn020127
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Nov 2009 10:46:52 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nAA5Gpdd2088960
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Nov 2009 10:46:51 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nAA5GolI014338
	for <ltp-list@lists.sourceforge.net>; Tue, 10 Nov 2009 10:46:51 +0530
Message-ID: <4AF8F73E.10506@linux.vnet.ibm.com>
Date: Tue, 10 Nov 2009 10:46:46 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4948C6E4.8080801@linux.vnet.ibm.com>
	<49491512.9000905@linux.vnet.ibm.com>
	<1229578051.5149.11.camel@subratamodak.linux.ibm.com>
	<20090214203139.GA10969@us.ibm.com>
	<1234762145.7791.13.camel@subratamodak.linux.ibm.com>
	<1245768501.4860.56.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1245768501.4860.56.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] testcase pidns20, pidns21 on pid namespace
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Nadia Derbey <Nadia.Derbey@bull.net>, Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>, gowrishankar.muthukrishna@gmail.com

Subrata Modak wrote:
> On Mon, 2009-02-16 at 10:59 +0530, Subrata Modak wrote: 
>   
>> Thanks Suka,
>>
>> On Sat, 2009-02-14 at 12:31 -0800, Sukadev Bhattiprolu wrote:
>>     
>>> Subrata Modak [subrata@linux.vnet.ibm.com] wrote:
>>> | 
>>> | > > pidns21:
>>> | > >    The pidns21.c testcase verifies that container-init is terminated
>>> | > >    by SIGUSR1 when:
>>> | > >       - a handler is specified for SIGUSR1,
>>> | > >       - container-init blocks SIGUSR1,
>>> | > >       - parent queues SIGUSR1 and
>>> | > >       - handler for SIGUSR1 is set to system default before SIGUSR1 is 
>>> | > > unblocked.
>>>
>>> I know I had acked this test before, but back then the actual implementation
>>> of the signal semantics in the kernel were not complete.
>>>
>>> To simplify the implementation of the semantics, it was decided that
>>> SIGKILL/SIGSTOP would be the only reliable signals from a parent
>>> container. IOW, container-init would ignore SIGUSR1 or SIGINT, SIGQUIT
>>> etc even if sent from a parent container.
>>>
>>> See patchset/discussion:
>>>
>>> 	http://lkml.org/lkml/2009/1/17/131
>>>
>>> (which is not yet merged, but appears to be close to consensus)
>>>
>>> The  rationale for this simplification is that any serious
>>> 'container-init' would explicitly SIG_IGN all signals that it is
>>> not interested in. So the only signals that would be in SIG_DFL
>>> state would be SIGKILL/SIGSTOP.
>>>
>>> Effectively, testcase pidns21 will fail if/when the above patchset
>>> (specifically, patch 5/6) is merged.
>>>       
>> Gowri,
>>
>> Kindly update this test when the patch makes into next stable kernel
>> release.
>>     
>
> Suka/Gowri,
>
> Are we still looking into these tests ?
>   


Anyone still looking into it ? Still i am getting failure for pidns21 
with latest ltp release.

-Rishi
> Regards--
> Subrata
>
>   
>> Regards--
>> Subrata
>>
>>
>>
>> ------------------------------------------------------------------------------
>> Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
>> -OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
>> -Strategies to boost innovation and cut costs with open source participation
>> -Receive a $600 discount off the registration fee with the source code: SFAD
>> http://p.sf.net/sfu/XcvMzF8H
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>     
>
>
> ------------------------------------------------------------------------------
> Are you an open source citizen? Join us for the Open Source Bridge conference!
> Portland, OR, June 17-19. Two days of sessions, one day of unconference: $250.
> Need another reason to go? 24-hour hacker lounge. Register today!
> http://ad.doubleclick.net/clk;215844324;13503038;v?http://opensourcebridge.org
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
