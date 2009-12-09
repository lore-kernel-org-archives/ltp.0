Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NILIb-0007ln-W7
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 12:05:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NILIV-0007Ai-N7
	for ltp-list@lists.sourceforge.net; Wed, 09 Dec 2009 12:05:41 +0000
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id E490A67F0A
	for <ltp-list@lists.sourceforge.net>;
	Wed,  9 Dec 2009 12:05:28 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 9 Dec 2009 07:05:49 -0500
References: <000001ca78a2$93fd5a50$bbf80ef0$@co.jp>
	<7F8A730D-2350-4FB1-8A5A-F37B8CFABFE9@gmail.com>
	<200912090609.08566.vapier@gentoo.org>
In-Reply-To: <200912090609.08566.vapier@gentoo.org>
MIME-Version: 1.0
Message-Id: <200912090705.49786.vapier@gentoo.org>
Subject: Re: [LTP] make error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3253596540771837601=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3253596540771837601==
Content-Type: multipart/signed; boundary="nextPart1819653.sRLzcsLJEn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1819653.sRLzcsLJEn
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 09 December 2009 06:09:07 Mike Frysinger wrote:
> On Wednesday 09 December 2009 02:48:45 Garrett Cooper wrote:
> > I'm making multiple versioned copies of Fedora based toolchains and
> >  sysroots to work around these issues, as I don't have a toolchain setup
> >  for ia64, nor do I have real hardware to compile on. Really
> >  counterproductive when trying to resolve these issues :(...
>=20
> Gentoo has ia64 hardware you could get an account on, and `crossdev` shou=
ld
>  be able to produce ia64 cross-compilers.  due to the libunwind funkiness,
>  ia64 tends to be one of the harder ones to make cross-toolchains for.

looks like things are still peachy.  i love when things just work ;).

# crossdev ia64
=2E.. wait a bit ...

# qlist -I -v cross-ia64
cross-ia64-unknown-linux-gnu/binutils-2.20
cross-ia64-unknown-linux-gnu/gcc-4.4.2
cross-ia64-unknown-linux-gnu/glibc-2.11-r1
cross-ia64-unknown-linux-gnu/linux-headers-2.6.30-r1

$ echo 'main(){}' | ia64-unknown-linux-gnu-gcc -x c -
$ file a.out
a.out: ELF 64-bit LSB executable, IA-64, version 1 (SYSV), dynamically link=
ed=20
(uses shared libs), for GNU/Linux 2.6.9, not stripped
=2Dmike

--nextPart1819653.sRLzcsLJEn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLH5KdAAoJEEFjO5/oN/WBnSkQALotJMJi7DJ19U7nHgsg1sD6
qvRYOtLc3LphC1eb3ry2ZKR4OpFOkdeJBCFcOQWo6PJtEvTmZo4PbhfgQFI9ZRQI
HijcNghktCBEyuzL5QnXWDBowmxnj/9B09/R9yvvyz9v76dCGr83ljP4rRyIBpTY
ehxQrQA6mZk1JfkAcoi7KrXLrzVhIPriS5DPePNpFCzTuP4h7TxSI6hsDBicvqUt
mPStpEK/hY56un/EfHM/PlLCBRuYs2xtrxauTXVbDh6c7Qulm+5kSoiTgepA/OkM
FukIxXYjwdMb2JTqm1QHhVHoNVdQOEkK+Rn40K9OjAfQoa/FeBk3OvQtGuCV8fV6
2OC/9C1Ugt3rfgK1tpeIDIW5nZbcg3QEAdn1lmFkZLLJdkNKK08+4UVCD7eYXrib
LEXTfyTjxN/StT4CPtUSCCo3AMrrkuKPz4gchBGq6KMfDxJjo6CBy62iJkjXez2J
dpmT04WuR0OLcdS8Hp6IG7FeuUBfBRzifO5IfylPBrcWDVNHocWDuOp0rHUFvWsY
psbjLV5OsRSZa2q1V55KHBaldvJVBXU82u9cY9zcMfaxO044TQFUuCOdYT1yQo1W
UhB9tF01PplylLDvEhyUvgncPwdM6qhYqV1XDpi5jN5wkE9DOF6+ZXPYFyzv6v1W
U900fvFYru7LaT9NST6t
=cEQf
-----END PGP SIGNATURE-----

--nextPart1819653.sRLzcsLJEn--


--===============3253596540771837601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

--===============3253596540771837601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3253596540771837601==--

