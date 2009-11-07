Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1N6PF1-0003yS-U8
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 13:52:39 +0000
Received: from e23smtp06.au.ibm.com ([202.81.31.148])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6PEt-0003Ha-Mj
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 13:52:39 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id nA6DH0Ql032205
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Nov 2009 00:17:00 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nA6DE6e8606412
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Nov 2009 00:14:06 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nA6DHCQA003284
	for <ltp-list@lists.sourceforge.net>; Sat, 7 Nov 2009 00:17:13 +1100
Message-ID: <4AF4CA85.8050206@in.ibm.com>
Date: Sat, 07 Nov 2009 06:46:53 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4AEFF53D.1010908@in.ibm.com> <4AEFF972.3080405@cn.fujitsu.com>
In-Reply-To: <4AEFF972.3080405@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH][RFC]Testcases mbind01.c and get_mempolicy01 fails
 with EINVAL
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
To: liubo <liubo2009@cn.fujitsu.com>
Cc: "Rishikesh K. Rajak" <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net

Liu
   Excuse me for the late response. I looked into Kconfig file and it looks that what you 
are saying is correct assessment.
This is what Kconfig file under arch/x86 says
---------------------------------------------------------------------------------------
config MAXSMP
         bool "Configure Maximum number of SMP Processors and NUMA Nodes"
         depends on X86_64 && SMP && DEBUG_KERNEL && EXPERIMENTAL
---------------------------------------------------------------------------------------
So this value is changed only specific to x86_64 arch

And check for ppc64 didn't reveal any modification to the MAX_NUMNODE value.

As you put it reading this value from configure file appears to be a better idea
Thanks
Sharyathi


On Tuesday 03 November 2009 03:05 PM, liubo wrote:
>>          int uninitialized_var(pval);
>>          nodemask_t nodes;
>>
>>          if (nmask != NULL&&  maxnode<  MAX_NUMNODES)
>>                  return -EINVAL;
>>                                                   <== in the kernel code,
>> MAX_NUMNODES comes to 512
>
>    Is it better that "MAX_NUMNODES" get from configure file?
>
>    For different platforms may have different  MAX_NUMNODES.
>
>
>    Regards--
>    Liu Bo
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
