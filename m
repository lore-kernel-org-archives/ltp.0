Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUuo-0000uc-OQ
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:40:02 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUuj-0005QE-R6
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:40:02 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:39:50 -0400
References: <364299f40908022332q29608627vb36b1c5c7c996b93@mail.gmail.com>
In-Reply-To: <364299f40908022332q29608627vb36b1c5c7c996b93@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200908130339.51018.vapier@gentoo.org>
Subject: Re: [LTP] [RFC] Bourne shell command library
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4338597025864409667=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4338597025864409667==
Content-Type: multipart/signed; boundary="nextPart3491084.QKItRA3TJh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3491084.QKItRA3TJh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 03 August 2009 02:32:59 Garrett Cooper wrote:
> export SHELL_DEBUG=3D${SHELL_DEBUG:=3D0}

does this really need to be exported ?  otherwise, the simpler way to write=
 a=20
default value is:
: ${SHELL_DEBUG:=3D0}

there are a bunch of places this can be fixed in this file

> exists()
> {
>     for cmd in $@; do

you should always use "$@", not $@.  if you actually want $@, then you shou=
ld=20
use $* to keep things clear.

>         if ! which $cmd 2>&1 1>/dev/null; then

which is not portable.  use `type` or `command`.  $cmd should be quoted.

>     TCID=3D${TCID:=3D}
>     [ -z "$TCID" ] && TCID=3D${0##*/}

does this really need to be two lines ?
=2Dmike

--nextPart3491084.QKItRA3TJh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg8NGAAoJEEFjO5/oN/WBtHEP/1+EqS0F073xRep0s0tXKm94
esSz/GqzL8ahYw0OtQHhc9OlYhQx12gw97rN2lpELSWI0dRLsROzWtAOPziNtbh8
QJHKHzyIf7G68lYCuM9PdcIxoe4t/96GElymJj6CwLlHRx6zL5fZz1O9gD5HYZKZ
g7X8sftTOoGLbZTd9GL3nNE3CwDEoQXpM9iOUGSdQ5+u9vDvwUZ0GeT/cl21rjso
YUFVckih3dG+A3Lj5Gm+IdnVq//5HKUbUQgAJ0agXu6aOtauvARAMb/0QBRYAK35
wPTEPcSA7OqZXZota+qeipkGwI55F6Tp+q9SHefGPjIP4J+TPM3GEqCQGajf+2R4
GhjG+fEFjmnOuaj5UNU0NoIV6GKAr0k26BfGGWJh+ltvLLmaXvp4gi43GU6biPLX
73Sgpd9Cm0lJJhcprAYMvJbn4m02XfVEM1lgfKlLDEZz+eDKQWD5hzZ865KBmVid
fCISqyXRM/HwmpxgptCxmezlOwzfLY1+HAWhjrtUsu8KyFXDojbr0XuLnH5Gx1NR
HSsM6yyEuA8mK+YOKKg9gFYx5MplhLyUT9P4zgs2xHvk5BdtxLiYyK8LsTZuOigg
CyaduE9BJ0yx6AFCUAvntaFrRoyYc2zURGtE5xgqSWad7+dHH7xcMJZfa9JDgZYZ
2W2VkAk43ckrQ3t1goeH
=ND/U
-----END PGP SIGNATURE-----

--nextPart3491084.QKItRA3TJh--


--===============4338597025864409667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============4338597025864409667==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4338597025864409667==--

