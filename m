Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NFbrg-0005v5-C4
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:10:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NFbrW-0001LQ-Gc
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:10:34 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 1 Dec 2009 18:15:11 -0500
References: <4b159725.8d13f30a.7a77.1f9bSMTPIN_ADDED@mx.google.com>
In-Reply-To: <4b159725.8d13f30a.7a77.1f9bSMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200912011815.12315.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix a wrong (reversed) success condition in echo01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4395402509481894463=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>

--===============4395402509481894463==
Content-Type: multipart/signed; boundary="nextPart1414320.fmPvgkduF9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1414320.fmPvgkduF9
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 01 December 2009 17:16:45 Jiri Palecek wrote:
> -            if [ "$csum1" = "$csum2" ]; then
> +            if ! [ "$csum1" = "$csum2" ]; then

please use [ x != z ] rather than ! [ x = z ]
-mike

--nextPart1414320.fmPvgkduF9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLFaOAAAoJEEFjO5/oN/WBpusP/RGGvakqZegEHAs7XMCL7jFE
AmHcBpH2bESieIVrk8p7eHr3olm0U5N2V7QTzNU91xyzkUXRsUCryYPOljB3Xx0P
kvALS+0odiE7fJlsh0w6/mgh62fMnouI/VIuQfZrbcGiHFWFFkXLjC4avC9qeBtH
+w/f2oBa7TCx8jNYC1+PyVDPfcsh7SfZc1Rcgoo/1yJ8cPtW30WDCimtvLT90dkS
TLvuO+KDyc3sUAtH9LikQl+vNbCiDv0vFH+Uzws7JPVcqLNPOyW5dcDc8QJLiMRp
CrcREPzFGv4n6D6ilLQWBCTK+QB6qyTa5S3gF2BFMf2C4oBWn/x88Q9PsIXyYP12
ANUrF2sO8UsMDu2g/mQ/oRlc42zFu9RE0n9kBBn/5EpQYYybfhk4hzQNRqOJNtBB
cz1Ja/nZ9nrQd3KtKLUacRrddUtomCJTBihGIRTOAs7QFGBHN+VM6JpC01r+4MPj
Q86o4boZbFB9Q4OAH1/6DFf0iTJFizmypJTg5z44ngzTYlqVQKF689/mMCRFJK0O
/Mqdb/eDXMZGBMgWcGcmUpUIJmI33rwPoQYhLSTWJDBUDSKHOwK0gMEEtxMM+/nm
v6hfLx7LsoOKZrqSGZrmEDGTu5CsWPVJv93ZaqUyxyg4Ka9wDGh1TyjBreCMLkD2
uI+ERsD82DJJn51eS7MR
=LTbh
-----END PGP SIGNATURE-----

--nextPart1414320.fmPvgkduF9--


--===============4395402509481894463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--===============4395402509481894463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4395402509481894463==--

