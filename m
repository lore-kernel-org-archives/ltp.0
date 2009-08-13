Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbWqX-0001TA-UB
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 09:43:45 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbWqO-0001w0-Or
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 09:43:45 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 05:43:28 -0400
References: <4A77F5D9.8030101@petalogix.com>
	<200908130346.26150.vapier@gentoo.org>
	<364299f40908130204h609050e7g702a415f2559c29e@mail.gmail.com>
In-Reply-To: <364299f40908130204h609050e7g702a415f2559c29e@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200908130543.30084.vapier@gentoo.org>
Subject: Re: [LTP] Extended return flag
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3681116082443180806=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>

--===============3681116082443180806==
Content-Type: multipart/signed; boundary="nextPart1453559.S6rGsx2rpB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1453559.S6rGsx2rpB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 13 August 2009 05:04:13 Garrett Cooper wrote:
> On Thu, Aug 13, 2009 at 12:46 AM, Mike Frysinger<vapier@gentoo.org> wrote:
> > On Tuesday 04 August 2009 04:48:25 Michal Simek wrote:
> >> I am thinking that will be good to extend return flag for function not
> >> implemented (errno 38) because
> >> some of tests return it when you don't have enable that option is kern=
el
> >> config.
> >> What do you think?
> >
> > what "return flag" are you talking about ?  do you mean test status like
> > TINFO/TBROK/etc... ?
>
> I was wondering about this earlier -- why wouldn't TCONF be sufficient?

should be fine i think ... we just have to (1) pick a method (2) document i=
t=20
and (3) start using it
=2Dmike

--nextPart1453559.S6rGsx2rpB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg+BCAAoJEEFjO5/oN/WBQgcP/3tdF+osUHgCbsHanGgLc2K8
yZICH0vsi5LH9jgsTW0JdmtS/sjcxVXZcqxcSsT9fTzewmE1rRAWdU8cMiOua1Zl
yHfmKey889Opd3AdKLanCy5fVMw39pCGFTqjMbaKWJoqA+xa75dRBT8NS4YOLOBe
IatulbO1yv/tQtd0NTU7YDtDEnKSi2+ed/9kFGe9Z1qJQFVw2xdE0L7hD72vqJ7o
tKVGyecibbCOAIggMDs44VOq9V1r1hN0BAwkbYRvCOcHMoTTnG6nv02sx4niePe5
/Zxfq6cZpJ65KTyA2284w9pQotFhhDnbEGteSauGXV/LfFJfq/wxNTiB/uL143uS
n3xD6RhCbauubVVyYQCSe0cM9s5itYpKACHZluIQinIO1JQhGSly5Ik36KMTI0nw
PdeMLzZBDgWHM/i9roXHn9gyWvPwMNJl1TCJCrlTgO0yqkYGGETGoDBNALWsnpJ2
OaiPUFaHyTfU2SOwvk6G8cxsJHQTzHzzdWu5kGFdWn0bV/NE2o+XDPGe6PsPueqw
neXncNNA0awbiSNZo/eggc9wPj85xJrYE6t0sTT+OTcHC7zJJmINOlVz+942gmoe
DGxUQM8J1TtvVCuu3Ud2ZG2faheDVYYLOxoGlfpBocOvsSl9mWW+Nl+IGDdJw341
Y5z8nf0dcVGW9jcJFSVP
=iiGg
-----END PGP SIGNATURE-----

--nextPart1453559.S6rGsx2rpB--


--===============3681116082443180806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3681116082443180806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3681116082443180806==--

