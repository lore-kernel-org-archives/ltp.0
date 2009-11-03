Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N5PgO-0002MF-6R
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:08:48 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N5PgB-0008QV-1m
	for ltp-list@lists.sourceforge.net; Tue, 03 Nov 2009 20:08:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Nov 2009 16:09:35 -0400
References: <20090929233015.GA22127@us.ibm.com>
	<20090930043554.GA32007@us.ibm.com>
	<1255436015.8438.35.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1255436015.8438.35.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200911031509.36633.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/1] define and use common clone helpers (v2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6544340422080488842=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

--===============6544340422080488842==
Content-Type: multipart/signed; boundary="nextPart4491199.LqNvppFZ2i";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4491199.LqNvppFZ2i
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 13 October 2009 08:13:35 Subrata Modak wrote:
> On Tue, 2009-09-29 at 23:35 -0500, Serge E. Hallyn wrote:
> > Quoting Mike Frysinger (vapier@gentoo.org):
> > > On Tuesday 29 September 2009 19:30:15 Serge E. Hallyn wrote:
> > > > Define ltp_clone() and ltp_clone_malloc() in libltp, and convert
> > > > existing clone usages to them.  (clone04 can't use it bc it wants to
> > > > pass NULL, which ltp_clone() will for many arches convert to
> > > > NULL+stacksize-1).
> > >
> > > i thought you fixed the clone04 issue ?
> >
> > Gah.  That's what i get for just wanting to get the thing out.  Here
> > is a new version.
>=20
> Sorry for being not in action for long. Garret made lot of changes for
> his Makefile enhancements and lot of files from the containers directory
> are missing. This patch fails to apply hence:

ive updated and committed.  things seem to work for me, but if someone coul=
d=20
double check on diff arches, that'd probably be good.

thanks for this clean up Serge ... ltp needed it pretty badly
=2Dmike

--nextPart4491199.LqNvppFZ2i
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK8I4AAAoJEEFjO5/oN/WBSOkP/A/Kyj2f0phZU7BvTArB5CPo
gxf8odHiFII/z51qi6fysdTIM+C+/C3c1UCcwUOj2lk+u7GMfSx6rI5gsUOTjFUY
czJJg6jMoQPfqwo2y7gqfrHjR6RDklXXH236yE9rDrA0u9SBGBAwddI5Zmkb4HHS
eyMWDzQvhTQ/JgG14L17XqPdFex8QZ3Zwq9ubTl8CFpmO7nDqKMByRi3j2Ks5tQb
MDCNi3UuNqzwQIYeiQXkFfWh6fTwXBHYR7RVgXD9oPBDbAbAyTa53GA5B0U50dMI
sDkdUl3GKejTI7Uddy8y77SXAJimDOW4P22wmrv7p1bshnArWztDI+ieW1gQaRR2
9UPhKqEB9ZV0JwqRtsZWIbuptd+6H8wlpEGxjpPyIQLf9qilzgkduKj3rRi0FWiZ
06nJn13LWefNcovEhlkUpEi5ZEQH3+VZYQjJjJVRNY6T6rU/ADuv1fjNonAQrOkn
RNR5VH2BzuAzZ+lmsXux/YGK3W1mCXgmAlCtx7RQj/wJa3FcBvgPgC/MShEPofP/
wscIZIGChXm4dPUrY66XWvMAXnTxdPHdBCoGji0oYRy30yO60M2GtZrddNrJ7UxV
NvJk2eaHGsijyKzpmYwyVnS2cp6T4ZxmEqUMre7ck7B0JblAmzHNdcdw6IkC0zSK
xyL5WQ6XE3GKjiU5xdBj
=JQPl
-----END PGP SIGNATURE-----

--nextPart4491199.LqNvppFZ2i--


--===============6544340422080488842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============6544340422080488842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6544340422080488842==--

