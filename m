Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1PdrSv-0005Tg-LN
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 21:45:49 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1PdrSu-0004XP-R8
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 21:45:49 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 14 Jan 2011 16:46:08 -0500
References: <4D301BF1.8070101@cn.fujitsu.com>
	<201101141624.59736.vapier@gentoo.org>
	<AANLkTik8_=dyDFacvbJs8t6E1iaCmAgUEKOSRtv9fepZ@mail.gmail.com>
In-Reply-To: <AANLkTik8_=dyDFacvbJs8t6E1iaCmAgUEKOSRtv9fepZ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201101141646.09224.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix a building error.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7815522833767085615=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============7815522833767085615==
Content-Type: multipart/signed; boundary="nextPart1390136.T8tWfQiK62";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1390136.T8tWfQiK62
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, January 14, 2011 16:33:38 Garrett Cooper wrote:
> On Fri, Jan 14, 2011 at 1:24 PM, Mike Frysinger wrote:
> > On Friday, January 14, 2011 04:48:33 Peng Haitao wrote:
> >>  testcases/kernel/syscalls/mallopt/mallopt01.c |    1 +
> >=20
> > please use descriptive subjects in your patches.  this really should be
> > something like:
> >        mallopt01: fix build error due to xxxx
> >=20
> >> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c
> >> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
> >> @@ -37,6 +37,7 @@
> >>  #ifdef CONFIG_COLDFIRE
> >>  #define __MALLOC_STANDARD__
> >>  #endif
> >> +#include <malloc.h>
> >=20
> > umm, no.  malloc.h is a dead header file and nothing should be including
> > it.
>=20
>     It is exposing extra junk in this case that isn't available from
> stdlib.h, which unfortunately the test uses. I fixed the build error
> for now, but maybe someone upstream should be informed that this
> header needs to die a painful death, because all contemporary
> documentation says that you need to include stdlib.h, not malloc.h
> when working with malloc(3). I was reminded of this recently because I
> built some stuff on FreeBSD and FreeBSD has a nice #warning about this
> deprecation.

err, right.  we're using mallopt() here and not malloc().  the former is no=
t=20
part of POSIX which means it should not be in stdlib.h.  i dont believe it =
is=20
being deprecated on the GNU side, so we dont want to go killing off the tes=
ts.
=2Dmike

--nextPart1390136.T8tWfQiK62
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNMMQhAAoJEEFjO5/oN/WBvVcP/j4jZ2T3ix1MD6+WMpsIBAqT
x3VFrXpLzeCEezVCvz6LSTNjrbLULSCkcO6/mMgvOQvMNH86+Nx3NLIFgLAmOktm
qZlWS0eFLcpTWRUaskXtOFOirLSTbMU3xEC8QgPgQq5Ye8g8BATlbAQ7IDxW3TRK
JprbDTEiYgmrgbzCal72bN9yuDW8BaR2Cpc54KZK5iFXkDnYWB1B3Oad1C8kP3Wv
3SYP1bVKdsuClQ705RTyS2235IrCo7Q0EzuI2RiFTNIBqLYIszI62CBXgcu7WQCR
nH9nbvM1IQls/ZZPaUimMUZlO2DpWSvmnjBfT+wEiH2cryx8S9wp0oOUj1WVrYY+
H9DCKrj869xiPEnBb96sB4NxeVZYAblFR+W+aJcRjdwgxUwW2NI9BbxuiQO2DHQI
+7TvJnIbUTsUzs+qwq5vbI7Q4JDONGmTc5Zhx2+/0H8VMUlRAIcbSnuju7kNFeIH
Y3BFhIIfjsatl6Ip/M65F2UXE1RvnnDcczHO5mGa6GBCBLMgWlt7Z2EIraDsaozg
sCFz6iLvrg7LwwzEEkL697HGnHKYh7Aiis0uzyBGd2J893AAaIFyJ93bPFPdJ7C5
+jG99tH/TYVDMA14TCHnO+iJCzAU2fNktvPJBq6vFdmJfoSTrjsvP6CIT7ztrc6x
aKmtROZJMtPFOMJSe1uR
=tUZm
-----END PGP SIGNATURE-----

--nextPart1390136.T8tWfQiK62--


--===============7815522833767085615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--===============7815522833767085615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7815522833767085615==--

