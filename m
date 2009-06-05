Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MCcH1-0004Gw-8D
	for ltp-list@lists.sourceforge.net; Fri, 05 Jun 2009 16:28:07 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MCcH0-0004Lf-Af
	for ltp-list@lists.sourceforge.net; Fri, 05 Jun 2009 16:28:07 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 5 Jun 2009 12:28:03 -0400
References: <31B17337989C4578A86EF9D2E270034D@BJningyl>
In-Reply-To: <31B17337989C4578A86EF9D2E270034D@BJningyl>
MIME-Version: 1.0
Message-Id: <200906051228.04091.vapier@gentoo.org>
Subject: Re: [LTP] ltp for kernel 2.6.28
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0497646197118650021=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: =?utf-8?q?=E5=AE=81=E9=9B=85=E5=88=A9?= <ningyl@inspur.com>

--===============0497646197118650021==
Content-Type: multipart/signed; boundary="nextPart1380945.Yb36f6cs7t";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1380945.Yb36f6cs7t
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 June 2009 21:42:50 =E5=AE=81=E9=9B=85=E5=88=A9 wrote:
> I have been testing the linux system with the kernel 2.6.28 by
> ltp-full-20090131. But the problem is that part of the testcases is not
> suite for the kernel 2.6.28. As the result, it causes that some cases
> FAILED as unexpected. Is there any distribution that is fit for kernel
> 2.6.28, the platform is ia64

you're going to have to be a little bit more specific as to the failures=20
you're seeing.  we dont typically track bugs in different kernel versions a=
nd=20
mark things as expected failures.  a bug is a bug and should be treated as=
=20
such -- i.e. fix your kernel.
=2Dmike

--nextPart1380945.Yb36f6cs7t
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKKUeUAAoJEEFjO5/oN/WB2wMQANLtC635Q/lN2WvWvmj40AHj
Aq8jdluLoJ/NbVqgWVkkQvVum5AmZbH08QFLk7irpIEA585kpHrTCiZ9Mps6C/j6
yCb/cx8MVxJ29uUL7fr4/8cjLmR+nOxzOZLT7o5Y5v/6PcLdDPWPQbVHnoCG49fE
oSg2HJJ5+ljTDXRMvZQIH5ITm9YtzXrtVWR/dvKD5UqddqJLFXTlXbAtLknDQfaV
cIelEV7NhcDEnkYlYFy7TSOkPocPUGpMP92jonD1fYvsxfZQ61wYGshM+/2PTI8T
TtvZAqOAMHBYHfRN/plIMZr2Z+2MAORT5+hMjBCrh4JgnUwrkHMLgN0Ij+Xos0VR
YJp3gaCMJafUKEfb97/2vy6ohL0/vZEb0/du2W9Oefic56kVx3JthDP7RlbaEKoF
rIs/C4ZuqqP/USJo5saBzoUJulpfJs+VANBI0JytAWKmP/cZh58NmfhhOpI+w4MH
6okKBlSeX0xd4Tj4mQ6YNNukt6uB2jfhO+yyPejdcqyQsBQ5yEY+Kf+hTYCUhKoJ
HIR6HyzgN3FxtN2pmwqGUDuPP3iI8jwYOj4VF5yGfKDlNmlp8riBsS1hKlUI1qK9
us+Pr6Hyhoi+QPEVNIyNw1q1qn+cGW0R3HbbWBQiZ2oS5nuV1JtxVc0d/jv83y5v
5jbc86f/+vLzHlzFeTDL
=q7bw
-----END PGP SIGNATURE-----

--nextPart1380945.Yb36f6cs7t--


--===============0497646197118650021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--===============0497646197118650021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0497646197118650021==--

