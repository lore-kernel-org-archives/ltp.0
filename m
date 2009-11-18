Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NAerN-0002RT-DG
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 07:21:49 +0000
Received: from mail-px0-f195.google.com ([209.85.216.195])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NAerI-0001XE-Hd
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 07:21:49 +0000
Received: by pxi33 with SMTP id 33so589293pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Nov 2009 23:21:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001ca680f$325eeb40$971cc1c0$@co.jp>
References: <000001ca680f$325eeb40$971cc1c0$@co.jp>
Date: Tue, 17 Nov 2009 23:21:38 -0800
Message-ID: <364299f40911172321r79ebd916n73ee5a145e792d2b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] make error of LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?ISO-2022-JP?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

2009/11/17 神谷朋範 <mitani@ryobi.co.jp>:
> Hi
>
> I ran "make" in RHEL4.8 (Kernel release : 2.6.9-89.ELsmp).
> But it ended with error message means "make: `testcases/realtime/configure'
> is up to date".
> Please refer to the error message log that I described last of this e-mail.
>
> - The same problem occurs in some distribution(SUSE, RHEL etc).
> - There are much users using these distribution.
> - LTP is used in tests of various situation.
> - Therefore, such users are troubled with the situation that LTP is not
> usable suddenly.
>
> I want make a Makefile code working with make 3.80 here and want to offer
> it.
> Can I get some advice?
>
>
> error message
> ============
> # make
> make: `testcases/realtime/configure' is up to date.
> #
> ============

Mitani-san,
    This is a known feature gap (make 3.81) that will do my best to
address before the November release.
Thank you,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
