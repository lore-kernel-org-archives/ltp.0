Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RnShL-0007hm-JE
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 10:24:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnShK-0006kw-5x
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 10:24:55 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 6958A1B400A
	for <ltp-list@lists.sourceforge.net>;
	Wed, 18 Jan 2012 10:24:48 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 18 Jan 2012 05:24:53 -0500
References: <4F14F368.80507@cn.fujitsu.com>
	<201201170001.13851.vapier@gentoo.org>
In-Reply-To: <201201170001.13851.vapier@gentoo.org>
MIME-Version: 1.0
Message-Id: <201201180524.53760.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 8/8] Add test usage_in_bytes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7292398615732153840=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7292398615732153840==
Content-Type: multipart/signed; boundary="nextPart2023147.dji5zWqDoE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2023147.dji5zWqDoE
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 17 January 2012 00:01:12 Mike Frysinger wrote:
> On Monday 16 January 2012 23:04:56 Peng Haitao wrote:
> > +. memcg_lib.sh || exit 1
>=20
> you have to use paths else the source searches $PATH.  relying on $PWD is
> not portable.
>=20
> . ./memcg_lib.sh || exit 1

btw, i was talking about all your patches having this problem and not just=
=20
this particular one.  you'll have to update them all.
=2Dmike

--nextPart2023147.dji5zWqDoE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPFp31AAoJEEFjO5/oN/WBPSsP/jkbJPC0nNuORRd6GkXzY8YQ
X200yuz0z/Nt5hWpm57WWSUqC7iYv1/Ap8PYQn/6anJZS9pKL8Deg69s3ogr3r0A
Jr9YB5vbDT78XXrGTU7Uzj0yEtC0tRUtQQa6zX8VDyjAc6x0qw4+ZzkNwvVMweF1
hsia5QhCj5TsIiHo9im5CqVRJ1AQ5LfUgvzgagg7Z5rEbNAPKZCUnROVy6a8lgKf
27yaZSAPACi1A8+fHuzGjaZFLvok1WCT9OyR6sk4Cm4hNYhBdvSyT49ijUxhqsXK
FRUBVNnpGnz9YUQv+++T1fsf3W2i7v/8No3fLN1Fs1dbbR0TBz+8UWra9idaO9ob
1H7Vs8c6XwXr9qbphVes3SVHD+B/a0tqQhtvgJvaKWjN6TsPyLhMPtDtvHHHa/41
8Rj6j1yeSyaox1pGZ6Q3jTv4n4JBoqUxWFmgk+MHGQbf0jfVAD8txMjxHvqjJKwz
D7qXzZ8ddYRGoP4oajZrchTnLv3Wtkz35VvWBAcR+j65GJgfuUySKtSz7TT7u4OU
BteWjALxYuxz06R+Cp9s/Z1dO2x55/+HAR3A29u6rGYCUAYbGYYSDxQ7blMugiFM
WRMJBww+kHOfb6g4JCRa862bc0X1vG8RD5ZJw9nf2n5jMGd0pg8/w+osNB4ylNuN
qF4Mjf2PNgKSFJ7GLUEP
=te58
-----END PGP SIGNATURE-----

--nextPart2023147.dji5zWqDoE--


--===============7292398615732153840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============7292398615732153840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7292398615732153840==--

