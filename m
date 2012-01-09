Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RkIu7-0002hT-3J
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:21:03 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RkIu5-0004ie-Vk
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 17:21:03 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 9 Jan 2012 12:20:54 -0500
References: <4F0A8E2D.8030305@cn.fujitsu.com>
	<20120109072905.GA27172@eguan-t400.redhat.com>
In-Reply-To: <20120109072905.GA27172@eguan-t400.redhat.com>
MIME-Version: 1.0
Message-Id: <201201091220.55745.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix getxattr02 case with errno EPERM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6558078150233390905=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6558078150233390905==
Content-Type: multipart/signed; boundary="nextPart2922294.QhBsLRuoAC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2922294.QhBsLRuoAC
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2012 02:29:05 Eryu Guan wrote:
> On Mon, Jan 09, 2012 at 02:50:21PM +0800, Peng Haitao wrote:
> > +	if ((tst_kvercmp(3, 0, 0)) >=3D 0)
> > +		exp_eno =3D ENODATA;
> > +	else
> > +		exp_eno =3D EPERM;
>=20
> I think some comments describing why the comparison is needed will be
> better, the commit message will be fine here.
>=20
> Or you can put the reason at the beginning of the test case along with
> the test descriptions.

a comment right above this section of code would be best.  less likely to=20
bitrot or get loss in the future.
=2Dmike

--nextPart2922294.QhBsLRuoAC
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPCyH3AAoJEEFjO5/oN/WB0Z4P/Aga6MYsmr/YcOs7z2ZwhQiK
Sm0KF/Cn0QUlC7PLq5q9RwT4wkeSMaEAX8abrbjj/v4Hi8XJaxr7uYOS5k6aSpJP
rwOZoT3tsP4aqdLep4XPEyv3cpCoOUOOI9vsC4fqR3noOof3/ytYQ/IE4A2AQ/qg
7Gl9j4Kn5iuYzl+ndXQe4zw526+Rt9ERZ99BfdCMOAJ1PX5WCYmdjEBhT11hkL/I
N3bgz1xZ+SY7qjPY/wUAC4F5gOiTMACuHOLUU9SyH4rCgS5McCgK3uAj38SoY98o
SwKe40InUvaFd8iuR1IRJrw0xe9iVAOpbHmVGWRXlKwFd8Q6ZJSeciSCWe1psN8L
5LSZ6scujhx70NaMh8juO4vLeYw8WJHu49SypW0M4T1EWWFG2Y8EX0aCFAtzjC+X
0Vrtr+2ftwswyv1D0aJQ7Pq7ahrtKVVc97g8r5atWFvvfh0Kb0AmLDvzGNHrurcl
nbw2YEIxJNAogLBWoxkO/c47wK8ZU3/EUhAukwUaNOFRJTCFlu0SgAf044DYjylf
uhXiyCADDSK1NJljhqJWPc04kWbuWZc+JZbDob/ugda5ovkPuBt1RtZkEGpWKv74
61oqIrSDWT2HOgPFuLo3Bx+c63vqf8lSXVFpSojxSCsHLT/SjX5Z4/5G2FfnM8QP
RpqcjG2LwI19yr8Zf+4L
=0s+K
-----END PGP SIGNATURE-----

--nextPart2922294.QhBsLRuoAC--


--===============6558078150233390905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
--===============6558078150233390905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6558078150233390905==--

