Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PXz7C-0004a0-EU
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:43:06 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PXz7B-00084E-Mo
	for ltp-list@lists.sourceforge.net; Wed, 29 Dec 2010 16:43:06 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 29 Dec 2010 11:42:31 -0500
References: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
In-Reply-To: <AANLkTi=TOy3i69CnLoZPK+rYqUQ_TfCQXmV=STzYop2i@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201012291142.32471.vapier@gentoo.org>
Subject: Re: [LTP] enable pwrite for 64 bits test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3687034404970452868=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3687034404970452868==
Content-Type: multipart/signed; boundary="nextPart1653955.PvJseYjm1f";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1653955.PvJseYjm1f
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday, December 29, 2010 04:35:45 Vivi wrote:
> Enable ltp test of pwrite for 64 bit test.

this patch is fine ... but i had to merge it by hand since your e-mailer is=
=20
sending both html and plain text.  please disable that.
=2Dmike

--nextPart1653955.PvJseYjm1f
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNG2T4AAoJEEFjO5/oN/WBFmMP/0xxz4PxJ3d/PC7CrQkNBkzj
5LDvxBlSV5s0muFcLlt0ZtUNAxMJoaA4cCmYpkW7GqugbidIGu10e0ftAjUqc9pd
6I5AOzUJrE6VF4C8W/5We2AJJtpsBSrSAh6XNe35NGwYg8MQxQsorGcqEz8yHLpy
9oD7QntqrVIsjtLNRy90zKDy6f5PXlkx4rUpulzpMReix6OYARKe5fwEUOLmqgvX
0EzCPmMkwUUhIawgEZwfASMKS5GaaggfcbhJce56Ones8Vmpsukd9tGBXCENewbY
ag1CNVwKX/el2DSUzJmRj2GdlQQyoOJIw+Xzuw0fgIjrH5Xmcaq1ahJEZRn9fJkt
aBmyhYSQg4HFebKJyWxwzrL9Jqk39GkEUSEkxq61/NHlwBSPQLRY7gQs34aBnTX2
Vx6Mh8eIjy7QMiZ7O63AQV/n8C9cYs54QXx9fVYSPnl2hRjF/Gvq3E3I0EzwPiw0
djH4POrK/hYjmjOHt4PdQ7tX2bM4CKnEPnfXFDEfdabUHj5P6As/EoJBd4o5JNSz
750Wb7+ejSoFWPIrcI6tA8HPIWA40MgUnb7inezWwhc+Vkc7fU+PmPXVsoa4bgZg
mXwpTyql/lLkpxmfQ/80opnEuKxXPZiD+bYn/0P1XtyXelHarPqlYKnIFYOjhYjl
Xf19ssBC2OUVHoms81co
=QmtM
-----END PGP SIGNATURE-----

--nextPart1653955.PvJseYjm1f--


--===============3687034404970452868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
--===============3687034404970452868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3687034404970452868==--

