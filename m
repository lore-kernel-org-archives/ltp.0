Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1XlPR7-0007QS-5c
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 21:45:17 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XlPR6-000656-9T
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 21:45:17 +0000
Received: from vapier.wh0rd.info (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id E8751340299
	for <ltp-list@lists.sourceforge.net>;
	Mon,  3 Nov 2014 21:45:09 +0000 (UTC)
Date: Mon, 3 Nov 2014 16:45:10 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20141103214510.GI5402@vapier.wh0rd.info>
References: <20141103201517.GA9814@tarantula.localdomain>
MIME-Version: 1.0
In-Reply-To: <20141103201517.GA9814@tarantula.localdomain>
Subject: Re: [LTP] [PATCH] file_test: fix testcase for ppc64le
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6973511087411966424=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============6973511087411966424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dMdWWqg3F2Dv/qfw"
Content-Disposition: inline


--dMdWWqg3F2Dv/qfw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Nov 2014 14:15, Jeffrey Bastian wrote:
> The file_test.sh test assumes all PPC systems are big-endian (MSB), but
> this assumption is incorrect on the new ppc64le little-endian (LSB)
> systems and file06 and file10 report false failures:
>=20
> file06      0  TINFO  :  TEST #6: file command recognizes ELF executables
> file06      6  TFAIL  :  ltpapicmd.c:156: file: Failed to Recognize ELF b=
inary executable. Reason:
> /tmp//cprog: ELF 64-bit LSB executable, version 1 (SYSV), dynamically lin=
ked (uses shared libs), ...
> ...
> file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
> file10     10  TFAIL  :  ltpapicmd.c:156: file: Failed to Recognize vmlin=
u correctly. Reason:
> /boot/vmlinuz: ELF 64-bit LSB shared object, version 1 (SYSV), statically=
 linked, ...
>=20
> This patch fixes the test so ppc64le is checked for "LSB", not "MSB".

we should delete the uname logic entirely.  how about instead we use `reade=
lf=20
-h` and look at the Data field.
-mike

--dMdWWqg3F2Dv/qfw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUV/dmAAoJEEFjO5/oN/WB+ZIP/iAJhfeVg6qGycs8wQNMGibm
O8CvJ/RlRks1QYpPoq4fMyjAMc+zLOoHpvVUqIul02b0pHPoqoaxW2ER7FBvXgdX
v8tblURrZhHP+qPSUBN3P+48NTlaR5UvliznWYKy8SDjbnRM23/IMuql36teh6Cg
U239X/s3o4u5d0z2eCar8FRIInPpQFQjh3LmLdo1dME6uFaSGS7gUafoAMmkpS0s
kAtqij5zK+6Ctg3lGuvH6w2bMhnavTJsbyE3fySTbjp5x2zLBMRTOOrdXZw+OYnQ
SfTehoUWmHgoE7GWUrQYXLX3M15jRDkNf7P18acfrEGSQ3aZ2vx8NPX6uJnUJrdO
JyeK3CgEwgzd0nt2IbP+MQnSMHJyVoPyTqAYDBAKwLIE+rNf05oU07TqFG9xc5Ou
ecuG7hD35jBxRbOXrraxEXwNuIyMkFpDztWgFFYHyfwfj+G6eMWlcYv+GfS9jRuj
dzYk/wpWikN1lagBsOPp1bqOCT5ModzbJl5e8Mh/D5kNkG1gTwn1cvNf+bXV/qJg
1Cf24bflq2NP3gyduY9Izu7RjGYGbtW64gYkZn4KDmobDFgzSHpfALwX71KKHgnJ
WIHn9pi8FmIbnYDXdO3JlAU1vrrsBjq4GEI3UoRMcXpaJPdVNOdCP9eisg4z6W6Y
y96dnnO8KBUVwDZEJgBu
=47aL
-----END PGP SIGNATURE-----

--dMdWWqg3F2Dv/qfw--


--===============6973511087411966424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============6973511087411966424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6973511087411966424==--

