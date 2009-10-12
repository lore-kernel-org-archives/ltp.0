Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MxPlC-0002Yc-0A
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 18:36:42 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MxPl4-0005qK-4q
	for ltp-list@lists.sourceforge.net; Mon, 12 Oct 2009 18:36:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 12 Oct 2009 14:36:25 -0400
References: <4AD2F942.1090004@cn.fujitsu.com>
	<364299f40910121128w48dbef1bpb8ab9fe4b48029ec@mail.gmail.com>
In-Reply-To: <364299f40910121128w48dbef1bpb8ab9fe4b48029ec@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200910121436.26663.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] ppoll01: Fix to set the signal handler of SIGINT
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0676574530375795933=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: liubo <liubo-fnst@cn.fujitsu.com>

--===============0676574530375795933==
Content-Type: multipart/signed; boundary="nextPart1564947.tbJvIHxbhG";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1564947.tbJvIHxbhG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 12 October 2009 14:28:02 Garrett Cooper wrote:
> On Mon, Oct 12, 2009 at 2:39 AM, liubo <liubo-fnst@cn.fujitsu.com> wrote:
> > The test case ppoll01 does not register the signal handler
> > of SIGINT, so the program will be terminated by SIGINT
> > from child process.
> >
> > Then, the rest cases will not be tested.
> >
> > This patch fixed the problem.
> >
> > --- a/testcases/kernel/syscalls/ppoll/ppoll01.c
> > +++ b/testcases/kernel/syscalls/ppoll/ppoll01.c
> > @@ -124,9 +124,17 @@ extern void cleanup() {
> > +/*
> > + * sighandler()
> > + */
> > +void sighandler(int sig)
> > +{
> > +       return;
> > +}
> >  void setup() {
> >         /* Capture signals if any */
> > -        /* Create temporary directories */
> > +       signal(SIGINT, sighandler);
> > +       /* Create temporary directories */
> >         TEST_PAUSE;
> >         tst_tmpdir();
> >  }
> > @@ -404,16 +412,6 @@ TEST_END:
> >  }
> >
> >
> > -/*
> > - * sighandler()
> > - */
> > -void sighandler(int sig)
> > -{
> > -        if (sig =3D=3D SIGINT)
> > -                return;
> > -        // NOTREACHED
> > -        return;
> > -}
>=20
> 1. If all that the signal handler does is just return, it should have
> been doing SIG_IGN from the beginning.
> 2. I don't understand how your change fixes this because the signal
> handler's function is almost the same (the original handler was more
> generic).

default behavior with SIGINT is to terminate, and going by this patch, no o=
ne=20
set up a signal handler for SIGINT.  so the fix as you implied sounds like:
	- call signal(SIGINT, SIG_IGN);
	- delete sighandlerr()
=2Dmike

--nextPart1564947.tbJvIHxbhG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJK03cqAAoJEEFjO5/oN/WBaB4QAJdR6aw6qfHIHU0mMKF6Vuh0
D9z3vLDnu/0vnwpavexmYX0BF/lO+gwZroX+9XhJD57Mjd3ER38pXCaSwLpT6PDB
M99kn4DUP+LgI0ENN0br8mMJhD4nnwQcdigxlyAnWCLjNLjrFkNuoUUKm/rw6b0W
KL95GDohOgyHu8AfKGCKZDRtYxu117DAlRCta1MdmUFp5ZJ4VPFVTnUHQKEkipOw
LiqHXx2uiNRLVdCiRRfk0N+7Djr6F/mNaPodXLWSbzZkGp4maLmnS1gIsQHyPUr2
jwIJTgHMVrhAV1v/J2ZdvOW3C1VFFFROarmi6ENfrMRHAa5GpEslQC0Y+fdkVwCt
et2+U1hJU4ncx2tr7/nwxD7sUwV8zBtGqAtb28J92/PtEkZJEHKbGtqUl6jhUbZk
S5yL/MGGQtg+NF4hxbULfg3aanwTwvfAkngPqv90fLJtwy8Nl1/sM22MwqzCQhb1
LCBRi+f3nawf2+bBzCOlNufYF6Rrk/v2nKyIAwg46p0UCR4z0Dey2CduwL9OyvJX
iGn7AZQOzFzDPkT1YWvQf71pVcU3dYB1bDGdB1Yf46e9zDLqcgj+7jGcmM/pNnne
xvGKU5zcb2K96DpbPf6jyOPQ+M2NSliaI6RsGs3ivvI/P1/SY/6gvX7W60zfhjqC
B3PC63saQICJ0tTGkdZM
=7zgK
-----END PGP SIGNATURE-----

--nextPart1564947.tbJvIHxbhG--


--===============0676574530375795933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============0676574530375795933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0676574530375795933==--

