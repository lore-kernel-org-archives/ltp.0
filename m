Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MUVpq-000605-VT
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 01:14:02 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MUVpX-0002oX-Qi
	for ltp-list@lists.sourceforge.net; Sat, 25 Jul 2009 01:13:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 24 Jul 2009 21:13:35 -0400
References: <OFE8FAC2C8.7B8ECD5A-ON852575FD.0081EDEC-852575FD.00837054@us.ibm.com>
In-Reply-To: <OFE8FAC2C8.7B8ECD5A-ON852575FD.0081EDEC-852575FD.00837054@us.ibm.com>
MIME-Version: 1.0
Message-Id: <200907242113.36309.vapier@gentoo.org>
Subject: Re: [LTP] hardware requirements
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7492592350086559057=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Mark Ver <markver@us.ibm.com>

--===============7492592350086559057==
Content-Type: multipart/signed; boundary="nextPart1433500.ZRDjascO4S";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1433500.ZRDjascO4S
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 24 July 2009 19:55:39 Mark Ver wrote:
> Is there an agreed upon set of hardware requirements (memory, disk space,
> etc.) for running, if not all tests, at least the default testcases
> executed by runltp?

not really

> Also, if not very knowledgeable of hardware, is there an easy way to tell
> if a particular test will run on a target platform or not?  For example, I
> suspect the DMA_THREAD_DIOTEST7 tests are not expected to run on all
> architectures.  Is there a way to find out what platforms it does support?

many of test cases dont care at all about resources.  might be useful to ha=
ve=20
an embedded doc format so tests that do care about resources can declare th=
em=20
and then a script can run periodically to collect all of them in a summary=
=20
format.

i'm pretty sure that in the vast majority of cases, the memory size is the=
=20
only thing that a test may play with.
=2Dmike

--nextPart1433500.ZRDjascO4S
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKalxAAAoJEEFjO5/oN/WBY6IP/A35i9QAH/wqBeVEUP7jN5Ag
5GUl+dwaMC5FaM7ai4K7OZCzDZiSR+xtreOJqAgNloSXnxp1HFE8Xs928PaHxngE
/Dk731/ETplDNiOksI1mL4zPHFyECWBDs/BbZEUHX4LV7jV36+QBLyNvnaw05aTc
ct+ghcmWIDNKTNLvmLe/bg/Nri13LogY6AfCSzn73A4KdpAM+l2Mh/lRHegR3piK
HYU+oLSVqYnmkjUKRLmbjVAj0MJv5/2Fx187xgUIkFgrw5LN3N6M5iQVJqWS331q
FHrDp04ap2CnnhfeT5KAfcK8cm68Ux3DjJwdoQnh4g39D/fJKfOLB52FVmDneMR3
kbdOUXMkT0f93M3r92sMTQXh1mdtcQmcFukMwTZVc5EHtxCXYAdj0LfIcC4HQz2r
UMooOPQVHTQQZY9tKHFwf8D3iKlXt4iEptLyVuJ4nDXLdDwSQq2ZP+rSLuzQD96/
hf2eVBmcSQQApnO6aaq0HS2COYnkiFz5Smq+0BT/HFMW67eL0hPpHKYF49BhGlB5
OcJ5DtK/4LVhzm3W4T2RR/6Q+h9rYvaq7vw/ul52FS7RIbnvB7rDdiePWWeTx7e5
IcFYF5KIEnarCGIq9R+5HSpBoN0ExaHYJgatLvDMzkjBpDGl6QoFd8iaIAwPIUEL
+oBfSEcfMuzYXLr1mKnW
=EoHu
-----END PGP SIGNATURE-----

--nextPart1433500.ZRDjascO4S--


--===============7492592350086559057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7492592350086559057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7492592350086559057==--

