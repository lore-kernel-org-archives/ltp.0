Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VVamU-00081W-U9
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 05:33:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VVamU-0003hN-0B
	for ltp-list@lists.sourceforge.net; Mon, 14 Oct 2013 05:33:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 14 Oct 2013 01:33:14 -0400
References: <523AF25C.1010907@oracle.com> <20130919134049.GA14290@rei>
In-Reply-To: <20130919134049.GA14290@rei>
MIME-Version: 1.0
Message-Id: <201310140133.16162.vapier@gentoo.org>
Subject: Re: [LTP] Policy regarding BASH
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4468477533980238315=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4468477533980238315==
Content-Type: multipart/signed; boundary="nextPart11633826.J2i5veZROi";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart11633826.J2i5veZROi
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 19 September 2013 09:40:50 chrubis@suse.cz wrote:
> > So what is the policy regarding bash presence in LTP? Is it permitted to
> > write testcases using bash specific features?
> > Or are we strongly encouraged to use "common shell" only?
>=20
> Just fix the tests to work with common shell and send a patch.

and please do not do it blindly.  running `checkbashisms` is known to produ=
ce=20
false positives.
=2Dmike

--nextPart11633826.J2i5veZROi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSW4IcAAoJEEFjO5/oN/WBpooQAMeX4e9Kr0GzX54eaFk0xqBS
CuBlqR2l9BF61XsHSOur2B2r7h/mYjv/4ze2WlsnxcvUxbTVnsNZVw58wSz3rkIY
090KD9rcANt7eL6gAw9Tbww6jHOln8Oqc+cAKVeLoA5NjFjaAgn1NinTIUGJJ8Xd
QU5r8J2SvC/t+ZVBcG/+BoARbJYcIUhieZZpumJuEn+aWbDserEjetNqpoyaml5w
E4GZ5NvXuEt/mtyC0gYDG3D8LrOQhTIUTVmfttpgnyRbMuUKFgFRGV9zwK6b8TaK
0c9WEYk8chtrP902PVU0N+FPnahzxK7VhEfr8ZMRr2kZeWl6YIkACNh7znmv2gg3
S2M5BUG/D2UtglkGeS02Pzz8zqK2MZ0BSEQ2E23+Z3mLnyVsis3HaZeWeyssJ8po
hAlJQsweMv9ERJ3F91tEFQl0qYG/jHbhTIMf9P8yOWEzTlYvvtQUmHarcLAVGi0d
PYo9Gquq6eddKv8oOPWTMHLfK4hzpUluQYs/njwnlIEDWXAreDpweV5yzP4BxRDQ
e5XO1Ct8TY/ev2W82TL28j9DJx9CBunRSt48wBZtfAOGVUkOuwj3NuuoxcR6Wfus
tjjQIU+Kon2kvfpkKWm0Zxt3NoaZJqU9Tq+WErRjY6OdcLWOcLbfMSv3Evi12gjk
UppGeIjag26GoodWcqBP
=u58i
-----END PGP SIGNATURE-----

--nextPart11633826.J2i5veZROi--


--===============4468477533980238315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
--===============4468477533980238315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4468477533980238315==--

