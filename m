Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MAPt9-00013n-H3
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 14:50:23 +0000
Received: from mail-bw0-f222.google.com ([209.85.218.222])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MAPt6-0005s7-Og
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 14:50:23 +0000
Received: by bwz22 with SMTP id 22so6494665bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Sat, 30 May 2009 07:49:49 -0700 (PDT)
Message-ID: <4A2142A0.2040301@petalogix.com>
Date: Sat, 30 May 2009 16:28:48 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A1E5847.6030807@petalogix.com>
	<200905290912.31947.vapier@gentoo.org>
In-Reply-To: <200905290912.31947.vapier@gentoo.org>
Subject: Re: [LTP] Installing outside LTP source
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: LTP <ltp-list@lists.sourceforge.net>, Jiri Palecek <jpalecek@web.de>

Mike Frysinger wrote:
> On Thursday 28 May 2009 05:24:23 Michal Simek wrote:
>   
>> I would to ask you if someone works or worked on moving LTP to Kbuild.
>>     
>
> the Subject line doesnt really seem to line up with this question.  what 
> exactly do you want to do and why do you think Kbuild is the solution ?  
> saying "let's switch to Kbuild!" without any rhyme or reason sounds like a lot 
> of work for no gain.
>   
I wanted to wrote two emails instead of one - that's why was there 2
different things.
1. disable compilation "verbose" mode and turn on it with V=1.
2. Move all binaries outside of LTP source code O=/path
3. I use only some parts of LTP for my testing and it will be good to
enable/disable just tests which you want to use.
4. If is possible clean all Makefiles

I don't have much experience with Kbuild I had just quick look. I looked
at uClinux distribution
(from blackfin repo - user folder) and there are called user apps
Makefile with make -C folder in loop.
Is it possible to easy compile many separates apps with any simpler
description.
I mean something like hostprogs-y += hello but not only for host programs.
Is it possible to use I don't know for example progs-y+=hello or any
similar?

Michal

> -mike
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
