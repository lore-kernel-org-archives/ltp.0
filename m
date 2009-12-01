Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NFbub-0001GW-SU
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:13:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NFbuV-0002OJ-Es
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:13:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 1 Dec 2009 18:18:15 -0500
References: <4b159c72.8213f30a.7cd0.746aSMTPIN_ADDED@mx.google.com>
In-Reply-To: <4b159c72.8213f30a.7cd0.746aSMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200912011818.15735.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fixes of some errors discovered by "set -u"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8848278464598512488=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>

--===============8848278464598512488==
Content-Type: multipart/signed; boundary="nextPart2262940.jDX4JnhjIR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2262940.jDX4JnhjIR
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 01 December 2009 17:30:33 Jiri Palecek wrote:
>  - when no interface is found tcpdump01, $IF is unset. Don't spit out
>    an error in that case
>=20
> --- a/testcases/network/tcp_cmds/tcpdump/tcpdump01
> +++ b/testcases/network/tcp_cmds/tcpdump/tcpdump01
> @@ -59,7 +59,7 @@ do_setup()
>              break
>          fi
>      done
> -    if [ -z "${IF}" ]; then
> +    if [ -z "${IF:-}" ]; then
>          end_testcase "Could not identify interface"
>          exit 1
>      fi

i would stick a comment above this explaining this is needed because the=20
scripts are run with `set -u`
=2Dmike

--nextPart2262940.jDX4JnhjIR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLFaQ3AAoJEEFjO5/oN/WBCygP/2HMKX8S4T+jSZmaB01xqeoo
vX7lEns1p9QJl3e0B9fnUWL0x5zIvQ0SRSk2HaJeMtDpuGi03CxW4kTSDuBLvTwA
4c22n+E08yxeKZf5jUcmPkAmoaE9VGukYa5EYaAL+x/pfXkRsSxALw9wMAgphHcX
tBHG945Awl2bdjC+/SBRCB4lEbdS1a48ZC2SseipXuTyrwWDN+mlfqIphNlZnNmW
6jjZaUFB/tnq0FcX4XSzJWmb/x7RSRAF4JUKpMmcbpy4yJ/JC5icj1a/FNSsO+sC
sH0GuRHtbpCA46GnrHsaWdOu+BV3N9zgvc/Dho0n5vA8Dc0ap5Mlesu/NrcwHrAU
ThAjWqqTl38qom5YuNIbISbJmHl23qOaXHLBul+u2/JntV5c4crejGdJrtD9YnLD
qbCHCS0mlSuPcBmKRjV9hBtq+djDYrq8YARFvTpqMRx0TfCxSd0+FUDM2pwaz0nF
y3EQjKP864FOwsSF0iXpKz8Kg18F9DyGoFZcCBHzk7wE0EdXbj5HBukaJ1a2MQ7y
emLdvdAGhWDQBNkERoXih1xVwp4FHNfRiv3wHsL+c3radCbOnS9L4EpUqDlKON1V
xjRf4VenZoPSxt3RyShS2ugM8dQimgMHWKB1s4EzFBgh7lYG1zTDpugGaYi3iICv
+bpFD2IIcYO1TMnSg3sZ
=wSHI
-----END PGP SIGNATURE-----

--nextPart2262940.jDX4JnhjIR--


--===============8848278464598512488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--===============8848278464598512488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8848278464598512488==--

