Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VDP3Y-0001Gf-H2
	for ltp-list@lists.sourceforge.net; Sun, 25 Aug 2013 01:23:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VDP3X-0008JC-LE
	for ltp-list@lists.sourceforge.net; Sun, 25 Aug 2013 01:23:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 24 Aug 2013 21:23:35 -0400
References: <CALGiYOHZ8qNPSNSwuQ_BQf3L3J=gXbGUgg9Pk45Lke9-ugBueQ@mail.gmail.com>
In-Reply-To: <CALGiYOHZ8qNPSNSwuQ_BQf3L3J=gXbGUgg9Pk45Lke9-ugBueQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201308242123.36727.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] network/stress/route/route[4,
	6]-redirect: add PATH setting for ip
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6468205091207141086=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

--===============6468205091207141086==
Content-Type: multipart/signed; boundary="nextPart3926181.MaziX2N2yX";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3926181.MaziX2N2yX
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 08 August 2013 05:59:06 Xie Lingyun wrote:
> ip command is not in default rsh $PATH, add PATH setting for 'ip addr
> flush' the same
> change
> in route4-redirect and route6-redirect

your patch is line wrapped.  maybe you should use `git send-email` to post=
=20
things ...
=2Dmike

--nextPart3926181.MaziX2N2yX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSGVyYAAoJEEFjO5/oN/WBqnAQALMdEuYIT6E40auJxLw6ab84
8j2iUX9US9P1/IIYQyPhY6ojT1dJT1Xr6ZpRTbyNYUjWkhRnw9dwyQq6V4Hd/yAz
asINO4k7ZFC9TvLLcOihMVfMht9Ul1ZnZxPJNDT1UsCHhbx5Y76Cs/FBlwZOw7Nc
gnan4+ogQGl/g21Lwic1Vuaz5sJMzlvDx1G/vatRJBIaL0TeLjJ+JJwCeLGEknXb
QS4lyr+JTZUcVtU6rWBpOT2EHSOmsHUWDj9QnnM+k7eWnZoEE36xNN1bckCP2xyE
cbi0RNyJ6iP95Q7CH4/7nUJr66vgZ/jtq7bFtZiW3www4FXQnwVjchPBI8T/s+Ax
l1Y3YtmIX7axbaNv/FJ6mlDvPQ+3SeDyyimYSwFH5AlZI2o/wd2kmL72xVgSTFbk
UqnJMwI0ktSlxEpZm1GsQSoPnpNpMGp2HeSg79TA6jcknESgj59sWpKLanulVlQL
y9yowwMRwGPoD2n7kg9dpHHI9Bdtr3vUDO1DH5eM7AhwK9+tVOOKu7f5Ql8dI1lK
QiCbwOBd/KoH2TzK1kATA1I/sIPOS3Q5wX1Ir6+wxsmClFVQeJ8TBOkmsHoFX9x3
S6KCxvWIb4LSLcl8a0UA0K34mc9rq5R/14+Jj8wlxHV4uwikfWwkXNHbahtBWsCR
pCe4aEaLi+sSXI4xlzMN
=zfzc
-----END PGP SIGNATURE-----

--nextPart3926181.MaziX2N2yX--


--===============6468205091207141086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
--===============6468205091207141086==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6468205091207141086==--

