Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Pdr8T-0006hK-He
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 21:24:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1Pdr8S-0005xt-6O
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 21:24:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 14 Jan 2011 16:24:58 -0500
References: <4D301BF1.8070101@cn.fujitsu.com>
In-Reply-To: <4D301BF1.8070101@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201101141624.59736.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============3794852230131807384=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3794852230131807384==
Content-Type: multipart/signed; boundary="nextPart1420409.G0tZZUQdxh";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1420409.G0tZZUQdxh
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, January 14, 2011 04:48:33 Peng Haitao wrote:
>  testcases/kernel/syscalls/mallopt/mallopt01.c |    1 +

please use descriptive subjects in your patches.  this really should be=20
something like:
	mallopt01: fix build error due to xxxx

> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c
> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
> @@ -37,6 +37,7 @@
>  #ifdef CONFIG_COLDFIRE
>  #define __MALLOC_STANDARD__
>  #endif
> +#include <malloc.h>

umm, no.  malloc.h is a dead header file and nothing should be including it.
=2Dmike

--nextPart1420409.G0tZZUQdxh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNML8rAAoJEEFjO5/oN/WB4RAP/3PVnn9MUMBQcct4xpQWXtiA
bMUAtEw5wiTpL7pa/IJSDcg0k3u9uhboYLpcr1X8RQ27K8s9lWoLu/Is4p1GQzxk
rtywHqgPw1Lx+uWivEoe3LY6YTADuybECQhkK01U79YVod/ltLOYTz9200QCyB92
tttEOiwjaUN8vtaUb9I3++0rGQL0GsetIhn2rXOkI6aVRpEVbIz6KMwW3YdwNORJ
kQHabSlLL0lXmPNGVg6Aa3qyj5rjRfUK8wV5Ddcj+YsVA7GUMfUAyWDXYXkX6WKL
aPtncczETg+oMXEQqiGzNviSOFmANgbjDXVsXy9GEXlg0t1wdROla5L8s+jYeJxM
Cm4nyfv9C5xn/YatObQsgWKg6YtpsU0PBdjfZai3fv6gEiFxN9jpqAPqaYGKjPzg
5WFPMt1GUTwsYc8N6h00WGNdPSi23EXveTN0HtazH/nKhZJNQ52YK4ntJmNIKY/w
9cp3rUKP9WxCIcaQ+7cLNsQvfUAoZ9Hkw1c0Dr1ZAYuvOC1URYICQwfyyjgtjOJF
IGt6uPq2U9h3Y3uWD/ZFjquD/sz3GCD3plu/RyHIiAr/2+CwHYQS5KsxyU2oRM4L
sNnsGZ5x6e/BdLX6pVJHzA+e3pVpTtMbaO2tT9y8zbnxBG+Ih7OO8Aa4QiMbdmN4
SI9WJMmqFj6PThWLzLzK
=ZPWl
-----END PGP SIGNATURE-----

--nextPart1420409.G0tZZUQdxh--


--===============3794852230131807384==
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
--===============3794852230131807384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3794852230131807384==--

