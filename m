Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPqKa-0007WL-63
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 04:06:28 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPqKX-0003VI-TF
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 04:06:28 +0000
Received: by pxi27 with SMTP id 27so506036pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 11 Jul 2009 21:06:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40907111455x3cd6187cs39a43add00cca20f@mail.gmail.com>
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907082042.33487.vapier@gentoo.org>
	<364299f40907090208o1c0d5b10kb151e6c910cfa79f@mail.gmail.com>
	<200907092007.58019.vapier@gentoo.org>
	<364299f40907111455x3cd6187cs39a43add00cca20f@mail.gmail.com>
Date: Sat, 11 Jul 2009 21:06:25 -0700
Message-ID: <364299f40907112106j53cd2a75l74d654d6a951ef6c@mail.gmail.com>
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

On Sat, Jul 11, 2009 at 2:55 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> On Thu, Jul 9, 2009 at 5:07 PM, Mike Frysinger<vapier@gentoo.org> wrote:
>> On Thursday 09 July 2009 05:08:22 Garrett Cooper wrote:
>>> On Wed, Jul 8, 2009 at 5:42 PM, Mike Frysinger wrote:
>>> > On Wednesday 08 July 2009 20:21:11 Garrett Cooper wrote:
>>> >> On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger wrote:
>>> > testcases/Makefile:
>>> > i dont get all these xxx_DEPS variables and the install-testcases-bin
>>> > target
>>>
>>> xxx_DEPS aren't used in typical situations. They are used in different
>>> situations where one _must_ preserve dependency ordering. People
>>> should NOT have to use these except with code generation, upper-level
>>> target dependencies (my next stop after this all gets said and done,
>>> e.g. if I do a submake from somewhere within testcases/kernel, I
>>> better well have libltp.a built beforehand :)...), etc.
>>
>> yes, but in the patch you posted, i didnt see why any of those needed to=
 be in
>> the Makefile's in question. =A0i dont have a problem adding knobs, but i=
 do when
>> they're used incorrectly or not at all.
>>
>> i guess i'll wait until your follow up patch to check this stuff again
>>
>>> >> > why cant testcases/kernel/Makefile leverage these .mk files ? =A0t=
he
>>> >> > whole point was to get away from these custom written jobbies ...
>>> >>
>>> >> Some of these Makefiles get a bit ugly with the pre- and post- junk.=
..
>>> >> There are a small number of Makefiles that are haunted by this work,
>>> >> but then again I did some more rework with the generic_trunk_target
>>> >> define.
>>> >
>>> > so that means you'll fix the Makefile to use the .mk files
>>>
>>> Yes. Again, these are bad hacks to work around the fact that these are
>>> initial commits, and the fact that the rest of the source tree isn't
>>> up to date with the new system (that will take ~3 days with straight
>>> work and verification, but I'd quote a week and a half because of
>>> random junk that can get in the way of getting things done). Only in a
>>> few key Makefiles are these hacks required. testcases/Makefile is just
>>> one of these examples. Here's the comment:
>>
>> ok, transitional hacks which are commented should be fine. =A0i dont rec=
all
>> seeing this comment in the patch posted for review though ;).
>>
>>> >> > debugging/optimization/warning/stripping flags shouldnt be added in
>>> >> > any Makefile that is being converted to these common .mk files. =
=A0same
>>> >> > for any DEBUG_XXX flags.
>>> >>
>>> >> Agreed. I was just duplicating what already existed, hoping that we
>>> >> could sweep up this stuff after everything was in and the base
>>> >> infrastructure was stable.
>>> >
>>> > i'd prefer we scrub the crap now
>>>
>>> Yes, but how and when should this stuff be done, and in what way? is
>>> the ultimate question. If I were to toss in every dumb warning
>>> compiler flag imaginable (which believe it or not _is_ the default for
>>> the proprietary code we compile), my group in Cisco would never be
>>> able to compile LTP because of coding issues. How much is enough, and
>>> how much is too little?
>>
>> create a mirrored set of W*FLAG variables in the top level and stick the
>> defaults in there. =A0then all sub level should be punted. =A0for now, u=
se -Wall
>> only. =A0we can save the -Wextra/-Werror/etc... bs for a later date.
>>
>> i.e. the top level .mk should have:
>> WFLAGS ?=3D -Wall
>> WCFLAGS ?=3D $(WFLAGS)
>> WCXXFLAGS ?=3D $(WFLAGS)
>> ...
>> CFLAGS +=3D $(WCFLAGS)
>> CXXFLAGS +=3D $(WCXXFLAGS)
>> ...
>>
>> keep language-dedicated flags available because there are language-speci=
fic
>> warnings that if added to the wrong language, you get even more warnings=
 (gcc
>> warning you that this warning flag is not appropriate ;x)
>>
>>> >> > i dont see the point in declaring empty rules like "install: ;". =
=A0if
>>> >> > they're declared .PHONY, there is no need to add explicit rules to=
 sub
>>> >> > Makefiles.
>>> >>
>>> >> They're there to avoid errors with targets not being found if I'm
>>> >> running recursive Make rules over the entire directory tree. So, I
>>> >> agree it's silly, but if you have a better idea, I'm all ears and I'=
ll
>>> >> get on it ASAP. I'm trying to avoid cramming more variables into the
>>> >> Make system because it will only generate more confusion...
>>> >
>>> > let's look at testcases/kernel/include/Makefile. =A0how would a missi=
ng
>>> > install target here generate an error ?
>>>
>>> testcases/kernel calls install recursively. I don't want to create
>>> annoying subvariables for all, install, clean, and whatever other
>>> recursive target I can think of, because even though I know how to, it
>>> only serves to confuse and complicate the purpose of the system
>>> (that's part of the reason why I'm the only individual, apart from two
>>> others in a team of about 100, who can stumble around our complicated
>>> build system at work).
>>
>> sorry, i'm still not following. =A0why would the default install target =
not work
>> in testcases/kernel/include/Makefile ? =A0if there are no subdirs to rec=
urse
>> into and there are no default targets to compile, what would the default
>> install do exactly ?
>
> The way it was originally designed (by whoever.. dunno who), regen did
> the equivalent to all, and all did the equivalent to install. Pretty
> whacky, but that's the way it was.
>
> I fixed the caller so it doesn't do jack for all, but instead directly
> calls install, like it basically should.
>
> I've had to do a lot of invasive surgery on the build over the past 4
> hours... once I can get it to compile through clean -> all -> install,
> without issues, I'll run a diff check on the generated files and
> resubmit the patch.

Sorry. Finding more and more random arse build issues. I *hope* I can
have a patch out by midnight PST, pending I don't run into too many
weird roadblocks.

So much was being hidden because set -e wasn't being run with certain
sections of the source tree when for-loops were used :(...

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
