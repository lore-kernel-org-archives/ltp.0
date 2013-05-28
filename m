Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Uh88A-0000T4-RX
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 00:51:14 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Uh886-0001EN-5s
	for ltp-list@lists.sourceforge.net; Tue, 28 May 2013 00:51:14 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 27 May 2013 20:50:55 -0400
References: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Message-Id: <201305272050.56940.vapier@gentoo.org>
Subject: Re: [LTP] LTP: Compilation error for powerpc
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6801104013963458665=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Bhushan Bharat-R65777 <R65777@freescale.com>

--===============6801104013963458665==
Content-Type: multipart/signed; boundary="nextPart2503103.GXUvQvWb0P";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2503103.GXUvQvWb0P
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 27 May 2013 07:32:32 Bhushan Bharat-R65777 wrote:
> There are a number of good test cases which we run to test various featur=
es
> ( like ptrace/memory etc). I tried below steps and failed to compile
> successfully:

as mentioned by other people, manual file management is an expert/advanced=
=20
technique.  if you don't hack on LTP, then don't do it that way.  use the=20
autotool step instead and run configure with the normal settings.
=2Dmike

--nextPart2503103.GXUvQvWb0P
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRo/9wAAoJEEFjO5/oN/WBgrUP/3gQLc097xEqUymFnMtwu4Nl
4ntIYHEI4FKxtLbL+oaBcYD2KJi1vijFVJDp8RCMov4FfkNybAZR96qikJWTZY0g
YBB0v/YeubUcP6R/RxzW7kDpiDeNFZxwzdGLWL/GHfdfldZ/FgVnQ1+uGUPGvLDD
UEoVlBwI+sPf43Hlh2Ow3pZcrOun5tp0YE9m/Hpvhq9ZdayLKr+04nAcTVWlrWYM
3uDNAjcisvV44sKvn9uKU8WXTfoMzc0XwHXtmQM/Bd7pOywDJnuuceyIxsSf6ZGG
LczPeInJCh+p7SlqD+Cxra+6n6532oVguvV5vk1kCYy/ipAjIgKC1J5mLkZ1N+m1
VB3ZQg4tZhErA+wXNou3bnv5tnLuQJkphcj6ysJEkpWtUj/N6cYN1yHYdg31dL95
bZs9gQIV0LchQXTB9n0jFBiqA45GX68DAWERCUelwvpOP6/XT6bdkE21cn71ZjHQ
jdRX+au77D99GB59IBQBLgxc28hHcFBUAmGl0pdlZ9U1gWPIefXxgh2T6wV+jpXB
8rwXqepjU4j2aoSSsGfeV5btl5XcDQhM2JC7Ci6oNBzowJ2CqhMaJJLfEzjtLrNp
a/SOX2DZoCico0ZTEgqZLNKGCWjWL4hmsrwjXajpZNe0ls4pp7GCgxlfxCn+jAPO
vy4pKTPTNw+bWI2o4e2v
=VcBy
-----END PGP SIGNATURE-----

--nextPart2503103.GXUvQvWb0P--


--===============6801104013963458665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
--===============6801104013963458665==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6801104013963458665==--

