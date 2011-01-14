Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Pds6K-000823-ST
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 22:26:32 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.72) id 1Pds6K-0000Dg-4L
	for ltp-list@lists.sourceforge.net; Fri, 14 Jan 2011 22:26:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 14 Jan 2011 17:26:52 -0500
References: <AANLkTi=gsOkRM0NQNsKp5-L37hTDwd4+5euqXD9E5gXe@mail.gmail.com>
	<AANLkTikQNHCvRUmYL8dYEayweEEmusAG2nobuPM5qF66@mail.gmail.com>
In-Reply-To: <AANLkTikQNHCvRUmYL8dYEayweEEmusAG2nobuPM5qF66@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201101141726.53024.vapier@gentoo.org>
Subject: Re: [LTP] [Bug Fix] utimes01.c can't build in uclinux
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2743060408695942752=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2743060408695942752==
Content-Type: multipart/signed; boundary="nextPart2882940.b1RY18SCXV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2882940.b1RY18SCXV
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday, January 14, 2011 02:54:47 Garrett Cooper wrote:
> On Wed, Dec 29, 2010 at 1:35 AM, Vivi <violetleigh@gmail.com> wrote:
> > LTP test case utimes01.c can't build in uclinux as it failed in file
> > common_j_h.c.
> > Fix this by diable fork related part in uclinux platform.
> >=20
> > --
> > Index: testcases/kernel/syscalls/utils/common_j_h.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- testcases/kernel/syscalls/utils/common_j_h.c
> > +++ testcases/kernel/syscalls/utils/common_j_h.c
> > @@ -115,6 +115,7 @@
> >  /*
> >   * Generate a child process which will send a signal
> >   */
> > +#ifndef UCLINUX
> >  pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
> >  {
> >         pid_t pid, cpid;
> > @@ -142,6 +143,7 @@
> >                 return cpid;
> >         }
> >  }
> > +#endif
> >=20
> >=20
> >  /*
> > @@ -351,6 +353,7 @@
> >  /*
> >   * Get unexist pid
> >   */
> > +#ifndef UCLINUX
> >  pid_t get_unexist_pid(void)
> >  {
> >         pid_t pid;
> > @@ -368,4 +371,4 @@
> >                 return pid;
> >         }
> >  }
> > -
> > +#endif
>=20
>     This will break more testcases than it's worth. Please revise your
> strategy of fixing the UCLINUX testcases.

in this case, it isnt possible.  this common file provides symbols we need=
=20
along with ones we dont, so the whole thing gets linked into tests.  the on=
ly=20
way to fix it to avoid #ifdef's is to split the fork-related symbols into=20
their own file.  that way the linker wont attempt to link in the unused=20
objects from the library archive because no test we care about will pull it=
=20
in.  but i guess that qualifies as a "revision" ...
=2Dmike

--nextPart2882940.b1RY18SCXV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJNMM2sAAoJEEFjO5/oN/WBVcQQALCa+Nqlyv4BGSKdAFnxllSa
jZHpN9FJIT0pnc2iuUoHuAoAWpQt9VdY2XXzqJnTu6RqiBEa0A3JymQtkRcqFpuz
NkxWGmWdjqaOxDPDHwUIfaHZz797eRYLgdHEh3Zi8nvpXh5O1P8Az2vaZSCKGp9v
5Hq7jQqqacWAL6TD09EsHGob1fZPSZXY7i/QCAs5Caw9B9IQyQTB3YwFP9nshEZP
C04XZr3FB8q4KGPLfg8fZNuTMuhJjhSVcYVoh5qpA7HH/OzV6j3ibQFh/rv/M4rm
KnNQkKfQCW/LqQAG460GgnXgXTFjd3LSrKvzVkbXJbqrkqdosK03aOm8VYYj45B0
2+q99QSlTmUh/s9hXYbc9ZbT/Ex/uzHRr0CFa4mm93CJA/bQhhcghoPZmo0/uHvC
T/dLhK35b9Fwqr14hsbVZcG6hhij2nSC0FuaGdvlzey+VMOSHJ/Ci7GXJ7qfuu1/
of8EADM0SR7Wg809iqCP7VAX/UHT9NXD+1kuMJ/ghY4cZrf2QwFa/XoFR8s2b6tm
uCTAwgRSlmlkf5PLiR2ldtQ2EOGYLksWHpeM1Zq9nsbCCXWtXi2O4MrLZUMtdQzx
2U1DWeofiKDt6xLuDdyxm0lRIrvH9I7oR722Kp1AlVvLweGOwM405r6XHBEBlYwC
M/Al+/AwctLxPM9pXMEV
=VIUP
-----END PGP SIGNATURE-----

--nextPart2882940.b1RY18SCXV--


--===============2743060408695942752==
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
--===============2743060408695942752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2743060408695942752==--

