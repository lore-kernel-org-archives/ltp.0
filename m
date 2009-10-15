Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chandru@in.ibm.com>) id 1MyLwq-0007gl-1c
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 08:44:36 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MyLwg-0007QY-3Q
	for ltp-list@lists.sourceforge.net; Thu, 15 Oct 2009 08:44:36 +0000
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id n9F8iEQA022723
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 14:14:14 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9F8iDi42310324
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 14:14:14 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9F8iDm0024627
	for <ltp-list@lists.sourceforge.net>; Thu, 15 Oct 2009 19:44:13 +1100
From: Chandru <chandru@in.ibm.com>
Date: Thu, 15 Oct 2009 14:14:12 +0530
References: <200910011340.32046.chandru@in.ibm.com>
	<1255552134.4892.12.camel@subratamodak.linux.ibm.com>
	<364299f40910141825k6d8a8e15w5843dd9d2574d262@mail.gmail.com>
In-Reply-To: <364299f40910141825k6d8a8e15w5843dd9d2574d262@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200910151414.13027.chandru@in.ibm.com>
Subject: Re: [LTP] [PATCH V2] ppoll01: add signal() syscall to register the
	signal handler
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
Cc: vapier@gentoo.org, ltp-list@lists.sourceforge.net

On Thursday 15 October 2009 06:55:29 Garrett Cooper wrote:
> Just curious -- was the issue seen at the following point in the code
> previously?
> 
> 361             TEST(sys_ret = syscall(__NR_ppoll, p_fds, nfds, p_ts,
> p_sigmask, sigsetsize)); /* <-- Blocks here indefinitely */
> 362             sys_errno = errno;
> 363             if (sys_ret <= 0 || tc->ret < 0)
> 364                     goto TEST_END;
> 365
> 366             cmp_ok = fds[0].revents == tc->expect_revents;
> 
> I've seen this issue 1 out of the 8 or 9 times I've run this test.

Nope, without the patch we only see case00 completing and the test exits while in the middle of case01

# ./ppoll01
ppoll01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case00) END => OK
ppoll01     0  TINFO  :  (case01) START
# 


With the patch we see the output as follows...

# ./ppoll01
ppoll01     0  TINFO  :  (case00) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case00) END => OK
ppoll01     0  TINFO  :  (case01) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
ppoll01     0  TINFO  :  (case01) END => OK
ppoll01     0  TINFO  :  (case02) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       0 errno=0 (Success)
ppoll01     0  TINFO  :  (case02) END => OK
ppoll01     0  TINFO  :  (case03) START
EXPECT: return value(ret)=(N >= 0) errno=0 (Success)
RESULT: return value(ret)=       1 errno=0 (Success)
ppoll01     0  TINFO  :  (case03) END => OK
ppoll01     0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case04) END => OK
ppoll01     0  TINFO  :  (case05) START
EXPECT: return value(ret)=-1 errno=4 (Interrupted system call)
RESULT: return value(ret)=-1 errno=4 (Interrupted system call)
ppoll01     0  TINFO  :  (case05) END => OK
ppoll01     0  TINFO  :  (case06) START
EXPECT: return value(ret)=-1 errno=22 (Invalid argument)
RESULT: return value(ret)=-1 errno=22 (Invalid argument)
ppoll01     0  TINFO  :  (case06) END => OK
ppoll01     0  TINFO  :  (case07) START
EXPECT: return value(ret)=-1 errno=14 (Bad address)
RESULT: return value(ret)=-1 errno=14 (Bad address)
ppoll01     0  TINFO  :  (case07) END => OK
ppoll01     1  TPASS  :  ppoll01 call succeeded

#




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
