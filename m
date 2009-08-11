Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MawDj-0001zZ-4m
	for Ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 18:37:15 +0000
Received: from mail-fx0-f222.google.com ([209.85.220.222])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MawDZ-0003sw-Bk
	for Ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 18:37:10 +0000
Received: by fxm22 with SMTP id 22so3122299fxm.33
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 11 Aug 2009 11:36:57 -0700 (PDT)
Message-ID: <4A81BA46.3050302@petalogix.com>
Date: Tue, 11 Aug 2009 20:36:54 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>	<1249892426.5187.12.camel@subratamodak.linux.ibm.com>	<6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>	<364299f40908100844l44497151g750f745648080c24@mail.gmail.com>	<6213bc560908100924h2d0da433y52391da42aeeaa16@mail.gmail.com>
	<6213bc560908110605q45ced45dgd36026da8adc0bb5@mail.gmail.com>
In-Reply-To: <6213bc560908110605q45ced45dgd36026da8adc0bb5@mail.gmail.com>
Subject: Re: [LTP] add_key01 & add_key02 test cases fails and shown as PASS
 in log file
Reply-To: michal.simek@petalogix.com
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
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

Trace add_key syscall and find that for this testcases you have to
enable CONFIG_KEYS in your kernel.
This could be reason to add new return value for Function is not
implemented and any sensible description
to test.

Cheers,
Michal
> Hi all,
>
> I observed that these two test cases are known to be failing on
> following architectures :
>
> 1. *PowerPC* (ppc440)    > Kernel */Linux-2.6.29.6/*
> 2. *MIPS*                       > Kernel /*Linux-2.6.28.10*/
>
> <<<test_start>>>
> tag=*add_key01* stime=1249655730
> cmdline="add_key01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : *Function
> not implemented*
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=1 cstime=0
> <<<test_end>>>
>
>
> <<<test_start>>>
> tag=*add_key02* stime=1249655730
> cmdline="add_key02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> add_key02    0  TINFO  :  call add_key() with wrong args got
> UNEXPECTED errno:38
> add_key02    1  TFAIL  :  add_key02 failed - errno = 38 :* Function
> not implemented*
> <<<execution_status>>>
> initiation_status="ok"
> duration=1 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=2
> <<<test_end>>>
>  
> Are these two test cases intended for these architectures ? Have you
> tested these tests on any of above mentioned architectures ?
>
> Waiting for your comments ?
>
> -Srikanth
>  
> On Mon, Aug 10, 2009 at 9:54 PM, srikanth krishnakar
> <skrishnakar@gmail.com <mailto:skrishnakar@gmail.com>> wrote:
>
>
>
>     On Mon, Aug 10, 2009 at 9:14 PM, Garrett Cooper
>     <yanegomi@gmail.com <mailto:yanegomi@gmail.com>> wrote:
>
>         On Mon, Aug 10, 2009 at 1:29 AM, srikanth
>         krishnakar<skrishnakar@gmail.com
>         <mailto:skrishnakar@gmail.com>> wrote:
>         >
>         >
>         > On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak
>         <subrata@linux.vnet.ibm.com <mailto:subrata@linux.vnet.ibm.com>>
>         > wrote:
>         >>
>         >> On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
>         >> > I see these two test cases are failing on PowerPC target
>         (ppc440) as
>         >> > shown in output file, but they are listed as PASS in log
>         file of the
>         >> > LTP :
>         >> >
>         >> > Target : PowerPC (ppc440)
>         >> > Kernel: Linux-2.6.29
>         >> > LTP Version : ltp-full-20090731
>         >> >
>         >> > LTP output file :
>         >> > #############
>         >> >
>         >> >
>         >> > 1. add_key01
>         >> > --------------------
>         >> >
>         >> > <<<test_start>>>
>         >> > tag=add_key01 stime=1248549741
>         >> > cmdline="add_key01"
>         >> > contacts=""
>         >> > analysis=exit
>         >> > <<<test_output>>>
>         >> > add_key01    1  TFAIL  :  add_key01 failed - errno = 38 :
>         Function not
>         >> > implemented
>         >> > <<<execution_status>>>
>         >> > initiation_status="ok"
>         >> > duration=0 termination_type=exited termination_id=0
>         corefile=no
>         >> > cutime=0 cstime=0
>         >> > <<<test_end>>>
>         >> >
>         >> > 2. add_key02
>         >> > ----------------------
>         >> >
>         >> > <<<test_start>>>
>         >> > tag=add_key02 stime=1248549741
>         >> > cmdline="add_key02"
>         >> > contacts=""
>         >> > analysis=exit
>         >> > <<<test_output>>>
>         >> > add_key02    0  TINFO  :  call add_key() with wrong args got
>         >> > UNEXPECTED errno:38
>         >> > add_key02    1  TFAIL  :  add_key02 failed - errno = 38 :
>         Function not
>         >> > implemented
>         >> > <<<execution_status>>>
>         >> > initiation_status="ok"
>         >> > duration=0 termination_type=exited termination_id=0
>         corefile=no
>         >> > cutime=0 cstime=1
>         >> > <<<test_end>>>
>         >> >
>         >> > --------------------------------------------------------
>         >> >
>         >> > BUT the Log file shows as PASS to the above test cases :
>         >> >
>         >> > ###########################
>         >> >
>         >> > add_key01                      PASS       0
>         >> > add_key02                      PASS       0
>         >> >
>         >> > ###########################
>         >> >
>         >> >
>         >> > May anyone explain, why it is so ? Is it a known behaviour ?
>         >>
>         >> No. It is not. On my X_32, it passes fine.
>         >
>         > Is it PowePC target on which you have tested ?
>         >>
>         >>
>         >> $ ./testcases/bin/add_key01
>         >> add_key01    1  TPASS  :  add_key call succeeded
>         >> $ echo $?
>         >> 0
>         >> $ ./testcases/bin/add_key02
>         >> add_key02    0  TINFO  :  call add_key() with wrong args
>         got EXPECTED
>         >> errno:22
>         >> add_key02    1  TPASS  :  add_key call succeeded
>         >> $ echo $?
>         >> 0
>         >> $ uname -a
>         >> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008
>         i686 i686 i386
>         >> GNU/Linux
>
>         Hi Srikanth,
>            I think that the error is fairly intuitive (function not
>         implemented). Are you sure that your subarchitecture supports
>         add_key(2)?
>         Hi Subrata,
>            As far as the actual issue is concerned, I think that the
>         problem
>         is that someone's exiting with exit(0) instead of tst_exit()...
>         Thanks,
>         -Garrett
>
>
>     Thanks Garrett,
>
>     I will look into it.
>
>
>     -- 
>     "The Good You Do, The Best You GET"
>
>     Regards
>     Srikanth Krishnakar
>     **********************
>
>
>
>
> -- 
> "The Good You Do, The Best You GET"
>
> Regards
> Srikanth Krishnakar
> **********************
> ------------------------------------------------------------------------
>
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> ------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
