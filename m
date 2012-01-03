Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB2D-000068-Js
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:32:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB2C-0000Sv-V3
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:32:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:32:43 -0500
References: <4F0301B5.7090006@imgtec.com>
In-Reply-To: <4F0301B5.7090006@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031532.43890.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 20/21] nfs/nfsstress/make_tree: Replace integer
	cast to pointer with 0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5212959484182816986=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============5212959484182816986==
Content-Type: multipart/signed; boundary="nextPart6696323.eHk7fkHk14";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6696323.eHk7fkHk14
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Tuesday 03 January 2012 08:25:09 Markos Chandras wrote:
> Hi, please review the attached patch

looks good
-mike

--nextPart6696323.eHk7fkHk14
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2XrAAoJEEFjO5/oN/WBEmoQAL81iv55Sfhh3yALygFB/XAf
CsAA+vv/ubxbnkXYbgtzruTca/GYPhuSjz69kCSVImzoGsf1XwWBp/wG+fe9EjFQ
zZx6DXtEJnR4yDggpOeAZmNE3rSL0aufnzGkfP7kZDqQzJ2a6ZGk17+DptyNzbQ1
YcE2ZhX+09tPiLZcq+ddCuwbrDcH8RlrJTqilRiHwQ9kvpQjy7riVtSzxE71Mdta
22VSADNfQnoh+rZ+y8WxBEGU10iEb7+PD4Zs+PeuoBAcNmI0hwLKwJ3gcubWG5On
nouJIR9LZtLfOmxnewph7td1BV8B4Y361O/5OSibtRa0+zCAoQSQ1AZUe/8+2ZaF
+2tpPHPR9voqUxpOIcLFv2aSUJEv+/22ii63vI8koHQHU3E0MkAHHlnodwZT6c6I
YYILlWqxq1eZtKsIon8SuE4cOa/2fT38xCErRVelypvVUh8LnGNdhqHke5zZLOvm
XYjE9j8HfopuAyKZzJWP4ISadCuAN7fwweO/SaHrs4VGdeJyFaMkFJJcfsYXwPiO
Cfm3Dpm5l/qVsXIZaHiDS4/BqXBHXs+VcfCq1dclmuYSB7B7mOi2Jasf5kq2TqEm
ChwRhyFhoiocSs6b8GxH9Fh6ZJrAAJP2I2oyYgeqmxHCEWGUhmbLEIzRm9OlcJ+V
NgBFso2sYb/evcbp+cLC
=skB1
-----END PGP SIGNATURE-----

--nextPart6696323.eHk7fkHk14--


--===============5212959484182816986==
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
--===============5212959484182816986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5212959484182816986==--

