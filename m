Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUMy-0006PK-W2
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:05:04 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUMr-0007TI-8J
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:05:04 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:04:49 -0400
References: <4A8330A1.20001@canonical.com>
In-Reply-To: <4A8330A1.20001@canonical.com>
MIME-Version: 1.0
Message-Id: <200908130304.49839.vapier@gentoo.org>
Subject: Re: [LTP] fix mail_tests for systems without mail installed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2337681123672932575=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2337681123672932575==
Content-Type: multipart/signed; boundary="nextPart6677785.CbKdxa4aWj";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6677785.CbKdxa4aWj
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 12 August 2009 17:14:09 Paul Larson wrote:
> +`which mail`
> +if [ $? !=3D 0 ]; then

this results in pretty ugly output, and the return value/output of `which` =
is=20
not portable.  use the type builtin instead.

> +    MAIL_NOT_INSTALLED=3D1

you should make sure this is always set/unset at the top of the script so=20
parent environment poisoning wont screw things up.

> +if [ -z $MAIL_NOT_INSTALLED ]; then

tests must always be quoted:
[ -z "$foo" ]
=2Dmike

--nextPart6677785.CbKdxa4aWj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg7sRAAoJEEFjO5/oN/WB5twP/AkusFBa1cGx4NYAHY18Qmvt
V2EHASehkuRB2YYITikaLuDNCmenMOmC54nGaO5k6vaCx/8fv58UYdQLkH7hRTBz
YO3jpTJhVf77X8JIZZrtBdyvAKq6DhnOnUCgcOsylSOyQFnUyGrMdCzlembmqqyG
5BLXlFPATA+/Ee0cfUhP9yZjUCtyF1aCy3mhwUFd0V0qhtfr3/IU2p4lVUMRQ5yB
ZlI8IoBbHTWQo4luOa6x4CxaJW4wYTLC+8TYmEAkAnCZRJy81XG8mQz03UkDIUtb
0fDKuogrgPdMMU6xSkZYuGQ8GVVyuU78VZU2A9e2HdwyjNKVAGigEL7M7VaZkz27
0sboBVH3guaRkWUmBdJiti1XTKuRqWGy3UBI0Hd56SQPrLC1Dn8xWoyE0xeHEkOB
k1uPz9fbuzFB81sPccTe9jA3ejGM+eNhfbKwPyq7nEDxq3zK3H1Ip7sxYoTOxc+r
LOzjFwdNKf6OEaaqBe3HTB5QKADukefaLRJye4i5S6jQTcAM9ZYuxUye92EXU8HI
twzwQswOWQM4jABXxegV9gdYM8uG1DS44sfibSdoYEPlfuB2UeWu9lJhvjDEtPL6
CVmsX1ExQIh7jDPTnWw2B7/01Um07G2OFm+hKCdlHYC/VSvcjFw+IvaiDQH/b6f0
uT5eFSFqjqPjEEayGoMe
=bOpy
-----END PGP SIGNATURE-----

--nextPart6677785.CbKdxa4aWj--


--===============2337681123672932575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============2337681123672932575==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2337681123672932575==--

