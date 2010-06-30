Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1OTqhj-0003Y0-Aq
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 06:23:27 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OTqhi-0005uz-9c
	for ltp-list@lists.sourceforge.net; Wed, 30 Jun 2010 06:23:27 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 30 Jun 2010 02:22:23 -0400
References: <AANLkTilncmIFzbwnHMEJKXsJagIMP9mSicqIZ5dQelLJ@mail.gmail.com>
	<AANLkTim0JhFpvTVlo-DMkhjdWzcuf1ob3nUWpkK-vT9y@mail.gmail.com>
	<AANLkTimzGJ2TR5q4WhtPcAlFWHWkGVSB4w2KrJTJKO7h@mail.gmail.com>
In-Reply-To: <AANLkTimzGJ2TR5q4WhtPcAlFWHWkGVSB4w2KrJTJKO7h@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201006300222.24447.vapier@gentoo.org>
Subject: Re: [LTP] Not cloning all the files from ltp-dev
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9111046130357317785=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vishwanath govind <vishwa.hochihally@gmail.com>

--===============9111046130357317785==
Content-Type: multipart/signed; boundary="nextPart1732413.rCBSUsqLMg";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1732413.rCBSUsqLMg
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, June 29, 2010 07:52:17 vishwanath govind wrote:
> Hi,
> I am facing one more issue now. I am able to build but not able to install
> properly. Here are my steps. Since I am working on server,  root
> permisision is restricted and have 777 permission on directory that i am
> working. There is no autconf/aclocal tools too
>=20
> # git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp
> # cd ltp
> # cp include/config.h.default  include/config.h
> #cp include/mk/config.mk.default   include/mk/config.mk

use proper autotools to create the files and then specify paths
=2Dmike

--nextPart1732413.rCBSUsqLMg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMKuKgAAoJEEFjO5/oN/WBNR8P/ROAxXegj/UNMjc+Knc1L/7N
D/Ujtly2SmlavVtsfYnOjl5zdHF7aKaBSmX5izLUX0sNlP/f+JMezoyVHNQN0SOt
ErxrC3gF7E2NEjvusCINU1OfDgMGHcjJYkfqmOy/ckx846xMMzkigXg06WMLwU+n
T/jZchnjaeS73lgDYE/egwYHk/LGdCMoXb8XO1p9JiPYuIoknFJcrnZdIMBdYiwH
sVjx2qTtXbuGNaD7P9OdBoU4PxduqTQ6ON/x9R1DxesE3Gm6xPSw8FMr3/hxCrYX
VsWSeJTkcdRdOOk1t0sQNJIuwxfXoV+QMJqGfRizXKGjD/e/B9mSc0RhSwMZx+oD
0zSNQ87CcVlruCWvypkB5D74sPn2f5o408DNogcqMOndj4b1ZsG650Ihdn4sBsb2
RFyeJF4bLliIP7KxqazxgPhgtaIh+3Y1XHsBtq9CWes4yBXzzmZeFtykoCTHcdCT
GABYsX3tFrDx6cOtim7ftIAspP2/2cUAZULMM/iFiZ18bIHRAJFv8Yxu8eOw3jSC
MUaqhTNVml+FSYF+nJdchINc3aHX6PuazrX9SqIgtkJIBdTA1mPkH0EX/vuSf4y0
CCJsRfQMTIls4nrlUdc8iztNYrozj45dtYgSHA0WFXUPhD8LizWwSJG37YDN6rD9
8rV2M9P8pBaz+GR/Q3Xt
=YUUD
-----END PGP SIGNATURE-----

--nextPart1732413.rCBSUsqLMg--


--===============9111046130357317785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============9111046130357317785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9111046130357317785==--

