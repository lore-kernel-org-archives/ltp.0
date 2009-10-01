Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MtOh6-00017b-Gl
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 16:39:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MtOh0-000565-8y
	for ltp-list@lists.sourceforge.net; Thu, 01 Oct 2009 16:39:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 1 Oct 2009 12:39:38 -0400
References: <200909241229.32866.chandru@in.ibm.com>
	<200909260725.29279.vapier@gentoo.org>
	<200910011257.47226.chandru@in.ibm.com>
In-Reply-To: <200910011257.47226.chandru@in.ibm.com>
MIME-Version: 1.0
Message-Id: <200910011239.39024.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] ppoll01: add signal() syscall to register the
	signal handler
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5945510728522303726=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Chandru <chandru@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============5945510728522303726==
Content-Type: multipart/signed; boundary="nextPart1356297.jFt7z9einp";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1356297.jFt7z9einp
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 01 October 2009 03:27:46 Chandru wrote:
> On Saturday 26 September 2009 16:55:28 Mike Frysinger wrote:
> > On Thursday 24 September 2009 02:59:32 Chandru wrote:
> > >  3. Takes away
> > >  printing the type of error ( i.e strerror(errno) ) since it only
> > > prints the last error seen and does not report the failures seen in t=
he
> > > cases before the last failed one. The reporting of NG or OK shoudl ta=
ke
> > > care of letting the user know the cases that have passed and cases th=
at
> > > have failed.
> > >
> > > -                 	   	tst_resm(TFAIL, "%s failed - errno =3D %d : %s=
",
> > > TCID, TEST_ERRNO, strerror(TEST_ERRNO));
> > >  +                 	   	tst_resm(TFAIL, "%s failed", TCID);
> >
> > why dont you *fix* the issues you see with this output instead of making
> > the output even more useless ?  also, this should be converted to
> > TFAIL|TTERRNO.
>=20
> em, the change was not useless, the existing reporting of failure was. The
>  output on failure of only the first case prints as
> "ppoll01     1  TFAIL  :  ppoll01 failed - errno =3D 0 : Success"

you've shown problems in one case, not every single one.  at any rate, you'=
ve=20
taken a stab at fixing the problem properly, so arguing semantics here is a=
=20
waste of time.
=20
> --- ppoll01.c.orig	2009-09-29 21:28:55.510487735 +0530
> +++ ppoll01.c	2009-10-01 17:34:42.651235797 +0530
> @@ -242,6 +242,8 @@ static struct test_case tcase[] =3D {
>  #endif
>  };
>=20
> +int tstatus, terrno[16];

declare terrno static and then everything is initialized to 0.  then you do=
nt=20
need to track things in tstatus as non-zero should indicate an error.

hard coding 16 seems like a bad idea ... isnt there already a define/variab=
le=20
that holds the test count that you can use ?

> @@ -331,6 +334,11 @@ static int do_test(struct test_case *tc)
>          errno =3D 0;
>          TEST(sys_ret =3D syscall(__NR_ppoll, p_fds, nfds, p_ts, p_sigmas=
k,
>  sigsetsize));
>  sys_errno =3D errno;
> +	if (((tc->ret =3D=3D 0) && (sys_ret =3D=3D -1)) || ((tc->ret =3D=3D -1)=
 && (sys_ret
>  =3D=3D 0))) {
>  +		tstatus |=3D (1 << tc_no);
> +		terrno[tc_no] =3D errno;
> +	}

looks like this test was written without really understanding the LTP=20
framework.  setting errno to 0 and the use of sys_errno is duplicating stuf=
f=20
LTP is already doing.  the code should be using TEST_ERRNO to get at the er=
rno=20
from the TEST() call.  this applies both to existing code and your new code.

> - tst_resm(TFAIL, "%s failed - errno =3D %d : %s", TCID, TEST_ERRNO,
> 			strerror(TEST_ERRNO));
> + tst_resm(TPASS, "ppoll result =3D %d  ",result);

how can it TPASS and then turn around and TFAIL ?  this new tst_resm() shou=
ld=20
just be dropped i think.

> + for (i =3D 0; i < (int)(sizeof(tcase) / sizeof(tcase[0])); i++)
>  +  if (tstatus & (1 << i))
> +     tst_resm(TFAIL|TTERRNO, "%s failed - errno =3D %d : %s", TCID,
>		 terrno[i], strerror(terrno[i]));

this isnt how TTERRNO works.  the code should be:
if (terrno[i]) {
	TEST_ERRNO =3D terrno[i];
	tst_resm(TFAIL|TTERNO, "test %i failed\n", i);
}
=2Dmike

--nextPart1356297.jFt7z9einp
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKxNtKAAoJEEFjO5/oN/WB1c4P+QHwqHFuQgeZjpAiNzb9Z+Rt
vhXiiQtXZWGQgL1NKxHPK+zCp9p/Q0xiceVAqVmQpV5FriSg3YUPLIfpE/cOnLbg
ch0a8VOb0slLkG16WZigPk4znGw878mKtXdXb7tMXwW7Iia7jqWhqRnu8Ji0dpna
Jiqld4SFzKAJ6GbxwMUj6MxXcmO0SNloH0z5cP55vGwevfP+wueJztJISDP/C+UP
pVC2ViBQsrR9sX4qXJIuCWnR7SnScWIm5wSLV7wCI2AYitPj6V4YEc4oA+5WxWtd
lxgGiMoysDQLyXfHZdSWIbHsvZkl+IBrDTei5OPzXINkBlxCAsTurqQubsAIxECL
Ca8SK7MNAgVwvYNDx6CBLIn8afZ+xVGrWq4sjjHiMccYaV9vUUSTyHa8sRau7SCO
Unw1F2z866HAVXikJBGdb7C5V2r3fYYea0avLOwBfzAIbCzjXHZxHfzRRXiJiV4u
3Pd1Qw4c/I4EeOQyaJ3Nq7scs1m/aoN5Ve8AlrDzHZUpKpJ/bbGHGB0hBedamkM3
Tof0gV4eHgjkMWDck71S4V0xC95e85Nrsz0Fb9Un+p4aLBMK+rlRk2aE5/ZVFeZD
0eGnwu9L5hngKXQNhRchD/SgtcR2pT8Kl/J8SEYlu+MvOvTRwT7g1hNHalWrkIKG
f93If6gfedX8H9GbAikf
=98EC
-----END PGP SIGNATURE-----

--nextPart1356297.jFt7z9einp--


--===============5945510728522303726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
--===============5945510728522303726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5945510728522303726==--

