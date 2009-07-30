Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaNr-0005eP-5D
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:43 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaNj-0001qa-Te
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:43 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
References: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
Date: Thu, 30 Jul 2009 23:59:17 +0530
Message-Id: <1248978557.5788.61.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Fixed this now.

Regards--
Subrata

On Thu, 2009-07-23 at 14:00 +0530, rohit verma wrote: 
> Hi,
> 
> I am running waitid02.c
> (ltp-full-20090630/testcases/kernel/syscalls/waitid/ ) test case on
> 2.6.29 kernel.
> Test case gives following error:
> "Error. is your system >2.6.9 ?";
> 
>  Anybody facing the same issue?
> 
> Code:
> 
> TEST(waitid(P_ALL,0,&infop,WNOHANG));
>         if(TEST_RETURN == 0)
>                 tst_resm(TPASS,"Success !");
>         else{
>                 printf("value of return is %d\n",TEST_RETURN);
>                 tst_resm(TFAIL,"Error. is your system >2.6.9 ?");
>                errnochoose();
>         }
> 
> 
> Regards,
> Rohit
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
