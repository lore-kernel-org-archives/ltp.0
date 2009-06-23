Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MJDHn-0007Lx-Me
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 21:12:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJDHm-0002Xz-V8
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 21:12:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 23 Jun 2009 17:12:07 -0400
References: <4a413aa8.8d13f30a.1754.ffffd0c3SMTPIN_ADDED@mx.google.com>
In-Reply-To: <4a413aa8.8d13f30a.1754.ffffd0c3SMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200906231712.08545.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix a surprising error in cacheflush01 test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0611646865328339181=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: "Jiri Palecek > (none)" <"<jirka"@debian.gentoo.org>

--===============0611646865328339181==
Content-Type: multipart/signed; boundary="nextPart1697135.EtNsQULgJa";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1697135.EtNsQULgJa
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 19 June 2009 10:13:25 Jiri Palecek > wrote:
> this patch fixes a strange build failure in the cacheflush test. Also, it
> makes the condition where it is build a little broader.

a little too broad -- you probably broke arm systems with this as they defi=
ne=20
__NR_cacheflush but not asm/cachectl.h

> -#if defined __mips__
> +
> +#if defined __NR_cacheflush
>  #include <asm/cachectl.h>

for using the systemcall you should use __NR_cacheflush.  for the header, y=
ou=20
should use autoconf.
=2Dmike

--nextPart1697135.EtNsQULgJa
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKQUUoAAoJEEFjO5/oN/WByBEQAIUscK/LeD/amaGD8cyFwlLF
kdjo4HpRnvFtRH01IDvgXBi2EyYbCunATRlSpYtq8l3pMGyFoEy6OUH5tTQkLomQ
wMI5VwsCiFmKS5USxsgj6TprjwobEKUuS75srWBSyxma5ko8psBdErX3GLvBgSO7
pVIYQ6v8q49Jv/bQAOd4sgPdEjom9FhVnvfotMw7u0i6BfD/eL2A/z2ch3Z6dz+H
zJFgkKtDe+tHp6H2rIxNwqckkWZHUZwvXlMToGwfbkvisgDUTRjUOUe0z2V6cbTt
uyPXR8kGXuNni4Xhd9160nwX64V6q8EaOlKVDFDxFZ93yPoNiQBAe37yi6rZ4UE4
2TfMm2Y08F4qooMF/5jYPHyE7Vv97hYkwtF4sCOUiEQtlnkq1sApiwaFs8HHfwcp
pGOJ37PdOlqglCR7rDObTBAiyndE4+/Rv7HHyuE8ZzqU3J6GntQMpegCH1bu3uBR
otIERuXb6cybX7f73ZV34XCDBPUh4krdgmaaynrFXJkWFCIrJWW9W7fxzn9VvVDx
84XKJepvXwtMpz29inTwm59iCATReVzid9RO7WIidbFkfXj4zxv8nfDTiB7LTGmc
nMAKBddQJSiAA69nEM0A92IlvwUHHggJD3IizHVJOD1gfn6SiFTcQnk/lqTMGLTi
YMLE3/zX6q1michzoZdH
=x0QM
-----END PGP SIGNATURE-----

--nextPart1697135.EtNsQULgJa--


--===============0611646865328339181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============0611646865328339181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0611646865328339181==--

