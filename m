Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1N0h0w-0002mu-4A
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 19:38:30 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N0h0n-0008K2-Rl
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 19:38:30 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 21 Oct 2009 15:38:38 -0400
References: <4adf2acd.8b13f30a.0849.7847SMTPIN_ADDED@mx.google.com>
In-Reply-To: <4adf2acd.8b13f30a.0849.7847SMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200910211538.38884.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix some bashisms
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8729955169400540812=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>

--===============8729955169400540812==
Content-Type: multipart/signed; boundary="nextPart1424368.0HLKpvk7e4";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1424368.0HLKpvk7e4
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 20 October 2009 20:19:58 Jiri Palecek wrote:
> this is another patch fixing bashisms in LTP tests (the fixes are more or
>  less the same as in the previous patches, except for a few exceptions).
>  Note that the patch is not complete, in the sense that there may remain
>  further bashisms in the source even after applying the patch (like use of
>  arrays, which is visible even from this patch).

thanks, these look good to me
-mike

--nextPart1424368.0HLKpvk7e4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJK32M+AAoJEEFjO5/oN/WBeW8P/As1xc1/NCSsT4SEDYlOUrM0
D41l6L/DYU4nZ4tQnmpwzIMVq3hxHA9FdzuHo0qXX1K1GRkEBcpf41pyxZwp3i25
AcM2IySeG/ywgLI1oMuHVrAVIIONC7U7VJNMrx4Vue2imD0zRgBQMS9M1VSIMkXp
JmOgvkGU/v21WnTN9wtI4/kVSAlNENHL9em3PBgOyCnespGVMoabe+hTsZUXY4ke
GaLxJxwTFRvsIc+hMhjri4ZKyiFxgW2ytTtZyIIfivuux8Mhy1rltlJYLDaAzI3b
f9eZiUxXshcV4DUz2Ht3SqmfxfbJDtYLq5CR/fdzYspU9eU0CnwdBSIgOnOrdRzR
4qpR5k/aTr5Qi6dBemUMSfnBiX/VdTfS22j36zQJI3udMHaIHgJLW590bW5THFC0
me+TOQgozmbb/7cScUZxdfpZZL+EWAPhZhIo8LuLGokjyqrnPYLPwBnfBjD8fDu4
7WaONoTHsJz+/x9VGumySNGLUrkRM0VDF5lqSDxeHd/yubHBnq44FlK/dKVv12hk
Lk+9XvXl6X2H/E73AOWBylomPQWjjr2NDxO997CsR9yLQVWXuzih5AFSvhC7oEFE
gHsIPC0vzThvIbxeJVp/1LPcWH9s3MS1DxlxE0V7P9W9o7Rh0vfzhtM5TSZ3E76G
wCtCdaMy8KVMyWKWRe0b
=C/e0
-----END PGP SIGNATURE-----

--nextPart1424368.0HLKpvk7e4--


--===============8729955169400540812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
--===============8729955169400540812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8729955169400540812==--

