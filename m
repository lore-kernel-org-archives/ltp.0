Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1OvI34-0006wY-Dz
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 23:02:54 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OvI33-0008Ti-GY
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 23:02:54 +0000
From: Paul Larson <paul.larson@canonical.com>
In-Reply-To: <1283625550.5303.5.camel@subratamodak.linux.ibm.com>
References: <1283625550.5303.5.camel@subratamodak.linux.ibm.com>
Date: Mon, 13 Sep 2010 18:02:44 -0500
Message-ID: <1284418964.3415.10.camel@plars-t500>
Mime-Version: 1.0
Subject: Re: [LTP] [ANNOUNCE] Linux Test Project for AUGUST 2010 has been
 released
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6576685127096243706=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>


--===============6576685127096243706==
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-gcoO6ZpW25KroslMejpS"


--=-gcoO6ZpW25KroslMejpS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2010-09-05 at 00:09 +0530, Subrata Modak wrote:
> Hi,
>=20
> LTP for August 2010 has been released. Please pick your copy from:
> http://ltp.sourceforge.net/,
Do we have a well-defined release process that is happening for each
release?  There were a few problems and differences with the August
release.  None of these are really huge, but they do tend to break
things for people that rely on the release tarballs for automated tests.
The fact that LTP has gone to releasing once every two months also makes
it more of a problem, since those affected will either need to make
changes that they'll likely need to roll back in two months, or roll
their own tarball.

The fact that make autotools had not been run has already been pointed
out.  The release was also done only as a .tgz rather than bzip2 like
the previous release.  I don't really care so much on that, but
consistency would be good.  Also the .git directory was left behind,
making the download size much larger than it should have been.

Any chance there might be an interim release to correct these?

Thanks,
Paul Larson

--=-gcoO6ZpW25KroslMejpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkyOrZIACgkQ3UR7ubYtCO5TmQCg4CAriyVuQKKF/tldl3/3cmbq
ZnMAoL3K6saoR7c2/1ZzrIRZrpkMaNPJ
=PFfa
-----END PGP SIGNATURE-----

--=-gcoO6ZpW25KroslMejpS--



--===============6576685127096243706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
--===============6576685127096243706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6576685127096243706==--


