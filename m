Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WEMNi-0003FK-6g
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 17:16:54 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WEMNh-0002wX-2M
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 17:16:54 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 14 Feb 2014 12:16:49 -0500
Message-ID: <24456249.p0z82pE2jZ@vapier>
In-Reply-To: <52FE2132.5060601@oracle.com>
References: <1392112090-13853-1-git-send-email-alexey.kodanev@oracle.com>
	<2020103.1jVMlSvdbW@vapier> <52FE2132.5060601@oracle.com>
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
Content-Type: multipart/mixed; boundary="===============6438452194503657471=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


--===============6438452194503657471==
Content-Type: multipart/signed; boundary="nextPart2277642.vEWjZrOnif";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2277642.vEWjZrOnif
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Friday, February 14, 2014 17:59:14 Alexey Kodanev wrote:
> On 02/14/2014 03:06 AM, Mike Frysinger wrote:
> > On Thursday, February 13, 2014 14:05:32 Alexey Kodanev wrote:
> >> On 02/13/2014 12:47 PM, Mike Frysinger wrote:
> >>> On Tuesday, February 11, 2014 13:48:10 Alexey Kodanev wrote:
> >>>> +static int get_tst_count()
> >>>=20
> >>> random note: never never never use () with functions.  always alw=
ays
> >>> always
> >>> use (void).  i'm guessing you're not aware, but what you've writt=
en here
> >>> may>
> >>>=20
> >>> be called (warning free!) like so:
> >>> =09get_tst_count(1, 2, 3);
> >>>=20
> >>> yes, even with -W -Wall -Wextra.  please stamp this horrible habi=
t out
> >>> of
> >>> your code.
> >>=20
> >> Thank you for explanation!
> >> There is a trick to try g++ to compile the code, it will throw an =
error
> >> on that and stops compilation.
> >=20
> > yeah, C++ fixed this historical wart of C.  sorry for not clarifyin=
g.
> >=20
> > iiuc (and i could be wrong as i'm not old enough to have lived thro=
ugh
> > it),
> > this dates back to when C (ANSI?) didn't have prototypes.  with a l=
ot of
> > code out there relying on the behavior, gcc never stopped accepting=
 it.
> >=20
> > i wonder if we could argue for like a newer GNU standard to reject =
it.
>=20
> True, what about -Wold-style-definition option? It will reveal old-st=
yle
> usage, at least would print a warning... Compiled LTP with the option=
,
> got 2 thousand warnings! There are truly a lot of code which is still=

> using it and LTP's code one of them.

we should look at adding that to our default warning list at configure =
time
=2Dmike
--nextPart2277642.vEWjZrOnif
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJS/k+BAAoJEEFjO5/oN/WB3csQAKhmS6XafSyvNo4vPZfqM0tQ
FGHShSJOlQBOMRZwnDctCdROVQyidK3LFeD/FzdtczDL56YFRkcEGFA/0UlytrMh
ESJJb9i0GKAhiouqiAjNMB3TBLkbjuPaC5NtntUjNqo5ySbOlSQVDyTzeeeAPquY
kavzp79KdevZ1jqo9h0PrYZByrCiHkXFPad7MHOmBpNQZH2cmqfh0FnghUsbQLzL
BVcGlxHTSB1Xhvywr471nG50b/9FBuSuyOHfS2VMNvWmjuziDIShFYal6EReHFSi
Db+geSK24dkO/XIYBjxhT+pU3+kH9P+hlrr363t+kn/4CzuGy40iqIMlA1foeyFT
jK3WB5oOtKfpXwyT38NT96NjzBTsRL2w6tBHUeLgBrsCGQflXq4PKG10rmD6JEwZ
vMe5yxVilr7p+vTkpr/eXKBEPysD8ruHsqJHyeXbEnCMumYswc4umP1ay8njrxcZ
IfF+6Ec3yakomLCnSE86LUfd1X7QybNTSIwW3c4fsdR6AX7kuvQKkqUXkKhnF0mH
fDDfY32gIWu07xSrwor6SVo0Ej+hRjYCeuXQb3U51p6KDq6eXAsl+7R9Tm62UMm7
sbxC5PnBuVrh2BnRcu/QQMi4nD3f6LoEEOzqgPEE+ec9zlirfwWijvQNBM8oK9ay
EkGCug7V+D/TMKa4krhT
=wW1p
-----END PGP SIGNATURE-----

--nextPart2277642.vEWjZrOnif--



--===============6438452194503657471==
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
--===============6438452194503657471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6438452194503657471==--


