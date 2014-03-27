Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WT3bQ-0007Y8-CX
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 06:15:48 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WT3bM-0005q5-9U
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 06:15:48 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 27 Mar 2014 02:15:44 -0400
Message-ID: <2329840.m4xvHeQu3f@vapier>
In-Reply-To: <532C4201.3030605@oracle.com>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<532C1813.9060609@oracle.com> <532C4201.3030605@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 2/3] isofs.sh: be more quiet
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7312421257308727872=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net


--===============7312421257308727872==
Content-Type: multipart/signed; boundary="nextPart2035772.Jni9YprBzV";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart2035772.Jni9YprBzV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Fri 21 Mar 2014 17:43:29 Stanislav Kholmanskikh wrote:
> On 03/21/2014 02:44 PM, Stanislav Kholmanskikh wrote:
> > I think that according to the patch the described behaviour is
> > absolutely expected. Therefore It would be better to leave "ls -lR"=
 in
> > the test or insert a 'sleep' instead. In this case we would use no =
more
> > than 2 loop devices per iteration.
>=20
> I suppose it would be a better solution (and without any waitings):
>=20
> loop_dev=3D$(losetup --show -f isofs.iso)
> # do mount and other stuff
> # do umount
> while /bin/true; do
>      out=3D$(losetup -d "$loop_dev" 2>&1)
>=20
>      if echo "$out" | grep -q -i "No such device"; then
>           break
>      fi
> done
>=20
> This way we doesn't depend on asynchrony in the loop-driver code.

that might work.  certainly the current code, if it's trying to make th=
e=20
script "sleep" in hopes the device is no longer in use by udev/whatever=
, is=20
also broken.

make sure to use LC_ALL=3DC though when running losetup so the localiza=
tion=20
doesn't screw up the grep.
=2Dmike
--nextPart2035772.Jni9YprBzV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTM8IQAAoJEEFjO5/oN/WBHhoP/ROM7ChuE6MnUICQl2jAHSqK
u6roEabNas6pNpTNbh6S1CoLKZ2hYqqZVXdh17+eXjpt8lpp/t87sMbgvvt/nWu4
w+DImUgqkxG2d9wQNr97/k3PmJog8gtKZnEzeLVfvRIwoOPl1IjwPkbqnFmzjzMz
GufMmb2QJwy506tQ4S4USsJZ0lPixB89qud33iU1hRkBcz3Gw/oFvwoL4a46EVyJ
k3GAIrz/xBOyRZzaTQDlMT+CIaMpN9PKpoqCdoIfNoFQTzNiBSyVHaqoMtJwSUAw
KxZjKFLpRCLYFk7iH0SIybDFrpG1fB9brZbT1vDlkN6EhGo7rgUnFPqWnBZJF7aV
OxkP4m2wUg9MJghHtTLTDqr4qcX8nsiA1El+NsH3UwnXoli91S7+O3j7BNTzjTNi
KBCcbwD36PdKPF5y63DhVBrUUvrFblyS0AKbgMYidho+4JXV1TD6XPZRssU7q9mV
n7WOSdc+bFPLoCRC9WS9rUdcuvL+bEmg+10TbKKltZof3tDs+sS/1XcysQ2KB3yJ
iN+jwTKwXmoVjMlLEzxrrRz4jMCyr5/QEjfYSh/uafBJ4gnvMvn5fBkf81IX93ry
FYNuvt0sApqjqEydWmXy526ieHCipYcWbpFMYTvGLUbdHmd7AaLqOylFBv1SXOOi
+SCBCt79TppGrZmlAtpR
=6KF/
-----END PGP SIGNATURE-----

--nextPart2035772.Jni9YprBzV--



--===============7312421257308727872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============7312421257308727872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7312421257308727872==--


