Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1SFbsO-0006zc-Gs
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:52:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SFbsN-0007DT-Oj
	for ltp-list@lists.sourceforge.net; Thu, 05 Apr 2012 01:52:40 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 4 Apr 2012 21:52:55 -0400
References: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
In-Reply-To: <alpine.BSF.2.00.1204041735200.25027@toaster.local>
MIME-Version: 1.0
Message-Id: <201204042152.56885.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 1/2] Clean up inotify(7) wrappers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0810040903747895143=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0810040903747895143==
Content-Type: multipart/signed; boundary="nextPart1613497.hBLmpXkdLU";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1613497.hBLmpXkdLU
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 04 April 2012 20:38:31 Garrett Cooper wrote:
> +/*
> + * ``junk`` is needed to make the macro function like a void argument
> + * function.
> + */
> +#define	myinotify_init(junk)	syscall(__NR_inotify_init)

you lost me.  how does this make it work like a (void) func ?  i think this=
=20
should drop the "junk" and just do:
	#define myinotify_init() ...
=2Dmike

--nextPart1613497.hBLmpXkdLU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPfPr4AAoJEEFjO5/oN/WBb4UP/37rHAZFBrzJJvIXUjDtPGT1
qjcze7dtzxaVUERe/w1THSaQwMEUP62quu6R/3/RV9GmDTi//CU5EiC0LrhxzNLP
u5BoCo9rov7ayTkoTHlCTX5ib/1dX5QMs+EhPGrww+vQE3zghkNLi8MRJgut3e5a
Tv4EHPKTCAWG7Nwl5pkol2JsdvapguI+MXiT4hHeqZtgSW+1r0hDNFUhEbdlQzx2
jKMyrF/EWk8DQrzeKNtrn6lWDaxuahq1RhfU9jOxZh4A+mbEks6DfQ3vEB2rsR7e
ACfaQdiHCrkuSfHK983cPYjPj60xsfl/ZPmAk2J/omiWmpdaw0ABe1pEQo8n2y2H
gox+cX5xr7TVdiTX22/IX1LwjF9VQ3yOS+qjKD+yYMCtJrPmdEn1ljI/ep+uKkf6
VgzBcYa6gDIRfXvymsp3GMJHXB79Pten8aIOy4PGk3kfBVv3Ke9hRSV80tYF38Az
Vq2rbQ3ufX96HO6mfqxxA9SgBIgns0SYWrFxSUGWBc4leIFv6cGs8oOYXjUSJdJ5
1pna99dbvapeZNvIqgu3uixPAQ1iI66dlhBGW9FxeMNmf6y5+IcsBhlL/ypSPg6h
3gd+4slFKpnWcMW9rTtUPwbok5jNqPXnK9LDUHWcxYDG6igg044qAhPOOOGz7AN/
CoLGKiSeTqnJ6GGkiorG
=C5E4
-----END PGP SIGNATURE-----

--nextPart1613497.hBLmpXkdLU--


--===============0810040903747895143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
--===============0810040903747895143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0810040903747895143==--

