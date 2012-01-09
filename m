Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RkIqZ-0004yI-B8
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:17:23 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RkIqT-00005V-C0
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:17:23 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Jan 2012 12:17:09 -0500
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
	<4F0AB938.9050504@imgtec.com>
In-Reply-To: <4F0AB938.9050504@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201091217.10203.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/xattr: fix compile when xattr.h not exist
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8801767627959101402=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============8801767627959101402==
Content-Type: multipart/signed; boundary="nextPart14742495.N7jJxprCFL";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart14742495.N7jJxprCFL
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2012 04:54:00 Markos Chandras wrote:
> On 01/09/2012 09:44 AM, Caspar Zhang wrote:
> > if<attr/xattr.h>  doesn't exist, compliation will fail. Fix it in
> > autotools level.
> >=20
> > Signed-off-by: Caspar Zhang<caspar@casparzhang.com>
> > ---
> >=20
> >   configure.ac                                    |    1 +
> >   testcases/kernel/syscalls/getxattr/getxattr01.c |   15 +++++++++++++--
> >   testcases/kernel/syscalls/getxattr/getxattr02.c |   16 +++++++++++++-=
=2D-
> >   testcases/kernel/syscalls/setxattr/setxattr01.c |   15 +++++++++++++--
> >   testcases/kernel/syscalls/setxattr/setxattr02.c |   16 +++++++++++++-=
=2D-
> >   5 files changed, 53 insertions(+), 10 deletions(-)
>=20
> The patch looks good to me. Another approach would be to disable these
> two tests for all UCLINUX targets (uClibc does not have attr/xattr.h>)
> from testcases/kernel/syscalls Makefile.

no -- it has nothing to do with the C library.   attr/xattr.h is provided b=
y=20
the 3rd party "attr" library.
=2Dmike

--nextPart14742495.N7jJxprCFL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPCyEWAAoJEEFjO5/oN/WBu3sP/jfTphgiUQLWN5gjp1ZyUF2z
x+V6IJBe7KN/jG0zkm6JPAmVPJrss/Nj+fEB9/eGywPnB7xWBG9x5lHjegSLNbWj
xFmUFynNoyI/0uRjiioNo/Bn8QE/meIf4EXp5KBUPKNlVlXHAL3ZA3GSBdb8ZdZO
4/LjBMeQ/ZJ4553gUcI0ImudVfk6VA+0WBhJxFOVs0NfEuX/ujIoOb1LDLugRMr1
IXlMUIwPX//f7CITRhBno8aURmqA31NMTGM7FmZ2+2e5ecfS6WaFMpm3Qq87Q+K8
6rndib9Ohau3rKSkfFtLHuGecx/JhQlBlzFree5BilEBpG8M+7fr+rr9+tX41pSU
BTMs+Qk9vp05C6jlSM+hRAYJ4hg/17A9kl2707ZBJlhT9/KBZRf5SKnVseHmzmum
mmbw5JL4z+R8jIH+4YHoW+QYhGHPViBBlmzNrNhhjZzIQwqPXulOhoIXmChCEtAT
n7VTZDyIcslRjnVpjZ87Atc63pYQcbYr7383ZrPPmTur+kQkQSK8FlldoVXO/qKJ
v8nTtAQTFTSTJxqWUFHkWLFxOzPIm6DHRYXyhdFkn2lg056eViCa/2Ttj+cjc/xU
sJz6kWT+GUnMfuSshfJKXkI9NzM/1eR8s/aYjbodMYytN9vjlvxX2lW5zG6BQJFJ
usXATcptVo8kZJKoEKdO
=eds9
-----END PGP SIGNATURE-----

--nextPart14742495.N7jJxprCFL--


--===============8801767627959101402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============8801767627959101402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8801767627959101402==--

