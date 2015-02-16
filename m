Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1YNHho-0007L8-Hl
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 09:11:04 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YNHhn-00017r-KZ
	for ltp-list@lists.sourceforge.net; Mon, 16 Feb 2015 09:11:04 +0000
Date: Mon, 16 Feb 2015 04:10:57 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20150216091057.GI4075@vapier>
References: <1418740497-24661-1-git-send-email-mats.liljegren@enea.com>
	<1418740497-24661-2-git-send-email-mats.liljegren@enea.com>
	<20150216051704.GB4075@vapier>
	<0247700D01F14443B9209F90AD938CC524E65CBB@SESTOEX04.enea.se>
MIME-Version: 1.0
In-Reply-To: <0247700D01F14443B9209F90AD938CC524E65CBB@SESTOEX04.enea.se>
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
Content-Type: multipart/mixed; boundary="===============4246961159111714710=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


--===============4246961159111714710==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nO3oAMapP4dBpMZi"
Content-Disposition: inline


--nO3oAMapP4dBpMZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Feb 2015 08:15, Mats Liljegren wrote:

please don't top post

> My change never made it into the repository. Instead, Cyril prepended the=
 path with ${SYSROOT}, where your cross-compile environment needs to setup =
SYSROOT path in order to make a proper cross-compile of LTP. See commit d4a=
b5d27d5ad666547d7b4d8e269e00921960c58. Cludgy, but it is simple and it work=
s. This "=3D" thing I proposed apparently didn't work for everyone.

i'm aware.  that's not really the way to go about it either.

> As for using pkg-config, I have no idea how that will work out in a cross=
-compile environment. But I guess it should be possible to go down that rou=
te as well...

pkg-config works fine for cross-compiling.  it's pretty much how library lo=
okup=20
should be done nowadays.
-mike

--nO3oAMapP4dBpMZi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4bQhAAoJEEFjO5/oN/WBFgAQAKdO6ZX1/b7pO8mCNtVbcK0f
3+eMWpcbeSAPtNUMT2kVr1nWerLNP2bQCE6VL3uiPbU0CBlnkCyP5lAtrWv4RXRM
XTNoKx/DLkn9v4KaRNmbnM24qiO44QiDQtXcTACvwkk+Ex+7kg5tXFrFNtAidlyQ
7y7Ip/yeoReaQXJedEaQOIE5QJZXpj/j03Z492/KCNNYu6W6vbWRzq8xd1kAwTvN
5y59nEVqLRBOS+WShQ/h31ElMICdDW8tQjX30+N6fVXaNEVQvNn+3Ws7wfmy9p0z
Djmq/OGC79LsqDGVisAWMTUBicOGjvIZ/vBr5QxJnGyGP2AqQVJHFGzlTmVuVNXl
HOovFHhYrS1mpT6L7LhMruK86XktpB92M0sNEUnKkIvgh/ris8p9PUNzIcdo6VXR
qZSjIAN+i4s56FbIKyeaC5saHvOuXB90B36zRBb4cksDAtK+R5bA9PLGnR7HFPwK
YxoQNLeOvFBz5XgsXuOv8dFgAaO3IsvFW4mMWPzkr3GDOZFNqXWX4nYQTWzSsvis
pLg4lbL1UD/toFYO/OFmmwYNggFO1j64SmqI8Kd2DXZQScS0DLdc7COBY/rvw/Lz
9Rf7QxMhEqjzAVWqpH/O1soGOhz+P8yvF/PvYmCiLc0onrtTPHVx1C/Lp4bUntQY
3ITVfTMKcxAmLzWQLsJ/
=pd6k
-----END PGP SIGNATURE-----

--nO3oAMapP4dBpMZi--


--===============4246961159111714710==
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
--===============4246961159111714710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4246961159111714710==--

