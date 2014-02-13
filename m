Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WE5MB-0005jx-W6
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 23:06:12 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WE5MB-0000sI-2j
	for ltp-list@lists.sourceforge.net; Thu, 13 Feb 2014 23:06:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Feb 2014 18:06:09 -0500
Message-ID: <2020103.1jVMlSvdbW@vapier>
In-Reply-To: <52FC98EC.80406@oracle.com>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<5757763.zAWEHsmlGc@vapier> <52FC98EC.80406@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============4392507272694393453=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


--===============4392507272694393453==
Content-Type: multipart/signed; boundary="nextPart3407659.fqBfvI1Qv0";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart3407659.fqBfvI1Qv0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thursday, February 13, 2014 14:05:32 Alexey Kodanev wrote:
> On 02/13/2014 12:47 PM, Mike Frysinger wrote:
> > On Tuesday, February 11, 2014 13:48:10 Alexey Kodanev wrote:
> >> +static int get_tst_count()
> >=20
> > random note: never never never use () with functions.  always alway=
s
> > always
> > use (void).  i'm guessing you're not aware, but what you've written=
 here
> > may>=20
> > be called (warning free!) like so:
> > =09get_tst_count(1, 2, 3);
> >=20
> > yes, even with -W -Wall -Wextra.  please stamp this horrible habit =
out of
> > your code.
>=20
> Thank you for explanation!
> There is a trick to try g++ to compile the code, it will throw an err=
or
> on that and stops compilation.

yeah, C++ fixed this historical wart of C.  sorry for not clarifying.

iiuc (and i could be wrong as i'm not old enough to have lived through =
it),=20
this dates back to when C (ANSI?) didn't have prototypes.  with a lot o=
f code=20
out there relying on the behavior, gcc never stopped accepting it.

i wonder if we could argue for like a newer GNU standard to reject it.
=2Dmike
--nextPart3407659.fqBfvI1Qv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJS/U/hAAoJEEFjO5/oN/WBDQcP/1f9ENcQzFQ10BMkSl2h8oYe
/rIDSZmeaQg1Y+m9HJgqN92xSxdPlDPAQ/h9i9Zr+G8KGD6tXMF90aPeoNAP+XXC
T4jR9jnKkAYzYVQXdyicuNBVaE+nP2qINH8RO7XhubeertPdAFJAuhIAB2K4cPAq
phYMsXQQpkDDXxf1bZwBcMo0uyIeSM8FkmVnA4rCJV4ZzVoX6D0G0VZEMsexvzg6
hdbZ5rZqIImg28Xkcy8Tycc6KFCbUb0/8zqe6ey4nHG3uU19Z3Z5ajWg4aVjU3iI
5s58YyfkwMAyJugj5SW1JFyYvLs58tKwnP3x/l18Vnj8NgEBoQfU8wF/6UIezCZA
4H0fcYCFA4wcTKd1RJga54HBArVgId7BJpFcmRl47Wn1ZNwgdHA1JYFxAuGsvfdF
KlAGuWkcwWum0nTJuKy9yaXHhwjnk9DT8UQ0SmhXzIt0KwH40xMZKnNUJBOCI5hb
uiKAUEQQTs3bxxTMu7nVbAZHa41ZYwNAgSUSihU6rLds+ZApi/vb0EFE9ZEwoSKU
l191SPBEzQudyL8OTDd1ZFfbod79xd9qRZgKf+YwRJxwGVsc60D/3in9fiPhbFwV
TVhB5P/T7yBTZqwrNM1Uf02bmxch763LILY1N/iqHOB+hm2WbEcnM1siW6viLMWn
EOf2iFUHipdq/F1BvLVy
=dMHZ
-----END PGP SIGNATURE-----

--nextPart3407659.fqBfvI1Qv0--



--===============4392507272694393453==
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
--===============4392507272694393453==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4392507272694393453==--


