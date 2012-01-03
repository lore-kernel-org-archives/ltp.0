Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB84-0000Oj-R1
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:38:40 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB84-0001AF-2r
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:38:40 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:38:47 -0500
References: <4F02E0C6.3090308@imgtec.com>
In-Reply-To: <4F02E0C6.3090308@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031538.47749.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 08/21] syscalls/remap_file_pages: unsigned int is
	always greater to zero
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9044776941477926345=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============9044776941477926345==
Content-Type: multipart/signed; boundary="nextPart2149756.10n3GxoMfl";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2149756.10n3GxoMfl
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 06:04:38 Markos Chandras wrote:
> Hi, please review the attached patch

you should add a local int variable, store getpagesize() into that, and the=
n=20
use that to initialize page_sz rather than call getpagesize() multiple time=
s.
=2Dmike

--nextPart2149756.10n3GxoMfl
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2dXAAoJEEFjO5/oN/WBvmUP/ArkfS2bD6Wb+lIAWY3FfMoE
JgJuV89z2PzgzPahyXYzfwVZMlyxX9cFLVd/pJvG3mnTYaG4zhx78nBLptktOoGp
2I6XiwzGySkAK/LQHlEqIsry2Orgq4cyzdstJO/tWOdKdF2AspAM7fDSm1MiuHDq
+8li/xbQ7Sj2uJBkeKi4ANU2qAJitRpooNo3kLI06Ywqrvd9Hu6lsMm8bUAn80av
fWsC19xKp0trVok+HbiUdoUvBxXieABIO8jOSWhKUDl+PKaRnmhRimnSNAVv2Kp+
5Wz3fXZWt4FmaVnPurDqOcRINbQhSyTvyQ+1j0pPeSHGG4ZPxpcuIX+3cHzk34ek
e7weTpMRRHhLOKiVaAuTg+fpvG6HTCmjcADS7IA/A2r6euLmZt8msizoS7/HoKgA
EPzukBS3o7BT76X25HlGxm/t97GN5kX6jDzK818EtmOa4PhE+5JaPFsJ45ww9MaV
YgpL8k4FMIhZiHp6skcD6zkxSq26/c9TfEsNmQqCwcvMH4/z9+/qaGPpQVNH5x4l
RvLqO7i3Kil1wiqzqfTmV0tzvKWQSbB1cBqpndHDEBx5+fE3dk4aFJPxiLrxdLQH
fV26u1gpcoxdMJI8RF53b+XUHkxG1DiptEjbM5v+BQNJAExqFje7Cr5hDQSy/kFc
1Gv6eJ7p1TmOgBcg3l6K
=SglP
-----END PGP SIGNATURE-----

--nextPart2149756.10n3GxoMfl--


--===============9044776941477926345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============9044776941477926345==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9044776941477926345==--

