Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NndzB-0000yP-GP
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 20:19:01 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NndzA-0003HM-NJ
	for ltp-list@lists.sourceforge.net; Fri, 05 Mar 2010 20:19:01 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 5 Mar 2010 15:18:53 -0500
References: <A69FA2915331DC488A831521EAE36FE4016A4F5195@dlee06.ent.ti.com>
In-Reply-To: <A69FA2915331DC488A831521EAE36FE4016A4F5195@dlee06.ent.ti.com>
MIME-Version: 1.0
Message-Id: <201003051518.53824.vapier@gentoo.org>
Subject: Re: [LTP] LTP compile errors
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0282555865876237993=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: "Gaur, Alok" <a-gaur2@ti.com>

--===============0282555865876237993==
Content-Type: multipart/signed; boundary="nextPart6347952.mnF4efD5At";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6347952.mnF4efD5At
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Friday 05 March 2010 10:42:51 Gaur, Alok wrote:
> I am trying to compile LTP using my ubuntu machine and get the errors as =
in
> the error_logs file attached herewith. Please help to resolve this issue.
> I have attached config.mk.in, config.h.in and config.log also. If any
> think else also required to debug this issue please let me know.

you cant expect to compile anything if you dont actually install all the=20
toolchain related packages in your distribution

configure:2849: checking for C compiler default output file name
configure:2871: gcc    conftest.c  >&5
/usr/bin/ld: crt1.o: No such file: No such file or directory
collect2: ld returned 1 exit status

that comes from glibc
=2Dmike

--nextPart6347952.mnF4efD5At
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLkWctAAoJEEFjO5/oN/WBJEgP/RHwrdFYR2tZC2tMckarL8Vg
tzCF9Oi/24rPdmWlvpE/v3RDc4zbgESCnJCT3SL2AwhQFBS4c6rd3wIyxPoyZRMF
hPiv5nVe1cBJit+p/FInsQ4p5WfRScEPplqHRXtStB029uEMnkPNVGNiPDMm0L5X
KNLfnMJuPUiz6NzLaMnvXVqYxp19ZybGQKxebQ9nrRFudpdPFVLXEZ27cCg0pYRd
iC37bzm5bNqve8Bk1GNAlVAsttCQY/ODlFTECrBVaBwTOBhikKcLY6rk1t4nmmjD
C+JI9rknQmMOtT6fPAyYiQVzoeeSIQ8zGNNWAC3G9FYuLq5SI+MalgOJ4tL7rZ33
ptijG0/Uc4l4KyIVyPTFlsXfjlOIJ2Xo0A591R7scKZXhtY7JxZotn/JW4qJoiQw
DeoxU5ccE0j36Foof/fNq2JDaLSRoZ/1XJFsYA3yz66F3fzFmOegvgZ520iVIF52
EVWT8SBZ4lGlSBWOyZLlkon5aOqKS5kLzJCWYKXu/SJLjaD0WItTuiFwiTNQtQ7p
0b5Yatfo/cTQa8wXHB6FWkKubhxn/pRAiVn2cJDq43IdUZjcv80DDH9HbXDWg0TG
HE0Aqpo4yxCIvruo+5UWeVXGNMm9xsAh7ngPfkMSUuxoVItXNNWwY5+yYo2MTxrK
IyJ676SvDnhHGSrCD4G6
=RYx1
-----END PGP SIGNATURE-----

--nextPart6347952.mnF4efD5At--


--===============0282555865876237993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============0282555865876237993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0282555865876237993==--

