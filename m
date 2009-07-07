Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOCYB-0003tD-Ie
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:25:43 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCY6-0000qR-9b
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:25:43 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 7 Jul 2009 10:24:45 -0400
References: <4A51CEDC.6080605@linux.vnet.ibm.com>
	<200907061806.47824.vapier@gentoo.org> <4A52F207.1010106@st.com>
In-Reply-To: <4A52F207.1010106@st.com>
MIME-Version: 1.0
Message-Id: <200907071024.46408.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5740755437162201795=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: ltp-list@lists.sf.net

--===============5740755437162201795==
Content-Type: multipart/signed; boundary="nextPart3823933.YsEZbWllyK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3823933.YsEZbWllyK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 07 July 2009 02:58:15 Francesco RUNDO wrote:
> Mike Frysinger wrote:
> >On Monday 06 July 2009 13:28:00 Garrett Cooper wrote:
> >>On Mon, Jul 6, 2009 at 4:38 AM, Francesco RUNDO wrote:
> >>>I've already fixed the same issue you reported. I've tested it
> >>>successfully.
> >>>
> >>>Subrata has already merged my patch (please, find it in attachment).
> >>>
> >>>Please, check it before to submit another patch.
> >>
> >>At the end of the day, the real problem is that we're not using the
> >>--with- functionality in autoconf, e.g. --with-cgroups, and instead
> >>we're hacking a lot of noise into Makefile's.
> >
> >selectively compiling groups of code needs to be thought out before we
> > start throwing --with-foo options at the problem.  otherwise we'll still
> > end up with crap, just in a different form.
> >
> >>I can tell at first glance that that Makefile is a mess anyhow,
> >>because it's referencing _hardcoded_ /proc references and as such will
> >>fail to cross-compile properly if the target or the host are setup
> >>differently from one another, in the following two scenarios:
> >
> >yes, the merged patch and that makefile suck.  there should never be any
> >filesystem check in a Makefile anymore.  while peeking in /proc is
> > somewhat forgivable, looking for headers never is ok.  we have autoconf
> > tests now and Gowri's approach looks like the correct one.
>
> I agree with your explanation. My patch tried to address an issue on the
> testcase when  LTP is cross-compiled.

i'm not faulting you ... you worked with what is available and common.  we =
now=20
have better methods of doing these checks, so we should transition to those.
=2Dmike

--nextPart3823933.YsEZbWllyK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKU1quAAoJEEFjO5/oN/WBybYQANWLwcB5eKwBvWwVv7NaMB2c
4KXhnBeRbN35RyjmJfrK7hvlJuVONlO0Ru8tdCjd68+tC1gboLXrlCmt4e5f666g
kRX3Pja4NjTMgYf94Ql83fVfrUNsvf1xAmtgyDER6Rb2LALsTCOdZ3z/+uzCRc/Z
SBspbn9bK2WurEYkLWebmlsVCjhsBh53wKyqbwqEHeO5XGVrh3phvgN5K/Oux1T9
2eq+Gl98P9pqugV02m0AkDsHSNOeS9iSU/D+06O1Q3FFURYfSRcWbCHFuu5DKbAe
86hlfAGc2UXidLRRZ8N8dxoLUTGPpQt5RGdKUSr2IWmWAcRK8aVHZJTuVRAt/3wB
NiHSe3MQbOW6cFI7iF9s8CM7OtXZfEciEK3faF/maA/UP9J4OPdB1AJ469C2/wLL
B1jAni2xfDJSrQadvX5+VN/xNVhsKlBSGxMaQL63L6mu6jCrHW9qGqATbrdmYk2n
roGIumnTkTTV/wP8ZO4IsMU5jzdPU3jcO/u8yerUe8ermh3HX6/Ow18uJ+XUHfTg
HGak4N8ysrHvTAJsDiprscRPBkpfpJc2UKuTBsue5c8bR5t/0RamYIIl3pI4PuSy
0XedSyfl/WKRMGocthCuuVy0RHI/CoCj96t7I6/cb5Iih8XCywdfhFjmGSlImUu2
6XJ/eU2yvfPTc5pVyoQy
=N+r2
-----END PGP SIGNATURE-----

--nextPart3823933.YsEZbWllyK--


--===============5740755437162201795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--===============5740755437162201795==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5740755437162201795==--

