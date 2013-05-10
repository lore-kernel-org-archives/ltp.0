Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UapMg-0005s8-Mx
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 15:36:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UapMc-00069a-Id
	for ltp-list@lists.sourceforge.net; Fri, 10 May 2013 15:36:10 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 10 May 2013 11:36:01 -0400
References: <518B618F.80400@cn.fujitsu.com>
	<201305091220.44861.vapier@gentoo.org>
	<518CB008.5080402@cn.fujitsu.com>
In-Reply-To: <518CB008.5080402@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201305101136.02884.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2]semctl/semctl01.c: Test features IPC_INFO,
	SEM_INFO and SEM_STAT
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2397827072551096795=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, gaowanlong@cn.fujitsu.com

--===============2397827072551096795==
Content-Type: multipart/signed; boundary="nextPart9084197.Ukzl2oQ6mT";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart9084197.Ukzl2oQ6mT
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 10 May 2013 04:30:00 Wanlong Gao wrote:
> On 05/10/2013 12:20 AM, Mike Frysinger wrote:
> > On Thursday 09 May 2013 09:32:32 chrubis@suse.cz wrote:
> >>> +#ifdef __linux__
> >>> +int TST_TOTAL =3D 13;
> >>> +#else
> >>>=20
> >>>  int TST_TOTAL =3D 10;
> >>>=20
> >>> +#endif
> >>>=20
> >>>  static int sem_id_1 =3D -1;
> >>>=20
> >>> @@ -57,8 +65,14 @@ static void func_sval(void);
> >>>=20
> >>>  static void func_rmid(void);
> >>>  static void child_cnt(void);
> >>>  static void child_pid(void);
> >>>=20
> >>> +#ifdef __linux__
> >>> +static void func_iinfo(int);
> >>> +static void func_sinfo(void);
> >>> +static void func_sstat(int);
> >>> +#endif
> >>=20
> >> Well the only part of the LTP that we promise that will build and run =
on
> >> anything else than Linux is Open Posix Testsuite, so in my opinion the=
se
> >> ifdefs are not needed. Has anybody different opinion?
> >=20
> > i agree -- drop the __linux__ check, especially under testcases/kernel/
> > ... the "kernel" there is "linux".
>=20
> So, you mean drop the "sgi" as well?

scrubbing it from testcases/kernel/syscalls/sighold/sighold02.c makes sense=
=2E =20
SGI is dead and so is IRIX.  if they want to run tests against their system=
,=20
then can download an older version of LTP.
=2Dmike

--nextPart9084197.Ukzl2oQ6mT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRjRPiAAoJEEFjO5/oN/WBuWMQAINkWRAy8wQXCcPj+Tm0+fp+
XC4UqvkmVl9TlJzJhKT/iZKoDxghKrOw4iszUKEgk3F21eqekSFCIgvAQ689SM/J
hMcXGzhoXCE95J407ILR2JcLzPEzYNaln2p6+X8Wz7/sfch8VxsybNd/y2zdl/VV
nr60eji0MorXr9UDyUc53G1Z9rUDKvvjLV4PK1U8itG4LacHSplima8fDu8Xpl+H
UOYtcsl2dSQwrAEAMrkpftCzma04P9DDXo+RmKEu7eEqaGJsjEE4M7CDi2USaG8F
rQboxR4VTkt6tT4+s0hewSUIleahsrrE9nkwTNo0cQWQISPg8PGYUiMXp+9aP2uO
S6XuiyDdjLefdJ9r7E9xK5uYUq4+bau28XgRUr+pjswihq7iakDll3YJAp35eMZi
z6CvGffT3GZ/zmg7CTJM4d2CwZo3d1ui7EYEnj5iF5fLHV/seA3ZFbHcbOQWrNBx
m4TmL1UMfTBrhaJnSVr1LgtJRkjymRC6Jp1zCd3gi9iN7duAJJH7h67ZZbLS2cyi
5F41S1kfSSuQwAOOGNM8nE8l4dQMa9VICYtZosOQUCCOcffF+PS0rdKLXZjuMXeV
a7q1usIO6ryfKZuzLoeZnf2q9WfnBbi0jyfAVVr01d0BzQOOlrGF+smQcYKYbQI+
8fZwDefNjKsPTAK19mXr
=kWXr
-----END PGP SIGNATURE-----

--nextPart9084197.Ukzl2oQ6mT--


--===============2397827072551096795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and 
their applications. This 200-page book is written by three acclaimed 
leaders in the field. The early access version is available now. 
Download your free book today! http://p.sf.net/sfu/neotech_d2d_may
--===============2397827072551096795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2397827072551096795==--

