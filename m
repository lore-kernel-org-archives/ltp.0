Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WMnKy-00014l-Da
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 23:40:56 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WMnKw-00089P-J8
	for ltp-list@lists.sourceforge.net; Sun, 09 Mar 2014 23:40:56 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 09 Mar 2014 19:40:52 -0400
Message-ID: <10580235.j7E8ls0tGP@vapier>
In-Reply-To: <b187cebc670c5e8d23f2405d95f82405a0416095.1394190599.git.jstancek@redhat.com>
References: <cover.1394190599.git.jstancek@redhat.com>
	<b187cebc670c5e8d23f2405d95f82405a0416095.1394190599.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] add tst_get_unused_port()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9181301570483375625=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============9181301570483375625==
Content-Type: multipart/signed; boundary="nextPart11540571.i1ZPf3DYRc";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart11540571.i1ZPf3DYRc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Fri 07 Mar 2014 12:39:24 Jan Stancek wrote:
> Returns unused port number for specified domain/type.

the new func isn't race free, but it is way better than the current cod=
e, and=20
the race is pretty small.  so LGTM.

> +unsigned short tst_get_unused_port(unsigned short family, int type,
> +=09void (cleanup_fn)(void))
> +{
> +=09int sock;
> +=09struct sockaddr_in addr4;
> +=09struct sockaddr_in6 addr6;

the current code works, but isn't the point of sockaddr_storage to avoi=
d this=20
duplicated storage logic ?  so you could just do:
=09struct sockaddr_storage _addr;
=09struct sockaddr *addr =3D (struct sockaddr *)&_addr;
=09struct sockaddr_in *addr4 =3D (struct sockaddr_in *)addr;
=09struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)addr;
=2Dmike
--nextPart11540571.i1ZPf3DYRc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTHPwFAAoJEEFjO5/oN/WBYnMP/2hifyZMIaqVinnVrJDrOhcm
VjCwYV+7adFhvXxhT16xBfJKLkLaFQbdpR0ZT9l59/fNbfnYcSPqdEpPgawZTSwp
wXEKnIB3GcfF4jg4C3WLCMZ+VzlqB5udfdyl4qIJ8FvXITaVIR2Ound57Yr6t3kt
IomYihdb66c7Tgb9ViwQ1vYxZSVvvRd9+xRLTzO8nY4X/76Gr0IW/CS94xXy0gs+
8z72yBBAf/jUd6/HVtEae+ZZi8dFgMbuOGozmnMZz2FuBHUEJ2Z8I67RgAdK9DjO
RxyJ/EHz3LShrnnquD0Mju97NA8DZ7lOGbpDOulQXV4OstlRemO6JnwTHHE7Zq2q
oWmuhWufLaMt4CNff1Aglgiswuo8Kr7i5swNwBDliyaaXjBhwISfciTvUZe6QKJf
7pDyZwbxIX24bBBU+qt2ThRAkRphv7oUzg8m3m/ixcsb1MQbR6//DzXlRlUn15Nt
7F6qNFwA4lRhZSNVMDQs0MsGlkaUvcFfEcbxgBv3vZg/Dt2JXPVS8lXSE2QupFmE
/nDGjznVJyAQE5sDyjTVqvWPQrP5wq1/6r24Kih3AU0CL1Zb/iSG7h5fQ5U0bOkO
nfYm3TI/kbImpuRnGMbEpaDYRZiAoJ//+4paVV/dTgTxNToJsV/UnhZZ5WusQTWn
3mpkDu2bvEtdAcNazpBj
=ysEw
-----END PGP SIGNATURE-----

--nextPart11540571.i1ZPf3DYRc--



--===============9181301570483375625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
--===============9181301570483375625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9181301570483375625==--


