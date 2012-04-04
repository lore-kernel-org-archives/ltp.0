Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1SFTud-0002yN-0o
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:22:27 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SFTua-0000zZ-QR
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:22:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 4 Apr 2012 13:22:38 -0400
References: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
In-Reply-To: <alpine.BSF.2.00.1204032222300.25027@toaster.local>
MIME-Version: 1.0
Message-Id: <201204041322.39735.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 0/4] Replace commonly used perl tools with awk
	equivalents
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8177737311141778217=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============8177737311141778217==
Content-Type: multipart/signed; boundary="nextPart3542117.M0WAvDYdij";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3542117.M0WAvDYdij
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 April 2012 01:23:43 Garrett Cooper wrote:
> The intent behind these changes are to remove unnecessary perl
> dependencies in LTP by using awk in its stead. It was something that was
> discussed a while ago on ltp-list@.

i like awk over perl a lot.  my only concern is non-POSIX stuff slipping in=
=20
(such as people who have gawk installed).  should we add a local wrapper=20
script that sees if the awk accepts a --posix flag and automatically pass i=
t ?
=2Dmike

--nextPart3542117.M0WAvDYdij
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPfINfAAoJEEFjO5/oN/WBx0wQAJC+cxLLBOtTgvvoj7MU9xgg
gZI+F1pGIrrHxzXe/mMJxNGxJOzCxlxn6ctIuUofDsZL9VKHxLIOvVgBVatqUu3F
iG5Qs6oBzPBpOh96RaZo1MuqNHMZzkIi+YLXcZoXMzktbI1JsvEPEdAzFlcbo9gB
ohVqATjGMKPF57jOjvOdNkAGPS6fDodznkEMFnHGBBtKK+ia9IxFt9mAfNKGgoqj
Y8GUEDKHv/cfNsdHgI+7Vz+O4Z3bjS8kGs7fp/NDUoAebE/ewlWE27CIPmul3B6X
xqOSQ3zZBTK6RR6MHK7vVlOe9z1U97iE4R7aN+2VhfmNkoLxTpmLzu93D4rlkl8e
JZVbngehOkQBszQjcD97WLFSJ7MCCi+A4oUmv/eG/Nw8L6/lgkNrYJhDE5bmtUC1
5iL6KLEGWERywrsqP4LDeIvK4GM1yG/U+6xLR4k+PBhNaUnkJOGNKI18WihVZ+Sg
qq0mjXSLc+sF52NasDB/YZJ+fq/+ZvmOYsr8wgHEkHKAMhpypUateHsXqe1O2nQ0
+BAZs44s0pnWg0fDMYOIm3w++Hh1xH7Yc+/O47f3c+JyTZ2hx4HfM7ilf+4lTGwo
hiDcMhKzgqje+WfPit2JIk2JdmgXJdcAzbf+xm0pZEusN6n4Dm9k/Dk7B6/Et0n+
X0Yqat7FuEjzqbAQPUJX
=1fig
-----END PGP SIGNATURE-----

--nextPart3542117.M0WAvDYdij--


--===============8177737311141778217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============8177737311141778217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8177737311141778217==--

