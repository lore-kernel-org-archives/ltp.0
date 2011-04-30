Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <vapier@gentoo.org>) id 1QG0Vw-0003e7-IN
	for ltp-list@lists.sourceforge.net; Sat, 30 Apr 2011 03:06:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QG0Vv-0000ar-J2
	for ltp-list@lists.sourceforge.net; Sat, 30 Apr 2011 03:06:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 29 Apr 2011 23:05:30 -0400
References: <20110428154913.GA30341@saboteur.suse.cz>
	<2f8166bddb0fc6d8c85de5ca7984e2292be5a1eb.1304131958.git.czhang@redhat.com>
In-Reply-To: <2f8166bddb0fc6d8c85de5ca7984e2292be5a1eb.1304131958.git.czhang@redhat.com>
MIME-Version: 1.0
Message-Id: <201104292305.31174.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v4] thp testcase come from CVE reproducer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1975196509545011781=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1975196509545011781==
Content-Type: multipart/signed; boundary="nextPart1860528.XZlS4AHGxi";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1860528.XZlS4AHGxi
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

dont hard depend on /bin/true.  simply execute it through $PATH ... i.e. us=
e=20
execvp().
=2Dmike

--nextPart1860528.XZlS4AHGxi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJNu3x7AAoJEEFjO5/oN/WBj/kP/2rFAYgIx6zjOJBAPSZR/qA3
4ZhPs0kN9Ozrj22bunEt3jMTihEGC2StuLtem4Ef4fNqkUFmI/VK5t6a1VsDoxgI
VsEx4fRQDJCW4HrwMlmasALyH8usuzk9q6K8+NohGQJ0vbfi8VVUDnUJlUTXnvGT
hzpF4LP+G1h8u7MbQQvReEDOG96aaC8gN1MJjcvQ1o5CDLKBeV2UT6V1dQ0l+fer
RP5VlIRlSZHidLbZVgopv5ae+pN2Z2Thxw4g9xS2E3MGPVdXmMEGm0i+eYmzF46q
sPoSSJ18I14JbHcgJtQBssey54HjKkz2lQ6XZ18o/KJk2bybLYZIyQhxHlFc86HU
aXT6JIKVd5Nydets9cK1tm8pwbpOVmlcOih+jHHtlnsRPoKJwSRiEo3Z2fR5qxbW
QnHzT1wgpQpIu/yrwz28863CvCky+1vXFdD3+jcOchlT5fc5cV5STypbU9DpDb0i
vpViEM2OrgH6JMWO89mm6o6malCrSJ1JEJCWgtL1xrl91n7OJ2D/u6PBpYhyNbga
0gtyiU1uWgOkOYmJlQxci1Q5K4MVJ2s8Hw8iPrnIhW941Nx1Ef9Cj2/8tgAJe+TH
AcnRlsJaXIdw9pPO1SO8gBimfJj7P+mSWJggvHTyBZq1965SqwRwlBeTojDBWPbd
qR6FT4Af9D4SSNLOl03J
=+uXM
-----END PGP SIGNATURE-----

--nextPart1860528.XZlS4AHGxi--


--===============1975196509545011781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
--===============1975196509545011781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1975196509545011781==--

