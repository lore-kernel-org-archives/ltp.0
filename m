Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharyath@in.ibm.com>) id 1MTBAb-0003bf-AW
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 08:57:57 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTBAR-0004SB-0U
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 08:57:52 +0000
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28smtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id n6L8ve0q022013
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 14:27:40 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n6L8vdTN1548330
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 14:27:39 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
	by d28av02.in.ibm.com (8.13.1/8.13.3) with ESMTP id n6L8vdQn010269
	for <ltp-list@lists.sourceforge.net>; Tue, 21 Jul 2009 18:57:39 +1000
Message-ID: <4A658302.60307@in.ibm.com>
Date: Tue, 21 Jul 2009 14:27:38 +0530
From: Sharyathi Nagesh <sharyath@in.ibm.com>
MIME-Version: 1.0
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
	<364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
In-Reply-To: <364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

Garret

> 
> Hi Yeehaw,
>     1. You didn't provide sign-off, as noted in the DCO:
> http://ltp.sourceforge.net/DCO.txt
Excuse me for missing that out, if this patch format is okie I will resend it with the 
sign-off included in it
>     2. This appears to be a legitimate documentation bug (at least as
> far as the manpages for 2.6.29-r5 are concerned), because I can't find
> a single reference to nobody in the manpage, as far as special
> importance is concerned. Furthermore, looking at the OpenGroup's
> documentation, I don't see anything there either:
> http://www.opengroup.org/onlinepubs/000095399/functions/getgroups.html

  I am not very clear with what you are pointing at, but let me take a shot. bin and nobody 
are 2 users used in the test case. I am not sure who or where it is getting created, but 
what I did observe is that they don't have the same privileges. GID of bin is in the list of 
supplementary group ids of root while nobody is not. If this is the case chmod/fchmod won't 
clear S_IGSID bit of the file, as you can read from man page of chmod/fchmod.
  Nobody won't be in any man page as this User was created by LTP, I suppose, to use in this 
test case.
Thanks
Sharyathi N


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
