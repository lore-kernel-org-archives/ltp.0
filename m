Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Swfpq-00021X-Cd
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 20:48:02 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Swfpo-0007Af-3n
	for ltp-list@lists.sourceforge.net; Wed, 01 Aug 2012 20:48:02 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Wed, 1 Aug 2012 16:47:55 -0400
References: <CAO8ONPyEzsnxpivfG-Jw=5YyzmPdzW2JyVCJrH0i8PkSqDX7tg@mail.gmail.com>
In-Reply-To: <CAO8ONPyEzsnxpivfG-Jw=5YyzmPdzW2JyVCJrH0i8PkSqDX7tg@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201208011647.55852.vapier@gentoo.org>
Subject: Re: [LTP] LTP on ARMV7
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4759870053363235300=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Vanni Genua <vannigenua@gmail.com>

--===============4759870053363235300==
Content-Type: multipart/signed; boundary="nextPart1681016.YArZUJhKje";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1681016.YArZUJhKje
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Monday 02 July 2012 11:27:45 Vanni Genua wrote:
> anybody know if LTP support ARMv7 and not only x86 architecture?

LTP doesn't really care about the architecture.  it works on any CPU.
-mike

--nextPart1681016.YArZUJhKje
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQGZX7AAoJEEFjO5/oN/WBALEP+gPJtWG4qP/MuDmCcquA3h9J
Fwnn1xA49jaNd2rt63Q5noYWkB6yeVRemUSWBEqkJI61wSHXPDKE2Cl6jTe6hd3/
CpUTREol+avffsU7riGkppPchslv9YhOLETMKe/HqACiSRxpiYmw1hYXO2ehfbyw
zpfHvVFBJf+991OFnQ3Kb+5cgyzkU27pb50PMPpKLuDDU5XjdKpa305NL4el3f53
MTfy/lQaonGu8jKrcMLyOyCvniQ67ju9MtjAWe4o2sGfYIm1shIu9aPnaHvxzmWB
/4XgEPOuwBiEvj/RQOaI02Wnn1CRN2tASanUtHCabbPNVxb73RBzJhOJkkSvHB9T
tPK9ajWbQsdlkZ//P3vuAwEG+70cExtjJVPg483jgociJMPF4TawEVNPXfVcMGpe
lGK0TEViSj4nNJlqBkonjkGLJGxvV9LQQf1h9MYca+PhuG0m0EygdJ6QCIpFpybx
z0+Ds0lRsTPOfWHQUi3K8i89zjL4kKiayGgHA5zXTBVLQRXdPM8Fxw5Pdnv2qptq
zWwa0h4OsSVQODxKuhFJ0HHVB1Ses+Yy7ScJLSZ9xRIwdkeJYyjoGNUCIAsA7TUd
ExDyGsi+/eJ/vBiNWnRaqsnD8zcb6wV/QTmmWpj/b+tGHP6ZgnVF4hfQJWlBtVgj
+oRgFgkehXy1bAt1JnOY
=jGDn
-----END PGP SIGNATURE-----

--nextPart1681016.YArZUJhKje--


--===============4759870053363235300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============4759870053363235300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4759870053363235300==--

