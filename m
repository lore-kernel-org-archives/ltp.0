Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOhO4-0000pI-Ri
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:21:20 +0000
Received: from an-out-0708.google.com ([209.85.132.240])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOhNw-000464-TR
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:21:20 +0000
Received: by an-out-0708.google.com with SMTP id c38so2510791ana.37
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 17:21:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907081953.18802.vapier@gentoo.org>
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907081953.18802.vapier@gentoo.org>
Date: Wed, 8 Jul 2009 17:21:11 -0700
Message-ID: <364299f40907081721r5c821cc3s9bf1253b1a9149e9@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Refactor top-level Makefiles,
	modularize 	autoconf logic
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Monday 06 July 2009 20:22:19 Garrett Cooper wrote:
>> 1. Better modularize and separate out the top-level Makefile such that
>> automake logic and top-level targets are better partitioned out, and
>> thus the overall logic and flow is more intuitive.
>> 2. Move help output to README.mk-user.
>> 3. Make $(.DEFAULT_GOAL) vary depending on whether or not the system
>> has been configured, such that typing in make will no longer run all
>> and result in Make errors, but instead will punt back help, thus
>> making LTP more newbie friendly and reducing support requests because
>> people don't RTFM ;)...
>> 4. Begin deprecation of the uclinux* rules, which can be communicated
>> using the UCLINUX=3D[0|1] make env var (like they should have been in
>> the beginning).
>> 5. Add appropriate GPLv2 copyright headers wherever needed.
>>
>> Notes:
>> 1. Requires [PATCH 2/4].
>> 2. Is an evolution of the commentary w.r.t. the config.mk not required
>> for clean patch submitted on Saturday.
>
> you have duplicated copyright notices here too

The Cisco junk is just to pass by our in-house copyright checker, but
I suppose it really doesn't matter anyhow...

> please drop the sleep in the uclinux warning

Ok.

> you seem to export the variables twice

Yeah, I'll look into that.

> there is a $(basename ...) make function so you dont need to use `basenam=
e`

Whoops... forgot about that. Thanks.

> you check SKIP_IDCHECK in some targets ... this is a make var, so using
> ifeq(...) instead is better -- avoids @ and nesting and set -e and other =
crap

Yes, will do.

> the if checking in the clean target seems unnecessary

Uh, no. If someone's root and they specify $(INSTALL_DIR) :=3D / (or
worse, empty), it'll nuke the host machine's entire rootfs. I ran the
build as a non-root user when I ran into that issue -- and quickly
quashed it :)...

> please use "$" to indicate prompts in documentation, not "$$"

Ok.

> for pre/post install hooks, why not declare a common name and everyone use
> that rather than forcing people to declare it. =A0i.e. declare the target=
 "post-
> install-hook" as a .PHONY and always call/depend/etc... on it.

I'm a bit confused by this comment. Can you review to spots in the
patch (when I upload it tonight), so this can be resolved?

> some of your for loops arent using set -e or checking the install exit st=
atus

Ok. I'll review that again. Thanks.

> why cant testcases/kernel/Makefile leverage these .mk files ? =A0the whol=
e point
> was to get away from these custom written jobbies ...

Some of these Makefiles get a bit ugly with the pre- and post- junk...
There are a small number of Makefiles that are haunted by this work,
but then again I did some more rework with the generic_trunk_target
define.

> you're mixing CFLAGS and CPPFLAGS. =A0-I/-D is for CPPFLAGS.

Ok. I thought it was the other way around. Whoops!

> what's this business of every Makefile having to declare MAKE_TARGETS ? =
=A0this
> should be a common default.

It defaults to a wildcard of the .c files in the directory -- hence
the `?=3D'. If that's a bad default, please let me know.

> rather than force everyone to hardcode the default ltp -I inc and -L lib
> paths, these should be added to the global defaults

Agreed. This was just the first stage.

> doing a for loop on a `rm` command is silly. =A0call `rm` once.

Yeah. I should be applying xargs instead of a loop. Calling rm once
may overflow the command line though (like with testcases/bin if it
grows large enough).

> debugging/optimization/warning/stripping flags shouldnt be added in any
> Makefile that is being converted to these common .mk files. =A0same for a=
ny
> DEBUG_XXX flags.

Agreed. I was just duplicating what already existed, hoping that we
could sweep up this stuff after everything was in and the base
infrastructure was stable.

> i dont see the point in declaring empty rules like "install: ;". =A0if th=
ey're
> declared .PHONY, there is no need to add explicit rules to sub Makefiles.

They're there to avoid errors with targets not being found if I'm
running recursive Make rules over the entire directory tree. So, I
agree it's silly, but if you have a better idea, I'm all ears and I'll
get on it ASAP. I'm trying to avoid cramming more variables into the
Make system because it will only generate more confusion...

> clean targets should always delete common things like "*.o". =A0forcing p=
eople
> to have to manually declare these is a waste.

Ok. Once upon a time (~1 year ago) I found a testcase that generated a
.o file which was just as input for a testcase (it was under
testcases/kernel/io somewhere -- maybe the floppy test). Maybe that's
a bug then that should be solved...

Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
