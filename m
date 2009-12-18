Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NLhbt-000778-Bd
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 18:31:29 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLhbl-0006SV-GJ
	for ltp-list@lists.sourceforge.net; Fri, 18 Dec 2009 18:31:29 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 18 Dec 2009 13:31:35 -0500
References: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
	<364299f40912151139s38bd457eg88c6908d805f6ab4@mail.gmail.com>
In-Reply-To: <364299f40912151139s38bd457eg88c6908d805f6ab4@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200912181331.36093.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2544585718207183435=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2544585718207183435==
Content-Type: multipart/signed; boundary="nextPart1655598.yek2zWuJEq";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1655598.yek2zWuJEq
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 15 December 2009 14:39:24 Garrett Cooper wrote:
> Until this issue is resolved (I ran into problems trying to use
> crossdev, so I'll have to manually inspect headers after I track down
> which versions are used in the Redhat distros specified), please
> remember that you _can_ always comment out the line which says:
>=20
> /* Define to 1 if you have the <asm/ptrace.h> header file. */
> #define HAVE_ASM_PTRACE_H 1
>=20
> Actually, I think I'll just remove that header check if the build
> passes unless Mike objects, because we really shouldn't be
> #include'ing asm/* headers without having a good reason to do so
> because it results in pain of this magnitude...

i guess i dont know why you've made changes to the ptrace.h header at all. =
=20
the original one i committed still works for me on bfin/ia64/x86/x86_64.  i=
=20
dont recall any questions being posted to the list about the logic, just=20
random shuffling to try and "fix" errors that i have yet to see.
=2Dmike

--nextPart1655598.yek2zWuJEq
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLK8qIAAoJEEFjO5/oN/WBYp4QANhuoztCul/Hs9nzZxvWRbcF
MhoswPPtMbyPvHPYawuSl0XseAeFCQgpiVm1aMrHNfbZPoOHblHZ/ZdVs7iKhkNj
PaA+CrQoMnvkeRYScntJrq+A04iTHcqaO/whTIzvJA4/H+LL6XZm/5mVYKz4sZG/
F8YmmcoA6I63x4DCRR43QZ0wgutOdRNkwH070j08+5Gz0q1RIYloWGDz4eQQQI3f
fhbDIz9M2Oz5+Ozh1AWRcjo3MeTvSP8CRNMvJcidkGU8ajixWeFWUkoyiKeWtXSK
Hg2/B051CQmfdYsymLibcbSusAbWHEeraIGBXL/FfVH5wvwn6RV1j6RvFdCgZfKm
/6yeKX0O6+VZEqqSLvxeRuQ6U5/sBahMNB1ej5AnPU48SZhCGfpweM61jLDP2UJu
wofikjyIzQ4mEheZkZ/oOJfi3er6tYTW+rVWciLnFDA24EFCuJj5kzkgAfRsahXj
mRzzzHektW/fCjysvYqOwUZqYJOw54bPlu5+p93cxBjW9+yjDd55nFBfoJrKX8t8
qqlz+yjSpx3whI5E8rYqpjpQ489b6OYDkp+DLpwvlHORPN6p3n8cpCHDrMQmlT9R
TofUeI72n+eolNyqGwOwBbHPjAHx4SauzRTXikR3OywGmJcoRfQYw5H7XBP6uYXJ
uaRz9xwKZP6bgK2hX24k
=8Y2s
-----END PGP SIGNATURE-----

--nextPart1655598.yek2zWuJEq--


--===============2544585718207183435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============2544585718207183435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2544585718207183435==--

