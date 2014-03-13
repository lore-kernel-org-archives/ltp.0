Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1WOCf4-0006p0-7F
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 20:55:30 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WOCf3-0000KT-2r
	for ltp-list@lists.sourceforge.net; Thu, 13 Mar 2014 20:55:30 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Mar 2014 16:55:26 -0400
Message-ID: <2396644.2WVkagNouJ@vapier>
In-Reply-To: <1394714306-9678-2-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1394714306-9678-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1394714306-9678-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/3] isofs.sh: use $TMPDIR for temporary directory
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6001368762566774423=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com


--===============6001368762566774423==
Content-Type: multipart/signed; boundary="nextPart1964501.gAyc2jRJgg";
	micalg="pgp-sha1"; protocol="application/pgp-signature"


--nextPart1964501.gAyc2jRJgg
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Thu 13 Mar 2014 16:38:24 Stanislav Kholmanskikh wrote:
>  #Initialize directory variables
> -    MNT_POINT=3D"/tmp/isofs_$$"
> +    TMPDIR=3D${TMPDIR:-/tmp}
> +    MNT_POINT=3D"$TMPDIR/isofs_$$"

why not just use `mktemp -d` ?
=2Dmike
--nextPart1964501.gAyc2jRJgg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTIhs+AAoJEEFjO5/oN/WBYlsP/2P2xa2/BuE/gI/9KfnDwmg/
nMycutPZ0oLXJS0BIkY+a9f3Ad0awnOO3cUh+GcVvsg8jCSFy5TtXHU1tbJdjoNQ
GO1xJ+8ZImLLFec68h8S6DaEtXUd7+LdJq/jAhLqdl3xYouedQOS79SDHDguylV9
tu2y2k9t80S22chJ6/XAJlXWMBhX44UcrS0hsaTiocjAFkO8J9VrwGo5VGYeqj+4
P/WgU3ptl1jQeU+6E1Ttss9wPRD8yPd20dBhQKTFood6G8hwpp+y3AnNOszjvYrc
tWx02EmOfDCNe0o5E17jocbS12tZC/4THYlS59RyPvBVBfPSZS+WfcilAjBtcSdP
fIIBKpHMZnRbzSPgK5e5FjCwt/HSw5s9UeAyhXiJjXSDuGYogQ/9do3KxiBK4cDO
CH5KPTBHTAr5Fx2IbKExPxJi2kTGmeLFpVyLttX2Kq17MalNRXyrJK7mfTtSIi3y
VZor0Tr35f1M7nrPQK0bRlPnNpxxJ2NhT+1WyCl9bkbOGGs1hqI0SfpBWJPl23WR
DnAUBMHqDNIm5WtYVkqN/BZq52bbV0U406IHWNjD8PqA8unvKraoXM//vBVnwr8/
+Vpw19auy8vi9XII8n7h8wWffXr8XF6KQi0AUcW1oBjEpEu4wyGEYdqVTeiwoOwP
KjymLYKZzGJusVXQQpa0
=R3hn
-----END PGP SIGNATURE-----

--nextPart1964501.gAyc2jRJgg--



--===============6001368762566774423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
--===============6001368762566774423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6001368762566774423==--


