Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1XlQUY-0008KE-PM
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 22:52:54 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XlQUX-0007pO-T7
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 22:52:54 +0000
Received: from vapier.wh0rd.info (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id 8A15D33F692
	for <ltp-list@lists.sourceforge.net>;
	Mon,  3 Nov 2014 22:52:47 +0000 (UTC)
Date: Mon, 3 Nov 2014 17:52:47 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20141103225247.GJ5402@vapier.wh0rd.info>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
	<20141103221828.GD9814@tarantula.localdomain>
MIME-Version: 1.0
In-Reply-To: <20141103221828.GD9814@tarantula.localdomain>
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
Content-Type: multipart/mixed; boundary="===============7126425784633714001=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============7126425784633714001==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3CAnR4CLEnEWqRMR"
Content-Disposition: inline


--3CAnR4CLEnEWqRMR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03 Nov 2014 16:18, Jeffrey Bastian wrote:
> On Mon, Nov 03, 2014 at 04:45:10PM -0500, Mike Frysinger wrote:
> > we should delete the uname logic entirely.  how about instead we use `r=
eadelf=20
> > -h` and look at the Data field.
>=20
> That's a good idea, although 'lscpu' is even easier to use.  But what if =
lscpu
> or readelf are not installed?

the test requires `cc` to be installed and fully functional.  that means=20
binutils also have to be installed (`as` and `ld`).  i'm not aware of any=
=20
distro that splits `readelf` out from the others.
-mike

--3CAnR4CLEnEWqRMR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUWAc/AAoJEEFjO5/oN/WBDD4P/3D1DNAe8yMbTWA9s6jHLVi3
/d9n1MfCEtluGRLh21hwwoYkILEYO5GeOnRWF+vpRDijFiOYxTS6TJObk2Nf7nf3
9vvd1GKkqREXICdb/vYsAlCsz5ICwfKAcbNrigCKiRzrZogx+ogCj/4aYL8rRXu1
CAJzUIZElpSZEDPIGvbzC78C4DnG9mWb60B/jwDzJHMvM+IXecehiMRPlnKy3TqT
5+QNb2OeEKnjzRyYhN467Dgvc/7sE+0ddE+ntpocnXpuwaNwSwLCybSGsWLBpQU8
CGzAJgV7UMIfFmHEW7PxgarDZusiWfriASKqn1idYIvjKVdrRTwFNjpynwKch1lL
Vcc07awsp8yGQGzLcyv8abEN/Ijv7fmThWTOCNwQoLBphRjW35cyQM0gBp88Kg3G
p8yJUQ2uEMLVjXANXEagvzk/ctq5EO+JNmdEicivoKZY9IwZRyalQSvkHzEMEgEY
iLKPnKtLMPWv3U99sPkdU7yXi9s1pH7oqYoVej278ky9NDVRFT3yYqH1MTM36XYC
ffo4qL17IzoTQ3urT8f2n9FqQcRdc7B/eUalLhhtJCdv6tr5wuK9uMBbhJeTSLiL
wzDtr2N4VgAhC6YmPTmEPk4P0Gu7ZACfx9LhXMvkoaJ/DWT9/zIbD7A1JMEABV9F
+4aefxFp6vfZNZfCFWHq
=AKnU
-----END PGP SIGNATURE-----

--3CAnR4CLEnEWqRMR--


--===============7126425784633714001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7126425784633714001==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7126425784633714001==--

