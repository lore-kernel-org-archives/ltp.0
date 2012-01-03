Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiBPp-00054n-9k
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:57:01 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiBPo-0002bF-Av
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:57:01 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:57:07 -0500
References: <4F02DBAF.5040202@imgtec.com>
	<201201031537.17888.vapier@gentoo.org>
	<CAGH67wRYtWO91esDJ2KUF0Db4_K=M+N1q2+r7JiE-A2BOOeO9Q@mail.gmail.com>
In-Reply-To: <CAGH67wRYtWO91esDJ2KUF0Db4_K=M+N1q2+r7JiE-A2BOOeO9Q@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201201031557.08072.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to proper
	integers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6480960342812405524=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

--===============6480960342812405524==
Content-Type: multipart/signed; boundary="nextPart1692106.g8Z8dXy9NK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1692106.g8Z8dXy9NK
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 15:51:52 Garrett Cooper wrote:
> On Tue, Jan 3, 2012 at 12:37 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Tuesday 03 January 2012 05:42:55 Markos Chandras wrote:
> >> Hi, please review the attached patch
> >=20
> > casting to a (long) would be better
>=20
> Or uintmax_t...

that would work too, and better.  i thought nlinks could be signed, but it=
=20
seems not, so any signed type would be not as good.
=2Dmike

--nextPart1692106.g8Z8dXy9NK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2ukAAoJEEFjO5/oN/WBD/wP/3o2vGnbpZftJCgKdGALhBnM
8xZ0JgPu7rcw1I0P/z4H72ViDzeBeBidhH2q6szTmDL5BXohC53LxDzVKH70OrPL
6dVo6GD9MVMHHho6Jz4DmKE6RVJBEKSVt1CQGZqW3XT1LUjh8mr7l+8nSGRwJuOP
ZFLu8Z59+2H1AWXgzGScYuCP44iWYIICcrmS0OMEMw+HM9VWdiittrsJneoDLvBj
cMN3ZAdB2J2M62a/9TvpWag6UhOzpxP5D/y4+rt0BjSkY9UtAvvGz2HRJvusbEbY
Ohjx4Xtras7N/cGC3NKmhn8PK462vvlocuxtaFr5p9lQNMmlqJyecPMqUfKXBXCY
QpAg852y3VZfw/N1MHFuTvibQbQZ7cs9ZdorrPdlxloX3CsD1tZMC3ygT6EwhVo5
X9myZlhnOq9VhJVtGuDFjWmHRa0oEBiQjOzRK3AFfwBaZzn6MAnFOIj9KBeJ+VtI
9Cqi8fqWGLTvNd4vqEKcqe+8qJp2zaygR9pgY9FBLLx+kbi4jBHg0TJHRpDPpWoe
Yk/gnemQasDpqfVmGk36nGtrTxp6qwogVhUODhpbbTOU4sPQgfVFzqceNsgKncnD
b/iA7HPvONOohnyfoznNDcgamYBCr+g1/qZ6h01JBXS2jZjXcEv5gVcuzMfRNNUA
ZOLVVTl6GEKBGjyM3e59
=ONWm
-----END PGP SIGNATURE-----

--nextPart1692106.g8Z8dXy9NK--


--===============6480960342812405524==
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
--===============6480960342812405524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6480960342812405524==--

