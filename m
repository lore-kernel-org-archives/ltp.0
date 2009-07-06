Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MNjXb-0002Z6-Mg
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 08:27:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNjXP-00037l-0e
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 08:27:03 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 6 Jul 2009 04:26:56 -0400
References: <1246864076.2865.35.camel@localhost.localdomain>
In-Reply-To: <1246864076.2865.35.camel@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200907060426.57132.vapier@gentoo.org>
Subject: Re: [LTP] LTP Build - Would it be possible to handle testcase build
	failures without failing all the build process?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5171077929139729721=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5171077929139729721==
Content-Type: multipart/signed; boundary="nextPart1748061.HOYI5yfJTd";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1748061.HOYI5yfJTd
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 06 July 2009 03:07:56 Lucas Meneghel Rodrigues wrote:
> LTP does have a large amount of testcases, and most of the testcases are
> independent from each other, thus IMHO, a single compilation failure
> should not fail the whole build process, instead, the tests that could
> not be compiled should be marked as BROKEN, and should not be executed
> during LTP execution.
>
> Do we have any plans to handle individual build failures in a way that
> doesn't fail the whole build process?

use the -k option with make
-mike

--nextPart1748061.HOYI5yfJTd
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKUbVRAAoJEEFjO5/oN/WBVHYP/1Yiij1f/csJrNVUptgdsQ9Y
8N0weUpjUVM+JiwTq8F5wmwo3O0j1gupaQCqYyk7g9InHzbrUhHAlEG0XFNujUSM
20nC34HBJHO+0hmrYNYtKdiy+Rlef51tUuZp+oiz7jXF7YHdwn2TR0z2rsyOzq6u
I6X1s9pilrwWe4aqxR7EeWu/bb+QOz7gquaMMUCkIvSKQlaqxCbXnac++fLI/wsv
zq5aCZtl+ijtVLWoOVVp313enNOugw3TV1ZxB5yhd/ELl8C/TExtTXZ1dynARUVy
LBNAw0aRbDcYxuN731ZYDS+daGRVoCae3w8fkavIVkSZNwrv35KoCjzUDC6lmB//
mPD+FFZAhMkl0nw+NgJGtW/0kobrzye6cj6qzkpTKThSe188Vs6ebwcWMUbjbB5g
GDw5X1682lhoHE6KFjvCt+O2jVqWKSpWC4SLEcfArnoet+HspTp2jiiZPM+s+j3E
fZY5whmRYfMW5AFtDXnJDye80xJabri6c0v/1DTCIVwp9vw+neccUBEelh3BHWzH
6qFyrzWx5l3fNb5cgPQtQoL+8cwH9sKOd5pfBy0hc4GqnE0nja9xPQcf1Ysf6FYH
kpVzU1kccxdu6lw0w9x7EBhEb0IYtzQiVjRK8h5thXx8c1Rf6dOO5Nmt223yNKJS
aq5+2SSG16Qfiwm8iJeU
=EWYU
-----END PGP SIGNATURE-----

--nextPart1748061.HOYI5yfJTd--


--===============5171077929139729721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============5171077929139729721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5171077929139729721==--

