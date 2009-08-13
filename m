Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUV2-0007Xj-1l
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:13:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUV1-0008Aw-3k
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:13:24 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:13:13 -0400
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
	<20090811173101.7074.31798.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20090811173101.7074.31798.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200908130313.16616.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 05/05] Add the necessary Interface and Option
	through "runltp"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5059700343832535463=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, LTP Mailing List <ltp-list@lists.sourceforge.net>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Paul Larson <paul.larson@ubuntu.com>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============5059700343832535463==
Content-Type: multipart/signed; boundary="nextPart2256494.8VnLFoDREE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2256494.8VnLFoDREE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 11 August 2009 13:31:01 Subrata Modak wrote:
> +	if [ $INJECT_KERNEL_FAULT -eq 1 ] ; then
> +		#See if Debugfs is mounted, and
> +		#Fault Injection Framework available through Debugfs
> +		if [ -d "/debug/fail_io_timeout" -o \
> +			-d "/debug/fail_make_request" -o \
> +			-d "/debug/fail_page_alloc" -o \
> +			-d "/debug/failslab" ]; then

debugfs should be mounted at /sys/kernel/debug/, not /debug/.  if you reall=
y=20
want to support the latter (incorrect) location, then you should use a=20
variable that defaults to the correct location and falls back to the /debug=
/=20
dir if it is actually mounted there.
=2Dmike

--nextPart2256494.8VnLFoDREE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg70MAAoJEEFjO5/oN/WBqa8P/2cgqignXwqmkVXdmtz5BjB0
bl8fOYjdd1eXWxoOI5RqOH6hTRSgY+A63VzlU268k2vjqNIoezTWTfj0gcZa7oDA
UDa92BIB7gvEHAxpkhhB9WYbwwXsaUwz9twvar4aYA6xY6HJfdajyWxD6gficvZh
+aP4GoWzYM3ZP6SzuZWbqMQjz6F0/YGbBeMsrT+3KLYgFtywlulC2ehjhiEqAm/Z
5R++6HewcRI5iQo5ODg9vI+HmqhPByAsGZkPAifxJorRInckqa5REzy5/Rfr+pM5
Wb+/PQPBR7q9t4+e11tYBynpxQUlEhyNqgJTgX61g7yFQb58zGSSrXC6HjVgA/ox
jFSUZ1tYtFJVx8Jqh7qvDKQa20/RwFG5rqyZ9WC1Unq8NIUtZTQYNl/t9NPbLvrO
hQNmPJRnovjBDaiamU65ss7TaLv+qlpY/GFm32Z/b3lExJ5TNAXVXvz/Eq7e/6Uo
23BkUvTIzqf5cEaIOJf7EEWgQFtxbITnpFkUNMCk3z+MeQ2mDJcwo9G1Eb6Qo0Ol
2A8KbVNuLRxMpAKKxtOyyS4CkobGznj/0+fBMAKmST9122mD6aaodG1g31JxdxzZ
OT4+mPyyjEZpBR309CJeF54YtlzadMNutsWVfU7rOSVoAsd19Jl5x6omZBRX3nr0
7FBafsV50f54mC2nujqQ
=ay/p
-----END PGP SIGNATURE-----

--nextPart2256494.8VnLFoDREE--


--===============5059700343832535463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5059700343832535463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5059700343832535463==--

