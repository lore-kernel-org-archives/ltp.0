Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NLypz-00052Q-UL
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 12:55:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NLypv-0000Pa-L5
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 12:55:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 19 Dec 2009 07:55:26 -0500
References: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
	<200912181331.36093.vapier@gentoo.org>
	<364299f40912182110w7e5591f1k4f1c59b292b642ad@mail.gmail.com>
In-Reply-To: <364299f40912182110w7e5591f1k4f1c59b292b642ad@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200912190755.26999.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5092932086861521971=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5092932086861521971==
Content-Type: multipart/signed; boundary="nextPart2259773.hq7K47gMZ3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2259773.hq7K47gMZ3
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 19 December 2009 00:10:58 Garrett Cooper wrote:
> On Fri, Dec 18, 2009 at 10:31 AM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
> > On Tuesday 15 December 2009 14:39:24 Garrett Cooper wrote:
> >> Until this issue is resolved (I ran into problems trying to use
> >> crossdev, so I'll have to manually inspect headers after I track down
> >> which versions are used in the Redhat distros specified), please
> >> remember that you _can_ always comment out the line which says:
> >>
> >> /* Define to 1 if you have the <asm/ptrace.h> header file. */
> >> #define HAVE_ASM_PTRACE_H 1
> >>
> >> Actually, I think I'll just remove that header check if the build
> >> passes unless Mike objects, because we really shouldn't be
> >> #include'ing asm/* headers without having a good reason to do so
> >> because it results in pain of this magnitude...
> >
> > i guess i dont know why you've made changes to the ptrace.h header at
> > all. the original one i committed still works for me on
> > bfin/ia64/x86/x86_64.  i dont recall any questions being posted to the
> > list about the logic, just random shuffling to try and "fix" errors that
> > i have yet to see.
>=20
>     You're right. I've reverted to your original copy and everything
> just works on my Gentoo box. I need to determine if our headers are
> f'ed up at work -- I wouldn't be surprised if that's the case.
>     If others need for this to be fixed on their toolchains /
> platforms, we'll definitely need access to the tools and/or maybe the
> hardware in order to verify that the changes are sane.

feel free to post the error you're seeing at work with this version so we c=
an=20
take a look.
=2Dmike

--nextPart2259773.hq7K47gMZ3
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLLM0+AAoJEEFjO5/oN/WBytMQALDnJEnYRhADAId2mXBfsNoG
1ZygV1E4HiIPqvn8itybXrdd6yuNNPu7/DgQsFIP6FJsWsbF7M8pJsC3xRddZBKP
H9YC/fv2aVSKBT19QWLcDCOCandau/qSsT2YDA5FnW2ShpFjmGBHhxJZ0+QE39OH
6r9rMpQ5gGAn+MkTlIkbgCKpfr9UL7K5ZvQjzdb4fjfvlztGLpGJKgoz0F3b7juM
u6BYHLGSypHUNvHQxj1lgyQgywOzV9S2oKX9BV4QoC7xI8t2/y+0K6mTphQ/5F+G
F3mdj4Uexs0whqVhnU1oQeV2gx/tYgraZYDB+YD+ciuNt+8Ad9oocnfeUrsar2K5
vVXDWoRntqjnNDafsPnyIFeaX33I7G7IIZaeWsse8xS6kOV9EdOFqyhWv79xsu7J
iUGyVhYDvDJI8iiaIgh0t5IKBZNpX6hi3JIjA3ou1EVYJlJN8YWg6Gq+AjS7lfkg
A4s+Tqlr+/zJUZ4zWcwhT2unRvmn9G5h+C7DJaAet13oNqVZpaa9PffQLi5OPeE/
wn3Vu7rHf+MSIXESOy6CPgATNNV7/0RuWcnGHi7TT6IJEvqWXmYC7oh+ZWd53/1t
peBxG3WD1HPYcaCsTuqihYz3AW1ScZbIxO+RjOWy48TobqBnVgB+bwwxNymqdNOi
lPVph0RjdsfaLUP7entT
=7K3O
-----END PGP SIGNATURE-----

--nextPart2259773.hq7K47gMZ3--


--===============5092932086861521971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============5092932086861521971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5092932086861521971==--

