Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N6UdO-0003x7-RI
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:38:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N6UdB-0004d2-UB
	for ltp-list@lists.sourceforge.net; Fri, 06 Nov 2009 19:38:05 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 6 Nov 2009 15:39:21 -0400
References: <20091106095745.GA25377@basil.fritz.box>
	<364299f40911061004mbb02ed3lf02a33164890625a@mail.gmail.com>
	<20091106191343.GC819@basil.fritz.box>
In-Reply-To: <20091106191343.GC819@basil.fritz.box>
MIME-Version: 1.0
Message-Id: <200911061439.22257.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============3403600978449528176=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andi Kleen <andi@firstfloor.org>
Cc: ltp-list@lists.sourceforge.net

--===============3403600978449528176==
Content-Type: multipart/signed; boundary="nextPart2852351.msKqnGRb38";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2852351.msKqnGRb38
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 06 November 2009 14:13:43 Andi Kleen wrote:
> > I've considered adding a configure check for the make version. I'm
> > probably going to do it this weekend to avoid support issues like
> > these.
>=20
> That's not a solution.
>=20
> Please just fix the makefiles or revert this misguided change
> and give us working makefiles back.
>=20
> From a quick look at the mailing list archives that doesn't
> even seem to be the only problem with this "improvement".

again, please stop wasting our time with your "revert it" comments.  it isn=
t=20
going to happen.  especially considering you apparently have no signficant=
=20
plans in helping maintain the huge code base that is LTP.

we can look at working around bugs in make-3.80 if/since there are a number=
 of=20
people who would like this functionality.
=2Dmike

--nextPart2852351.msKqnGRb38
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK9HtqAAoJEEFjO5/oN/WBo1IP/19bCiy8fLXHCaW1m2kb8KUf
WZY9aP2CF+QPzUxGAJzk2Ie1xnulOgmUsFTG3R4RN3hhmMlW3vuujoJPZ5gLEzzG
V5GegPJjcM5ZnJqsFw9d6VFc0V8dftU4eooAYN9DeJeGLCDjQqwHumQYI4GLiV/A
misnFYf+fP51IiOG6j14zx1WoM3i7wb2BbdBBYHWvdCuKVSATRlWbqILJS0xcgwN
99lVEs3rtHEivOPBMsw7ePDnz6iCtYPT6aDUrlFQeIMF8TvAmPIL7YHxxuYl+Hmw
8Z+rX/BYK8in5YXNJ1NAo8AE5W+UrNFhLliEJ8asOY47WATNv45KM5BmzKqu90Fi
LhPYHXgpreQ7x4AzHy3e/TLyzufg0M2fSYjfFjr0GLdabSCwoHBh9QqORdJKdQia
XyqQzFlmL2io5Nh742hf9X7tUPCkZmcfmhXeO1XLXFoNBXv+f8/NUE+8KB4YhKpX
MAAtD7TKCNivDb0RRugyH5Ag5hjqkt9PiUq5rQtIk2ww07aatEXGNTUFELA3M3BK
iAS3kd2A+5SSfL2vb4lZF96FzpgkFmPb6tVuJwSMdyetQbq3oKYSDZu4HWCA4T2x
cv0x5L5dZ91q60aFgbd8KgiUQLG/4eJV9w8o0twTG3bvH9qaq68m9EXWiHKjBf2p
B0vnoGhB5XtaCHnrWeS5
=gdWF
-----END PGP SIGNATURE-----

--nextPart2852351.msKqnGRb38--


--===============3403600978449528176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3403600978449528176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3403600978449528176==--

