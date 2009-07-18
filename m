Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MSJ7m-00033a-Vz
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 23:15:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSJ7g-0003li-Q7
	for ltp-list@lists.sourceforge.net; Sat, 18 Jul 2009 23:15:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 18 Jul 2009 18:45:48 -0400
References: <364299f40907112242j13b7349fued53c53f3f8defee@mail.gmail.com>
	<200907151254.49595.vapier@gentoo.org>
	<364299f40907181408y2f56d39bwd4a268cfe634e883@mail.gmail.com>
In-Reply-To: <364299f40907181408y2f56d39bwd4a268cfe634e883@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907181845.49744.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============1224318421434984652=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============1224318421434984652==
Content-Type: multipart/signed; boundary="nextPart6947976.fU53OVK1YR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6947976.fU53OVK1YR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 18 July 2009 17:08:50 Garrett Cooper wrote:
> On Wed, Jul 15, 2009 at 9:54 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Sunday 12 July 2009 01:42:03 Garrett Cooper wrote:
> >> +$(LD)                        : The library linker.
> >
> > the system linker (typically $(CC))
>
> Here's what I said (instead of the above):
>
> $(LD)                   : The system linker (typically $(CC), but not
>                           necessarily).

The system linker (this *should* be the same as $(CC))

i cant think of any reason that the source would *need* to invoke `ld`=20
directly rather than letting `gcc` do the linking, but i can think of many=
=20
cases where doing so will screw up edge cases.  we should fix places that=20
invoke `ld` directly.

> >> +$(OPT_CFLAGS)                : Optimization flags to pass into the C
> >> compiler, -O2, +                       etc. IF YOU SPECIFY -O2 OR
> >> HIGHER, ENSURE THAT YOU +                       ALSO SPECIFY
> >> -fno-strict-aliasing, BECAUSE OF PAST +                     =20
> >> OPTIMIZATION GCC BUGS!!!
> >
> > tr '[:upper:]' '[:lower:]'
> >
> > do you have any actual examples of this ?
>
> Yes, there are a ton, but here are the two most recent ones I brought up:
>
>                           1. tree-optimization/17510
>                           2. tree-optimization/39100
>
> Needless to say the gcc folks have not been able to get a stable
> tree-optimization checker for more than 2 minor releases from what I'm
> seeing.. these bugs have cropped up since 3.3.x, and have appeared in
> 4.0, 4.2.x (IIRC -- 4.2.1 is the FreeBSD system C compiler), and have
> popped up in 4.4. They generally have been fixed swiftly and without
> remorse, but for the sake of sanity, the suggestion still stands to
> always use -fno-strict-aliasing from FreeBSD, as well as other
> software groups due to compiler bugs.

the software groups i see that recommend that do so because their code is=20
broken and they havent figured out how to fix it properly yet

> I agree though, if a compiler is sound, using -fstrict-aliasing
> should, and could produce broken code if it is indeed broken code --
> again, unfortunately the tree optimizer hasn't remained stable long
> enough for that to remain the defacto standard.

sounds like the FreeBSD guys just keep picking the wrong major versions.  4=
=2E0=20
and 4.2 were awful choices -- many distros simply skipped them because they=
=20
had so many bugs in general.  that is why most Linux distros went 3.4 -> 4.=
1 -
> 4.3.

i would change the warning to include the word "should"

> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> +Other Errata
> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >> +
> >> +- This system (in its current form) supports cross-compilation out of=
 a
> >> single +directory. Object directory support will be completed soon to
> >> properly enable +cross-compilation. This is required to avoid sporadic
> >> Make-related errors.
> >
> > i have no idea what you're talking about here
>
> The first phase of the work was to resolve outstanding issues with
> structure. Then after that's fixed the whole objects being produced in
> the same directory as the source files issue can be resolved, THUS my
> group can finally build two different copies of LTP _in-parallel_,
> with the same workspace, provided they specify the right variables in
> their make call.

yes, but i dont see how full out-of-tree build support is related to (1)=20
"properly enable cross-compilation" or (2) "avoid sporadic Make-related=20
errors".  cross-compilation is supported today already and i dont see your=
=20
patches changing that.  i dont see any sporadic make-related errors either=
=20
today, and your patch shouldnt change that.

or are you just being pessimistic that your patches will break some edge ca=
se=20
Makefiles ?

> >> +# Where are we currently located in the object and source tree?
> >> +relpath                              :=3D $(subst
> >> $(abs_builddir),,$(CURDIR))
> >
> > is this actually necessary ?
>
> relpath is what calculates how to make it back up the tree (basically
> calculating top_builddir, on the fly I suppose)... probably isn't
> needed now though.

i also couldnt seem to find any references to $(relpath) ...

> >> +all: | $$(MAKE_DEPS) $$(MAKE_TARGETS)
> >> +
> >> +clean: $$(CLEAN_DEPS)
> >> +     -$(RM) -f $$(CLEAN_TARGETS)
> >> +
> >> +pre-install: | $$(INSTALL_PATH) $$(PREINSTALL_DEPS)
> >> +
> >> +install: | $$(INSTALL_FILES) $$(POSTINSTALL_DEPS)
> >
> > so why do we need these _DEPS vars ?  do you need the $(MAKE_DEPS) to be
> > processed before $(MAKE_TARGETS) ?
>
> Yes. The point is to force in-order dependencies, e.g.
>
> If I need to install a file, I'll do a bunch of prereq steps first,
> then once they all complete, I'll go on to generate the file and
> install it.

i dont think make operates the way you're expecting.  the form is:
targets : prerequisites | order-only prerequisites

and the dependencies of the targets can be processed in parallel.  so by=20
putting the deps and the targets together, you've said make may process tho=
se=20
in parallel if it so chooses ... which sort of defeats the point.  and the=
=20
prerequisite part means any updated dependencies do not force updating of t=
he=20
targets in question ... which might be your intention ...

i think you actually want:
$(MAKE_TARGETS): | $(MAKE_DEPS)

> > at least for the clean target, it'd be easier to write it:
> > clean::
> >        $(RM) -f $$(CLEAN_TARGETS)
>
> Yeah, that's true. It just makes specifying the recursive targets a
> PITA (can't mix :: with :), but then again all recursive targets
> should have a clean. If not, they're broken.

using double colon rules should hopefully allow us to be more proactive in=
=20
weeding out these bad apples though right ?

> > and then people can just define their own "clean::" in their makefile to
> > do whatever they want.  be nice if we could use this method for all the
> > targets.
>
> Yeah, but that was the point of *_DEPS.
>
> *_DEPS is for PHONY targets.
> *_TARGETS is for _real_ files.

these notes should be in the .mk file as well

> The purpose is that PHONY targets are always executed -- something
> that may or may not be a good idea, but it forces evaluation and
> regeneration on the fly, which can be a big plus for what we're trying
> to accomplish as far as generating a series of files is concerned
> (testcases/kernel/include's regen target, for example).

i think you misinterpret the point of the regen target.  it exists so i cou=
ld=20
run `make regen` regardless of dependencies (i.e. *force* a regen).  it doe=
s=20
not come into play at any other time though -- the normal `make` should not=
=20
force a regeneration of the header file unless the dependencies were update=
d.

> You can define MAKE_TARGETS generation, based on an actual target, but
> the point was to ween people off of Makefiles that are all over the
> map as far as style goes because it makes maintenance a serious PITA.
>
> If they _really_ want that behavior anyhow, they can always just
> completely skip defining MAKE_DEPS, as it will evaluate to an empty
> value :).

i guess we can do the conversion of the tree and then go back and evaluate =
if=20
these _DEPS are truly necessary, and if so, how we can architect them in=20
simpler terms.
=2Dmike

--nextPart6947976.fU53OVK1YR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKYlCdAAoJEEFjO5/oN/WBt6wP/iFRZ/WK8zkzHJNTzswcvneY
KaGUa9c9VRVsWBTR3TI2+eyegzOmLFmloEjiPNMHuq+S0ujjZxbaxVvfwlVyo6cz
7sY8JJpI6bWCB/2x/Nnjb6bfQwLsSiI4BuzvcdFAYBMF4xHXtjr69dr3GVTvDWMl
v03kopI4te1tdgaUg2C0ubV12LTi1iz2YGriMzDnMxih2JKe2Pw0UuyZLFNWHw/Q
MxwuxwdMygFna2U30dXZKn6aZJtqsG06NQwo0EGiu8PvOaMDtwmN3HcJwl1A+8PL
/0zrYi72X5lK66VeuproSYG8dyQC4ryTRuTOLBDGJdTHRYutosc8VxAIYKc04rGh
ef7pPXcp82wQZ2xNhkCUmVsbQhYM6k+RUTajxdqtrBfVaaa6iG5yYHGQv1I+7kDF
KkxldUTgQgyBcDPy1o0r6k6+0UlOyMGMHvf9JIM705ctpIjO7gxGvn9DcuGaS45R
mW/iOF9/ZjR/TITR4FvrdeX7WfTpKF+AoBuez6b7RHvGGJFR4qey0M6V0p6/KsK4
lSDfnmIFy1x/3FmG2sMXUFZXpqBc0nlpAmJhBktixH/TI1ifv6ltlDMF4pv8vXjA
M6SyK/MysYtjvyeEOCnMUe66QOMz4gMmcEMLVmQlUAChYc1/XKyGeoPafZFiSloX
KPFw5QB1UotDu+EoO4BF
=o2Nv
-----END PGP SIGNATURE-----

--nextPart6947976.fU53OVK1YR--


--===============1224318421434984652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============1224318421434984652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1224318421434984652==--

