Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MUOuM-0000Rn-9K
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 17:50:14 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUOuE-0003eR-0b
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2009 17:50:14 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 24 Jul 2009 13:49:56 -0400
References: <f5a7b3810907240831t75a058a2m96abdc28a28c4365@mail.gmail.com>
In-Reply-To: <f5a7b3810907240831t75a058a2m96abdc28a28c4365@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907241349.58754.vapier@gentoo.org>
Subject: Re: [LTP] Char Limit issue on 2.6.29 kernels
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3501768381181665515=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, tim.bird@am.sony.com, rohit.170309@gmail.com, naresh kamboju <naresh.kernel@gmail.com>

--===============3501768381181665515==
Content-Type: multipart/signed; boundary="nextPart1585721.GUq8EBI8DJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1585721.GUq8EBI8DJ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 July 2009 11:31:59 naresh kamboju wrote:
> I have come across with char Limit issue on 2.6.29 kernels.
>
>
> SIGFAULT:
>
> #define SIZE            8053759
> char buf1[SIZE] ;
>
> NO SIGFAULT:
>
> #define SIZE            8053758
> char buf1[SIZE] ;
>
> This SIGFAULT not observed on 2.6.23 kernels.

=2DENOINFO

post some actual code rather than saying "i declared a large buffer and thi=
ngs=20
crashed".  is there a reason you cc-ed LTP ?  is this a crash i a LTP test ?

> What could be the changes that effecting from 2.6.23 to 2.6.29 kernels.
> Please share me the information.

git log v2.6.23..v2.6.29
=2Dmike

--nextPart1585721.GUq8EBI8DJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKafRGAAoJEEFjO5/oN/WBSf4P/3Vxc4bpI8ZyX28k8KmIBthC
18d1yJETty3qlAcrGpMf9iK2sKY2CHOMOGn0gu0TabTjZhN+e98v7n9rxYN9vard
JHT3iUtrbHVgNUhnwkxdrG58jZM62csDCr3JyB8fTxqKb4uheX7vDRuO4LVjjT5y
nw/kA0tyWklFRTQQyJvBnZgDUsvJNPkxCnJ6NOijHv/Fl1Z2+D1sO1HKRrkzNVn9
T/n+IlYV2wmKROJnci5LGCxKjYBpvhWVUdDJHF1oqNaIp2oRi3r2EUrmNuaEleQY
/icjvTqhghPZ6oCiqHPUpApD5qKO5qVYipRG8TklnCSNcL6l/hEOmNjzkYYtbRQU
vJGTIMkhBf5XxX8GTpT26NuDOjqat1UDRzPvVd9lOJC5mUE3+OxuegefvcRN0qdZ
uZFTLM40XrnmkjECulFz9Yj2eGSJcVif2H50UYpoDguuOmCC6zY1lkknkY+vI2/Y
UKLNBo7Anid+uFIJ5vpxPNVwmnZ3f+Lud6/8C55oWOiyL1NjTC5G/3Tx0aj2+fMh
ZzqOQiLcnnE0JzJfSRIaVLHwCY2P16REG8NuGz2EFdgU+rsMYVLtFHdR5b2Ih5EX
CEHJr35omKfjMajy7tLyGfnZ477CGHyd8VfW4leavHf18XzgJyIGgThxMVPgRIuV
GmZQz9hJB3Z9UKwmiNwh
=Z5Lj
-----END PGP SIGNATURE-----

--nextPart1585721.GUq8EBI8DJ--


--===============3501768381181665515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============3501768381181665515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3501768381181665515==--

