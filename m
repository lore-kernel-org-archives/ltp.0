Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UqSNF-0001c8-DI
	for ltp-list@lists.sourceforge.net; Sat, 22 Jun 2013 18:17:21 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UqSND-0004FI-Hh
	for ltp-list@lists.sourceforge.net; Sat, 22 Jun 2013 18:17:21 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 22 Jun 2013 14:17:03 -0400
References: <016bca5a3f28e308234e5b1028a831e5fa50fda6.1371736603.git.jstancek@redhat.com>
In-Reply-To: <016bca5a3f28e308234e5b1028a831e5fa50fda6.1371736603.git.jstancek@redhat.com>
MIME-Version: 1.0
Message-Id: <201306221417.04276.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] new testcase: kmsg01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3202572398822548341=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============3202572398822548341==
Content-Type: multipart/signed; boundary="nextPart3237859.LjaZSNSQHW";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3237859.LjaZSNSQHW
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Thursday 20 June 2013 10:12:47 Jan Stancek wrote:
> Test /dev/kmsg based on kernel doc: Documentation/ABI/testing/dev-kmsg
>  - read() blocks
>  - non-blocking read() fails with EAGAIN
>  - partial read fails (buffer smaller than message)
>  - can write to /dev/kmsg and message seqno grows
>  - first read() after open() returns same message
>  - if messages get overwritten, read() returns -EPIPE
>  - device supports SEEK_SET, SEEK_END, SEEK_DATA

lgtm
-mike

--nextPart3237859.LjaZSNSQHW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRxeogAAoJEEFjO5/oN/WBpicQAIeobECHH1n2xtHE1ciukUWP
WFUoQbiBdUCqdHiN34OiZyjoi0x6vDa5gHUrVCkOxYzJyHIWG3HqfK8xc9FN0S51
gjsV3RyFQapPPSxJnnX1HI7tj/ueCCXPiowtIHYRZxZR2PWyKdHMrqW9aQil5wOU
L2ARmcdBtDGWGMpwsiWUq+SXB/6sRo4E4o+F+Y+iDJZL/gv4GeRCUhEzoiavxBrZ
g0UFkcwDWm1V2xQA0V008UIxzlQC1ZmlJqqfr/lKdVZmas4Dcfs64tAJe/9ZFkru
G2WwGvfYjjugkL7V+s/akUv0j6cRYRPaFimFoh2LkSi6xw5t6yr2ynRHIsa8eTgc
DKBg5et8ohmu1xmR1vjzVqQhgTFPOpYhVkbVR0EXe6ScMmaU1svPiVnFWTNEoluZ
gBoc3wycMe6eMRAtPRz4ozR5surqNYD157LY6J/euhJr2pO+/CKljatm4SJRGtum
iBc0IS5UM0iERRYhp/orc5FUpVCyhUnxHD9TsD2xQ5fWigsfwmpEwRQGCgJcg0rZ
F54fEOQWPbrULKzPv+SNXNquhoI2Va22ntXtzukSjkQXqsx1LieY5DtN99tI0ca+
YmWsaHqZlZvIQJ0noM2aXbnVkKiCwqBQIJAouw25qYIIsLa3LKJp2xaXNhTwEdgN
TcPXgHhF35duO7sellKv
=SXZc
-----END PGP SIGNATURE-----

--nextPart3237859.LjaZSNSQHW--


--===============3202572398822548341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============3202572398822548341==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3202572398822548341==--

