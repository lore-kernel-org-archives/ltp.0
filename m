Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbSzI-0006g4-Qi
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 05:36:32 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbSzA-0007bF-VE
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 05:36:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 01:36:16 -0400
References: <364299f40907182138w484cc898gac9fe00dbde75afd@mail.gmail.com>
In-Reply-To: <364299f40907182138w484cc898gac9fe00dbde75afd@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200908130136.16712.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix bad strerror calls in
	testcases/kernel/syscalls/waitid01.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6131543700672215755=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6131543700672215755==
Content-Type: multipart/signed; boundary="nextPart2191923.utev9z7QoY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2191923.utev9z7QoY
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 19 July 2009 00:38:39 Garrett Cooper wrote:
>  int errnochoose(void){   //choose the relative errno
>
>      switch (TEST_ERRNO){
> -        case    0:      tst_exit();
> -        case    ECHILD: strerror((int)"ECHILD");
> -        	        break;
> -        case    EINTR:  strerror((int)"EINTR");
> -                	break;
> -        case    EINVAL: strerror((int)"EINVAL");
> -                	break;
> -        default:     strerror((int)"Other Error");
> +        case  0:     tst_exit();
> +		     break;
> +        default:     strerror(TEST_ERRNO);
>                       break;
>     }

maybe i'm missing something, but strerror() doesnt write any output, it=20
returns a string.  so ignoring the return value of strerror() makes it=20
pointless.  which means this whole function is useless ?
=2Dmike

--nextPart2191923.utev9z7QoY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg6ZQAAoJEEFjO5/oN/WBRakQANUUPhT9dCFhFOJDz9OIrrQ0
ZdckHNQaEyM7pAgj1pauDjh4+y98QTC4qGcv2n56cDph/sDO3ABFuqZM8cB6uV5m
ouw3mSe0aM/NkMVvYk+QVH/5e80ZwnRsht66hYXunNG1luDg4KSApSxLdbE4MVVO
t+mZ2fgf11ROykDzuozBIFlega3wWZaKrXgkv/11JmbE4NYVZSSL0uqNg+AiORiT
d2x4Y/HUpWhDDO1hqXYdD9O4pb3e5Klkc8u0Klo4gEHUmWuWXVFd21RbCgyouULJ
dOhIePDnvNMk0U8GUcwPNIyrbI8BYoQvAZ6KfmSLtmPT7Rx2IcwBKQ3iMf/I0W0s
BgnIq7B4WCBkwdVyZ5QkbvoEecWvEN6N3L8pqNFTNJgmdG8pU1yzSxvxQQ3KHQ5h
71oBzzCXQ08d0ZKplJkZG0t6kktex60cROIaLrpXkaadzLDEdSs9Uhdg+iPuLHoN
q57hm3WflX45DIp7sjcV8685BxQYLS61JaJQFezXFg6Aht2GLidKjgWyo3XslOpJ
hJMIniGZJBZMW6+52gCGUTO+4iXNwl/mWwtMoXfdvJWctBpO68QuBRAkZg8pZnke
IZmrrrp22d3iiQ0pyguX2kxtxmK6TcbM1cegiIdmUL7Y87CT2MMqcDU6XGXOfuvJ
aVrVLWXGr+75CP5HdcZq
=L2w3
-----END PGP SIGNATURE-----

--nextPart2191923.utev9z7QoY--


--===============6131543700672215755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6131543700672215755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6131543700672215755==--

