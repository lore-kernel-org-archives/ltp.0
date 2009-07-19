Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MSOrG-0001ck-Ad
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:22:46 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSOr8-00012v-Dt
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:22:46 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 19 Jul 2009 01:22:35 -0400
References: <4A5E7649.9040705@cn.fujitsu.com>
	<364299f40907182147l4239c229m25eb180ea7c8ebf9@mail.gmail.com>
In-Reply-To: <364299f40907182147l4239c229m25eb180ea7c8ebf9@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907190122.36427.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix the system call number of exit_group01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9022681567404370010=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============9022681567404370010==
Content-Type: multipart/signed; boundary="nextPart2572219.k4TJxxnSIR";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2572219.k4TJxxnSIR
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sunday 19 July 2009 00:47:29 Garrett Cooper wrote:
> On Wed, Jul 15, 2009 at 5:37 PM, Wei Yongjun<yjwei@cn.fujitsu.com> wrote:
> > The system call number is depend on the system architecture, not always
> > 252. This patch fixed the problem.
> >
> > --- a/testcases/kernel/syscalls/exit_group/exit_group01.c     =20
> > -                               TEST(syscall(252,4));
> > +                               TEST(syscall(__NR_exit_group,4));
>
>     The best way to do this (IMHO) may be to add the relevant syscall
> number to the architecture specific .in file in
> testcases/kernel/include. Do you have the syscall number for your
> architecture?

both should be done.  syscall() should never be used with a hardcoded #.
=2Dmike

--nextPart2572219.k4TJxxnSIR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKYq2cAAoJEEFjO5/oN/WBNKMQALAWVO/oG7qq7IgNwo/DsTUR
w3wrJsNeKSz6h7AechIfVT58/Si+s53VHTzw/pkzsUbgrfz0r3wmVyjNZxWd55DL
Gj6Vjg+sKSeQwvCIPO7h0VzvvRHFqlX8ruOggYk7jEsmYA75xHqaRL3rEw5DlAAW
pg4nV+6n+Jsz/VBVAgJ/agCxw38AOIzzNNCIvbtQDLHfxAQMQY4lZzH4U2KQaQzd
6w0kfBXgDb5HFJnmfHnckBPdjTcQ6543nTOoz3m2zE0DqRbA06Cd4NpKMjS1KrTA
yYFQMA1KUZzVh4QMKs1IChDt6YcBD6KGYItIPqNwU/8gB3/8/ikJX/GROsVMYlBQ
XbrtApnqE+dNfFi0i2mVtQba0Z1OZUpGcFfq88hOjEO/LsjIHD/ByMhRB/XYMMf7
Iu2EU5+mBGS5EmaLs4atTWxdispg6suy4xfblcS6ONjYb8ZkVOMkQ94EpObLlEap
dmWwrjt/MEBnKcdMEb3V/8sLNDuVWH3hTajnhcVkjUIj3WG1+JHtZasecSZ5qmz2
mPUIuI4zqlLkNoC3NccYsqh+sZoq6tDBTI/PvmqZQnM7guAjjHrZOhiQ69ddejph
v7Kwq/hx+VecilssKqx0U0CZI3zCKOmiIYuWucXc6M8gyu3fL8p+YPz9nZIyn4Om
q2MJLSnM/N+X8uytdTDS
=socU
-----END PGP SIGNATURE-----

--nextPart2572219.k4TJxxnSIR--


--===============9022681567404370010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============9022681567404370010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9022681567404370010==--

