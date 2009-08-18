Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MdM25-0000YN-RF
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 10:35:13 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MdM1z-0004Yu-NX
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 10:35:13 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 18 Aug 2009 06:05:37 -0400
References: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1250586433.9913.15.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200908180605.40908.vapier@gentoo.org>
Subject: Re: [LTP] Dead End with LTP Options
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8266993117045210439=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, Michael Reed <mreed10@us.ibm.com>, Cai Qian <qcai@redhat.com>, Nate Straz <nate@refried.org>, "manoj.iyer" <manoj.iyer@canonical.com>

--===============8266993117045210439==
Content-Type: multipart/signed; boundary="nextPart2963582.JA8Poh9i0E";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2963582.JA8Poh9i0E
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 18 August 2009 05:07:11 Subrata Modak wrote:
> We are about to hit the dead end for LTP options with increasing no. of
> options being added to 'runltp' with each passing day

so switch to longopts

>      1. "./runltp -h" will scroll up and will not show on a single
>         screen,

it's already beyond 1 screen of text

>      2. It will be difficult for users to remember all options and their
>         usage as no. of options increase manifold, which is already too
>         much.

meh, --help exists for a reason

> I have no reservations of how it should be implemented, so, would like
> to hear from you on how it can be done best. I would like to see just
> the following command execute LTP as desired by the user:

ive never used `runltp` and i probably wont start, so i dont really have an=
y=20
input here on its interface
=2Dmike

--nextPart2963582.JA8Poh9i0E
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKinz0AAoJEEFjO5/oN/WBJD8P/0hj5tZ4J07DDTG8WzDc7phq
Q4oXfU4toHemnFeoOOHWNbIIjqqZIplH2pyYQzIkqxPxHnIVWdiQaovqlCdx00LF
tKmH6Bgj7MGImVFhKLeGKxE7mnXj0mOPvRRMjir86noPjtwAxtzMda+sdKAsgOCC
mQO2jLBrs34pXAm3V1ZwJDY/7YNghDeuQQrN3TbQ/MN5v6qcX2rSNWL5Goxj1ZDS
zamwiqvCqU1VyLc4k9oz/w22OS9Kf3G4UKmIZDctK4J4AGu/RN+8Y9j49YRkQDWZ
xAeY11z1n1q9cuvIQDUIX8IN3tv176sKi5feVjjg4FVerlCtDcveP2D6j5Snj/ms
MYptS0tt1y3flLzzz9NklKDLHVF5RG0lbQNcasejqOcvsY65Lxj3Myhqou93LqEd
GWrm020YOGg2iW3hBMaNbkDiwl3BaNTM0Uwhj3xAY8Mc4gNlspKzSOcUwPmhsuTa
DhVYbJi7I2cSP/x9wtlungop7NV6foN5GVOQe+ky9jnTtlLUOjouUeZT8/XeUrik
oaGiscF7W4p7uwyP5tZcrKQxkO/xZnzWyi3+BGkV0GPSmamFfobRUBtJE/ZdtxN2
LPb+fX75vamEFy5dkg/Q9ku4oBlR2K2CAB32Vm5DXu1LxZJzU7nCipgC9HlqwDJH
FoT306JS9igoU24H3lf2
=IWX/
-----END PGP SIGNATURE-----

--nextPart2963582.JA8Poh9i0E--


--===============8266993117045210439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8266993117045210439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8266993117045210439==--

