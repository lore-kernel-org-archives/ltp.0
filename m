Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1P6Eil-0006cA-8t
	for ltp-list@lists.sourceforge.net; Thu, 14 Oct 2010 03:43:11 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P6Eik-0003Mc-4S
	for ltp-list@lists.sourceforge.net; Thu, 14 Oct 2010 03:43:11 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 13 Oct 2010 23:42:48 -0400
References: <450673838.432411287026581092.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <450673838.432411287026581092.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <201010132342.48804.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v6] mmap/munmap /dev/zero: a common way of
	malloc()/free() anonymous memory on Solaris
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1415403806271294293=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: CAI Qian <caiqian@redhat.com>

--===============1415403806271294293==
Content-Type: multipart/signed; boundary="nextPart2751338.yeyjprNb7m";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2751338.yeyjprNb7m
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday, October 13, 2010 23:23:01 CAI Qian wrote:
> +void help()

another "(void)" fix

otherwise, assuming it does as you intended, i have no complaints left ;)
-mike

--nextPart2751338.yeyjprNb7m
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMtnw4AAoJEEFjO5/oN/WBkZcP/jZDcJD8c/ChQ0VYg/FVL4qV
YkIploVr+54Zqzf/B5FV8WD6OzW4bBry/wWqkkUjATZW0lFlVu0cEfhiMHVMJqqO
6Uko9E38TuwUxHBEXQ8VMSdOeeMlM6SZfTOPW7KGxqmU1GezS/OUPz8NbIiWYSmZ
GWqlk1C98JuwRCfHHrShjLEH2LgK8Rrv6kScUMa3L1gvL1syxFV37ltkyLfOes2c
vFwWMcxWsclCvdsz1sE8es2zZxlHvmRiVKEHVHkB37pX/wczJffizzzoCpfH421X
vLARMGD1AFdpx5DozSk8mr8RTuW5h7lqqoG+hDbkKoi9kghdgLGhb06ldd8DfnY6
ZtveWZSkd79NAYVJUPFTGLuvoWIp+/vcNKZQFMK0/Twk3Lj6KB9iCq0kpNIXZB1N
s7AfHa01aFMOk0fVqHisix+hJg8zjxWxvEnGdD+tTnUA/IafIo/LMu32Ej0kKzQG
Soiu0thYRZUwp5BoOVDaLjRAto9QXaTcsouNib1L+6hTerwIA+WsuN1lCGWVcgiO
kVT8IoOUkXqn26zMMUn4qvUtW8TDz0Tx8y7J2i88iDypjBrvT5/8+JxwVPTBwqcK
pPOiKCJqup/1+BGigXBlDEb57RczErkTAH8uydZj4if6xPZLqEHYijTzEi2fPRSg
ULkXAS3zexR6Wn/Sr3Za
=P1ZW
-----END PGP SIGNATURE-----

--nextPart2751338.yeyjprNb7m--


--===============1415403806271294293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============1415403806271294293==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1415403806271294293==--

