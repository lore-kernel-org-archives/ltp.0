Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSJK7-0007AW-4n
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 23:28:11 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSJK2-0004ZW-8j
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 23:28:11 +0000
Received: by pzk8 with SMTP id 8so1267218pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 16:28:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907181845.49744.vapier@gentoo.org>
References: <364299f40907112242j13b7349fued53c53f3f8defee@mail.gmail.com>
	<200907151254.49595.vapier@gentoo.org>
	<364299f40907181408y2f56d39bwd4a268cfe634e883@mail.gmail.com>
	<200907181845.49744.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 16:19:59 -0700
Message-ID: <364299f40907181619u24d79760x2413ed4ee61f001a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 3/4] Make system enhancements, Draft 2
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

On Sat, Jul 18, 2009 at 3:45 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Saturday 18 July 2009 17:08:50 Garrett Cooper wrote:
>> On Wed, Jul 15, 2009 at 9:54 AM, Mike Frysinger<vapier@gentoo.org> wrote:
>> > On Sunday 12 July 2009 01:42:03 Garrett Cooper wrote:
>> >> +$(LD) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: The library l=
inker.
>> >
>> > the system linker (typically $(CC))
>>
>> Here's what I said (instead of the above):
>>
>> $(LD) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : The system linker (typically=
 $(CC), but not
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 necessarily).
>
> The system linker (this *should* be the same as $(CC))
>
> i cant think of any reason that the source would *need* to invoke `ld`
> directly rather than letting `gcc` do the linking, but i can think of many
> cases where doing so will screw up edge cases. =A0we should fix places th=
at
> invoke `ld` directly.

This doesn't happen anywhere today, thankfully. I'll change the comment the=
n.

>> >> +$(OPT_CFLAGS) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: Optimization flags to=
 pass into the C
>> >> compiler, -O2, + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etc. IF =
YOU SPECIFY -O2 OR
>> >> HIGHER, ENSURE THAT YOU + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ALSO SPECIFY
>> >> -fno-strict-aliasing, BECAUSE OF PAST +
>> >> OPTIMIZATION GCC BUGS!!!
>> >
>> > tr '[:upper:]' '[:lower:]'
>> >
>> > do you have any actual examples of this ?
>>
>> Yes, there are a ton, but here are the two most recent ones I brought up:
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1. tree-optimization=
/17510
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2. tree-optimization=
/39100
>>
>> Needless to say the gcc folks have not been able to get a stable
>> tree-optimization checker for more than 2 minor releases from what I'm
>> seeing.. these bugs have cropped up since 3.3.x, and have appeared in
>> 4.0, 4.2.x (IIRC -- 4.2.1 is the FreeBSD system C compiler), and have
>> popped up in 4.4. They generally have been fixed swiftly and without
>> remorse, but for the sake of sanity, the suggestion still stands to
>> always use -fno-strict-aliasing from FreeBSD, as well as other
>> software groups due to compiler bugs.
>
> the software groups i see that recommend that do so because their code is
> broken and they havent figured out how to fix it properly yet

Yeah, perhaps.

>> I agree though, if a compiler is sound, using -fstrict-aliasing
>> should, and could produce broken code if it is indeed broken code --
>> again, unfortunately the tree optimizer hasn't remained stable long
>> enough for that to remain the defacto standard.
>
> sounds like the FreeBSD guys just keep picking the wrong major versions. =
=A04.0
> and 4.2 were awful choices -- many distros simply skipped them because th=
ey
> had so many bugs in general. =A0that is why most Linux distros went 3.4 -=
> 4.1 -
>> 4.3.

Well, they haven't (and most likely won't) jump to 4.3+ for licensing
reasons, but that's a different story for a different forum.

> i would change the warning to include the word "should"

Ok.

>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +Other Errata
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> >> +
>> >> +- This system (in its current form) supports cross-compilation out o=
f a
>> >> single +directory. Object directory support will be completed soon to
>> >> properly enable +cross-compilation. This is required to avoid sporadic
>> >> Make-related errors.
>> >
>> > i have no idea what you're talking about here
>>
>> The first phase of the work was to resolve outstanding issues with
>> structure. Then after that's fixed the whole objects being produced in
>> the same directory as the source files issue can be resolved, THUS my
>> group can finally build two different copies of LTP _in-parallel_,
>> with the same workspace, provided they specify the right variables in
>> their make call.
>
> yes, but i dont see how full out-of-tree build support is related to (1)
> "properly enable cross-compilation" or (2) "avoid sporadic Make-related
> errors". =A0cross-compilation is supported today already and i dont see y=
our
> patches changing that. =A0i dont see any sporadic make-related errors eit=
her
> today, and your patch shouldnt change that.

Yeah, I meant out-of-tree build support... I keep on mixing those two
terms up -_-...

> or are you just being pessimistic that your patches will break some edge =
case
> Makefiles ?

Eh? I'm making sure that it doesn't by testing beforehand, but yes,
there's some fixing that will follow after these are completed.

>> >> +# Where are we currently located in the object and source tree?
>> >> +relpath =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=
=3D $(subst
>> >> $(abs_builddir),,$(CURDIR))
>> >
>> > is this actually necessary ?
>>
>> relpath is what calculates how to make it back up the tree (basically
>> calculating top_builddir, on the fly I suppose)... probably isn't
>> needed now though.
>
> i also couldnt seem to find any references to $(relpath) ...

I nuked it.

>> >> +all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
>> >> +
>> >> +clean: $$(CLEAN_DEPS)
>> >> + =A0 =A0 -$(RM) -f $$(CLEAN_TARGETS)
>> >> +
>> >> +pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
>> >> +
>> >> +install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
>> >
>> > so why do we need these _DEPS vars ? =A0do you need the $(MAKE_DEPS) t=
o be
>> > processed before $(MAKE_TARGETS) ?
>>
>> Yes. The point is to force in-order dependencies, e.g.
>>
>> If I need to install a file, I'll do a bunch of prereq steps first,
>> then once they all complete, I'll go on to generate the file and
>> install it.
>
> i dont think make operates the way you're expecting. =A0the form is:
> targets : prerequisites | order-only prerequisites
>
> and the dependencies of the targets can be processed in parallel. =A0so by
> putting the deps and the targets together, you've said make may process t=
hose
> in parallel if it so chooses ... which sort of defeats the point. =A0and =
the
> prerequisite part means any updated dependencies do not force updating of=
 the
> targets in question ... which might be your intention ...
>
> i think you actually want:
> $(MAKE_TARGETS): | $(MAKE_DEPS)

Hrmmmm... ok. I was goofing it up from the start then ><.. thanks for
the clarification on that.

>> > at least for the clean target, it'd be easier to write it:
>> > clean::
>> > =A0 =A0 =A0 =A0$(RM) -f $$(CLEAN_TARGETS)
>>
>> Yeah, that's true. It just makes specifying the recursive targets a
>> PITA (can't mix :: with :), but then again all recursive targets
>> should have a clean. If not, they're broken.
>
> using double colon rules should hopefully allow us to be more proactive in
> weeding out these bad apples though right ?

True, but in the beginning it's going to be wide-spread breakage.

>> > and then people can just define their own "clean::" in their makefile =
to
>> > do whatever they want. =A0be nice if we could use this method for all =
the
>> > targets.
>>
>> Yeah, but that was the point of *_DEPS.
>>
>> *_DEPS is for PHONY targets.
>> *_TARGETS is for _real_ files.
>
> these notes should be in the .mk file as well

Ok.

>> The purpose is that PHONY targets are always executed -- something
>> that may or may not be a good idea, but it forces evaluation and
>> regeneration on the fly, which can be a big plus for what we're trying
>> to accomplish as far as generating a series of files is concerned
>> (testcases/kernel/include's regen target, for example).
>
> i think you misinterpret the point of the regen target. =A0it exists so i=
 could
> run `make regen` regardless of dependencies (i.e. *force* a regen). =A0it=
 does
> not come into play at any other time though -- the normal `make` should n=
ot
> force a regeneration of the header file unless the dependencies were upda=
ted.

Yeah, I suppose so.

>> You can define MAKE_TARGETS generation, based on an actual target, but
>> the point was to ween people off of Makefiles that are all over the
>> map as far as style goes because it makes maintenance a serious PITA.
>>
>> If they _really_ want that behavior anyhow, they can always just
>> completely skip defining MAKE_DEPS, as it will evaluate to an empty
>> value :).
>
> i guess we can do the conversion of the tree and then go back and evaluat=
e if
> these _DEPS are truly necessary, and if so, how we can architect them in
> simpler terms.

Yes, because in most cases these variables aren't needed, by it helps
define prerequisite ordering (at least in my mind :\...).

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
