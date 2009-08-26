Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MgOUi-0007o9-5y
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 19:49:20 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MgOUU-00060O-4g
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 19:49:15 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 26 Aug 2009 15:48:57 -0400
References: <alpine.LRH.2.00.0908261651080.29020@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908261651080.29020@vixen.sonytel.be>
MIME-Version: 1.0
Message-Id: <200908261548.58741.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] LTP must be extracted to an accessible location
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1149753311252227877=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

--===============1149753311252227877==
Content-Type: multipart/signed; boundary="nextPart3677431.thj9pA8k9C";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3677431.thj9pA8k9C
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

On Wednesday 26 August 2009 10:51:29 Geert Uytterhoeven wrote:
> --- a/INSTALL
> +++ b/INSTALL
> @@ -67,6 +67,9 @@ contributions are welcome.
>  2. Untar the ltp tarball into a spare directory.  There is not a
>     standard location for it yet.  We put it in our home directory
>     while we're working on it.
> +   Note that this location must be accessible for unprivileged users, as
> +   some tests are run as a different user than root.  Hence /root is not=
 a
> +   good choice on several distributions.

i would use the phrase "full path to this location".  non-root could access=
=20
=2E/foo/, but it could not access $PWD/foo/ ...
=2Dmike

--nextPart3677431.thj9pA8k9C
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKlZGqAAoJEEFjO5/oN/WB2+gQAJuiWr35zdNb+UZgjL90XAHN
oa2W7ij2oFuozMf2+xGKNfFqFts/DA7p3D8JNKHBfvEFBX0654oDPGyQ28rB+pIT
0SEhzLkughewjzH5zjCEWWMwiQH2ZfJyhpcHfIyXE+89uLT4GhPZmL1IZicobMsH
f4Me/lpE8Sqq4y4b/sfftI0PMmw4mZ9XVKB4qLQ832fNvpi/OL6f1p2qUwDouYIu
uVWsaQgOjdABWmBRCd4NCshdpUHJ6vmp4IdXFzZUaXDwf1/NwHWwuKb2M79ThMzw
ebtd55WjQL9MNiEMUOO1mKFgF0BdPh7EeyUZ+S5uiHghBEYpviHQdJIxJGk1wKYA
3R7baDIFkyUXvtS9sxa1OvB0XPeIS/YFHIqUJMkXQg4e3RUqgspPpAHg2XZrdnNv
SENQFILEIPtcHnxtt0L/L8Nj8G16YKQOcjwAWHcGQ/maLtWZF4P5NwYjV7t07eRr
JoguFUA4VEgNIaK1Nw7zM3hoSn2SJz/FbGCbEY738wrMxRGul3df30ca6RZJvQ8o
/epp4PPBpKZir2xL4Y5c5aAYW+Zawp1tiBiJcUMYfkLsGrE4iSPT8TDpEptI388Y
yysCscHhkrWarwdKs/0MhJDvc7nLj9s1IO3G0/ccvEysCITfO9h3uIiUpAFP/hG1
aPCLcfW4t1+GP3kHvMqx
=ufdm
-----END PGP SIGNATURE-----

--nextPart3677431.thj9pA8k9C--


--===============1149753311252227877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1149753311252227877==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1149753311252227877==--

