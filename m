Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MZOmY-0007Hz-Ts
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:50 +0000
Received: from e6.ny.us.ibm.com ([32.97.182.146])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MZOmT-00007Z-5V
	for ltp-list@lists.sourceforge.net; Fri, 07 Aug 2009 12:42:50 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n77CkQbG003588
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:46:26 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n77CgbeM229960
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:42:37 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n77Cgb8x016275
	for <ltp-list@lists.sourceforge.net>; Fri, 7 Aug 2009 08:42:37 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <8368651DACC1964480F951191B94A078F8A313@svexch01.mvista.com>
References: <4A7AA1BE.9050901@petalogix.com>
	<8368651DACC1964480F951191B94A078F8A313@svexch01.mvista.com>
Date: Fri, 07 Aug 2009 18:12:00 +0530
Message-Id: <1249648920.4851.46.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] utimes01
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
To: Henry Yei <hyei@mvista.com>, michal.simek@petalogix.com
Cc: LTP <ltp-list@lists.sourceforge.net>

Michal,

My x86_32 behaves fine with this Syscall test, may be because it is
2.6.18 kernel as henry said.

$ uname -a
Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
GNU/Linux

$ ./testcases/bin/utimes01 
utimes01    0  TINFO  :  (case00) START
utimes01    0  TINFO  :  E:0,1000 <=> R:0,1000
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
utimes01    0  TINFO  :  (case00) END => OK
utimes01    0  TINFO  :  (case01) START
utimes01    0  TINFO  :  E:1000,0 <=> R:1000,0
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
utimes01    0  TINFO  :  (case01) END => OK
utimes01    0  TINFO  :  (case02) START
seteuid failed.
utimes01    0  TINFO  :  (case02) END => OK
utimes01    0  TINFO  :  (case03) START
EXPECT: return value(ret)=-1 errno=2 (No such file or directory)
RESULT: return value(ret)=-1 errno=2 (No such file or directory)
utimes01    0  TINFO  :  (case03) END => OK
utimes01    0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=14 (Bad address)
utimes01    0  TINFO  :  (case04) END => OK
utimes01    1  TPASS  :  utimes call succeeded 
[ltp-full-20090731]$ echo $?
0

However,

On Thu, 2009-08-06 at 17:56 -0700, Henry Yei wrote: 
> Michal, 
> 
> This is a known issue. If you look at the manpages it states the following under the BUGS section:
> 
> Linux is not careful to distinguish between the EACCES and EPERM
>     error returns.  On the other hand,  POSIX.1-2001 is buggy in its
>     error description for utimes().
> 
> utimes01 passes on 2.6.28-13 kernel (Ubuntu 9.04) as well as the 2.6.18 kernel in CentOS 4.

Can you send across a patch to update include the above information in
the test case itself ?

Regards--
Subrata

> 
> 
> -----Original Message-----
> From: Michal Simek [mailto:michal.simek@petalogix.com] 
> Sent: Thursday, August 06, 2009 2:26 AM
> To: LTP
> Subject: [LTP] utimes01
> 
> Hi All,
> 
> Can you please run utimes01 test? I see there on x86 and Microblaze this fault.
> There is different errno value.
> 
> Thanks,
> Michal
> 
> EXPECT: return value(ret)=-1 errno=13 (Permission denied)
> RESULT: return value(ret)=-1 errno=1 (Operation not permitted)
> 
> [root@monstr utimes]# ./utimes01
> utimes01    0  TINFO  :  (case00) START
> utimes01    0  TINFO  :  E:0,1000 <=> R:0,1000
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       0 errno=0 (Success)
> utimes01    0  TINFO  :  (case00) END => OK
> utimes01    0  TINFO  :  (case01) START
> utimes01    0  TINFO  :  E:1000,0 <=> R:1000,0
> EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
> RESULT: return value(ret)=       0 errno=0 (Success)
> utimes01    0  TINFO  :  (case01) END => OK
> utimes01    0  TINFO  :  (case02) START
> EXPECT: return value(ret)=-1 errno=13 (Permission denied)
> RESULT: return value(ret)=-1 errno=1 (Operation not permitted)
> utimes01    0  TINFO  :  (case02) END => NG
> utimes01    0  TINFO  :  (case03) START
> EXPECT: return value(ret)=-1 errno=2 (No such file or directory)
> RESULT: return value(ret)=-1 errno=2 (No such file or directory)
> utimes01    0  TINFO  :  (case03) END => OK
> utimes01    0  TINFO  :  (case04) START
> EXPECT: return value(ret)=-1 errno=14 (Bad address)
> RESULT: return value(ret)=-1 errno=14 (Bad address)
> utimes01    0  TINFO  :  (case04) END => OK
> utimes01    1  TFAIL  :  utimes01 failed - errno = 0 : Success
> utimes01    0  TINFO  :  NG
> 
> --
> Michal Simek, Ing. (M.Eng)
> PetaLogix - Linux Solutions for a Reconfigurable World
> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
> 
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
