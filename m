Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Xm5hl-0002nh-LB
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 18:53:17 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Xm5hk-0000dV-Ks
	for ltp-list@lists.sourceforge.net; Wed, 05 Nov 2014 18:53:17 +0000
Received: from vapier.wh0rd.info (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with SMTP id 4F3C33402BD
	for <ltp-list@lists.sourceforge.net>;
	Wed,  5 Nov 2014 18:53:10 +0000 (UTC)
Date: Wed, 5 Nov 2014 13:53:10 -0500
From: Mike Frysinger <vapier@gentoo.org>
Message-ID: <20141105185310.GQ5402@vapier.wh0rd.info>
References: <20141103201517.GA9814@tarantula.localdomain>
	<20141103214510.GI5402@vapier.wh0rd.info>
	<20141103221828.GD9814@tarantula.localdomain>
	<20141103225247.GJ5402@vapier.wh0rd.info>
	<20141104210118.GE12659@tarantula.localdomain>
	<20141105021415.GM5402@vapier.wh0rd.info>
	<20141105183706.GA4361@tarantula.localdomain>
MIME-Version: 1.0
In-Reply-To: <20141105183706.GA4361@tarantula.localdomain>
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
Content-Type: multipart/mixed; boundary="===============8454377130879277814=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net


--===============8454377130879277814==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8RsyD0KswhpoK73Z"
Content-Disposition: inline


--8RsyD0KswhpoK73Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 05 Nov 2014 12:37, Jeffrey Bastian wrote:
> If a missing readelf command becomes a problem, there are a number of
> other ways to check:
>   1. echo -n I | od -to2

`printf I` :)

>   2. lscpu | grep "Byte Order"
>   3. python -c "import sys;print sys.byteorder;"
>   4. perl -MConfig -e 'print $Config{byteorder};'
>   5. a small C helper program since we know at least the compiler
>      is installed

the way autoconf does it is to compile a data struct and grep the string:
$ cat test.c
short big_endian[] = { 0x4269, 0x4765, 0x4e64, 0x4961, 0x4e00, 0, };
short little_endian[] = { 0x694c, 0x7454, 0x654c, 0x6e45, 0x6944, 0x6e41, 0, };
extern int foo(short *, short *);
int main(int argc, char *argv[]) {
    return foo(big_endian, little_endian);
}
$ gcc -c test.c
$ grep -q BiGeNdIaN test.o && echo big endian
$ grep -q LiTtLeEnDiAn test.o && echo little endian

> The patch below uses just the readelf command, and it uses your
> simplified code path, and it also updates the comments at the top of the
> test (I forgot that in my earlier patches).

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike

--8RsyD0KswhpoK73Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUWnIWAAoJEEFjO5/oN/WBa0MQAIFxgXFmCZfCPOW3RBrNM6cu
2YUkXMXvxV4s+9Unva1dheH8Y2pGSO+rt+Nyn8fKCFrAyPggse4yfcXXao75sTOC
iQwKRdy8YmkSoAA4CZmIXYG5B75qgb1JgPFj0cVJpeFkZMXoRw3gyo6X5qLVaIOF
xwPE1R4k3bCzt9VzoFUG/4EAMlfMY6FmI2aGRKZ7k25V2UuAMuII2BxeOtoTCz4G
TATz/FoHJVfRIuEr6ZrFNrOLK5vnpqWQTEG0C9wS1w/bFoDYMqUHZ0IZGntnHhtt
NHEGj5RZqVqmgn0lfkFwdLV3EI+CnGTRdXphEMIV0P9VcYtpTtwxFN6Sc3XE6X+A
l2xwUBQMSdfhIFUWhICbhAeE1lb+LtIBFszhW4uoyjOxpNqBTQGtuUZ0VjG6gioh
YqWINNRAt24Tq49zo4PL3WieMKjvO09duMjwEUnwyC1mvS9bHjPuaawYjeSKWr5w
EJbEMSq+Bw7VOLwhjpeM1o6sTjzF5lX4HTFUqdrflqjBfy3M5NRnBc5+yR2Foisx
F5V4fd8yTurkO9f1JmDpDcMpVbZNKs2THiFhMNb90ffYcohHfF92XNn8gf+tcjq2
ae64D60wwKLGksdk5sIMvvEtb4olzbESqSEfoaZmjToSaAFfF38mGttoaqA2Imha
C+eoYFdP+vAYTOtVhnz/
=D7l5
-----END PGP SIGNATURE-----

--8RsyD0KswhpoK73Z--


--===============8454377130879277814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8454377130879277814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8454377130879277814==--

