Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UNyeY-00030V-Cy
	for ltp-list@lists.sourceforge.net; Fri, 05 Apr 2013 04:53:30 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UNyeX-0000Xs-Bp
	for ltp-list@lists.sourceforge.net; Fri, 05 Apr 2013 04:53:30 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 5 Apr 2013 00:53:45 -0400
References: <1365125797-31405-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1365125797-31405-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201304050053.46087.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] getdents01: don't compare first entry to "."
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1261114348206921699=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1261114348206921699==
Content-Type: multipart/signed; boundary="nextPart2118563.lS1gHGn4hA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2118563.lS1gHGn4hA
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 04 April 2013 21:36:37 Wanlong Gao wrote:
> --- a/testcases/kernel/syscalls/getdents/getdents01.c
> +++ b/testcases/kernel/syscalls/getdents/getdents01.c
> @@ -75,8 +75,6 @@ int main(int ac, char **av)
>  	setup();
>=20
>  	for (lc =3D 0; TEST_LOOPING(lc); lc++) {
> -		const char *d_name;
> -
>  		tst_count =3D 0;
>=20
>  		if ((fd =3D open(".", O_RDONLY)) =3D=3D -1)
> @@ -102,15 +100,7 @@ int main(int ac, char **av)
>  			continue;
>  		}
>=20
> -		if (longsyscall)
> -			d_name =3D dirp64->d_name;
> -		else
> -			d_name =3D dirp->d_name;
> -
> -		if (strcmp(d_name, "."))
> -			tst_resm(TFAIL, "First entry is not '.'");
> -		else
> -			tst_resm(TPASS, "call succeeded");
> +		tst_resm(TPASS, "call succeeded");
>=20
>  		if (close(fd) =3D=3D -1)
>  			tst_brkm(TBROK, cleanup, "file close failed");

this test isn't really useful after your change.  you've basically validate=
d=20
that the a valid fd and a large enough buffer was passed to the kernel and=
=20
that's it.

you should have it walk the results to try and find an "." and ".." entry.
=2Dmike

--nextPart2118563.lS1gHGn4hA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRXljaAAoJEEFjO5/oN/WBr3kP/iRBClXS/ShnYPYAUs3X+Pma
W4CBTKzkV94gOzP/iXF4bJ3TuqEAVHcknqwA0wDVIguGpLzzKUwECQH6NG17Vozo
e4MsTbHGXEoMRKedhf9CyP/iM98cK2Fytj1dqIPn0TMsfCNCeBtffKrirca/pEev
lvzdUOcniNNWdexhJhRD7n8H743/greM4CtniJLLnA/uroULr4zWPmHoTO0vhatV
pXpVi1+aoqhYeRGJ1KElUPqzela/A2Wq9f3Mdi54LqgPFp6tD0dtaUCJqkujcxjy
uehSg8rIfTTQ+Xp0gOp5gvFGIuzfS2geXghV6kQJPX5mqxYZ3SvUqlM5AFoZVU0s
tgvq0TyWnH2dSPMOC9x03Fiv8hepKZfaKzXGbNnMa7abWS7Z93+kqiKMXqw4syAo
/0S1dPjTZjCy3hEytUD+fhwXMCICE0k27oTGMRNTSXQlgZGX2D2Q4fg0dOz8dBB5
YAv3kYfzf2STiO1jUTflA5KR0KsBpOFlG2VO9HQf7AAR4aAed3MnAEGIJ1eb2czV
OmTT5/Chyv1TMB1KvwA6wrbHxWZe+791npq2HOJaT3r6uuPZhNQaitrfaH8HBQ4C
JDD9rH0X7CZskcUBO9SUB2VfFHvBKFwOECl+bQiSBrODp2dlzg6ZLfOtFcYJlyG0
+THL+Ps5hZ6/+bjKhf+S
=8syz
-----END PGP SIGNATURE-----

--nextPart2118563.lS1gHGn4hA--


--===============1261114348206921699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
--===============1261114348206921699==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1261114348206921699==--

