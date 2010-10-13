Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1P5rAN-0001kZ-Lc
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:34:07 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5rAL-0007zz-AI
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 02:34:07 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 12 Oct 2010 22:31:20 -0400
References: <92362031.267291286935348328.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <92362031.267291286935348328.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Message-Id: <201010122231.21412.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] mmap/munmap /dev/zero
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7504224607822153463=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: caiqian@redhat.com

--===============7504224607822153463==
Content-Type: multipart/signed; boundary="nextPart1529471.69oF0qaFxE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1529471.69oF0qaFxE
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 12, 2010 22:02:28 caiqian@redhat.com wrote:
> Add a new test to mmap/munmap /dev/zero. A common way of malloc()/free()
> anonymous memory on Solaris. Anyway, mmap() of /dev/zero results in
> calling map_zero() which on RHEL5 maps the ZERO_PAGE in every pte within
> that virtual address range. Since a application is also multi-threaded the
> subsequent munmap() of /dev/zero results is TLB shootdowns to all other
> CPUs.  When this happens thousands or millions of times the application
> performance is terrible. The mapping ZERO_PAGE in every pte within that
> virtual address range was an optimization to make the subsequent pagefault
> times faster on RHEL5 that has been removed/changed upstream.

you need to fix your mailer and/or use `git send-email`.  changelogs must b=
e=20
line wrapped to the standard e-mail length (or even a few chars shorter).

further, your e-mail lacks the marker "---" which tells git where the=20
changelog ends.  `git send-email` takes care of this for you too.

patch changelogs (i.e. what changed in v2, v3, ....) should be below the "-=
=2D-"=20
marker or at the end of the changelog (not the start).  personally, i prefe=
r=20
the "---" system.
=2Dmike

--nextPart1529471.69oF0qaFxE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iQIcBAABAgAGBQJMtRn5AAoJEEFjO5/oN/WBnUgP/3+PIbmFslp+fiBG0Ft1nrh0
S2MA12MYm6qHiF3ZcuJ7fcutBLUJQpJGvx80vf6yP0u/cWS+GdguUtkjc6RdY6Ia
SdPsOriJoKY9iiD/LwGB/dE90vNzgB6AVBc8dZmtOl8pqc/iPcCrwnKMNgjECmIL
PzQpNw6dNTCwQmXexWZ8dmBYaWTYna+kH6XYaFAw3ijxYleA99B9lbISSUeyXDRs
XuJqNWDTSIZikhS9iNWwptK4cy2f6RJuJ1b6ZekDPHdB2WBVuWVBO/YMkJ0Grgpu
AUXPiSqKIsAiu8FdAQf3mO1WH5Rx6ezXIMo+gMCsUt7ByzLsLiyReqe1Kh9JGrOU
NhYrcWiWSv2kGjyW416cBLzNuZD8VkApLFBrtUU7B5TfUM3vblnT69ZBo5iaLpBx
Ba7ezqJtFkYfL1YCALjtFjTMDvl1SQKpOg1YWQL45QT/u7k6QUguZPwdnVVPUAZU
eFklxuDY4xvl/l7V8HhC3rT8kfN5dhksVM1Fe0TnHXECu9hd8Z0frPMCaV8ZHsLA
UONFt5Ui5VFKJalh9T8LjJW//KLbfQTRxDqssB8Ihi2aRZf+lldAJlFNtHYpnT1a
EjMWkcARGtJR4VGs16ZCeTtaaSFViCFF7F1jGt+dxCnQRlEia9zxZV2XTWjz8kxj
mEF0ay/er1ziSHr9RiTV
=tv44
-----END PGP SIGNATURE-----

--nextPart1529471.69oF0qaFxE--


--===============7504224607822153463==
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
--===============7504224607822153463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7504224607822153463==--

