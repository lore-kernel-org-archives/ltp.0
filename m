Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MJpmf-0002nG-Ka
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 14:18:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJpmd-0008Ft-9c
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 14:18:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 25 Jun 2009 10:18:29 -0400
References: <A850D9FA-3282-440E-8B85-4A5BC5B4B067@gmail.com>
	<1245921038.5542.46.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1245921038.5542.46.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <200906251018.30773.vapier@gentoo.org>
Subject: Re: [LTP] Goals and milestones
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4065817938450636772=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: LTP list <ltp-list@lists.sourceforge.net>, Nathan Straz <nstraz@redhat.com>

--===============4065817938450636772==
Content-Type: multipart/signed; boundary="nextPart3759010.zUBaQH1gDW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3759010.zUBaQH1gDW
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 25 June 2009 05:10:38 Subrata Modak wrote:
> Great to hear back from you. Your plan looks good to me. However, i
> would like to complete the Makefiles stuff this year itself. I know its
> quite tedious. May be i would also pitch in to help you post my Linux
> Symposium 2009 in July 2009.
>
> On Wed, 2009-06-24 at 02:38 -0700, Garrett Cooper wrote:
> > Hi Subrata,
> >      After being away from FOSS for a while I'm going to jump back in
> > a bit to get some work done in my personal time that aligns itself
> > with deliverables at Cisco. Here's the breakdown in terms of priorities:
> > 1. Ltp crosscompile makefile push completion - need this to resolve
> > several issues with the current hacked make system and expedite
> > upgrades on our end. Hard goal: before July snapshot is released
> > (several items are dependent on a functioning upgrade). I will commit
> > in small, discrete patches to get the work done quicker, but I'll need
> > a makefile reviewer.
>
> Nathan has already been helping us. So, we would get help from him and
> Mike as well. I need to bring back Mike as well for more LTP
> involvement. Mike, what do you say ;-)

sure, if the patches get posted to the list and i dont miss them ...
-mike

--nextPart3759010.zUBaQH1gDW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKQ4c2AAoJEEFjO5/oN/WBQK4QAJNvR/H0Mk3qjyQXLsKIl0hB
jLl2cIOVnvzinvBGpi9Wzdo+Xrs6/z2EKD5aNKh7anXRkVzWmGWRKGmWf6CS6FvC
xIPsCLD9ike5eFNx8F30M7HdN+3xk8IIqp0thPSM7z8a7O0wGvBR6m2acAbtOhj/
HMjYJUFiN9XGlsDiqj4lqvZvd484m2OA/brnW8MASydfc9sMiAUQ0e6I16NiKSuT
2S2uVFQtrnHdyh9cful/zwdJY4xJceVjiPYJylyXHQldBDEl51Rv9GnehGeAl0ze
UTBY3xEXNEDMFF/PacGwTEJqXkLtjUJnMnf076RyXDEc4fRbd7S2OLlpsTIWjD9M
sdfS+VN0mny7nMCR7eqcRItqCW/3lt5UDHW38YrO3FMLFk0S5kC6kBootYuKXXJW
5/weANdgmpRushCtn8oEgbLyo+sv/eCyCJbYvYN16t4qcppauTuUYgca6qqT66b4
ual+cDHmZLX6jyR6PHrukKr4iPmJ0UrsA9eHPvu41e2CQmoGolRL51vF21X7yHUV
OL0mLQN+Ph89JdVgeGen9m7+eKWPkR9KUDubnDOzu3/Afd0RaFjkmNWpJJ1ePorh
wDq7YDe/MCBq9z3kKrjhAygP4zSdpl3IYffocuTxBKUWsyqhmomja6FoiE7EUT0D
Of+bmsRTrJ63gcyAdXED
=rs7s
-----END PGP SIGNATURE-----

--nextPart3759010.zUBaQH1gDW--


--===============4065817938450636772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4065817938450636772==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4065817938450636772==--

