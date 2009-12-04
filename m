Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NGdS6-0002ka-3T
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 19:04:26 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NGdRz-000381-NN
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 19:04:26 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 4 Dec 2009 14:09:27 -0500
References: <4b193c6d.9113f30a.0553.186fSMTPIN_ADDED@mx.google.com>
In-Reply-To: <4b193c6d.9113f30a.0553.186fSMTPIN_ADDED@mx.google.com>
MIME-Version: 1.0
Message-Id: <200912041409.27672.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Fix overreaching clean targets in Makefiles that
	cleaned the readme files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2647749469722386517=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Jiri Palecek <jpalecek@web.de>

--===============2647749469722386517==
Content-Type: multipart/signed; boundary="nextPart1385906.fyvk2YK8mK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1385906.fyvk2YK8mK
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 04 December 2009 11:31:55 Jiri Palecek wrote:
> the makefiles in some of the float tests contain the glob "[dr]*" in their
>  clean targets. Unfortunately, this deletes not only the generated
>  reference files, but also the readme files shipped in those directories.
>  This patch fixes it by changing CLEAN_TARGETS to more specific patterns
>  (that capture all generated files in all float tests, however).

easier to rename the file to README (which i've done now)
-mike

--nextPart1385906.fyvk2YK8mK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iQIcBAABAgAGBQJLGV5nAAoJEEFjO5/oN/WBS6wP/2guYWlxbJ80Spg+63QWjUuH
CBajH0rSkDRiTZIekH97A9G3v/frPW09GB5jHbWEI6FWL7NZLM5duMTvR441YMd1
lG0heJmDuNCW8vB88D3O7Ot3x9FtEybr5POLcCIM8pbJI84ljBhmHlqSIUprYV6S
MNpL/L5diEthNrBjF1IIHMJy3SkAYuDolQRKGqdqgOL9ff7BqFjb9AucKqozjBfT
fbH7lyJzEYyLDtuREPSdqrS9p5e79c1Pg4q6sr/mc53zvGqtQbcdttnPosjzXv9T
5z0MUKXC3Pq7PYjHsq/NwV+Nh34Ps+xaixivdHvRTRhbQDkXOuh39wvkkrXZ/7Xo
33XuH6cX9PfxKGEEgbGVyswR2badg5ip2KEmZQMEFFBgU4yaF/WPWdAnABY/3pdp
NXRCU1fCciGiBFawdeT5tCEiBleKZDhv6Z1g2FcpDzxTcXF/e3Nnz3S4xK6YcPCd
rX2P8giCOi09khXWM9hrEp/Mkivu0gZpJaB7a6ucuBrqkMVNri6pSzT7Vh3WL4lL
WmQ3vJkwUADrlLvMXrqAiZffuwYGRHKbHoQxg2FkmF8eli+xNpPlc5uYL4nw8zti
GsgkjmAmSNuG9jkLAKl1msQ8qyRE/t4+bhBrXBFYGKE+4ADV/CpMSjRM+QlxuYZ8
M/l5ZVWl+0IemBj+2MzD
=BrLF
-----END PGP SIGNATURE-----

--nextPart1385906.fyvk2YK8mK--


--===============2647749469722386517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
--===============2647749469722386517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2647749469722386517==--

