Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Ur8i5-0003MC-DY
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:29:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ur8i4-0003w7-H7
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:29:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Jun 2013 11:29:18 -0400
References: <1371729277-12450-1-git-send-email-alexey.kodanev@oracle.com>
	<201306221415.17130.vapier@gentoo.org>
	<51C81903.2030905@oracle.com>
In-Reply-To: <51C81903.2030905@oracle.com>
MIME-Version: 1.0
Message-Id: <201306241129.20164.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] tst_module: create new library functions for
	kernel modules
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5511892263477043890=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: alexey.kodanev@oracle.com
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

--===============5511892263477043890==
Content-Type: multipart/signed; boundary="nextPart2859812.CYcPu7GMib";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2859812.CYcPu7GMib
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 24 June 2013 06:01:39 alexey.kodanev@oracle.com wrote:
> On 06/22/2013 10:15 PM, Mike Frysinger wrote:
> >> +/* declared in tst_tmpdir.c */
> >> +const char *tst_get_startwd(void);
> >=20
> > use a proper header instead.  extern func decls only leads to bit rot a=
nd
> > hard to debug crashes.
>=20
> But, there is no header for this function in LTP, it is declared inside
> c file, and I
> used it in the same way as it was already used in tst_resource.c.

=2E.. so add the decl to an existing header and fix the existing usage.  th=
e fact=20
that someone else did it wrong doesn't justify extending that misbehavior.
=2Dmike

--nextPart2859812.CYcPu7GMib
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRyGXQAAoJEEFjO5/oN/WB8fIQAMllJkRyOW54qUdaOtdU7IKv
eulpZ+zAVWFLXTvBoDcden1R5plzosB5syvFOORrQt5vf/aWkUbeuK3u6ZO9Zx+Z
+ivEgo6VUBtGImmjaeqSv+m28x85NT+/VgN1kaSealT0JvXMhEzEmj/y0NP1E2Av
x3fvZLKH0w1gcjFT29BU1UD23z29PYnPEPsRA7FZkpP3/psUCVMBChIgA2ie+DUS
TLZ9/MUeP2OSFRqWnyr2qoIEGb7CgJhhY6ESJiGmOwip7pl9NWDvIj6oUMu9JqTl
2saBfpwCQqS1Hd5f/r1yPWev8SXQiHuhddO5CDa+pE8FahAn+zrwnVQxWoSeG4c2
/wnKVTvnIzgCYHdj1p2nK9+V9Uessw/o2qv7wN4lbc+Yoq2Qac2ota/23hwe6g8m
kd8NuCutJzCMexZLkELL7atdMrTHU0qP7f70GYFilnXBIs8WHXuB+NrOxprMqTn9
Oxe8u4mFGUjvXZQqhqXneYdTrGrjRODUWaJEZw47jXv2GOB5mh8bhVRRH45Y/a/C
xcjNuqNtwpIwpmIgGPKTCtd+j5X2wiwf36a5/zeQgpii+qd7uF3lu0FFjCdiTGBq
0KR0R2eoHj/TfXzJqyNPGF6hh6HStsXdWrCGP+SgM30LvKmVRl7RaT2eyTfz2loN
YpvXbpkM1ZMkY+Y9RrWY
=zVNf
-----END PGP SIGNATURE-----

--nextPart2859812.CYcPu7GMib--


--===============5511892263477043890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============5511892263477043890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5511892263477043890==--

