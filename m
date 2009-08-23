Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1Mf48I-0006Sn-43
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 03:52:42 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mf48B-0006tx-R5
	for ltp-list@lists.sourceforge.net; Sun, 23 Aug 2009 03:52:42 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 22 Aug 2009 23:52:41 -0400
References: <20090821.195739.1000278277145530969.caiqian@cclom.cn>
	<364299f40908211417i21840c17n4e144c85852cb08a@mail.gmail.com>
	<20090823.103728.112603315.caiqian@cclom.cn>
In-Reply-To: <20090823.103728.112603315.caiqian@cclom.cn>
MIME-Version: 1.0
Message-Id: <200908222352.42884.vapier@gentoo.org>
Subject: Re: [LTP] The Best Practice to Skip Syscall Tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8080874763841013911=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: CAI Qian <caiqian@cclom.cn>
Cc: ltp-list@lists.sf.net

--===============8080874763841013911==
Content-Type: multipart/signed; boundary="nextPart2331791.AItcSb0iHm";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2331791.AItcSb0iHm
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Saturday 22 August 2009 22:37:28 CAI Qian wrote:
> From: Garrett Cooper <yanegomi@gmail.com>
> > On Fri, Aug 21, 2009 at 9:00 AM, Mike Frysinger wrote:
> >> On Friday 21 August 2009 07:57:39 CAI Qian wrote:
> >>> Test cases unshare failed to compile on systems without such a
> >>> syscall. I am unsure what the best way to handle it. The old ways are,
> >>>
> >>> * add a kernel version check in the unshare tests code.
> >>>
> >>> or
> >>>
> >>> * add a m4 rule.
> >>> * modify the unshare tests code to check if the macro, and add stub
> >>>   functions if the macro is false.
> >>>
> >>> The first approach is unable to handle non-vanilla kernels. The second
> >>> approach needs to add stub functions which are unclean. What I would
> >>> like to do is,
> >>>
> >>> * add a m4 rule.
> >>> * modify unshare Makefile like this,
> >>>
> >>>   ifdef HAVE_UNSHARE  <-- if the syscall is present, compile the tests.
> >>
> >> the configure test should always be there if the code needs new headers
> >> (like sys/signalfd.h).  if it's only a new syscall, then the configure
> >> test should only be for the new symbol (assuming one is provided).  in
> >> all cases, the tests should be compiled.  your proposal doesnt handle
> >> the case where the C library is in place, but the kernel is older so
> >> returns ENOSYS.
> >
> >     check_for_unshare was a poorly hacked app, IMO and Mike is
> > correct. The issue needs to be a combination of buildtime and runtime
> > tests as it needs to pass through the build and the issue with the
> > syscall needs to be detected and marked TBROK if the syscall isn't
> > implemented.
>
> ENOSYS is the expected result if the kernel under test has no such
> implementation, so I would consider TPASS or TCONF.

TPASS is wrong.  in another thread, people seemed to be OK with TCONF.
-mike

--nextPart2331791.AItcSb0iHm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iQIcBAABAgAGBQJKkL0KAAoJEEFjO5/oN/WB48EP/1gm+Vb1muNDDzxRjBZ5Odrs
8dtTRgK6HUwh77rswdIweqMGUvOWsXLFaoOHQXQYMij2VIUd6aFpIgN6+mID/+yw
ygpOtWeQsAbHKZMNSMhDVX8biCpC/+DSC8U7/6xJbSYg1aZta/h2aqcthY+cDtwm
JEzso9wjhe+oQ0UIac8ILtISwU7T17UZmdDoKnUxZy8abmXvh7QHt2fzFMHhxMR7
bfAmTPGB80xS0YzTownsu+Q3lEG0AOh/K3qAae7qZ9eZhhKe2tdHpog1Dq+MIiY9
E4kTvscrLrZWwSrbX0LZrJ+NiSA7deKm2UBq7ZE1QHfei2sfw/hJK39prfgUGnF5
FJHjZVsBYiEbVxjDKnbw6AU1cfNS+eyLR8OhYrHIJwT6JE40aY6qMrgcneJDJogn
h/AM7GV7LdVspjLWnP/OkNZyi94kpXkOS14YuGA11Kkqwrn9r6FJQSkqzRWX4gF8
MR+vASG68OcxumcP/7HPd5J54lVigcLVF399qpdcN66CwrEgUnAHOcNQzc5SbcFf
31fooorPsH7s8TUpfg0mOMAUUaqu2baPvk+c1HvONysZ85HiC1sNFLW/fazI1UKS
+xqh4xOgxdWIjjMc7Tdcu3sGmeKCYfvgXyEp2QNvXK0YQeaHTXJR8sBhrzIZGjc/
3XXB2of9Mb5hRYHiN+Af
=MA0p
-----END PGP SIGNATURE-----

--nextPart2331791.AItcSb0iHm--


--===============8080874763841013911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============8080874763841013911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8080874763841013911==--

