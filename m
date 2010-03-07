Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1No5kJ-0006F9-Mc
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 01:57:31 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1No5kI-0005vq-S5
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 01:57:31 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 6 Mar 2010 20:57:19 -0500
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<4B922D86.70704@petalogix.com>
	<364299f41003061716t5b2a4597oea20b28f76aeeaad@mail.gmail.com>
In-Reply-To: <364299f41003061716t5b2a4597oea20b28f76aeeaad@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201003062057.23905.vapier@gentoo.org>
Subject: Re: [LTP] A note from Maintainer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5033154350150338389=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, ambar.seksena@calsoftinc.com, Cai Qian <qcai@redhat.com>, kamaleshb@in.ibm.com, doug.chapman@hp.com, risrajak@in.ibm.com, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, jburke@redhat.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============5033154350150338389==
Content-Type: multipart/signed; boundary="nextPart1443583.5KrsuafACS";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1443583.5KrsuafACS
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Saturday 06 March 2010 20:16:21 Garrett Cooper wrote:
> If git-config isn't setup properly it will complain about usernames,
> email, etc; is it possible for a hook to be added, s.t. this becomes a
> hard requirement and any proposed commits will be rejected?

should be easily doable via .git/hooks/pre-commit
-mike

--nextPart1443583.5KrsuafACS
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLkwgDAAoJEEFjO5/oN/WBWJkP/1qnlXedHMWourxzeUyWvIYP
r2xpaqzok3uyJpCSrr6k4twVseUUnYrv1UzddhjVBrdJ6LmcmWP6YWH59B2Cp+KY
E4bO8ZyTktFna6iAJ6EImukhYVkxfROccTAApACqxH3FIYOochxl+v6zWUilmlPS
hea0us2jtzpj1VzlUzIFBr2i+FfOkdKr4cI1Nxbe5QiumqzjDAm1otQfM215Z7BT
xvCCR2f1Fp/VAE1SyLrIYvRwYGawAZBCpq2idXqC0g2uCf0XfCFk9rcqilfo9q3p
HakycjJ/RdVYTiZvyuWZg9/BHuP/eDw9SMsgzf4rhxu8aK1yVIIVSzEfWSOS2SDC
RxPLVq5XJJWY2j/qtbWnfO0V2TcEVq0rK1eoNa5muPSHJP6BmjKs5+XS889F1p+1
jnyNJXQZzLaYS1GoXdMJVIXZK7Sc/SGNwpqRtg1fkIVHXBedC10QZk7FSoQ9XJ78
mNU5WMM6FR+md/8UXaaLUgDNTQLgnyHOoFzwz2q/w68AjlSGvkAcPRZKfCt3ZRGv
KQd+mS6tw4bQFbFbUlANiq5k07hULjjuTGqsTsVjBRriFNg4b773l46/1yU/p5h4
RxVCVNvmlVxjKtLXGYNjq4yYrQkvTg98VslOee1bU9m2poEWyaKZdV8/xJTad8vi
xf70cUvzFBu1gY5nQTJh
=9z7d
-----END PGP SIGNATURE-----

--nextPart1443583.5KrsuafACS--


--===============5033154350150338389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============5033154350150338389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5033154350150338389==--

