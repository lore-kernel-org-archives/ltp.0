Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOhie-0006MZ-CF
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:42:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOhiX-0000wt-2X
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:42:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 Jul 2009 20:42:32 -0400
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907081953.18802.vapier@gentoo.org>
	<364299f40907081721r5c821cc3s9bf1253b1a9149e9@mail.gmail.com>
In-Reply-To: <364299f40907081721r5c821cc3s9bf1253b1a9149e9@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907082042.33487.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 3/4] Refactor top-level Makefiles,
	modularize autoconf logic
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5074799619738866099=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5074799619738866099==
Content-Type: multipart/signed; boundary="nextPart3932247.XmPY1B2H6y";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3932247.XmPY1B2H6y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 08 July 2009 20:21:11 Garrett Cooper wrote:
> On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> > you have duplicated copyright notices here too
>
> The Cisco junk is just to pass by our in-house copyright checker, but
> I suppose it really doesn't matter anyhow...

i also noticed the statements "all rights reserved" ... i dont think those=
=20
have any business being in open source code

> > the if checking in the clean target seems unnecessary
>
> Uh, no. If someone's root and they specify $(INSTALL_DIR) :=3D / (or
> worse, empty), it'll nuke the host machine's entire rootfs. I ran the
> build as a non-root user when I ran into that issue -- and quickly
> quashed it :)...

sorry, i meant the "-d" part.  besides, all recent distros will refuse to r=
un=20
something like `rm -rf /` -- the util itself rejects "/".

> > for pre/post install hooks, why not declare a common name and everyone
> > use that rather than forcing people to declare it.  i.e. declare the
> > target "post- install-hook" as a .PHONY and always call/depend/etc... on
> > it.
>
> I'm a bit confused by this comment. Can you review to spots in the
> patch (when I upload it tonight), so this can be resolved?

testcases/kernel/controllers/cpuset/Makefile:
why must "install" manually depend on pre-install ?  that dependency should=
=20
always be there leaving the subdir to only have to define the pre-install=20
target.

testcases/Makefile:
i dont get all these xxx_DEPS variables and the install-testcases-bin target

> > why cant testcases/kernel/Makefile leverage these .mk files ?  the whole
> > point was to get away from these custom written jobbies ...
>
> Some of these Makefiles get a bit ugly with the pre- and post- junk...
> There are a small number of Makefiles that are haunted by this work,
> but then again I did some more rework with the generic_trunk_target
> define.

so that means you'll fix the Makefile to use the .mk files

> > what's this business of every Makefile having to declare MAKE_TARGETS ?
> >  this should be a common default.
>
> It defaults to a wildcard of the .c files in the directory -- hence
> the `?=3D'. If that's a bad default, please let me know.

i'm talking about the Makefiles that are setting this variable.  i.e.
testcases/kernel/controllers/cpuset/cpuset_syscall_test/Makefile
testcases/kernel/fs/proc/Makefile
tools/Makefile

> > doing a for loop on a `rm` command is silly.  call `rm` once.
>
> Yeah. I should be applying xargs instead of a loop. Calling rm once
> may overflow the command line though (like with testcases/bin if it
> grows large enough).

if you really want to go that far, but i was looking at=20
testcases/kernel/include/Makefile.  there's no way that is going to overflo=
w. =20
besides, i guess there shouldnt be a clean target in there anyways -- it=20
should be using the default one.

> > debugging/optimization/warning/stripping flags shouldnt be added in any
> > Makefile that is being converted to these common .mk files.  same for a=
ny
> > DEBUG_XXX flags.
>
> Agreed. I was just duplicating what already existed, hoping that we
> could sweep up this stuff after everything was in and the base
> infrastructure was stable.

i'd prefer we scrub the crap now

> > i dont see the point in declaring empty rules like "install: ;".  if
> > they're declared .PHONY, there is no need to add explicit rules to sub
> > Makefiles.
>
> They're there to avoid errors with targets not being found if I'm
> running recursive Make rules over the entire directory tree. So, I
> agree it's silly, but if you have a better idea, I'm all ears and I'll
> get on it ASAP. I'm trying to avoid cramming more variables into the
> Make system because it will only generate more confusion...

let's look at testcases/kernel/include/Makefile.  how would a missing insta=
ll=20
target here generate an error ?

> > clean targets should always delete common things like "*.o".  forcing
> > people to have to manually declare these is a waste.
>
> Ok. Once upon a time (~1 year ago) I found a testcase that generated a
> .o file which was just as input for a testcase (it was under
> testcases/kernel/io somewhere -- maybe the floppy test). Maybe that's
> a bug then that should be solved...

we should fix that then as that's just craziness
=2Dmike

--nextPart3932247.XmPY1B2H6y
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVTz5AAoJEEFjO5/oN/WBxtUP/2+d7SK71b1PpICJ6Ak900Xn
v3uj7rsoDTHPBgn9k0/3wJiEchY/io7ml9XPmTxVj5oWbRo+X37mzr+rBrnUqISm
qLIQ8NpNkRlmEWQOdprX4htB81zMy4qxcyBYGjfzPtfLLCVxcpP0MW0AYfAcx6yg
MdzNAxq6ypX6dNlh9wOZ4DBZa3Oq7xnW7IYW3fyiIJUhrxYtuI+3/JA2W/xgT8mZ
qug7aFO1ootiY0xmIsB+m0BZB0r77jveUBqtyxYisWHZdLBZbtmA5hboNaa+2obX
4IN4GYsBxjunf9WEVjzEi0glJ7DqxsVgbTUUmLU0YS0N94FR75G28o5xw3BNgnnW
T/KZkOEsyCVm/3aD0FGZjOZFbffoqr/A+xNGw0shngwoOHBqVF3vtXl9WVyoiH9o
ysS7yrBdVT9q1nfDXG9hfI2A8nmiCZKREcKJ1qx2Olx+bbxMep9EmoZ06d0slC57
I9BkP9vWY54/342Ki+HEJvMjKo/ad3lU0JhB6Piv5mxIOYwwmvPvs1iLjH+Iz0cT
V/zdUcX11ysgSN+1qHIWhhH4BO+bhVL/xlqlzt9izqlRz5ci3nnRmVTzLrYg5KPz
3awG9CPGavEsiOsU5hzjfgZrqqlSY889COHOPirOU4rDcQ2BWHLMfvwrv3ij49gy
qvkNLib1ekEy1liWrj3I
=Uyiq
-----END PGP SIGNATURE-----

--nextPart3932247.XmPY1B2H6y--


--===============5074799619738866099==
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
--===============5074799619738866099==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5074799619738866099==--

