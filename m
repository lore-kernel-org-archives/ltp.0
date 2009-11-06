Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <andi@firstfloor.org>) id 1N6OZA-0001u3-Pf
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 13:09:24 +0000
Received: from one.firstfloor.org ([213.235.205.2])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6OZ5-00047K-JK
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 13:09:24 +0000
Date: Fri, 6 Nov 2009 14:09:06 +0100
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20091106130906.GW31511@one.firstfloor.org>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911060616.40305.vapier@gentoo.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200911060616.40305.vapier@gentoo.org>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
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
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 06, 2009 at 07:16:39AM -0400, Mike Frysinger wrote:
> On Friday 06 November 2009 04:57:45 Andi Kleen wrote:
> > I ran configure, which seems to spend 99% of its time
> > checking for stuff that is always there on any Linux,
> 
> not really.  most of the configure checks are there because people have 
> complained about specific issues trying to run on older linux distros.  and we 

I always just deleted the tests that didn't build. That's far better
than not building at all like now.

> arent actively blocking using LTP on other *nix systems.

yes you're just actively blocking running LTP on Linux now it seems.

> 
> > and after that I just get
> > 
> > # make
> > make: `testcases/realtime/configure' is up to date.
> > #
> 
> -ENEEDINFO
> 
> are you using live cvs ?  latest release ?  what distro ?  what version of 

See Subject on SUSE 10.0

> autoconf/make ?  what does `make -d` show ?

autoconf doesn't matter because I didn't regenerate the script.

GNU Make 3.80
Copyright (C) 2002  Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Reading makefiles...
Reading makefile `Makefile'...
Reading makefile `/root/ltp-full-20091031/include/mk/env_pre.mk' (search path) (no ~ expansion)...
Reading makefile `/root/ltp-full-20091031/include/mk/config.mk' (search path) (don't care) (no ~ expansion)...
Reading makefile `/root/ltp-full-20091031/include/mk/automake.mk' (search path) (no ~ expansion)...
Updating makefiles....
 Considering target file `/root/ltp-full-20091031/include/mk/automake.mk'.
  Looking for an implicit rule for `/root/ltp-full-20091031/include/mk/automake.mk'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/automake.mk,v'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/RCS/automake.mk,v'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/RCS/automake.mk'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/s.automake.mk'.
  Trying pattern rule with stem `automake.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/SCCS/s.automake.mk'.
  No implicit rule found for `/root/ltp-full-20091031/include/mk/automake.mk'.
  Finished prerequisites of target file `/root/ltp-full-20091031/include/mk/automake.mk'.
 No need to remake target `/root/ltp-full-20091031/include/mk/automake.mk'.
 Considering target file `/root/ltp-full-20091031/include/mk/config.mk'.
  Looking for an implicit rule for `/root/ltp-full-20091031/include/mk/config.mk'.
  Trying pattern rule with stem `config.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/config.mk,v'.
  Trying pattern rule with stem `config.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/RCS/config.mk,v'.
  Trying pattern rule with stem `config.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/RCS/config.mk'.
  Trying pattern rule with stem `config.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/s.config.mk'.
  Trying pattern rule with stem `config.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/SCCS/s.config.mk'.
  No implicit rule found for `/root/ltp-full-20091031/include/mk/config.mk'.
  Finished prerequisites of target file `/root/ltp-full-20091031/include/mk/config.mk'.
 No need to remake target `/root/ltp-full-20091031/include/mk/config.mk'.
 Considering target file `/root/ltp-full-20091031/include/mk/env_pre.mk'.
  Looking for an implicit rule for `/root/ltp-full-20091031/include/mk/env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/env_pre.mk,v'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/RCS/env_pre.mk,v'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/RCS/env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/s.env_pre.mk'.
  Trying pattern rule with stem `env_pre.mk'.
  Trying implicit prerequisite `/root/ltp-full-20091031/include/mk/SCCS/s.env_pre.mk'.
  No implicit rule found for `/root/ltp-full-20091031/include/mk/env_pre.mk'.
  Finished prerequisites of target file `/root/ltp-full-20091031/include/mk/env_pre.mk'.
 No need to remake target `/root/ltp-full-20091031/include/mk/env_pre.mk'.
 Considering target file `Makefile'.
  Looking for an implicit rule for `Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `Makefile,v'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `RCS/Makefile,v'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `RCS/Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `s.Makefile'.
  Trying pattern rule with stem `Makefile'.
  Trying implicit prerequisite `SCCS/s.Makefile'.
  No implicit rule found for `Makefile'.
  Finished prerequisites of target file `Makefile'.
 No need to remake target `Makefile'.
Updating goal targets....
Considering target file `testcases/realtime/configure'.
 Finished prerequisites of target file `testcases/realtime/configure'.
No need to remake target `testcases/realtime/configure'.
make: `testcases/realtime/configure' is up to date.



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
