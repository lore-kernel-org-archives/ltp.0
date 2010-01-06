Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NSOO7-0005Dm-A0
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:24:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSOO6-0004NI-HD
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 05:24:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 6 Jan 2010 00:25:09 -0500
References: <4B421480.1040400@petalogix.com> <4B43E1CD.2050609@web.de>
	<20100106032644.GB8157@us.ibm.com>
In-Reply-To: <20100106032644.GB8157@us.ibm.com>
MIME-Version: 1.0
Message-Id: <201001060025.11076.vapier@gentoo.org>
Subject: Re: [LTP] clone tests fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5313869615329297778=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Jiri Palecek <jpalecek@web.de>, Nathan T Lynch <natlynch@us.ibm.com>, ltp-list@lists.sourceforge.net

--===============5313869615329297778==
Content-Type: multipart/signed; boundary="nextPart1823248.8V5bJNJI9W";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1823248.8V5bJNJI9W
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 05 January 2010 22:26:44 Serge E. Hallyn wrote:
> Quoting Jiri Palecek (jpalecek@web.de):
> > Michal, I suspect the failures you see are somehow related to
> > alignment (that your architecture doesn't like odd addresses). Is
> > that right? Under x86, the address gets aligned (so some of the
> > space is unused).
> >
> > Perhaps both of these behaviors should be tested by LTP?
>=20
> Gah, yes, Nathan had mentioned arches where this matters (including
> some power?).  Nathan, did you have a generic fix for this in
> userspace?  Should always be safe to do
> 	(stack + stack_size - 1) & ~0xf
> ?

(sizeof(long double)-1) would probably be better than 0xf
=2Dmike

--nextPart1823248.8V5bJNJI9W
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLRB63AAoJEEFjO5/oN/WBt64P/2MNI9tWuadLs9yWxEnmpQVN
Z/RQwgBDeQ45fvLA8MW8KLfPYhCv+uLTanPPmL7I03cmxFk69aefOJxjGsgX3+is
bDAYrdBLQSdEMOpvl+Lp/XFuRjEH6mUkEVynmgJCy8ZVnihgVR4jnSS9EGIu68ZV
4vAt7hLdofWho6DEec53qY1i6PbZGBAhuRH18ViStuSmbieTLNjFSmLxLCKbZP4X
7EbgSTDMtYDrrH54YKyPqbwy4VBKKHt1eEdfHlLMAH0Bpio+jxGsPq3sZkZelTkH
amnlIJv4Qrxua+/gcTwa6HKbCMc3eIOvlpOa7iVIuWz2B2XqmXHYzIq90BNgwiZ6
DCSrP7SyT0EWpcLA2bkcznMnX9ZiUMyfno66nql2ElsUhObxC00AKFvIpPlKbVif
tIEXyoE4BxFbA0Qzvl5dSbakygMaxsDKYbDc8B2xLp5Jbx3zejbpy8J0VaFXk1T2
gnWpUNZyyuSRaQ6x8uywyApRLfdFD6ZHv68tiMGEcNDmVQPZaofbEZ54SXFqhFO9
ZNNdktLdOMzf9BSijV1GthfweTmA38m6BMWFY11aWYb4UlxKJfi5ukOzlVQG0kX3
1H677m71h/kPX+p6WB8EY2P5pKxI2lcBX8MoOjP/cKZ/vW4Ylzb5HHiLgxJc+m81
RqYQuHiYu/1k2/ECfPoZ
=EeZT
-----END PGP SIGNATURE-----

--nextPart1823248.8V5bJNJI9W--


--===============5313869615329297778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============5313869615329297778==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5313869615329297778==--

