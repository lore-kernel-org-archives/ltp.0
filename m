Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMYn9-0004jL-OW
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:46:23 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMYn5-0004yl-BS
	for ltp-list@lists.sourceforge.net; Fri, 03 Jul 2009 02:46:23 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 2 Jul 2009 22:45:42 -0400
References: <364299f40907021746p3ce4bacdwbfc834ef7e4cfcfd@mail.gmail.com>
	<200907022157.30535.vapier@gentoo.org>
	<364299f40907021900q5a9529favc07f84cd4ffd0d6a@mail.gmail.com>
In-Reply-To: <364299f40907021900q5a9529favc07f84cd4ffd0d6a@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907022245.43330.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 8/10] config.mk not required for clean
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6726937371759180216=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============6726937371759180216==
Content-Type: multipart/signed; boundary="nextPart2343597.F2LAMSyTBZ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2343597.F2LAMSyTBZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 July 2009 22:00:41 Garrett Cooper wrote:
> On Thu, Jul 2, 2009 at 6:57 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Thursday 02 July 2009 21:21:06 Garrett Cooper wrote:
> >> Both sinclude and include are possible I suppose, but as far as I
> >> understand that actually does an fstat, tries to open the file, etc,
> >> but this completely ignores the include statement and reduces I/O a bi=
t.
> >
> > yes, it'll remove a syscall or two, but i dont think that is significant
> > in the larger scheme of things
> >
> > the problem is that i dont want these kind of ifdef things propagating =
as
> > they'll get tweaked and go inconsistent all over the place
> >
> > how about include a top level .mk file that always exists and in there,
> > you have the conditional config.mk include
>
> I couldn't agree more :)...
>
> FWIW using include all over the place has footprint implications
> (somewhere on the order of 2~3 times longer when taxing the fs a bit
> more), so it could be a boon to multijob compiles to go with sinclude
> / -include.

well, if you can see tangible differences, then it's worth discussing.  i d=
ont=20
think the include style would make a difference in this regard at all, it'd=
=20
only change the behavior when the file doesnt exist (warn/error/etc...).

how about we aim for avoiding the include completely regardless of target. =
=20
really config.mk is setting up the environment and recursive makes should b=
e=20
inheriting those.  so if our toplevel .mk exported something like:
LTP_CONFIG_INCLUDED =3D yes

then all the fragments in the sub-makefiles should look like:
ifneq ($(LTP_CONFIG_INCLUDED),yes)
include $(topdir)/config.mk
endif

then you could have the clean target lie by doing:
$(MAKE) -C testcases LTP_CONFIG_INCLUDED=3Dyes clean

which would address all of your concerns ?

> People already complain about compiling LTP in my group -- I'm just
> trying to give them less of a reason to complain :)..

bah, tell them to build it in a tmpfs partition then ;)
=2Dmike

--nextPart2343597.F2LAMSyTBZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTXDXAAoJEEFjO5/oN/WBbCEQAIHm8ORhXeWkxHkAve6oOzlM
wUPhoQfUiC+8q5rV7Q3X55vpsOqHxtZa/UlCpp+LWFQWe0z3ZVh7BETyDJQ/Ulto
p3wFzzRjf43P4rwAAtU+D7b7k8ZfGhdNQi4LyRWqm+j3RIPHBgoUmERtGJa2SSe+
SFtYV6WCC3Z/N2TQ4AZStV/aHx+sE6AEp6Hzq1zvwjIfpsRisun/g9mSAzmtlDue
2U4jMxk/vJeeKh1IJ4R4Kc3CtVwyU6rytOAa9Zvdt7mzHoA1Zb/Hax/ie7k6xxpF
6yvv66vyC3YBFyZNDVygzXc2k3ua/3IOle4VNhx94fSS5Q9Qbqr/db027rD/IzxW
zF0hISOfOnbXz0l/F/Ycll2mLEUcNjo55rgsvfa+usDPixPIGyfUHjmVytJDBjx7
uITzxEn1lq+/6FMZiTHsW+0Kt//B6NLK4w+IlYBq197M1xjydRZtLHmk8V0Jcr01
Vy0gueLe9YkBfXn1EZ1LG6MxNlu9xPSyetrSLF4Vej6vuF0W4Vc9SncuQf74qmwf
w3XjtIimfOwQTmDOUHGbpdaUEHOG3QrrNRhS5OFvbcW7CqyQzAf1J7lVWogBwRvP
TA5WCA3pHGShQOjol8GJpUaErEQXAUiZXSvvKGEiKRdh7kb4DmQRyDM/A2160lZv
Y/MG2SPcMrIibK4xYQ+/
=DqdC
-----END PGP SIGNATURE-----

--nextPart2343597.F2LAMSyTBZ--


--===============6726937371759180216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6726937371759180216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6726937371759180216==--

