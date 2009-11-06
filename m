Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6Xn6-00009w-2V
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:00:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6Xmu-0003Gt-5Z
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 23:00:19 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 18:01:38 -0500
References: <20091105131852.GA13908@schrodinger.suse.cz>
	<200911061748.35248.vapier@gentoo.org>
	<364299f40911061453p77c6a71ewb254b6b6355b8e89@mail.gmail.com>
In-Reply-To: <364299f40911061453p77c6a71ewb254b6b6355b8e89@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200911061801.38607.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] replacing -Wextra with -W
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8269848403231545851=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============8269848403231545851==
Content-Type: multipart/signed; boundary="nextPart1800288.HCVD3GkGja";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1800288.HCVD3GkGja
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 17:53:56 Garrett Cooper wrote:
> On Fri, Nov 6, 2009 at 2:48 PM, Mike Frysinger wrote:
> > some of the Makefiles Cyril highlighted havent been converted to the
> > common .mk framework.  we could cheat and just pull in config.mk fo som=
e,
> > but for others (ones that build kernel modules), i'm not sure that will
> > work.  linux' kbuild gets pissy if you try to tweak build flags like
> > CFLAGS/CPPFLAGS.  so we might have to create a new .mk target
> > specifically for kernel modules that takes care of these details.
>=20
> I was avoiding those Makefiles because they require kernel build tools
> and it requires some adjusting to get them to work.

np.  i guess i can take a look.
=2Dmike

--nextPart1800288.HCVD3GkGja
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9KrSAAoJEEFjO5/oN/WBdz8P/A1ouxkm3nO67Nlrw1qWsPwk
ZrDFEnEvO8qP5IMBZd6RXdOdff2bbC1O5HEYT7uYB+f9Ak9zkScPXVYc0fCW6BzM
doGU5yf6UNx0ttKLyEsvBVuZSkX4azEFj+3cib8fxx1NjpA1p4dCHaMAdBOOh/KB
9BmiRgrsV1nZrTi5rRDuLjnDsyeYBYN3UE1mlAB+V1k1VhtMHbUW9Tss3w6XUW3O
vr55HZEME2zPFe3K9RX8rXis9KKv3PP8OT2fd6YRi1ZBtgYEv7hn4jDhty7AszY9
5F5jrj3dWvwtl8/fRs4pBwC955fma5vmGFeVqMf1Vfh6awAI65idrMiidfK3tHLc
l0SZvDaYArE+j3OGYoI6yw45R7lQHFeLqfrVuo8T6nVYOipjTBNr8obCjkc/KmUJ
N4dS8gEkHdb5IiOOLpqkqWKLpkEb5yuJulksDS6SHzI81YoQfIeGdEetsXmMoq8y
0qm//kM4qv0kbsMRJO6h1uyxSht7FYqTe6KCzEoX2cHfmpv/mwt4Ug9CJ1QO9h/O
ebGt5MglS7S106QJQTuJrJAhGM0sg5DasRzGEv170+KIfppBQLgtREIBOq4w7mta
WPfrCp1uzUrAqh9YEqdldyWWWGB0N1EmHGweZT57I7CR8VCVEBEkvHR61OJxcWLU
j/e0swHhOKBWXyQaqRki
=eQ6x
-----END PGP SIGNATURE-----

--nextPart1800288.HCVD3GkGja--


--===============8269848403231545851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8269848403231545851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8269848403231545851==--

