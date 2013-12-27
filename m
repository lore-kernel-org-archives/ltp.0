Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1VwV7C-0006ai-IP
	for ltp-list@lists.sourceforge.net; Fri, 27 Dec 2013 10:58:02 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VwV7A-0002DR-Js
	for ltp-list@lists.sourceforge.net; Fri, 27 Dec 2013 10:58:02 +0000
Message-ID: <1388141867.1656.0.camel@G08JYZSD130126>
From: "zenglg.jy" <zenglg.jy@cn.fujitsu.com>
Date: Fri, 27 Dec 2013 18:57:47 +0800
In-Reply-To: <201312250423.10814.vapier@gentoo.org>
References: <1387884941.1622.98.camel@G08JYZSD130126>
	<1387885358.1622.104.camel@G08JYZSD130126>
	<201312250423.10814.vapier@gentoo.org>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH v3 1/4] fallocate/fallocate.h: move inline function
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
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Wed, 2013-12-25 at 04:23 -0500, Mike Frysinger wrote:
> On Tuesday 24 December 2013 06:42:38 zenglg.jy wrote:
> > On Tue, 2013-12-24 at 19:35 +0800, zenglg.jy wrote:
> > > >From edb98f0b69c16f612f79fe24d10597af47424f13 Mon Sep 17 00:00:00 2001
> > > 
> > > From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > > Date: Tue, 24 Dec 2013 19:21:32 +0800
> > > Subject: [PATCH] fallocate/fallocate.h: move inline function
> > > 
> > > Moved common inline function to fallocate.h
> > > 
> > > Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> > > ---
> > > 
> > >  testcases/kernel/syscalls/fallocate/fallocate.h   | 47
> > >  +++++++++++++++++++++++
> > >  testcases/kernel/syscalls/fallocate/fallocate01.c | 23 +----------
> > >  testcases/kernel/syscalls/fallocate/fallocate02.c | 19 +--------
> > >  testcases/kernel/syscalls/fallocate/fallocate03.c | 19 +-------- 4
> > >  files changed, 50 insertions(+), 58 deletions(-)
> > >  create mode 100644 testcases/kernel/syscalls/fallocate/fallocate.h
> > > 
> > > diff --git a/testcases/kernel/syscalls/fallocate/fallocate.h
> > > b/testcases/kernel/syscalls/fallocate/fallocate.h new file mode 100644
> > > index 0000000..e47338b
> > > --- /dev/null
> > > +++ b/testcases/kernel/syscalls/fallocate/fallocate.h
> > > @@ -0,0 +1,47 @@
> > > +/*
> > > + * Copyright (c) International Business Machines  Corp., 2007
> > > + * Copyright (c) 2013 Fujitsu Ltd.
> > > + *
> > > + * This program is free software;  you can redistribute it and/or modify
> > > + * it under the terms of the GNU General Public License as published by
> > > + * the Free Software Foundation; either version 2 of the License, or
> > > + * (at your option) any later version.
> > > + *
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU Library General Public License for more details.
> > > + *
> > > + * You should have received a copy of the GNU General Public License
> > > + * along with this program; if not, write to the Free Software
> > > + * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307,
> > > USA. + *
> > > + */
> > > +
> > > +#ifndef FALLOCATE_H
> > > +#define FALLOCATE_H
> > > +
> > > +#include <sys/types.h>
> > > +#include <endian.h>
> > > +#include "linux_syscall_numbers.h"
> > > +
> > > +static inline long fallocate(int fd, int mode, loff_t offset, loff_t
> > > len) +{
> > > +/*
> > > + * Use __WORDSIZE will fail on ABI's that have 64bit registers but 32bit
> > > + * longs like MIPS n32 and x86_64 x32
> > > + */
> > 
> > I do not know about the ABI's problem. Could someone give me a help.
> 
> you can check for mips n32 by doing:
>         #if defined(__mips__) && _MIPS_SIM == _ABIN32
> 
> you can check for x86_64 x32 by doing:
>         #if defined(__x86_64__) && defined(__ILP32__)
> 
> these should use the 64bit code path

Thank you very much!
Best regards,
Zeng

> -mike



------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
