Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOgx2-0007it-LB
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 23:53:24 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOgwt-0001li-20
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 23:53:19 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 Jul 2009 19:53:17 -0400
References: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
In-Reply-To: <364299f40907061722v45417bddhac499efa1415d6af@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907081953.18802.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 3/4] Refactor top-level Makefiles,
	modularize autoconf logic
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1480721134087979067=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============1480721134087979067==
Content-Type: multipart/signed; boundary="nextPart7096328.8hyeQiIID4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart7096328.8hyeQiIID4
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 06 July 2009 20:22:19 Garrett Cooper wrote:
> 1. Better modularize and separate out the top-level Makefile such that
> automake logic and top-level targets are better partitioned out, and
> thus the overall logic and flow is more intuitive.
> 2. Move help output to README.mk-user.
> 3. Make $(.DEFAULT_GOAL) vary depending on whether or not the system
> has been configured, such that typing in make will no longer run all
> and result in Make errors, but instead will punt back help, thus
> making LTP more newbie friendly and reducing support requests because
> people don't RTFM ;)...
> 4. Begin deprecation of the uclinux* rules, which can be communicated
> using the UCLINUX=3D[0|1] make env var (like they should have been in
> the beginning).
> 5. Add appropriate GPLv2 copyright headers wherever needed.
>
> Notes:
> 1. Requires [PATCH 2/4].
> 2. Is an evolution of the commentary w.r.t. the config.mk not required
> for clean patch submitted on Saturday.

you have duplicated copyright notices here too

please drop the sleep in the uclinux warning

you seem to export the variables twice

there is a $(basename ...) make function so you dont need to use `basename`

you check SKIP_IDCHECK in some targets ... this is a make var, so using=20
ifeq(...) instead is better -- avoids @ and nesting and set -e and other cr=
ap

the if checking in the clean target seems unnecessary

please use "$" to indicate prompts in documentation, not "$$"

for pre/post install hooks, why not declare a common name and everyone use=
=20
that rather than forcing people to declare it.  i.e. declare the target "po=
st-
install-hook" as a .PHONY and always call/depend/etc... on it.

some of your for loops arent using set -e or checking the install exit stat=
us

why cant testcases/kernel/Makefile leverage these .mk files ?  the whole po=
int=20
was to get away from these custom written jobbies ...

you're mixing CFLAGS and CPPFLAGS.  -I/-D is for CPPFLAGS.

what's this business of every Makefile having to declare MAKE_TARGETS ?  th=
is=20
should be a common default.

rather than force everyone to hardcode the default ltp -I inc and -L lib=20
paths, these should be added to the global defaults

doing a for loop on a `rm` command is silly.  call `rm` once.

debugging/optimization/warning/stripping flags shouldnt be added in any=20
Makefile that is being converted to these common .mk files.  same for any=20
DEBUG_XXX flags.

i dont see the point in declaring empty rules like "install: ;".  if they'r=
e=20
declared .PHONY, there is no need to add explicit rules to sub Makefiles.

clean targets should always delete common things like "*.o".  forcing peopl=
e=20
to have to manually declare these is a waste.
=2Dmike

--nextPart7096328.8hyeQiIID4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVTFuAAoJEEFjO5/oN/WB4FsQAMvR108xjQ7aleslsFcl3LbF
37ATZeRObjG/9saM/RMlg/3aloFTPztCUJb0lZj1wYUgzCtGaNW9ACu19Qi+0jJ+
8lejuY/RoKOVXJWgo1d9uME2LA0PezB/Fb6XhS+X03HkFXvobEQnli+WO/Lacibg
jxqCQ0oDMWa/XaB0ChXKP3kUBXn5RO+/FcpjYLTUlQ2unjySQ7rLmdjmwI/wwsdL
uTSKqWHnhjxZltnPUKCeO+4XzF6rGXQsgdPPnVhuCwN4hCnbXn+/GbK3hGjMcAUV
3es0odlYTsKpRPT5WKB+e2F11HcM8rBRN+O1I/bftJXQrkKFuhsPH7lqag+2SYoV
Uz2t7tfBZk7un3sPF21sZjiKhnf/rKVoDBk4R3zHcmcEF70h2sM48U5R/e3s8bnG
tsUNenxNjHy9pJitF+CVOXtZrqTxsu868yUu1X69byCZ3fNfTjBQulq0QXP83w0f
eCKUCjKy0hdS3nZ1txjiViUOJg4jDytwTI5rqst3CszYyQBedFE6j4gLkf23mNIc
5TnazCTm+mIBWfrYnk7/o1x9N9oKbUuh82cXeqAGAs/Xer4e/AkM9GhzgvEmyjj6
MfUdLFlGqdami6syBTQZothavIZ9q9nRp61rxzhNAfoeQRpcaQmiTv95TRf5cDxN
g2wwLNTbuNMzr5u8IYvM
=YEO2
-----END PGP SIGNATURE-----

--nextPart7096328.8hyeQiIID4--


--===============1480721134087979067==
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
--===============1480721134087979067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1480721134087979067==--

