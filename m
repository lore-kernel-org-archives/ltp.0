Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Pdrs2-0007Nv-He
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 22:11:46 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1Pdrs1-0002an-GP
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 22:11:46 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 14 Jan 2011 17:12:04 -0500
References: <4D301BF1.8070101@cn.fujitsu.com>
	<201101141646.09224.vapier@gentoo.org>
	<AANLkTiknw80paBiHe9_qBhW1XHLXuaKM=dQyx4kNg1x6@mail.gmail.com>
In-Reply-To: <AANLkTiknw80paBiHe9_qBhW1XHLXuaKM=dQyx4kNg1x6@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201101141712.05548.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix a building error.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4264748712835534034=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4264748712835534034==
Content-Type: multipart/signed; boundary="nextPart13637097.Dt7B4zLB2Z";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart13637097.Dt7B4zLB2Z
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, January 14, 2011 16:52:15 Garrett Cooper wrote:
> On Fri, Jan 14, 2011 at 1:46 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> > On Friday, January 14, 2011 16:33:38 Garrett Cooper wrote:
> >> On Fri, Jan 14, 2011 at 1:24 PM, Mike Frysinger wrote:
> >> > On Friday, January 14, 2011 04:48:33 Peng Haitao wrote:
> >> >>  testcases/kernel/syscalls/mallopt/mallopt01.c |    1 +
> >> >=20
> >> > please use descriptive subjects in your patches.  this really should
> >> > be something like:
> >> >        mallopt01: fix build error due to xxxx
> >> >=20
> >> >> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c
> >> >> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c
> >> >> @@ -37,6 +37,7 @@
> >> >>  #ifdef CONFIG_COLDFIRE
> >> >>  #define __MALLOC_STANDARD__
> >> >>  #endif
> >> >> +#include <malloc.h>
> >> >=20
> >> > umm, no.  malloc.h is a dead header file and nothing should be
> >> > including it.
> >>=20
> >>     It is exposing extra junk in this case that isn't available from
> >> stdlib.h, which unfortunately the test uses. I fixed the build error
> >> for now, but maybe someone upstream should be informed that this
> >> header needs to die a painful death, because all contemporary
> >> documentation says that you need to include stdlib.h, not malloc.h
> >> when working with malloc(3). I was reminded of this recently because I
> >> built some stuff on FreeBSD and FreeBSD has a nice #warning about this
> >> deprecation.
> >=20
> > err, right.  we're using mallopt() here and not malloc().  the former is
> > not part of POSIX which means it should not be in stdlib.h.  i dont
> > believe it is being deprecated on the GNU side, so we dont want to go
> > killing off the tests.
>=20
> Should these tests live with glibc then and not ltp?

not really.  you might be able to get glibc to accept these, but you'll mos=
t=20
likely need to rewrite them considerably.  plus, other C library=20
implementations also support mallopt, not just glibc.  while it isnt part o=
f=20
POSIX, i do believe it is part of older standards.  glibc seems to quote=20
SVID/XPG/ANSI.
=2Dmike

--nextPart13637097.Dt7B4zLB2Z
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNMMo1AAoJEEFjO5/oN/WBoeQP/3Koh57BiH2lyBsUorEGhpsO
L3unwwMtMIFvcSKnuUNrtj0jsQRvSxbf/QoySO4ZwVqzNQfx5plc0/s+W5CkGv08
CFsG5kQgXYW6jnVKdl06h5MmSbXQN7Q+CzOeE+qVoi+8WAEqKOCtA/hjKHKPuX8s
X7bB/89p7ayjR203kjo+gH/BEpZHKl+QyiYnkh+kdS/EFT7az4+TEE4qs2Q3DnV4
lafNK0COgCMQGwteYeGYeiOhhbSFr7DfMp1eGapdDiRwa9DZ5gXVMZ1uCfHRoUab
jNlmPcODGbT5iyOlmKXOTH9+zO+BHrg7c0AJ5v+LcHvIc7v9RsEjukC0lxINprhK
lEkVR7CUU13yChLNRckbRUsUNHEiml6mDZOI+GFJUu7wkiHq7rcbndHJKldyQrDj
2agX0DHhcrPhPHtn9OsLbWiDeaD2ice1XVg9Yh2UslF9hPvrRc36XtlRccsPpPE/
reMD5gxOpuXlr9UtUIyA8y636PJSwmV+AGwYe5xa5GvGOHljWdzHNTEeFoRsjuB5
lM3RazY0+DWOC4SoW3WfHuuQSlTwqi2P+/bgQrIa2I4aIxtGApxbVwfbXpldrJ1O
YjcPKXDIgZAZNdUM9jjEua3OfrTtk5CFm0aQ5O3I1nI/ii9saZyHaKhqfIG4DNme
dZjbo7SoS4pfpZ4W2Lui
=POo5
-----END PGP SIGNATURE-----

--nextPart13637097.Dt7B4zLB2Z--


--===============4264748712835534034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
--===============4264748712835534034==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4264748712835534034==--

