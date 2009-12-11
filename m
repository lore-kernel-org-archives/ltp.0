Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NJBiu-0006eS-Uk
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 20:04:20 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NJBin-0001xM-5T
	for ltp-list@lists.sourceforge.net; Fri, 11 Dec 2009 20:04:20 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 11 Dec 2009 15:04:50 -0500
References: <1114676463.211401260531001515.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1114676463.211401260531001515.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <200912111504.50858.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2256503577300329977=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2256503577300329977==
Content-Type: multipart/signed; boundary="nextPart1435338.gvPKonyVNS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1435338.gvPKonyVNS
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 11 December 2009 06:30:01 Caspar Zhang wrote:
>   Here are two patches to fix compiling error in ia64,
> I tested only in version ltp-full-20091130, please check
> your own version. They are for work well on my system.
> See the attachment.

the ia64 change is incorrect.  there's ia64 ifdef hacks in there already wh=
ich=20
are to be used.

the ppc64 issue is not ppc64 or ptrace specific.  garrett has a different f=
ix=20
in the pipeline for that.
=2Dmike

--nextPart1435338.gvPKonyVNS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLIqXiAAoJEEFjO5/oN/WB2nkP/iXmLNu9sqYHk5+XVLLhihM9
MJZbhvFdT8XDtOwC8hj5Y72ukR+VHJlEqKvxMVCMW7nPnOMbOsz4BogkAZHyBW+u
SZVkpBDu1Hcxkhtv3TUxERJv2j56WSDW9zbrh95y8nB0veGqylnBHFADMnnX6M6z
VvzEDe1dwbO+MrlGpkRGj4mmp3T3xdFV2L95z7bpKswk0AqF+sXID7ZMRaPb68mu
vXlz7EEH+sIsx1kg/UTGr0LTEgri5T8SYnUO7UC2+KkQF3/Thh8KD3/77X7vtyp5
/Ch228pUrTJKlu9WcsZQeOGXX9U4feT1HCx2tuQ3KGnrlKlDIQxWbYjyHGWE8GqW
jRkttTpJ+HUretSVTxWkWAbajObsM4QiCZ1ij7xC+3ooraTn/UgNmlVTjw06F47+
/ewmL2q6DmhYeauX7elSlj33F7s41h0KBZuJv7SNodFkkXJYG2tmY5eX/T7zJsAb
e93Jxwiys8aANdIdG9Mef8aqBC4++PNEMHO8KsfSZwC6tXgverNrSs1DEhLUbN+N
rzGlGi/8HD2EKIuvWpFnVLD3pQOc0k3WSuR0UcuItdEryqLH+i9nyrk6yRagyIv7
HJjlE4PBNw51hMS/8+BxCACyuTdhIU3wKwvcsOv5I/7IAYborKUGafMwkiWBXbDe
eAgj0iAS5Lxfuk/8PbBy
=MwI8
-----END PGP SIGNATURE-----

--nextPart1435338.gvPKonyVNS--


--===============2256503577300329977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev

--===============2256503577300329977==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2256503577300329977==--

