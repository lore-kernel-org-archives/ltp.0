Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MaQ7p-0005To-80
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:21:01 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MaQ7j-0002CT-7U
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:21:01 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7A8F23D020685
	for <Ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:15:02 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7A8KnIw210592
	for <Ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:20:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7A8Knvg026717
	for <Ltp-list@lists.sourceforge.net>; Mon, 10 Aug 2009 04:20:49 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
Date: Mon, 10 Aug 2009 13:50:26 +0530
Message-Id: <1249892426.5187.12.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] add_key01 & add_key02 test cases fails and shown as
	PASS	in	log file
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
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
> I see these two test cases are failing on PowerPC target (ppc440) as
> shown in output file, but they are listed as PASS in log file of the
> LTP :
> 
> Target : PowerPC (ppc440)
> Kernel: Linux-2.6.29
> LTP Version : ltp-full-20090731
> 
> LTP output file :
> #############
> 
> 
> 1. add_key01
> --------------------
> 
> <<<test_start>>>
> tag=add_key01 stime=1248549741
> cmdline="add_key01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : Function not
> implemented
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=0
> <<<test_end>>>
> 
> 2. add_key02
> ----------------------
> 
> <<<test_start>>>
> tag=add_key02 stime=1248549741
> cmdline="add_key02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> add_key02    0  TINFO  :  call add_key() with wrong args got
> UNEXPECTED errno:38
> add_key02    1  TFAIL  :  add_key02 failed - errno = 38 : Function not
> implemented
> <<<execution_status>>>
> initiation_status="ok"
> duration=0 termination_type=exited termination_id=0 corefile=no
> cutime=0 cstime=1
> <<<test_end>>>
> 
> --------------------------------------------------------
> 
> BUT the Log file shows as PASS to the above test cases :
> 
> ###########################
> 
> add_key01                      PASS       0
> add_key02                      PASS       0
> 
> ###########################
> 
> 
> May anyone explain, why it is so ? Is it a known behaviour ?

No. It is not. On my X_32, it passes fine.

$ ./testcases/bin/add_key01
add_key01    1  TPASS  :  add_key call succeeded
$ echo $?
0
$ ./testcases/bin/add_key02
add_key02    0  TINFO  :  call add_key() with wrong args got EXPECTED
errno:22
add_key02    1  TPASS  :  add_key call succeeded
$ echo $?
0
$ uname -a
Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
GNU/Linux

Regards--
Subrata

>  
> 
> Regards
> Srikanth Krishnakar
> ********************** 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
