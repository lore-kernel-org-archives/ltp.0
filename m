Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1YNE14-0006Ly-Km
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 05:14:42 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YNE13-0001u8-MN
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 05:14:42 +0000
Date: Mon, 16 Feb 2015 00:17:04 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20150216051704.GB4075@vapier>
References: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
	<1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
In-Reply-To: <1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [PATCH] ltp: Fix cross-compile issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1522879095490357784=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net


--===============1522879095490357784==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Dec 2014 15:34, Mats Liljegren wrote:
> --- a/m4/ltp-tirpc.m4
> +++ b/m4/ltp-tirpc.m4
> @@ -25,7 +25,7 @@ AC_DEFUN([LTP_CHECK_TIRPC],[
>  	TIRPC_LIBS=3D""
> =20
>  	AC_CHECK_HEADER(tirpc/netconfig.h,[
> -		TIRPC_CPPFLAGS=3D"-I/usr/include/tirpc"
> +		TIRPC_CPPFLAGS=3D"-I=3D/usr/include/tirpc"
>  		AC_DEFINE(HAVE_LIBTIRPC, 1, [Define to 1 if you have libtirpc headers =
installed])
>  		AC_CHECK_LIB(tirpc, rpcb_set, [TIRPC_LIBS=3D"-ltirpc"])])

this m4 is fatally flawed and tweaking the flags won't help.  we should swi=
tch=20
to use pkg-config here.  a cursory glance suggests acl/cap should also be=
=20
updated.
-mike

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4X1QAAoJEEFjO5/oN/WBSjwQAKmh/FSveHhRsQ4U7Nb/V4Sf
4Xixp7KBn4WlRWDM4GAQ+klC+zLTt67BpYqgbWRIe4dBTSjB9qIWkF2O1x58Sikg
OkQWCEuU07q/AVS9RLy2h/vA+7c9sKihlQRnk/fPp88effvy+oXemvzzfnoZSBEz
+DFOQqMh8g1w7bhdVq5IkjxwfqoaRbpskTGtjMVcFpiukPKufz/N9+bqgb781YHM
2OoGUQXJ97mq7I3AmGpmmlLLd4WmaPHr7oKmK8lx7Jh2mnUEEwDT7B+TrtAO495j
ZY+6b9vyoAdW0YQtSIUPLAIezyRrSRMxP0fB4C3UITQ66dRnagHyqbccRI8Rwv5I
EgHzcjJSkKSjPy5/PfF+beu69YSdTmGDKu1pay9kxdjwqyHU/NKs4uW5cJ+nuPPr
90ShxPntgx0C6cVWCnqPP24LKYtWkCkA3qqdIKMLceApZysFHoXrG7tP7341lPde
f7ZjX6HeTrcfNb13jWOWT9FfxeBpZdAtckOKE0mqFwBzDFOfz716GDeQ3H/Fn26R
51hDyeh+0rcfSyOVOoUHKUnWdTTX5L9KYWKjdYass2I07zFD7SJq2hpOxPyGzwZY
1LfTWbddo+Iw70cz3Y8CKQMdmueYSu3tSzC48M7Xq90F2axuSbucuXoOM31Nr+Pq
HhsQemiOdQw/RUgfVUGH
=kVRT
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--


--===============1522879095490357784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=190641631&iu=/4140/ostg.clktrk
--===============1522879095490357784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1522879095490357784==--

