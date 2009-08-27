Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgdIY-0006hw-6g
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 11:37:46 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgdIS-0000TK-3V
	for ltp-list@lists.sourceforge.net; Thu, 27 Aug 2009 11:37:46 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Aug 2009 07:37:31 -0400
References: <alpine.LRH.2.00.0908261719130.29807@vixen.sonytel.be>
	<200908270606.16787.vapier@gentoo.org>
	<alpine.LRH.2.00.0908271311410.22490@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908271311410.22490@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908270737.32793.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] su01: Yellow Dog Linux doesn't support passwd -e
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0099634157009928461=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Cc: ltp-list@lists.sourceforge.net

--===============0099634157009928461==
Content-Type: multipart/signed; boundary="nextPart5139974.N8YWJrkLK6";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5139974.N8YWJrkLK6
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Thursday 27 August 2009 07:12:01 Geert Uytterhoeven wrote:
> On Thu, 27 Aug 2009, Mike Frysinger wrote:
> > On Thursday 27 August 2009 05:49:49 Geert Uytterhoeven wrote:
> > > Next question: Does Google Translator do bash =3D> expect? ;-)
> >
> > not sure what you mean ... program options are not translated
>
> The script that does the test is written in expect.

not sure whether you want to convert it all to expect (TCL) or you actually=
=20
meant "expect =3D> bash".  while converting POSIX shell to TCL is pretty ea=
sy,=20
going the other way is largely infeasible.  expect does the right thing wit=
h=20
ttys and sessions and such which are either a huge hack under POSIX shell o=
r=20
downright impossible.

in either case, i'm not interested in converting anything as i dont use the=
se=20
tests ;)
=2Dmike

--nextPart5139974.N8YWJrkLK6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKlm/8AAoJEEFjO5/oN/WBi0kP/0ewwFyw/cElfk0AiPLpn6sB
8OvpoxjAOa3HXq+u81gVp3e0tFkusuLJL1y8jmN8NNeDVCsd78WScEu0U4LH9oZo
cBTyrcv+8BYx1WNordcBh0JqNdQSZLFpnCaHHz74b8p7/UZMqlMzVR239EYvBOA4
XzUD1MTrxnJPE5cJ+2VkcmoWs+i/pUEgnvdBWS04hs4vb+rzripIAE0mcNLPEs0N
k9S44SxuPTB5ezZYXfaawIYrHnPOC96yru/8wst4TMZ0df55CtqFu3y4ugkAQi0M
/8OlEtaTn0WbnOh4XVi7GCNUVQFtNEx6AltDrbJdqW6yPGWF0ghZUzYiYt9ATxYN
x4oVgYfAfJd+OCXCKGDppRo1X9GJApd2Leh1undNBrXP/nazbG1onL+UfPmgqXtZ
KsycFJ8VJF6DJoNdGOVmHQtDw3TpCqe9Yklwu/SQvag2XynbImJFW4UyLk32peof
fan6MUgvsphnivnF2wMwXBN6VV/fmbHeJ2yZBcn86v57MY6OaPK1+JPDXxnKjY+N
02dvMXTJIlMrDmqx/jA12OiMsIat+iJBGEqGsVwjC0INMAnpJ//fE1Iwul6DonNt
H4AboMnGzmnMBLgIB163l0xe+RN8aVit9+cBJW7MZtmMAaQlCdRRT2Lm5BwuXbit
3VLEFfLknvmTjP1s4um0
=W5JO
-----END PGP SIGNATURE-----

--nextPart5139974.N8YWJrkLK6--


--===============0099634157009928461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0099634157009928461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0099634157009928461==--

