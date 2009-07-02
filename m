Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MMRA8-00024g-QS
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 18:37:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MMR9K-0006Tf-1B
	for ltp-list@lists.sourceforge.net; Thu, 02 Jul 2009 18:37:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 2 Jul 2009 14:35:46 -0400
References: <20090702084828.GC19135@count0.beaverton.ibm.com>
	<20090702090532.GF19135@count0.beaverton.ibm.com>
In-Reply-To: <20090702090532.GF19135@count0.beaverton.ibm.com>
MIME-Version: 1.0
Message-Id: <200907021435.48510.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 4/4] netns: Change interpretters from sh to bash
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0162681854386897820=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Poornima Nayak <poornima.nayak@in.ibm.com>, Daniel Lezcano <daniel.lezcano@free.fr>, Veerendra C <vechandr@in.ibm.com>, Munipradeep <mbeeraka@in.ibm.com>

--===============0162681854386897820==
Content-Type: multipart/signed; boundary="nextPart1957566.MmS7zWs4L4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1957566.MmS7zWs4L4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 July 2009 05:05:32 Matt Helsley wrote:
> As best I can tell these tests do not use true sh syntax -- they use bash
> syntax. Rather than bother hunting down all the bash-isms just convert
> them to use bash as their interpretter.

the changelog doesnt seem to jive with the commit.  if you were merely=20
changing the shebang, why did you also fix the bashisms like s/=3D=3D/-eq/ ?

at any rate, someone (i dont recall who) posted fixes to these files recent=
ly=20
to de-bashify them.  there was some feedback though, so perhaps you should=
=20
address those minor issues and submit an updated patch.

in general, converting sh to bash is a bad idea as it can cause issues for =
us=20
embedded peeps.
=2Dmike

--nextPart1957566.MmS7zWs4L4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKTP4EAAoJEEFjO5/oN/WB3pwQAOWNivSZYoGcY1DJnzfU6i/E
7waAkpDVRzibEGxYRVqH7TP5RjjR/GGV3poPOMgzrix4mJWmF/JMfVn32aIXbXHr
6LrWSaFBmjfatG3P8njk1+L81ZG01BrVolzsw0CjsVKMGyEUi0zORiAjLdb8RHx9
yWpmwuPT0tbLLKN6G2Urc4Ar0LyxkT7PEKi+Eh8I07/w0vNWQgg0DfyFJK03xSgw
9LJGv7tYVqvrPP450nBZExBCg6M9uedFYyD0BISkvt8bPcxo0cXhfTjwGTZvZ6YB
q+i3HNsqzKTBQHFY4svLQ1W7WYO37PfiXZoXy1T7aOyUkwEzRVRNwXCjgRl3/ab2
piyyjMK3ujZnOkFJ2999nPt36ZTiW0bAc0cuimqlZmW9O2MWR9wjOnNwQdNTNEC/
fTGFih7ka+YWs1Uni6a1udsz+Y6hGd8LBfbEDtFdtLbvKM+C6HfEWkUfCw3rVfSJ
oSRAfoTfsJtbxUctDi6xedhWxKUfiEK3Yjt1DDTStnWGRBWYhcYwlbTdJd2MJHRX
UisbTW8Lv5VtBLcibUSHc47tHxY6bieSAOo3n1LutfBN1Sy0Thzp9EbmGPF17lHC
JF3Tf+2flk8QolZUg6FxOH/Ec50kTXUo9SKBgXzluY2O0sPkE76OHNBYL6Fr7cON
293Lyy/M0mUOQ5YuKZMt
=ss60
-----END PGP SIGNATURE-----

--nextPart1957566.MmS7zWs4L4--


--===============0162681854386897820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============0162681854386897820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0162681854386897820==--

