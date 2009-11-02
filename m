Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N55NL-0001Gi-SV
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 22:27:47 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N55NC-0003ee-P6
	for ltp-list@lists.sourceforge.net; Mon, 02 Nov 2009 22:27:47 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 2 Nov 2009 18:02:08 -0400
References: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1257168835.4977.46.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200911021702.09153.vapier@gentoo.org>
Subject: Re: [LTP] Build Fails on some archs
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0609405718158838250=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>

--===============0609405718158838250==
Content-Type: multipart/signed; boundary="nextPart1884308.aJva49Axud";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1884308.aJva49Axud
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 02 November 2009 08:33:55 Subrata Modak wrote:
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/root/subrata/ltp/ltp-full-20091031/testcases/kernel/include
> -I../../../../include -I../../../../include   -L../../../../lib
> ptrace04.c   -lltp -o ptrace04
> ptrace03.c: In function 'main':
> ptrace03.c:182: warning: format '%d' expects type 'int', but argument 3
> has type 'long int'
> ptrace04.c: In function 'compare_registers':
> ptrace04.c:50: error: storage size of 'pt_regs' isn't known
> ptrace04.c:50: warning: unused variable 'pt_regs'
> make[4]: *** [ptrace04] Error 1

the ptrace stuff has always been fairly unfriendly to cross-arch work.  we'=
ll=20
probably have to add header tests for a bunch of files and unify it in a lo=
cal=20
ptrace.h header.

> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I../../../../include -I../../../../include   -L../../../../lib
> tomoyo_file_test.c   -o tomoyo_file_test
> /tmp/ccvzdsNd.o: In function `main':
> /root/subrata/ltp/ltp-full-20091031/testcases/kernel/security/tomoyo/newn=
s.
> c:43: undefined reference to `clone' collect2: ld returned 1 exit status

these test cases need to be changed to the new common ltp clone code.  as p=
art=20
of that, we should probably add a macro that changes clone() to a compile=20
error so that people stop using it by accident
#define clone(...) DO_NOT_USE_CLONE
=2Dmike

--nextPart1884308.aJva49Axud
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK71bhAAoJEEFjO5/oN/WBDlAP/0xOyjvP45pozPwkhXWTIiV8
5Z2oTuhfMUFJIWbSwGp/VGpzdl5mHW4qdU9KSHdhkdbolkmARokSFP5kU1VCBVK9
o9+UPoOxo/pDLJuA8/vypqvQrOwNnVTsC7so/Qm9oIp5B+M4/HUl9nNvrO6FHWgN
BvdVU51Yvdgd4DzsLZr4FfNFDbPb/4Wbau9e57auyyQdeMbrq0DUL4XuPR0MHdbx
87SEmhxy0shMKnUZ+gmHQ50HchReU3tScWCYlZM9tICfN68IfsF6E8dCb0i3Obi1
Kovha7cm5scgj5U/Rk2IwoITAnuTujPmhuEepufCdxuG7r7v4zQhCVwwKroGjuLO
cG/WcJnDvRsHoW1a8RV5i2y5iFSDCDW4g7uQZUupKKL27jmwYsatMGUKiHzNU/Re
sIlmxR9ytw829tmw0ykNIJrPKcsacGybdgzI2tHihoNWLLnoAo2LngRzNt3OteX0
qtilydwFNWOJB0meiCiregjE45M0eVPVD4lEmHVpUf2FX/g1Rm6WblUJjdI9Slmb
z/JcUu6+LU4exkoAKEEcprxf5IKJjUrBcf5+mWSEH3Yr/UUTdlky07AtFWbkVN4x
iS3l49QeECiKNGmRyOMQ9frvqDAslUBR+2XJi8bTu/wyhsmLjWOq5ahGQj9XW9Ey
rPmQcqBhjRvruvCTAdZt
=gxFz
-----END PGP SIGNATURE-----

--nextPart1884308.aJva49Axud--


--===============0609405718158838250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============0609405718158838250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0609405718158838250==--

