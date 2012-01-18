Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RnXFz-0001rX-B1
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:16:59 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RnXFv-0001Ir-If
	for ltp-list@lists.sourceforge.net; Wed, 18 Jan 2012 15:16:59 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 18 Jan 2012 10:16:55 -0500
References: <1326897408-26778-1-git-send-email-carmelo.amoroso@st.com>
	<1326897408-26778-2-git-send-email-carmelo.amoroso@st.com>
In-Reply-To: <1326897408-26778-2-git-send-email-carmelo.amoroso@st.com>
MIME-Version: 1.0
Message-Id: <201201181016.56309.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2] profile01: fix build using uClibc runtime
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5227155376316249565=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5227155376316249565==
Content-Type: multipart/signed; boundary="nextPart45785709.iDmgNu7WT3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart45785709.iDmgNu7WT3
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

same feedback as the getcontext01 patch
-mike

--nextPart45785709.iDmgNu7WT3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPFuJoAAoJEEFjO5/oN/WB2L4P/ROJFDlrtNp/5EckiY7e/jbE
bLl+P9t2uxUi/GdnQYSbSbrLJlvxGfRuXC6WTRkKOhge0V87W49K/9rMzrjNN5w5
2bLoTVltN1d2kauTpmzhPvBnDIIx4EJT+7kSNN6ZwGPVWCh115KDkz2pCY3p7NWD
lF3+SSrEGbUnXxm+aPldzaldObWCuFpMWyntm8XEgrR2IAAL2a/5nkQpwtNRB8++
kBKH2HXlV+uv3jWr+rbJmdyMRlZ2/HPgtkTFCXpxQ06FozMO3CdsrGE3Dfegrgg8
9oZq792bho8HDZUVQgpdoKJbmMAe+tf0nhdbRwyiwJRvzeqB7DcrXBJ3rWg7fwhq
sVuR8q7el2WkC/O7iLHncaKcqmby40eJZAkTPunNYttJfRZBt+RX6JyxVITAWW+Y
yDNTepQA4P37zPLCaPR0NDyDM+Tt0yXNHO26Ul70I8ycedDHqQbNDHRKpvCIyAJO
rcgDHKaKXq0xJsOrl7kKrV8iMmYS73Z2LEXG9dw4KQ/gohTQoBOEY3VGzhZ+BzK4
fL19P27G8W9sE0V74mo6/8L/Ub5+wC6p7Dwj+fleiZH4J2Hi+WIlsyDMUPBFPUa6
peeHiYNZFknawQMkRgawImYSck9STdu6akxiMiHVXmMCi04pTzKr6F3JRFjQSO9K
5WCX41CqitJdSp+YUfhB
=uaOY
-----END PGP SIGNATURE-----

--nextPart45785709.iDmgNu7WT3--


--===============5227155376316249565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
--===============5227155376316249565==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5227155376316249565==--

