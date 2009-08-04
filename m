Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MYImb-0003Dw-As
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:06:21 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MYImT-0000EY-55
	for ltp-list@lists.sourceforge.net; Tue, 04 Aug 2009 12:06:21 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <d51f89b0908040431w6208a47fgbe79b5df30c6268c@mail.gmail.com>
References: <d51f89b0907230130k158cbfbeo31f290cf207432b6@mail.gmail.com>
	<1248978557.5788.61.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040422o17ac20f6q36aaff23ea88e839@mail.gmail.com>
	<1249385096.15587.17.camel@subratamodak.linux.ibm.com>
	<d51f89b0908040431w6208a47fgbe79b5df30c6268c@mail.gmail.com>
Date: Tue, 04 Aug 2009 17:35:39 +0530
Message-Id: <1249387539.15587.24.camel@subratamodak.linux.ibm.com>
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

On Tue, 2009-08-04 at 17:01 +0530, rohit verma wrote:
> FYI

unfortunately, you did not attach the patch itself ;-)

Regards--
Subrata

> 
> ---------- Forwarded message ----------
> From: Subrata Modak <subrata@linux.vnet.ibm.com>
> Date: Tue, Aug 4, 2009 at 4:54 PM
> Subject: Re: [LTP] waitid02 testcase fails on 2.6.29 kernel
> To: rohit verma <rohit.170309@gmail.com>
> Cc: maknayak@in.ibm.com, CAI Qian <caiqian@cclom.cn>
> 
> 
> Rohit,
> 
> Post this to ltp mailing list.
> 
> Regards--
> Subrata
> 
> On Tue, 2009-08-04 at 16:52 +0530, rohit verma wrote:
> > Dear Manas Kumar Nayak,
> >
> > Pls find attached patch for waitid02 test case.I have modified the
> > test case.I have also added 2 test scenarios in the test case using
> > WSTOPPED and WNOWAIT.
> >
> > Note:
> > The testcase was failing in LTP July, 2009 release.
> > The warning- "implicit declaration of function 'getpgid", has been removed
> >
> > Pls verify the patch.
> >
> > Regards--
> > Rohit Verma
> >
> >
> >
> > On Thu, Jul 30, 2009 at 11:59 PM, Subrata
> > Modak<subrata@linux.vnet.ibm.com> wrote:
> > > Fixed this now.
> > >
> > > Regards--
> > > Subrata
> > >
> > > On Thu, 2009-07-23 at 14:00 +0530, rohit verma wrote:
> > >> Hi,
> > >>
> > >> I am running waitid02.c
> > >> (ltp-full-20090630/testcases/kernel/syscalls/waitid/ ) test case on
> > >> 2.6.29 kernel.
> > >> Test case gives following error:
> > >> "Error. is your system >2.6.9 ?";
> > >>
> > >>  Anybody facing the same issue?
> > >>
> > >> Code:
> > >>
> > >> TEST(waitid(P_ALL,0,&infop,WNOHANG));
> > >>         if(TEST_RETURN == 0)
> > >>                 tst_resm(TPASS,"Success !");
> > >>         else{
> > >>                 printf("value of return is %d\n",TEST_RETURN);
> > >>                 tst_resm(TFAIL,"Error. is your system >2.6.9 ?");
> > >>                errnochoose();
> > >>         }
> > >>
> > >>
> > >> Regards,
> > >> Rohit
> > >>
> > >> ------------------------------------------------------------------------------
> > >> _______________________________________________
> > >> Ltp-list mailing list
> > >> Ltp-list@lists.sourceforge.net
> > >> https://lists.sourceforge.net/lists/listinfo/ltp-list
> > >
> > >
> >
> >
> >
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
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
