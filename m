Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MNxYB-0000Ok-BK
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:24:43 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNxY6-0003Vg-Hz
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 23:24:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jul 2009 19:24:33 -0400
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<20090706215111.GA32310@count0.beaverton.ibm.com>
	<op.uwn5bux1u2flwt@debian>
In-Reply-To: <op.uwn5bux1u2flwt@debian>
MIME-Version: 1.0
Message-Id: <200907061924.36146.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Remove bashisms (WAS Re: [PATCH 4/4] netns:
	Change interpretters from sh to bash)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6106363940108380877=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?utf-8?q?Ji=C5=99=C3=AD_Pale=C4=8Dek?= <jpalecek@web.de>
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, ltp-list@lists.sourceforge.net, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

--===============6106363940108380877==
Content-Type: multipart/signed; boundary="nextPart4280832.nTQ16LZhs5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4280832.nTQ16LZhs5
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 19:10:36 Ji=F8=ED Pale=E8ek wrote:
> On Mon, 06 Jul 2009 23:51:12 +0200, Matt Helsley wrote:
> > 	Change the increment syntax to use : $(( X +=3D 1 )) instead of:
> > 		X=3D$((X + 1))
>
> I changed this to (IMHO cooler syntax, it's for the sake of aesthetics
> after all) ": $((X++))" in my patch.

yes, x++ is better, but it is marked as "optional" in POSIX and some crappy=
=20
shell implementations do not implement it (like dash).  rather than fix das=
h,=20
people change the code to not use these operators.
=2Dmike

--nextPart4280832.nTQ16LZhs5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKUoe0AAoJEEFjO5/oN/WB0jAP/2uCoHkfICfrrwvVVThOVQjb
8lzPY22gtOQZvDViHUIWpKW4dF73dxgRm7TB8mMEkHF3yVwVTpRRsfhs+2cYX22t
gYQDtbmfscZmeN2MJWU7DpwM/7lrKZlr+Eiv9sUavOw8pFhkSd61NRu5Tk80UhJK
n2nN/fjfKFE27FsLr3znYMo+HqiUsXC2ZbvhtSGXjClxLHBu9dE3bN80Qp2J9YkL
K85ZatYj/4a4sZNu6+pSxT1/NRLHW6cKgLL0KgvY+rw3RzHRPuxhtjoZPZOVn5/C
RqXL0a6W/sdl2fbhrBFeEaxjAXp7ZP1OPtb1UPhZLBKYTUr4+jISl36kCoKUp7Sz
seZ1NqZGaor5Nm+JGCIMJr4QXxGHJJXEvJqTLmHG9JQJ6zSUSu2HlRmE/AUPplHI
rzY+KqVa6szPnrBI7zb8q9p2I8Z2Pur4rLNjO7SNzH4PfcQBkgGoW8tWosAaMeZy
XVx3a/bA9Hvzxf5zBuWT7key4vvcI3PBezH37fhttgGkl9dzRlW1FFaWmb33EKW6
z1WiW6exstJ8jezq8mEFATPt0bCCfZyA2IxEwmpZEgDr2/8WKs7c8Qm5qkvPnHkk
mo57kI4tSf1V6rg6ubmVqwGW4j0fh7Y5p4LqFC7+btYjQCZjZzxZccqvah/tKxoT
gCoPcxYxtyuWButGfbRs
=G6jR
-----END PGP SIGNATURE-----

--nextPart4280832.nTQ16LZhs5--


--===============6106363940108380877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--===============6106363940108380877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6106363940108380877==--

