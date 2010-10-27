Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PBAQ9-0008Ca-B2
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 18:08:21 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PBAQ8-0005v9-73
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 18:08:21 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 27 Oct 2010 14:06:51 -0400
References: <AANLkTimEXJFo6vDOxKb_Q=_F92Rcr_xU289N18M6khVu@mail.gmail.com>
	<AANLkTimC09CBkscKJvpFTRhs2GuXc0MwiV9GLLVZEb5p@mail.gmail.com>
In-Reply-To: <AANLkTimC09CBkscKJvpFTRhs2GuXc0MwiV9GLLVZEb5p@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201010271406.52236.vapier@gentoo.org>
Subject: Re: [LTP] Shell usage on embedded targets
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3876778846460612133=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: David Peverley <pev@sketchymonkey.com>

--===============3876778846460612133==
Content-Type: multipart/signed; boundary="nextPart1537858.YUiX20CjzU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1537858.YUiX20CjzU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday, October 27, 2010 07:34:14 Garrett Cooper wrote:
> On Wed, Oct 27, 2010 at 4:24 AM, David Peverley wrote:
> > In our embedded rootfs we have both /bin/sh provided by busybox (i.e.
> > a true sh) and also a /bin/bash compiled from bash.
>=20
>     busybox sh is based off ash (which forked off BSD's /bin/sh,
> IIRC), but it looks like they stripped away a lot of effective
> features in /bin/sh, in an effort to try and trim down the size of the
> rootfs. Pity, because it cripples the shell interpreter.

not really true.  busybox may be either ash or hush.  the latter is the onl=
y=20
option for NOMMU systems (like my Blackfin board).  no way in hell somethin=
g=20
like bash is going to work on a NOMMU system.

>     Who knows if they've been trying to import bugfixes or make it
> POSIX compliant either.

i think it's diverged too far for most bugfixes to be useful.  but both she=
lls=20
absolutely strive for POSIX compliance.  if something is in POSIX but doesn=
t=20
work with the busybox shells, then a bug should be filed so it can be fixed.

> > This causes a pain as typically full systems use a symlink from sh to
> > bash.
>=20
>    Actually it's hardlinked in proper configurations that I've run
> into. Symlinking allows for naughtiness.

most i see use symlinks.  i dont think there's any realistic differences=20
between the two.

> > This breaks runltp (and probably other scritps) as they use
> > getopts which I *think* is technically a bash-only builtin?
>=20
>    Wrong. It's a POSIX shell built-in:
> http://www.opengroup.org/onlinepubs/009695399/utilities/getopts.html .

it isnt required to be a shell built in, but generally it is ... busybox's =
ash=20
implementation does it this way

> > I've currently re-written the hashbangs before copying to the system. F=
or
> > those googling I did :
> >   find . -type f | xargs perl -pi -e 's/bin\/sh/bin\/bash/g'
> >=20
> > I can't get my head around what a 'neat' solution would be other than
> > rewriting all to bash but I'm guessing that isn't a favoured choice
> > for most people? I would expect a fair response would be "don't do odd
> > things with your target" ;-)
>=20
>    Or maybe you should just hardlink /bin/bash to /bin/sh like most
> Linux targets (or spoof a non-Busybox based environment with a
> chrooted env with /bin/bash setup as /bin/sh)? This isn't ideal, but
> unless you have access to a /bin/sh that's can do POSIX compliant
> shell constructs you're kind of SoL with LTP.

if the person who configured their busybox shell didnt enable getopts suppo=
rt,=20
they screwed up and this is their problem.  if the busybox getopts isnt=20
conforming to the POSIX spec, then the person hitting the problem should (1=
)=20
make sure they're using the latest busybox release and (2) file a bug at=20
bugs.busybox.net.
=2Dmike

--nextPart1537858.YUiX20CjzU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMyGo8AAoJEEFjO5/oN/WBtiIQAIUBK4d6JwxDD9ZnGnyDlgTG
Zs0i/VoX5iPu9cpuLbFgAPR5nt+PGna7Pt1wRcCrGGLMvy+v58vbp2Yc32rMwRtT
GL+otbW1nVu/a+lp/mdx9cRddcf/9c1vA9B9GtQVFKn22FKb9jfFPwtglfmIarjv
V0Vvi3zdfoqCRsBYmXls595CCnwJMGpVWkn/hN0VIKTcQUirntAvEcapqf7F/aE3
s4BeqcN7BKZD0GLCU481iDiTZ4HAie6zdBsDFonrKIgzQxjgUWx8SXPVH2MoVHrv
V2mdDAfk+s9Rf8UscIkUjfJD026y6zRiNBgmKG0jiGrIdrZPwxDRJKKpZH8iojGD
2j5Fb/y4eJGQstX/KnROhDRWn3OUCVd2IfUAmrJI9+TKpZP5MdwtgDAVNGS71pj1
fVH9g7pBIjpG19wkHfD3hLDjzrTR29vXO7i8K9TRn8hW3UzI7BNHBIsgygu0iqMT
YvbYGfJQ0/u3tBHttD3wd90eaWVVN8J/ezdO0OXe5pYejil71DJZKL23/1EmenBU
N8ymAJkwOPGSfEsdbHxPOZPRRNgH4Hsu66PHuaA9D8Z3LiXR3cwgQeBC8gaZpJlW
y/AUbIBP9RtKJSiPKU+UDZNBptD36QsF4zC7Kz/MoOF9TZhil8Ol1uov9YwKx7jy
9K4h53E/YNkyAV30bt6u
=PAZ6
-----END PGP SIGNATURE-----

--nextPart1537858.YUiX20CjzU--


--===============3876778846460612133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
--===============3876778846460612133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3876778846460612133==--

