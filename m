Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1XlPxR-0007jN-SQ
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 22:18:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XlPxQ-0002hY-EP
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 22:18:41 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA3MIUos003804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Nov 2014 17:18:30 -0500
Received: from tarantula.localdomain (ovpn-113-179.phx2.redhat.com
	[10.3.113.179])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sA3MISi7008477
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Nov 2014 17:18:30 -0500
Date: Mon, 3 Nov 2014 16:18:28 -0600
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20141103221828.GD9814@tarantula.localdomain>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
MIME-Version: 1.0
In-Reply-To: <20141103214510.GI5402@vapier.wh0rd.info>
Subject: Re: [LTP] [PATCH] file_test: fix testcase for ppc64le
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0999331294754145424=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============0999331294754145424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03, 2014 at 04:45:10PM -0500, Mike Frysinger wrote:
> we should delete the uname logic entirely.  how about instead we use `rea=
delf=20
> -h` and look at the Data field.

That's a good idea, although 'lscpu' is even easier to use.  But what if ls=
cpu
or readelf are not installed?

~]$ uname -m
ppc64
~]$ lscpu | grep Byte.Order
Byte Order:            Big Endian
~]# readelf -h /usr/bin/readelf | grep Data
  Data:                              2's complement, big endian


~]$ uname -m
x86_64
~]$ lscpu | grep Byte.Order
Byte Order:            Little Endian
~]$ readelf -h /usr/bin/readelf | grep Data
  Data:                              2's complement, little endian


--=20
Jeff

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJUV/80AAoJEHUSMhRJf0WVe5sIALh45Ppc8sa1LOJraHQFrIF7
5Z+Vttm0KiDOXyiMXP6b8Ph3Xrw/P8uCjnXkRiwp3HvBRTyoy5ksDH+M7V1A2pQy
ETVaV2isvw1qizavciZ75EEozV6l1zgSWVrXVp8vxEQdUCnZ5QcaACz9dgu4NtB2
MdFfy5RCJzaeuZISnY1WHifMAHLpcW6aV0xUGdGjx1ljnbNqly9tEUYUkFCiwJEI
B+ZjjTyvJCXOwb6ROyC1K5Ih/8JKHEINv2dPkz1zef47f2jpHo8VXJ9rxhDMOZmi
+O4sT1IgMx6902PN6TG6J9yKjf1Fx8fCbcZblbXPQyePB1FaDxMSWcsNw+CTG8U=
=WQj0
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--


--===============0999331294754145424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============0999331294754145424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0999331294754145424==--

