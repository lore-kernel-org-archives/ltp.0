Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6V1r-0005mF-5A
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:03:27 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6V1m-0001WH-8o
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 20:03:27 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 16:04:46 -0400
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061439.22257.vapier@gentoo.org>
	<20091106195036.GG819@basil.fritz.box>
In-Reply-To: <20091106195036.GG819@basil.fritz.box>
MIME-Version: 1.0
Message-Id: <200911061504.47432.vapier@gentoo.org>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0023777826329734822=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net

--===============0023777826329734822==
Content-Type: multipart/signed; boundary="nextPart1519214.FdvvRIdEak";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1519214.FdvvRIdEak
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 14:50:36 Andi Kleen wrote:
> On Fri, Nov 06, 2009 at 03:39:21PM -0400, Mike Frysinger wrote:
> > going to happen.  especially considering you apparently have no
> > signficant plans in helping maintain the huge code base that is LTP.
>=20
> I submitted some tests and fixes in the past, but yes I'm primarily a use=
r.

right -- you've certainly contributed useful pieces in the past which is wh=
y i=20
used the word "significant", but tackling the entire code base like Garrett=
=20
has isnt a semi-trivial task, as well as fielding follow up reports.  i=20
imagine it's been pretty draining on him.
=2Dmike

--nextPart1519214.FdvvRIdEak
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9IFfAAoJEEFjO5/oN/WBP88QAMHKL17xEKczCTaVmy1Pn5uh
XJChYeLLJzdRI/h9tZLUtbXXVtL9GXfni5hngZwORTZLpfs1IIg/VQX0qIwibFYr
DWOm5318mQuxblXFzfFH1NrNabfIIv7tw2CvEDfoidNBYMVwA23TWNkVIDV5ZZA9
MBfeEdpNaWP1wgW7oXzZCKSICnfBpYDIgGhcFJrmvlC1TnUQh8tolClQvTe+3qsa
8xUpQATApsbRfDgN/8N78ZxD210k3tTFNmdAwcLmnNYzMSsYJVF8AiZLfMmDjohw
+MTafwWLO78B4vqxxUGgcq/tEa8ooU70SkZ0yxkPCmQaA5JtWVy7s4mF/KZHPboy
1ElqyqPH+cBPJUUfokGHVr/Pv2JsBxuqdFjMhbTz5rhJ/9rF2hTHhloConp7S3dt
+SDNTC3KDUeZ9uxTdH1fZQ+1TNF+iOZOkzl3XJ1F2V6zxjVUNL9uEJ5rl9IU7rqX
cvLNW77nuyLONU5y3OuJSLZEpsQkJ5l4XjJm5JMb9JH9DPFKUHqmlsQlC59eFuVk
06iPYzg7+eyQdkxELoxtaWuqyT1y5k76tiCjL8IIju8C6rFWU1yNb5ko/Pw9S2la
fUkQgg/fMtNwVUutZao2hZ7G4VFAEqaoF/uRZH/Y+qXob/Jj2uY1VjhVpbxXKU+n
MwWwUQDLc2K1cSloemev
=0EqY
-----END PGP SIGNATURE-----

--nextPart1519214.FdvvRIdEak--


--===============0023777826329734822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0023777826329734822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0023777826329734822==--

