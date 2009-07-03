Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMXSu-0005M7-1V
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:21:24 +0000
Received: from mail-px0-f183.google.com ([209.85.216.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMXSr-0003jx-Hw
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 01:21:23 +0000
Received: by pxi13 with SMTP id 13so565807pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 02 Jul 2009 18:21:20 -0700 (PDT)
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022058.43574.vapier@gentoo.org>
Message-Id: <4B19CF3F-6820-48B8-BE63-8F9046C559DE@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <200907022058.43574.vapier@gentoo.org>
Mime-Version: 1.0 (iPhone Mail 7A341)
Date: Thu, 2 Jul 2009 18:21:06 -0700
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Both sinclude and include are possible I suppose, but as far as I  
understand that actually does an fstat, tries to open the file, etc,  
but this completely ignores the include statement and reduces I/O a bit.

Sent from my iPhone

On Jul 2, 2009, at 5:58 PM, Mike Frysinger <vapier@gentoo.org> wrote:

> On Thursday 02 July 2009 20:46:05 Garrett Cooper wrote:
>> In order to loosen the requirement of having config.mk for a clean /
>> distclean operation, we need to check for %clean in MAKECMDGOALS.
>
> then why not simply use sinclude ?
> -mike

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
