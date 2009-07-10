Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MP3ec-0000Vs-RL
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 00:07:54 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MP3eX-0002ky-Sr
	for ltp-list@lists.sourceforge.net; Fri, 10 Jul 2009 00:07:54 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 9 Jul 2009 20:07:57 -0400
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
	<200907082042.33487.vapier@gentoo.org>
	<364299f40907090208o1c0d5b10kb151e6c910cfa79f@mail.gmail.com>
In-Reply-To: <364299f40907090208o1c0d5b10kb151e6c910cfa79f@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907092007.58019.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============8914176737890387989=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============8914176737890387989==
Content-Type: multipart/signed; boundary="nextPart2058470.scZHho7PlM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2058470.scZHho7PlM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 09 July 2009 05:08:22 Garrett Cooper wrote:
> On Wed, Jul 8, 2009 at 5:42 PM, Mike Frysinger wrote:
> > On Wednesday 08 July 2009 20:21:11 Garrett Cooper wrote:
> >> On Wed, Jul 8, 2009 at 4:53 PM, Mike Frysinger wrote:
> > testcases/Makefile:
> > i dont get all these xxx_DEPS variables and the install-testcases-bin
> > target
>
> xxx_DEPS aren't used in typical situations. They are used in different
> situations where one _must_ preserve dependency ordering. People
> should NOT have to use these except with code generation, upper-level
> target dependencies (my next stop after this all gets said and done,
> e.g. if I do a submake from somewhere within testcases/kernel, I
> better well have libltp.a built beforehand :)...), etc.

yes, but in the patch you posted, i didnt see why any of those needed to be=
 in=20
the Makefile's in question.  i dont have a problem adding knobs, but i do w=
hen=20
they're used incorrectly or not at all.

i guess i'll wait until your follow up patch to check this stuff again

> >> > why cant testcases/kernel/Makefile leverage these .mk files ?  the
> >> > whole point was to get away from these custom written jobbies ...
> >>
> >> Some of these Makefiles get a bit ugly with the pre- and post- junk...
> >> There are a small number of Makefiles that are haunted by this work,
> >> but then again I did some more rework with the generic_trunk_target
> >> define.
> >
> > so that means you'll fix the Makefile to use the .mk files
>
> Yes. Again, these are bad hacks to work around the fact that these are
> initial commits, and the fact that the rest of the source tree isn't
> up to date with the new system (that will take ~3 days with straight
> work and verification, but I'd quote a week and a half because of
> random junk that can get in the way of getting things done). Only in a
> few key Makefiles are these hacks required. testcases/Makefile is just
> one of these examples. Here's the comment:

ok, transitional hacks which are commented should be fine.  i dont recall=20
seeing this comment in the patch posted for review though ;).

> >> > debugging/optimization/warning/stripping flags shouldnt be added in
> >> > any Makefile that is being converted to these common .mk files.  same
> >> > for any DEBUG_XXX flags.
> >>
> >> Agreed. I was just duplicating what already existed, hoping that we
> >> could sweep up this stuff after everything was in and the base
> >> infrastructure was stable.
> >
> > i'd prefer we scrub the crap now
>
> Yes, but how and when should this stuff be done, and in what way? is
> the ultimate question. If I were to toss in every dumb warning
> compiler flag imaginable (which believe it or not _is_ the default for
> the proprietary code we compile), my group in Cisco would never be
> able to compile LTP because of coding issues. How much is enough, and
> how much is too little?

create a mirrored set of W*FLAG variables in the top level and stick the=20
defaults in there.  then all sub level should be punted.  for now, use -Wal=
l=20
only.  we can save the -Wextra/-Werror/etc... bs for a later date.

i.e. the top level .mk should have:
WFLAGS ?=3D -Wall
WCFLAGS ?=3D $(WFLAGS)
WCXXFLAGS ?=3D $(WFLAGS)
=2E..
CFLAGS +=3D $(WCFLAGS)
CXXFLAGS +=3D $(WCXXFLAGS)
=2E..

keep language-dedicated flags available because there are language-specific=
=20
warnings that if added to the wrong language, you get even more warnings (g=
cc=20
warning you that this warning flag is not appropriate ;x)

> >> > i dont see the point in declaring empty rules like "install: ;".  if
> >> > they're declared .PHONY, there is no need to add explicit rules to s=
ub
> >> > Makefiles.
> >>
> >> They're there to avoid errors with targets not being found if I'm
> >> running recursive Make rules over the entire directory tree. So, I
> >> agree it's silly, but if you have a better idea, I'm all ears and I'll
> >> get on it ASAP. I'm trying to avoid cramming more variables into the
> >> Make system because it will only generate more confusion...
> >
> > let's look at testcases/kernel/include/Makefile.  how would a missing
> > install target here generate an error ?
>
> testcases/kernel calls install recursively. I don't want to create
> annoying subvariables for all, install, clean, and whatever other
> recursive target I can think of, because even though I know how to, it
> only serves to confuse and complicate the purpose of the system
> (that's part of the reason why I'm the only individual, apart from two
> others in a team of about 100, who can stumble around our complicated
> build system at work).

sorry, i'm still not following.  why would the default install target not w=
ork=20
in testcases/kernel/include/Makefile ?  if there are no subdirs to recurse=
=20
into and there are no default targets to compile, what would the default=20
install do exactly ?
=2Dmike

--nextPart2058470.scZHho7PlM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVoZdAAoJEEFjO5/oN/WBwTcP/RjzEhIVwiEZRielnc1tRUPO
jR7l03vkAIZ/3vPgrj/cuvtovuJ0HNCMC5NiHCpW8eIA+K4j0+QcREv0jKn1L5gq
yG27XGCexhHqfzRKKXFC+ZGzmQSne5Dn8RPOEbp+3Lq5/dCM9nDM7WUilarv+8r+
wJvi0f1qgKWvICYXFZWG7dLrIUJrZf8jaaA3SU36KMB5ECBt/DuqrvlkxXygkcXT
V1idgnN4Q8eJoP2hlMNu+YOCeKw2gyXN37SdhfuWvYDAvskiDKVsTg+aZ9cpIhq5
op6OJB4DtwlGKOkH1xREdrEjKMlunK8qIHPC6IZ9KCOz/CNVYZ7pBji8+N+HfGUJ
7r2MSICNqpxqrMf1/xDzJAGRcnZCOiHnnKavkAU6ioNTG6BCmyf7WF9oGwcwUdpT
YKwhqf456DTxbwYSpigTFk43lpxk6B70fg4+hm0DAcQlGl6z6pGChM+vtEcskVE3
7BECEwUnWl4AaK3FcdoD1aveSSTm8J7YJe+540I4uqE281yAKa1Ehv6emFr+7LQE
601pIdHpeXAOoNif192p+FQgWHvzh/Jq/qTh6H41QE1UNkInSm9pWSviH8ahXFrd
IXdaJz9kZXQR70P1i7xoWsYnHeEBcw+qX01PHaTbUtlXlCQPNeJGl9CPn02Cy6A7
PjdlAZMZJgMGRKiRJa4k
=kzBQ
-----END PGP SIGNATURE-----

--nextPart2058470.scZHho7PlM--


--===============8914176737890387989==
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
--===============8914176737890387989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8914176737890387989==--

