Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbV1F-0000DY-Pk
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:46:41 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbV16-0005z2-MH
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:46:41 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:46:24 -0400
References: <4A77F5D9.8030101@petalogix.com>
In-Reply-To: <4A77F5D9.8030101@petalogix.com>
MIME-Version: 1.0
Message-Id: <200908130346.26150.vapier@gentoo.org>
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
Content-Type: multipart/mixed; boundary="===============0393878786163014218=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, michal.simek@petalogix.com
Cc: Jiri Palecek <jpalecek@web.de>

--===============0393878786163014218==
Content-Type: multipart/signed; boundary="nextPart1434309.JezzAJIql9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1434309.JezzAJIql9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 04 August 2009 04:48:25 Michal Simek wrote:
> I am thinking that will be good to extend return flag for function not
> implemented (errno 38) because
> some of tests return it when you don't have enable that option is kernel
> config.
> What do you think?

what "return flag" are you talking about ?  do you mean test status like=20
TINFO/TBROK/etc... ?
=2Dmike

--nextPart1434309.JezzAJIql9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg8TSAAoJEEFjO5/oN/WBfXgQANLzp4h2VAO0mZYH/rC/jxIv
OGzMPugb56y3/lI/NbN0n/IxFoMQWqwfbrTS4NtQZVg6/vNvKEJVVkFgNJ03RZAJ
+FStyK4Vl/CjNILpgtQAEGUb+Zlo3tLQ8j44yvmlVMPHqCVsfaHpc2bbE4N+qYsF
rqICR2plKWyOQFgo3r6QIXek9bHWoLhH/ShyNtcN5jfqHQE8BVrrMXyljg8jiDng
K19miPtqtJpcikOueTRZAgQeGRpnfZybdHlJy40JnDGGrqFc0zH+FprpanT4aRwz
LK/8OF2igVRbwwf95ED4rSSnjQMb4ib/GlSkEAPmvtg27k0O3BRUHsK0GjYnD3OQ
cLGS3kQ/zhINH+bykMCqps2Y4GVNhJiaH2QEJW1xTuVYYI317tr1c3uhpFQjcNDl
awE2hs+Q39qIFEPprM9YsfcwjvLHG2VvlXRlOxasW8KsCTVC+hcIZ6m80mphQ4mx
6j8E7x9H2nrt4/Z0WxjQ6a9ukw85VXKfGZp99vbhYkq4ZQs0OXUA27oQHIvr9l9Z
xtWNXHZ1fq5+GYMRQg64SVuRnTMHZnWms0IDcjs6+laZsibbdkwnEu66OKQf37BR
iab+X7Jj83GvBsxKrAzA+xU+McY20fvMscxVdpIXK/jj6ftH25hv/oEEmYD1MNxU
1h5A536mNd+TQLNH/sk8
=M8zL
-----END PGP SIGNATURE-----

--nextPart1434309.JezzAJIql9--


--===============0393878786163014218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0393878786163014218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0393878786163014218==--

