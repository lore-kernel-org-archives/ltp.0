Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yjwei@cn.fujitsu.com>) id 1MbrvS-0004DG-A2
	for ltp-list@lists.sourceforge.net; Fri, 14 Aug 2009 08:14:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbrvL-0000Wd-Mp
	for ltp-list@lists.sourceforge.net; Fri, 14 Aug 2009 08:14:14 +0000
Message-ID: <4A850550.7080109@cn.fujitsu.com>
Date: Fri, 14 Aug 2009 14:33:52 +0800
From: Wei Yongjun <yjwei@cn.fujitsu.com>
MIME-Version: 1.0
References: <d51f89b0908130131u5742ff3epf58617e3f4ab38a3@mail.gmail.com>
In-Reply-To: <d51f89b0908130131u5742ff3epf58617e3f4ab38a3@mail.gmail.com>
Subject: Re: [LTP] utimes01 test case issue
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

rohit verma wrote:
> Hi Wang Yong,
>
> I have observed the following thing in case02 of the test case
> utimes01 in latest ltp release.
>
> Expected error value is  EACCES (In the code below)
> But the actual error value is EPERM.I have checked this on  2.6.27 and
> 2.6.29 kernel.
>   

You can try root user and noroot user, the return error is different.

> static struct test_case tcase[] = {
>
>         { // case00
>                 ...
>         },
>         { // case01
>                 ...
>         },
>         { // case02
>                 .ttype          = NORMAL,
>                 .a_sec        = 1000,
>                 .m_sec       = 2000,
>                 .user          = "nobody",
>                 .ret             = -1,
>                 .err             = EACCES, // RHEL4U1 + 2.6.18 returns EPERM
>         },
>         { // case03
>                 ...
>         },
>
>         { // case04
>                 ...
>         },
> };
>
> Kindly confirm whether you are facing the same issue at your end.
>
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
