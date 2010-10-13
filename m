Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1P5r7w-0006HQ-CZ
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:31:36 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5r7v-0003QQ-By
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:31:36 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 12 Oct 2010 22:28:50 -0400
References: <190532638.267491286935589416.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <190532638.267491286935589416.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <201010122228.51488.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] mmap/munmap /dev/zero
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7729410554806453090=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list@lists.sourceforge.net

--===============7729410554806453090==
Content-Type: multipart/signed; boundary="nextPart2432699.KWTMcyqoRB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2432699.KWTMcyqoRB
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 12, 2010 22:06:29 CAI Qian wrote:
> ----- "Mike Frysinger" wrote:
> > On Tuesday, October 12, 2010 10:07:16 CAI Qian wrote:
> > > +	 x =3D mmap("/dev/zero", SIZE+SIZE-4096, PROT_READ|PROT_WRITE,
> > > +		 MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
> >=20
> > uhh, have you even checked this test ?  this mmap() makes absolutely
> > no sense on so many levels.
>=20
> Can you elaborate?

so you havent actually looked at the syscalls made by the application and t=
he=20
memory maps created nor used mmap() in detail before ?  well, let's start w=
ith=20
the mmap() man page:

	void *mmap(void *addr, size_t length, int prot, int flags,
		int fd, off_t offset);

"addr" doesnt sound like "file name" to me, and the description agrees:

	If addr is not NULL, then the kernel takes it as a hint about where to
	place the mapping; on Linux, the mapping will be created at a nearby page
	boundary.  The address of the new mapping is returned as the result of
	the call.

so basically you told the kernel to create a mapping in/near your .rodata=20
section (since that is the address of the constant string "/dev/zero").  th=
e=20
contents of that pointer (which is not of type "char *") have absolutely no=
=20
meaning to the kernel.

then there are the flags you're using:

	MAP_ANONYMOUS
		The mapping is not backed by any file; its contents are initialized
		to zero.  The fd and offset arguments are ignored; however, some
		implementations require fd to be -1 if MAP_ANONYMOUS (or MAP_ANON)
		is specified, and portable applications should ensure this.

so not only are you not getting a mapping from /dev/zero, you're just=20
allocating a random piece of memory that the kernel has guaranteed will be=
=20
zeroed out for you.  so any attempts to verify the contents are zero *becau=
se=20
the data came from /dev/zero* fail.

finally, there's the fd which you're passing as "-1":

	The contents of a file mapping (as opposed to an anonymous mapping; see
	MAP_ANONYMOUS below), are initialized using length bytes starting at
	offset "offset" in the file (or other object) referred to by the file
	descriptor "fd".

"-1" is not a valid fd, so there's no way it could possibly be from /dev/ze=
ro.

so we're back where we started: this test makes no sense as written and you=
=20
apparently havent verified it "works" beyond "is the exit status 0 when it=
=20
finished".

> > why are you using _exit() ?
>=20
> It is used to terminate a child.

i meant why arent you using exit() ?  why do you need _exit() semantics ?
=2Dmike

--nextPart2432699.KWTMcyqoRB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMtRljAAoJEEFjO5/oN/WBStQP/37RHCBOFUJru0Vje0EYAvKJ
EaC/V11/L21eLe0yccxEiN9IWNaAZTt08SFPHa2Q1Xyc0TcIQl38yLpGTbe9yUfM
3kc8BSKnT3wMERPn0t54lvZxi4Nx14UwxxHp6GkcPkxwB/Dto1sVSA+glLTVUiBF
qOZiBDsmu9iEyKKqtWOIRpInMbQr5BT95nYlon2qWO/pLpWalzzixfQVLEfKL21E
ieVnmAV+mr4azUhVC4UIEYnYJRmsouvGgD7uAxtbCkdz4gzikKMne8LTAYg86bcB
EtnRHv5x6G93fWVM2TKYeKNgDUCJsH94hd6lsWtqErRgNNpn23pRTov2lrqQaZ+7
hK0DiCJP2xVGlhokHWkW4FPxkWya0rsIMi0Y3JyQG95W6YGwrKJGpCt931IPmwup
ntREHYwD5uw9SbHD/vBuUxUJjypnDiMgjY1OzfxMzh8s3aYePWSSL3SrgAWuiUvP
UdW9HuZkfNDoHIVV2DAR8j5Mm46uJne/WsANYU0U+CKGhisVBM8toP1Siw3Qmqrf
ZYGaCsAvFXRuu7KlvYnJowQSB+PkcROcdL/jzlOpHBQyeANvDCG/uWuo61kNB507
2Ll/4EIy59hXPkPKom957/ptCNeJRyaHrvHl3B5D/13RVXMt7kMhg7uiyOeP6o3X
9ro2mvO36HF0/IpQpDwh
=rNyi
-----END PGP SIGNATURE-----

--nextPart2432699.KWTMcyqoRB--


--===============7729410554806453090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============7729410554806453090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7729410554806453090==--

