Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NLJWv-0000oV-M9
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 16:48:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLJWu-0003yH-Ok
	for ltp-list@lists.sourceforge.net; Thu, 17 Dec 2009 16:48:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 17 Dec 2009 11:48:41 -0500
References: <1261057201.11550.21.camel@munipradeep-laptop>
In-Reply-To: <1261057201.11550.21.camel@munipradeep-laptop>
MIME-Version: 1.0
Message-Id: <200912171148.41996.vapier@gentoo.org>
Subject: Re: [LTP] Configuration error while installing
	ltp-intermediate-20091209
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2717294341077020191=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2717294341077020191==
Content-Type: multipart/signed; boundary="nextPart1780036.kISW1kKFE4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1780036.kISW1kKFE4
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 17 December 2009 08:40:01 Munipradeep Beerakam wrote:
> I faced the following error while running ./configure in the latest LTP.
> After changing the system date to some random future date, issue is
> resolved.
>
> [root@xxx ltp-intermediate-20091209.orig]# ./configure
> checking for a BSD-compatible install... /usr/bin/install -c
> checking whether build environment is sane... configure: error: newly
> created file is older than distributed files!
> Check your system clock

sounds like a local problem.  the sanity code here isnt from ltp, it's the=
=20
same stuff that exists in all autoconf packages.
=2Dmike

--nextPart1780036.kISW1kKFE4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLKmDpAAoJEEFjO5/oN/WBhuwP/i0j0aGKtDy0pwrXlqEls5Ob
KqMX1e278H8UzJvqMFyLvOTFYcZMzsU0rdtlxwoAxYqRufMxK04wCcK0CVpfj8Mi
6+zny6F5foT4+7vxaF3eMF8vDG1JW/Xh1JufX5tyyQqVDaXYLtzEREnXyFmzJlK3
QpQRGt5FACo5o8YGXQKDzXIXd8i+RaDl66Emb4u5Q0KbYj6cTBmgqO7oC5U0pnFz
8nvTvP8BxudJZ0MLEId14QmebSdoaHl6eHg8eLkA5ejDmSqQ7xaVEnz0WFejvTfu
NpuFMif/0dALU6enbBrLonIYCZYFXMmKjzRyr0qy6+Yc9qpP+HuPoAGZzZ9DmZ8m
bTHIfUnk/ZWJAZCuFB4oJ6NmVUW7qU5J4XosBkCTw+NEFGNr9SrTbV6d2d2sYZbi
ceKWb/I7YVveaItZ7esv7DDFDBVAFrszM0H+g2U0G2UymJIURl4TyBbkAq0luOFw
mx38tb8gMyvSAqj0VEJoKFwFL5NdbTVZAim3rfnvVMqHqUjAD4rslzhFpwzafcf0
P62rm+0EYv9SjJu9kKVgJOocqn2wka4eX2HRZvg66i03RH6j81uxc5eGeGodI9F8
HPXNpWBjU69PZxl5T5e4ZTj6bLYRbZhvbq8UYuuYPVtvwp5JjJulnBo1d/r0ZQfJ
HX0lRMYzLJLxKCtqzlDL
=5I+G
-----END PGP SIGNATURE-----

--nextPart1780036.kISW1kKFE4--


--===============2717294341077020191==
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
--===============2717294341077020191==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2717294341077020191==--

