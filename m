Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOpcB-0005ln-Tw
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 09:08:27 +0000
Received: from an-out-0708.google.com ([209.85.132.242])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOpc7-0002Ft-M0
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 09:08:27 +0000
Received: by an-out-0708.google.com with SMTP id c38so4131ana.37
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 02:08:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907082042.33487.vapier@gentoo.org>
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907081953.18802.vapier@gentoo.org>
	<364299f40907081721r5c821cc3s9bf1253b1a9149e9@mail.gmail.com>
	<200907082042.33487.vapier@gentoo.org>
Date: Thu, 9 Jul 2009 02:08:22 -0700
Message-ID: <364299f40907090208o1c0d5b10kb151e6c910cfa79f@mail.gmail.com>
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

On Wed, Jul 8, 2009 at 5:42 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Wednesday 08 July 2009 20:21:11 Garrett Cooper wrote:
>> On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger<vapier@gentoo.org> wrote:
>> > you have duplicated copyright notices here too
>>
>> The Cisco junk is just to pass by our in-house copyright checker, but
>> I suppose it really doesn't matter anyhow...
>
> i also noticed the statements "all rights reserved" ... i dont think those
> have any business being in open source code

Yes. It's going out the door with all stuff I develop. I'll get my
peer to do the same with commits that he's going to do as well.

>> > the if checking in the clean target seems unnecessary
>>
>> Uh, no. If someone's root and they specify $(INSTALL_DIR) :=3D / (or
>> worse, empty), it'll nuke the host machine's entire rootfs. I ran the
>> build as a non-root user when I ran into that issue -- and quickly
>> quashed it :)...
>
> sorry, i meant the "-d" part. =A0besides, all recent distros will refuse =
to run
> something like `rm -rf /` -- the util itself rejects "/".

Key point -- recent distros. We don't know if some person's going to
be running an ancient distro with a 2.4 kernel because I've seen
report requests about that on the list. I'd rather keep the support to
prevent shooting one's self in the foot. Besides, INSTALL_DIR is
DESTDIR =3D "", prefix =3D "". Only if someone's dumb enough NOT to
specify both of these variables (in which case they'll be installing
like /testcases/bin, /lib/libltp.a) will this ever be an issue. And if
someone chooses to shoot themselves in the foot, they can very well do
so by hacking the Makefiles to remove the checks ;)...

The only time that it will error out is with clean, when INSTALL_DIR
isn't set to any value (most of the time when they haven't done
configure).

>> > for pre/post install hooks, why not declare a common name and everyone
>> > use that rather than forcing people to declare it. =A0i.e. declare the
>> > target "post- install-hook" as a .PHONY and always call/depend/etc... =
on
>> > it.
>>>
>> I'm a bit confused by this comment. Can you review to spots in the
>> patch (when I upload it tonight), so this can be resolved?
>
> testcases/kernel/controllers/cpuset/Makefile:
> why must "install" manually depend on pre-install ? =A0that dependency sh=
ould
> always be there leaving the subdir to only have to define the pre-install
> target.

No longer than way anymore ;)...

#
#    kernel/controllers/cpuset testcase suite Makefile.
#
#    Copyright (C) 2009, Cisco Systems Inc.
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Garrett Cooper, July 2009
#

include Makefile.inc

$(eval $(generic_trunk_target))

> testcases/Makefile:
> i dont get all these xxx_DEPS variables and the install-testcases-bin tar=
get

xxx_DEPS aren't used in typical situations. They are used in different
situations where one _must_ preserve dependency ordering. People
should NOT have to use these except with code generation, upper-level
target dependencies (my next stop after this all gets said and done,
e.g. if I do a submake from somewhere within testcases/kernel, I
better well have libltp.a built beforehand :)...), etc.

>> > why cant testcases/kernel/Makefile leverage these .mk files ? =A0the w=
hole
>> > point was to get away from these custom written jobbies ...
>>
>> Some of these Makefiles get a bit ugly with the pre- and post- junk...
>> There are a small number of Makefiles that are haunted by this work,
>> but then again I did some more rework with the generic_trunk_target
>> define.
>
> so that means you'll fix the Makefile to use the .mk files

Yes. Again, these are bad hacks to work around the fact that these are
initial commits, and the fact that the rest of the source tree isn't
up to date with the new system (that will take ~3 days with straight
work and verification, but I'd quote a week and a half because of
random junk that can get in the way of getting things done). Only in a
few key Makefiles are these hacks required. testcases/Makefile is just
one of these examples. Here's the comment:

#
# bin, bin-clean, and install-testcases-bin are only here for compatibility
# until all of the Makefiles properly install files in $(DESTDIR)/$(prefix)=
/...
# using master_rules.mk, and similar behavior is properly emulated in the
# top-level Makefiles for larger components (ballista and open_posix_testsu=
ite
# for instance).
#

This won't be the case in the majority of the hacked Makefiles, once
the children are up-to-date.

>> > what's this business of every Makefile having to declare MAKE_TARGETS ?
>> > =A0this should be a common default.
>>
>> It defaults to a wildcard of the .c files in the directory -- hence
>> the `?=3D'. If that's a bad default, please let me know.
>
> i'm talking about the Makefiles that are setting this variable. =A0i.e.
> testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
> testcases/kernel/fs/proc/Makefile
> tools/Makefile

Zapped.

>> > doing a for loop on a `rm` command is silly. =A0call `rm` once.
>>
>> Yeah. I should be applying xargs instead of a loop. Calling rm once
>> may overflow the command line though (like with testcases/bin if it
>> grows large enough).
>
> if you really want to go that far, but i was looking at
> testcases/kernel/include/Makefile. =A0there's no way that is going to ove=
rflow.
> besides, i guess there shouldnt be a clean target in there anyways -- it
> should be using the default one.

Rewritten.

>> > debugging/optimization/warning/stripping flags shouldnt be added in any
>> > Makefile that is being converted to these common .mk files. =A0same fo=
r any
>> > DEBUG_XXX flags.
>>
>> Agreed. I was just duplicating what already existed, hoping that we
>> could sweep up this stuff after everything was in and the base
>> infrastructure was stable.
>
> i'd prefer we scrub the crap now

Yes, but how and when should this stuff be done, and in what way? is
the ultimate question. If I were to toss in every dumb warning
compiler flag imaginable (which believe it or not _is_ the default for
the proprietary code we compile), my group in Cisco would never be
able to compile LTP because of coding issues. How much is enough, and
how much is too little?

>> > i dont see the point in declaring empty rules like "install: ;". =A0if
>> > they're declared .PHONY, there is no need to add explicit rules to sub
>> > Makefiles.
>>
>> They're there to avoid errors with targets not being found if I'm
>> running recursive Make rules over the entire directory tree. So, I
>> agree it's silly, but if you have a better idea, I'm all ears and I'll
>> get on it ASAP. I'm trying to avoid cramming more variables into the
>> Make system because it will only generate more confusion...
>
> let's look at testcases/kernel/include/Makefile. =A0how would a missing i=
nstall
> target here generate an error ?

testcases/kernel calls install recursively. I don't want to create
annoying subvariables for all, install, clean, and whatever other
recursive target I can think of, because even though I know how to, it
only serves to confuse and complicate the purpose of the system
(that's part of the reason why I'm the only individual, apart from two
others in a team of about 100, who can stumble around our complicated
build system at work).

>> > clean targets should always delete common things like "*.o". =A0forcing
>> > people to have to manually declare these is a waste.
>>
>> Ok. Once upon a time (~1 year ago) I found a testcase that generated a
>> .o file which was just as input for a testcase (it was under
>> testcases/kernel/io somewhere -- maybe the floppy test). Maybe that's
>> a bug then that should be solved...
>
> we should fix that then as that's just craziness

Seems like someone already might have removed it, but I'll keep my
eyes peeled and fix it immediately if it resurfaces.

Thanks,
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
