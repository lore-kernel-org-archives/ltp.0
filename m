Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MAWsQ-0004za-MX
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 22:18:06 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MAWsP-0001pn-C9
	for ltp-list@lists.sourceforge.net; Sat, 30 May 2009 22:18:06 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 30 May 2009 18:16:30 -0400
References: <4A1E5847.6030807@petalogix.com>
	<200905290912.31947.vapier@gentoo.org>
	<4A2142A0.2040301@petalogix.com>
In-Reply-To: <4A2142A0.2040301@petalogix.com>
MIME-Version: 1.0
Message-Id: <200905301816.32273.vapier@gentoo.org>
Subject: Re: [LTP] Installing outside LTP source
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5673330161888521677=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: LTP <ltp-list@lists.sourceforge.net>, Jiri Palecek <jpalecek@web.de>

--===============5673330161888521677==
Content-Type: multipart/signed; boundary="nextPart7455389.LYMKg66FrW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7455389.LYMKg66FrW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 30 May 2009 10:28:48 Michal Simek wrote:
> Mike Frysinger wrote:
> > On Thursday 28 May 2009 05:24:23 Michal Simek wrote:
> >> I would to ask you if someone works or worked on moving LTP to Kbuild.
> >
> > the Subject line doesnt really seem to line up with this question.  what
> > exactly do you want to do and why do you think Kbuild is the solution ?
> > saying "let's switch to Kbuild!" without any rhyme or reason sounds like
> > a lot of work for no gain.
>
> I wanted to wrote two emails instead of one - that's why was there 2
> different things.
> 1. disable compilation "verbose" mode and turn on it with V=3D1.

meh.  `make -s` seems to work fine enough for me.  most people arent review=
ing=20
the output for warnings and similar issues, so i dont really see much point=
 of=20
having quiet output in LTP.

> 2. Move all binaries outside of LTP source code O=3D/path

you mean out-of-tree compilation.  you can use lndir to get the same=20
functionality, but it isnt really an optimal method.

> 3. I use only some parts of LTP for my testing and it will be good to
> enable/disable just tests which you want to use.

you can run `make` in only the dirs you care about.  how deep do you actual=
ly=20
want to get ?  having Kconfig entries for every single test (i.e.=20
kernel/syscalls/{getsid,pipe}0{1,2} .....) is crazy.

> 4. If is possible clean all Makefiles

dont really know what that means

> I don't have much experience with Kbuild I had just quick look.  I looked=
 at
> uClinux distribution

the uClinux distro is really an example you should look at.  the kconfig co=
mes=20
from the kernel, but all of the Makefiles are custom done.  the features it=
=20
has arent terribly relevant.
=2Dmike

--nextPart7455389.LYMKg66FrW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKIbBAAAoJEEFjO5/oN/WBacUP/jniRJwDmUy9GfkROBDaC/XJ
ro+sq3QIR8N6r9yN4SIpY1FY/miaR5vIaXDmOhCt2Qx77kQ5PlUkdXG70Rs0MImw
vQr9Br6yX3YPiMO4vP/sXyCA4z1imDHZmqBfEJ6m2fURdZ/1/kjqY/3jCQ1hd6KI
r6Ng6d2ZOJ7wTQ41jqqu92hJACpUCmFFA4VBbwkWVnXU9E3Sny+tlTlj8WvTXlUi
KH6+XcwTV4ks9IRY7W+bRtZoNqh2wOzIQyLlH5w9heUcBcLsYz1MlOj6GFrxtK9E
/ZC9e/QuN47ZuNR1uLfnqB+PFmm5NpLzd26S3wwnLbpZ0HpUtE2jnZ5Gjxv9YHK3
r6pK1kDlh18rsnzCz1lTxQzz9u6saxpRdthLe8S4Oa5aoKw3joVyMnUyRXgvGGZw
m8ciYx6DtwxtTTn9U11/XE7WnY4MWdA70ZdrliPZ4YliWA0sg/ctTQHd5EdaPobQ
XGsTUf9DDAeqCNp0h4/TsyPuQOMRAUpDetv5ha0CRM75HDMA/WUIJncP/XZFHPO6
pdiyCjDQVxu6ORCiDDPSk0bj8o4hWbODDPTqNbXfAdXARlih+wfdJ9Eq26n77pLP
VI8cfg+uX2C2o1AyEGm9QZ/JJTqWa6TMM6tgnS5HXOa06VR0fAgaeRMXFt45Nl8z
6jT+9vxmVzwlcq5TuyJo
=vb4T
-----END PGP SIGNATURE-----

--nextPart7455389.LYMKg66FrW--


--===============5673330161888521677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
--===============5673330161888521677==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5673330161888521677==--

