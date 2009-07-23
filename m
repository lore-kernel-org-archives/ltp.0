Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1MTzNr-0002nY-2s
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 14:34:59 +0000
Received: from e28smtp04.in.ibm.com ([59.145.155.4])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTzNk-0002A7-BV
	for ltp-list@lists.sourceforge.net; Thu, 23 Jul 2009 14:34:58 +0000
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
References: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
Date: Thu, 23 Jul 2009 19:52:58 +0530
Message-Id: <1248358978.17741.0.camel@munipradeep-laptop>
Mime-Version: 1.0
Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
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

Hi,

I am also facing the same issue.
I think it is testcase problem.

Regards
Muni

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
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
