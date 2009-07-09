Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MOhiM-0006Nx-1b
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:42:18 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOhiA-0000rS-1G
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 00:42:12 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 8 Jul 2009 20:41:31 -0400
References: <364299f40907061602v3d05964cq31150d97eab75daa@mail.gmail.com>
	<200907081924.08439.vapier@gentoo.org>
	<364299f40907081726l2a78728dx957f06cb3c46a986@mail.gmail.com>
In-Reply-To: <364299f40907081726l2a78728dx957f06cb3c46a986@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907082041.32384.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/3] Make system enhancements, Draft 1
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3275163179715866250=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============3275163179715866250==
Content-Type: multipart/signed; boundary="nextPart2135080.x77l5JnTAM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2135080.x77l5JnTAM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 08 July 2009 20:26:37 Garrett Cooper wrote:
> On Wed, Jul 8, 2009 at 4:24 PM, Mike Frysinger<vapier@gentoo.org> wrote:
> > for the toolchain, do you purposefully only document CC and CFLAGS ?
>
> Where did I do that?

README.mk-devel

> > i'm not familiar with this "MAKEOPTS=3D';'" thing you refer to.  what's
> > that all about ?
>
>        -r, --no-builtin-rules
>             Eliminate use of the built-in implicit rules.  Also clear
> out the default list of suffixes for suffix rules.
>
> There isn't a way to disable -r in make-3.81 except by removing it
> from MAKEOPTS (that's how it was enabled in our make system at Cisco
> in my group). `MAKEOPTS=3D;' is the quick way out. Nasty PITA...

doesnt that clobber -j and -l and similar ?

rather than help the user, spank them for it.  in the .mk, you can add a=20
findstring on the MAKEOPTS for "r" and $(error) out if found.

> > master_rules.mk shouldnt be a '-include' ... we want an error if that
> > doesnt exist
>
> I only did that to ensure that this commit could go in, irrespective
> of PATCH 3/4, but I agree, it should be enabled once both changes are
> committed.

dont worry about it ... assume they're going in as a set

> > your %.a rule is missing a call to ranlib on the archive
>
> Ok. How do I do that call exactly?
>
> ar [blah]
> ranlib [blah]
>
> maybe?

ranlib only needs one argument -- the archive
=2Dmike

--nextPart2135080.x77l5JnTAM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKVTy8AAoJEEFjO5/oN/WB/WsQAMwek8jDQ7frlSphtgtOUgVW
KbElpZl3pYng9bIqHJDIrj7Vr/+tgfAggVYtubvV0JjjdCeuDncgm3XAkzmo8qcE
murPWPhx93LLj3H0aBHncZ/2+jfyF1A6KxfHsa7mCtMeRdlV1POFb2ZXYSYmAQGy
2ui/AAeyjAH0uuOg69+o96XaLv5z5DgipjPGExWnd4zL/9IKnjpctmkLGWXOBz7W
CXg9Jg1Oz8ktrRilkR+lL7eI0CfsxH9gvlMZRDbx1D6CUL0+vdsxnSYdritV9Kqj
rKSi7SYFvSH7qNMcXYWr/TyCs2MkhSqH4MSMhsgnrlF/F1lItw2PGd1Oe/uEnWOc
dLLEFvkvqesFurHA/qnyc3dkHk9zWbxCbNy+Eww+/xrG5sh+UAUEITF2cjNkom8T
oBKaMu1Jxss1ui5UpK4rRbwyfSH5KYGGqUp/NVa9M0vUYada1JClRY3txtTozi4D
l6tBk5NFc3U5tvlJz2h7OA0BcXami/8HD3wVKXG0XU0rQdIMHM3496tQViMrzf9f
CShwQxMCqKkWbFseHuQcQ2ooz5BtbYD3Oiu99wa/5XAgnour35xBvfDfUeFE4nRn
SO/LF5/sL4qOpvA33gczugkkKzHdZ6RINBLMAzy6j3VUkWZlzZ/Nda3vUc6PJ82y
TSbG+dbyplafFklrL6Nc
=FtAF
-----END PGP SIGNATURE-----

--nextPart2135080.x77l5JnTAM--


--===============3275163179715866250==
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
--===============3275163179715866250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3275163179715866250==--

