Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MfQmh-0001YD-6V
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:03:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfQmd-0003eu-2y
	for ltp-list@lists.sourceforge.net; Mon, 24 Aug 2009 04:03:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Aug 2009 00:03:40 -0400
References: <20090824.012723.112609532.caiqian@cclom.cn>
	<200908232249.46097.vapier@gentoo.org>
	<20090824.114921.104053885.caiqian@cclom.cn>
In-Reply-To: <20090824.114921.104053885.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908240003.42716.vapier@gentoo.org>
Subject: Re: [LTP] What is the Story of "make autotools"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1026626106395252789=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sourceforge.net

--===============1026626106395252789==
Content-Type: multipart/signed; boundary="nextPart1503262.nDmJAv56du";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1503262.nDmJAv56du
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Sunday 23 August 2009 23:49:21 CAI Qian wrote:
> From: Mike Frysinger <vapier@gentoo.org>
> > On Sunday 23 August 2009 13:27:23 CAI Qian wrote:
> >> $ make autotools
> >> make: *** No rule to make target `m4/Makefile.am', needed by
> >>       `m4/Makefile.in'.  Stop.
> >
> > that file is in cvs.  if you have an incomplete checkout, there's nothing
> > we can do about it.
>
> Hmm, looks like the GIT repository has no such file though,

you'll have to complain to whoever runs the git repo.  it isnt us.
-mike

--nextPart1503262.nDmJAv56du
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKkhEeAAoJEEFjO5/oN/WBmhgQAJIB3LnU02wJTRwyJjxmGheu
2waonOXqHuTRCQShx3qSzjQzpfvOe/u2GFdLgsnkaJfQs2aygdO8LV7ITn07qNZx
Aill3B60greBbI2B2gunyKHW4Vg9V8dmC6Y5YUwl8/u3Qapxq6za2M47KrVtHlOn
xvtPTRwrAAqj0lseC7jg/UKX8LZ99QqTej+y4i0GCb/XrBx2Hoeatqt5Ep1RpXXb
oNI0mRPYyCMIpFsrVQ3hVQoqAaBEc3/N1F3IVXsJ9hGwGoukK2SnUEJlbqBr23E9
rwV0vtV53RdRgqRq7ZQnploBshYVQ6qrg3KFtARDYQfqI9HkiYBRDNKqj+2sStl2
/c7vjXHeq28GHwVjq0YKOrwet+4eT3M98nhHuhOYiAYL1gL/4a1YIQnhj6iUX306
netxcAiJprKNqPvbtd1gRace5/boncs5qS07EFllhTKic+TqO+VC8qGP6CnnvAP7
JXuYi92KuatxE+4WL6IRpxKKTvxNWlDySTwiN38rkLTlaEvslu4YCzuGyGWAqeGR
Zdv/pwddctQyiUwkR8r8EG6u8o6V8r6EeQ/ZW1gyNhbXt5SCOqKDMn0bkdzKGh04
n4bqnasnHQuHszQdw3agpiefLeszmKwaWU/Jv1EDYK2OUsSOD1n+E+YYXY+xda9p
XZdIo3NLXr1OmkALINsf
=20Ra
-----END PGP SIGNATURE-----

--nextPart1503262.nDmJAv56du--


--===============1026626106395252789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1026626106395252789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1026626106395252789==--

