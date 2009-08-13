Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUYH-00082V-Ub
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:16:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUYB-0000Ik-GV
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:16:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:16:31 -0400
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
	<6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>
	<364299f40908100844l44497151g750f745648080c24@mail.gmail.com>
In-Reply-To: <364299f40908100844l44497151g750f745648080c24@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200908130316.32386.vapier@gentoo.org>
Subject: Re: [LTP] add_key01 & add_key02 test cases fails and shown as PASS
	in log file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7442703103644030367=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: srikanth krishnakar <skrishnakar@gmail.com>

--===============7442703103644030367==
Content-Type: multipart/signed; boundary="nextPart1957307.K8X5mGhoEB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1957307.K8X5mGhoEB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 10 August 2009 11:44:57 Garrett Cooper wrote:
> On Mon, Aug 10, 2009 at 1:29 AM, srikanth krishnakar wrote:
> > On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak wrote:
> >> On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
> >> > I see these two test cases are failing on PowerPC target (ppc440) as
> >> > shown in output file, but they are listed as PASS in log file of the
> >> > LTP :
> >> >
> >> > Target : PowerPC (ppc440)
> >> > Kernel: Linux-2.6.29
> >> > LTP Version : ltp-full-20090731
> >> >
> >> > LTP output file :
> >> > #############
> >> >
> >> >
> >> > 1. add_key01
> >> > --------------------
> >> >
> >> > <<<test_start>>>
> >> > tag=3Dadd_key01 stime=3D1248549741
> >> > cmdline=3D"add_key01"
> >> > contacts=3D""
> >> > analysis=3Dexit
> >> > <<<test_output>>>
> >> > add_key01    1  TFAIL  :  add_key01 failed - errno =3D 38 : Function=
 not
> >> > implemented
> >> > <<<execution_status>>>
> >> > initiation_status=3D"ok"
> >> > duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=
=3Dno
> >> > cutime=3D0 cstime=3D0
> >> > <<<test_end>>>
> >> >
> >> > 2. add_key02
> >> > ----------------------
> >> >
> >> > <<<test_start>>>
> >> > tag=3Dadd_key02 stime=3D1248549741
> >> > cmdline=3D"add_key02"
> >> > contacts=3D""
> >> > analysis=3Dexit
> >> > <<<test_output>>>
> >> > add_key02    0  TINFO  :  call add_key() with wrong args got
> >> > UNEXPECTED errno:38
> >> > add_key02    1  TFAIL  :  add_key02 failed - errno =3D 38 : Function=
 not
> >> > implemented
> >> > <<<execution_status>>>
> >> > initiation_status=3D"ok"
> >> > duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=
=3Dno
> >> > cutime=3D0 cstime=3D1
> >> > <<<test_end>>>
> >> >
> >> > --------------------------------------------------------
> >> >
> >> > BUT the Log file shows as PASS to the above test cases :
> >> >
> >> > ###########################
> >> >
> >> > add_key01                      PASS       0
> >> > add_key02                      PASS       0
> >> >
> >> > ###########################
> >> >
> >> >
> >> > May anyone explain, why it is so ? Is it a known behaviour ?
> >>
> >> No. It is not. On my X_32, it passes fine.
> >
> > Is it PowePC target on which you have tested ?
> >
> >> $ ./testcases/bin/add_key01
> >> add_key01    1  TPASS  :  add_key call succeeded
> >> $ echo $?
> >> 0
> >> $ ./testcases/bin/add_key02
> >> add_key02    0  TINFO  :  call add_key() with wrong args got EXPECTED
> >> errno:22
> >> add_key02    1  TPASS  :  add_key call succeeded
> >> $ echo $?
> >> 0
> >> $ uname -a
> >> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
> >> GNU/Linux
>
> Hi Srikanth,
>     I think that the error is fairly intuitive (function not
> implemented). Are you sure that your subarchitecture supports
> add_key(2)?
> Hi Subrata,
>     As far as the actual issue is concerned, I think that the problem
> is that someone's exiting with exit(0) instead of tst_exit()...

and ENOSYS really should be TBROK or something, not TINFO+TPASS.  or this=20
leads into a past thread where LTP handles this case inconsistently.
=2Dmike

--nextPart1957307.K8X5mGhoEB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg73QAAoJEEFjO5/oN/WBUZYQAKxaA32SFX7xKWjuE99ACnQm
+PFqi/wo8Fzrq1QjPL+pjv4MiaCu9VIiYFpi7c69cFGPNOsvg2TZps7jQWeaSzmX
Xris4qwxTVOInCsQE217L8IYnYYTz5xhvT3TtdIjdXRpvKIxE8t/dXTb3xBfcZi0
O3FyNDncUh8TJUvpfMFZXma8YJFHfNPX4jD6assV+Hem+MxJd6VCtZ6kE1MIi4qp
Ya8kMA7a06ufMS4i8M374sXfQ0L/U6qec1ytJ3QWZgVRhDntDDgPMDGQKyAb2Pz4
pXu1Vh68tnbTmKDeVYG2V3wicoCUJVPM5C5UJTR1Z4mNdlluHKSZadU4ImxgHxK8
cLFlQrapv7xyBXVSMR555GkU7uBbR5Yk4q3xZvmkJH5LVshUxbMWrkkkH0q0oy6/
0ShC1gUcK5Z0MONZGwFmfTzSi56lddKHVEw5dClAFzeLkGcpKiItRMgFkDnpy7pc
8fh7KjyCRPFhG+Z3L+I/x/Hgc5GJohhy8IAEiOvkHu3uiPdBp8My4g7AVcExUhgT
Tjo6onC62J3oQkjCmjrGMRpMiG3RLvgnQVetWx+qwjSnb4gqfBOEElafXZWOy40u
IULtUyqQJIXc9m9UaBHY0+yK6cL5iOHCIZR039j4mFYY2phBTV30xMo/9LbB9RtG
NzdD2NVp7+NsGJcYUsEf
=v/Zq
-----END PGP SIGNATURE-----

--nextPart1957307.K8X5mGhoEB--


--===============7442703103644030367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7442703103644030367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7442703103644030367==--

