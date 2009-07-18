Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSH9Q-00047M-E8
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 21:09:00 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSH9H-0002Va-48
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 21:09:00 +0000
Received: by pzk8 with SMTP id 8so1237084pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 18 Jul 2009 14:08:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <200907151254.49595.vapier@gentoo.org>
References: <364299f40907112242j13b7349fued53c53f3f8defee@mail.gmail.com>
	<200907151254.49595.vapier@gentoo.org>
Date: Sat, 18 Jul 2009 14:08:50 -0700
Message-ID: <364299f40907181408y2f56d39bwd4a268cfe634e883@mail.gmail.com>
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

On Wed, Jul 15, 2009 at 9:54 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> On Sunday 12 July 2009 01:42:03 Garrett Cooper wrote:
>> +$(CC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: The system C com=
piler.
>> +
>> +$(CXX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 : The system C++ com=
piler.
>
> should add $(CPP) - the system preprocessor

Done.

>> +$(CFLAGS) =A0 =A0 =A0 =A0 =A0 =A0: Compiler flags.
>
> C compiler flags
>
> should add $(CXXFLAGS) too

Done.

>> +$(LD) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: The library link=
er.
>
> the system linker (typically $(CC))

Here's what I said (instead of the above):

$(LD)                   : The system linker (typically $(CC), but not
                          necessarily).

>> +$(LDFLAGS) =A0 =A0 =A0 =A0 =A0 : What to pass in to the linker, includi=
ng -L arguments
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 and other ld arguments, ap=
art from -l library
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 includes (see $(LDLIBS)).
>
> should note that flags should be in the form given to the compiler driver
> because we arent invoking `ld` -- i.e. -Wl,-foo not -foo

Similar to above...

$(LDFLAGS)              : What to pass in to the linker, including -L argum=
ents
                          and other ld arguments, apart from -l library
                          includes (see $(LDLIBS)).

                          This should be done in the $(CC) args passing sty=
le
                          when LD :=3D $(CC), e.g. `-Wl,-foo', as opposed to
                          `-foo'

>> +$(LDLIBS) =A0 =A0 =A0 =A0 =A0 =A0: Libraries to pass into the linker (e=
.g. -lltp, etc).
>
> s/into/to/

Done. All other instances where I used into instead of to have been
fixed as well.

>> +$(OPT_CFLAGS) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: Optimization flags to pa=
ss into the C compiler, -O2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etc. IF YOU SPECIFY -O2 OR=
 HIGHER, ENSURE THAT YOU
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ALSO SPECIFY -fno-strict-a=
liasing, BECAUSE OF PAST
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OPTIMIZATION GCC BUGS!!!
>
> tr '[:upper:]' '[:lower:]'
>
> do you have any actual examples of this ?

Fixed the all-caps.

Yes, there are a ton, but here are the two most recent ones I brought up:

                          1. tree-optimization/17510
                          2. tree-optimization/39100

Needless to say the gcc folks have not been able to get a stable
tree-optimization checker for more than 2 minor releases from what I'm
seeing.. these bugs have cropped up since 3.3.x, and have appeared in
4.0, 4.2.x (IIRC -- 4.2.1 is the FreeBSD system C compiler), and have
popped up in 4.4. They generally have been fixed swiftly and without
remorse, but for the sake of sanity, the suggestion still stands to
always use -fno-strict-aliasing from FreeBSD, as well as other
software groups due to compiler bugs.

I agree though, if a compiler is sound, using -fstrict-aliasing
should, and could produce broken code if it is indeed broken code --
again, unfortunately the tree optimizer hasn't remained stable long
enough for that to remain the defacto standard.

>> +$(OPT_CXXFLAGS) =A0 =A0 =A0 =A0 =A0 =A0 =A0: Optimization flags to pass=
 into the C++ compiler.
>
> s/into/to/

Done.

>> +$(RANLIB) =A0 =A0 =A0 =A0 =A0 =A0: What to run after archiving a librar=
y.
>
> the archive indexer

Done.

>> +# Replace [options] with any make specific options and variables, for e=
ach
>> +# step, example: -j 4, DESTDIR=3D/path/for/install, etc.
>> +make ac-clean ac-maintainer-clean distclean maintainer-clean [options]
>
> there should be no need to run these targets. =A0"maintainer-clean" shoul=
d imply
> all of these other targets.

Done. Thanks for the note :)!

>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +Other Errata
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>> +
>> +- This system (in its current form) supports cross-compilation out of a
>> single +directory. Object directory support will be completed soon to
>> properly enable +cross-compilation. This is required to avoid sporadic
>> Make-related errors.
>
> i have no idea what you're talking about here

The first phase of the work was to resolve outstanding issues with
structure. Then after that's fixed the whole objects being produced in
the same directory as the source files issue can be resolved, THUS my
group can finally build two different copies of LTP _in-parallel_,
with the same workspace, provided they specify the right variables in
their make call.

>> +# Where's the root source directory?
>> +top_srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D $(abspath $(top_src=
dir))
>> +# Where's the source located at?
>> +srcdir =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D=
 .
>> +# Where's the root object directory?
>> +builddir =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ?=3D $(srcdir)
>
> need a top_builddir too

Ah, good catch. Done.

>> +# Where are we currently located in the object and source tree?
>> +relpath =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D=
 $(subst $(abs_builddir),,$(CURDIR))
>
> is this actually necessary ?

relpath is what calculates how to make it back up the tree (basically
calculating top_builddir, on the fly I suppose)... probably isn't
needed now though.

>> +all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
>> +
>> +clean: $$(CLEAN_DEPS)
>> + =A0 =A0 -$(RM) -f $$(CLEAN_TARGETS)
>> +
>> +pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
>> +
>> +install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
>
> so why do we need these _DEPS vars ? =A0do you need the $(MAKE_DEPS) to be
> processed before $(MAKE_TARGETS) ?

Yes. The point is to force in-order dependencies, e.g.

If I need to install a file, I'll do a bunch of prereq steps first,
then once they all complete, I'll go on to generate the file and
install it.

> at least for the clean target, it'd be easier to write it:
> clean::
> =A0 =A0 =A0 =A0$(RM) -f $$(CLEAN_TARGETS)

Yeah, that's true. It just makes specifying the recursive targets a
PITA (can't mix :: with :), but then again all recursive targets
should have a clean. If not, they're broken.

> and then people can just define their own "clean::" in their makefile to =
do
> whatever they want. =A0be nice if we could use this method for all the ta=
rgets.

Yeah, but that was the point of *_DEPS.

*_DEPS is for PHONY targets.
*_TARGETS is for _real_ files.

The purpose is that PHONY targets are always executed -- something
that may or may not be a good idea, but it forces evaluation and
regeneration on the fly, which can be a big plus for what we're trying
to accomplish as far as generating a series of files is concerned
(testcases/kernel/include's regen target, for example).

You can define MAKE_TARGETS generation, based on an actual target, but
the point was to ween people off of Makefiles that are all over the
map as far as style goes because it makes maintenance a serious PITA.

If they _really_ want that behavior anyhow, they can always just
completely skip defining MAKE_DEPS, as it will evaluate to an empty
value :).

HTH and Thanks!
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
