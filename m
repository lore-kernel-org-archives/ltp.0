Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1M5KLN-0003EK-Pm
	for ltp-list@lists.sourceforge.net; Sat, 16 May 2009 13:54:29 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M5KLA-0007nH-GY
	for ltp-list@lists.sourceforge.net; Sat, 16 May 2009 13:54:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 16 May 2009 09:36:30 -0400
References: <1238499818.6818.25.camel@subratamodak.linux.ibm.com>
	<c384c5ea0905151027x5a74ee85l294616e0ddae41ce@mail.gmail.com>
In-Reply-To: <c384c5ea0905151027x5a74ee85l294616e0ddae41ce@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200905160936.31857.vapier@gentoo.org>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been Released for
	MARCH 2009
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9050160236155487821=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Leon Woestenberg <leon.woestenberg@gmail.com>

--===============9050160236155487821==
Content-Type: multipart/signed; boundary="nextPart1501483.c3OREhqyBz";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1501483.c3OREhqyBz
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 15 May 2009 13:27:50 Leon Woestenberg wrote:
> 2009/3/31 Subrata Modak <subrata@linux.vnet.ibm.com>:
> > Dear All,
> >
> > The Linux Test Project test suite has been released for the month of
> > MARCH 2009. Please see ltp/INSTALL file carefully, as, there has been
>
> OpenEmbedded builds LTP for a large number of machines / architectures.
>
> JFYI, The LTP January release required some patches, especially in the
> area of cross-compilation:

then someone should be submitting them so we can give feedback and they'll=
=20
update/re-submit

> http://cgit.openembedded.org/cgit.cgi?url=3Dopenembedded/tree/recipes/ltp=
/ltp
>-20090131

the first patch (the cross compile one) is wrong -- CPP is not the C++=20
compiler, it's the C preprocessor.  those all need to be CXX.

the epoll one should be a configure test.
=2Dmike

--nextPart1501483.c3OREhqyBz
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKDsFfAAoJEEFjO5/oN/WBBZIP/j0SesaGAdlwKaflB0o4VPQO
S2hZ0nwOKW42nfHLHRAnNWS69B4fAZlvha+3Od2JWq/WWb4SRUc9UVwLwKGw3o2S
bLPL76lfeATLrZbm9K/AQJerVdIgolFvgCXRulBEgD+ynE04lwQFCCWGFO+EmKfM
MRxBAM+kukNqVQZlsOHxyROvtWWw+AgRk/QdnnEcd2o3NXAP3kwIHBhL0Joo/ZJb
nYn5SEtlRuoK97RQKw+KYQu1vEdIuvcmS4cUd3UJ2veXfLZeVVpPQZ/PlwFwYto5
VdYme0n4PXkzdNax+YmTo5JaZ1FKXepl6B4J3lA55Npm6ljyEJ5PukyfMVEQAn4a
ILN3jtYzD0RJ/eNatMUgCBBzAQMsJj4EDm9RB62D6MjOUqielf8lKFFLqdcRgmht
esRQYaHTw05JkI7H0Jr7tC4/8hAhwzsPcLH8vlEcpMQZsFZEccqWDKyRkaQ3FsKb
uYuh2Tw2889EUpCIfe734/ArIOinMFzTsAlLFredOJU3088YJyCmxz74EOJskKYA
tL3v6yT/ZahYecFegu0PfoYXj8ij52A9P5fiyPLYhysr+RcudXBB4MA9sYa7J/9D
ChUZ2hPxWtfEP5Ty70xrPeYe+nmu065H5bCZKDPvs8IwRgdENDB0amjIhdmbosgu
MLmmRBqIBKKE6JPGKqtu
=KLS7
-----END PGP SIGNATURE-----

--nextPart1501483.c3OREhqyBz--


--===============9050160236155487821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
--===============9050160236155487821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9050160236155487821==--

