Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WDrxk-00040q-Dz
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 08:48:04 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WDrxj-0005Vc-NY
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 08:48:04 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Feb 2014 03:47:57 -0500
Message-ID: <5757763.zAWEHsmlGc@vapier>
In-Reply-To: <1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<1392112090-13853-3-git-send-email-alexey.kodanev@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 4/4] lib: add tst_res_r.c
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1505391331104836185=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Alexey Kodanev <alexey.kodanev@oracle.com>, vasily.isaenko@oracle.com


--===============1505391331104836185==
Content-Type: multipart/signed; boundary="nextPart2582855.XOFJrslntr";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2582855.XOFJrslntr
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday, February 11, 2014 13:48:10 Alexey Kodanev wrote:
> +static int get_tst_count()

random note: never never never use () with functions.  always always al=
ways=20
use (void).  i'm guessing you're not aware, but what you've written her=
e may=20
be called (warning free!) like so:
=09get_tst_count(1, 2, 3);

yes, even with -W -Wall -Wextra.  please stamp this horrible habit out =
of your=20
code.

> +=09/*
> +=09 * Build the result line and print it.
> +=09 */
> +=09type =3D strttype(ttype);
> +=09if (T_mode =3D=3D VERBOSE) {
> +=09=09size =3D snprintf(message, sizeof(message),
> +=09=09=09=09"%-8s %4d  %s  :  %s", tcid, tnum, type, tmesg);
> +=09} else {
> +=09=09size =3D snprintf(message, sizeof(message),
> +=09=09=09=09"%-8s %4d       %s  :  %s",
> +=09=09=09=09tcid, tnum, type, tmesg);
> +=09}
> +
> +=09if (size >=3D sizeof(message)) {
> +=09=09printf("%s: %i: line too long\n", __func__, __LINE__);
> +=09=09abort();
> +=09}

ugh, the 90's called and they want their staticly defined stack buffers=
 back. =20
use asprintf() and throw this historical wart in the trash where it bel=
ongs.

i've cleaned up tst_res.c some.
=2Dmike
--nextPart2582855.XOFJrslntr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJS/Ia9AAoJEEFjO5/oN/WBYJIQAKF6ZLfAHubKh4XyPS95D5I0
w+ogGe51gDBKQo23ji/EbU4dGurVne6+pKpL7QveXDUtd/ioMNoVlOOfn8GpGzdT
oV1vwX91OQe90VIwMOq8Gw/SUq6yU4K1+GPLHu8okAJkJYjMrvOjzMGO5kr/O4fu
LgQ0kGzfEIhcZ6EYdMwK3+npAK6QUzKuiyQz0U6qZtR+vqPtPYWHL6lrzIVtaJ6n
q8GfBHjm+PUfctrgRyxJI/QQZfMPn1+oodyEyOevMUFKQOm3jFtKEXOgsN59+o13
eN+IU6xRikKLAGol7qERJYmU6lCgg6iI9QVayYIwE8nPrTMGxaQ7ne4klqLfZ4Hs
chGua6FZYVa5a734CuXYX62Rj3Ok6QsF+jvxH7iYTSh+PltyApD5NA1sfngyJcm/
CjjttwX22B6jD7mPBGI0ciSvygTcyyHncrercAr0GumB2H4AA3SvPacJOPSh9Z/q
Obj50W8onBIDz7p8mvkdJX7uqwJX2dPR1rN7Mk+E6CSuJbwTCsk0QsCBimmT0Rdv
O5G3Gl3rC1TZyhfXBPmdels2be7VQHUBfnHLMBBCYwFUmeTphd04jVswfOu4qfF4
wK2khulYfyW1oGwbE9WQ9cGgPq0y++oKKlz1fnopqx0n6048V5tUY9PKDsdBxj2K
7bEL07vUIPUSZ5NvEdCU
=tT8X
-----END PGP SIGNATURE-----

--nextPart2582855.XOFJrslntr--



--===============1505391331104836185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
--===============1505391331104836185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1505391331104836185==--


