Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NAdFo-0005W8-7m
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 05:38:56 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NAdFf-0003fT-Qq
	for ltp-list@lists.sourceforge.net; Wed, 18 Nov 2009 05:38:56 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Wed, 18 Nov 2009 14:23:01 +0900
From: =?iso-2022-jp?B?GyRCP0BDK0p+SE8bKEI=?= <mitani@ryobi.co.jp>
Date: Wed, 18 Nov 2009 14:23:01 +0900
Message-ID: <000001ca680f$325eeb40$971cc1c0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] make error of LTP
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
To: ltp-list@lists.sourceforge.net

Hi

I ran "make" in RHEL4.8 (Kernel release : 2.6.9-89.ELsmp).
But it ended with error message means "make: `testcases/realtime/configure'
is up to date".
Please refer to the error message log that I described last of this e-mail.

- The same problem occurs in some distribution(SUSE, RHEL etc).
- There are much users using these distribution.
- LTP is used in tests of various situation.
- Therefore, such users are troubled with the situation that LTP is not
usable suddenly.

I want make a Makefile code working with make 3.80 here and want to offer
it.
Can I get some advice?


error message
============
# make
make: `testcases/realtime/configure' is up to date.
#
============

Regards--

-Tomonori Mitani



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
