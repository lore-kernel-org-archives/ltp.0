Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MbUNR-00026I-9f
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:05:33 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbUNM-0007aW-PN
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 07:05:33 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 13 Aug 2009 03:05:21 -0400
References: <4A833067.2000204@canonical.com>
In-Reply-To: <4A833067.2000204@canonical.com>
MIME-Version: 1.0
Message-Id: <200908130305.22282.vapier@gentoo.org>
Subject: Re: [LTP] fix file_test.sh for systems without rpm installed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6048718895277632911=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============6048718895277632911==
Content-Type: multipart/signed; boundary="nextPart1882884.h2nHaK9o0M";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1882884.h2nHaK9o0M
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 12 August 2009 17:13:11 Paul Larson wrote:
> If you run file_test.sh on a system without rpm installed, it should
> return tconf instead of tfail.

this has the same problems as i mentioned with your mail_tests patch
-mike

--nextPart1882884.h2nHaK9o0M
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKg7syAAoJEEFjO5/oN/WBa6AP/1c+bfDEbaI5roOotf9dflfQ
SrShI8QeNkup+kgZJZwH6RO/sorslD5RyrEfldqbuUQbXkpiB8cRM4DsdS55ImR/
tpu5wfzVMnELdPOJHoJfLQ/1wsPNBGj7bwWoNRc4qWY623MAz58btUnJ71Pd5xIj
EMdAmIamcJP90kKPI+2+BHpUcnuLB3Xn2RmmU5Jr3t0Xue0Zp0RXX7kN1me5jyNa
U+VzpymzNXhTOBwUTYeS7rVs2DAJtnknXp1cBmiZ25Db0+fFxAEMwtMlmKtkmdzo
14IHWmFXl9HuKp2TZ1taaD6ovr0pdjeV1bYffh4jOSkK/oL/Rd9LncGmaafsetEY
NcLEBjEencublEPhw+vipV1obGv2RpBtICD64uw3xgeU4/xsgqyZa9ROTgZAnyMi
08UkxnemT3/Nz0ykm04Yw4LP0MutBEIPBYXtS+gC5ETSBYRrZMcVKg9Kw2u6tKgf
Ck2BPMJgrEK0xc44FwUmM+s9Xk6Z47QseC7wmx55Wxq0r6gAkLzwNj+FH6LVU8/b
s6lO4mUC+WctSg1jTWqCW9MuDhLyh4+jobclyd6/IZ6kp/F86LSvtg7M3gpCd3KA
IlOK/s1xj0vxP0x7kz7qMH6p0h+cdKAXxX0BQ3vRXlOq+MKxkShJT98Rr8rgZUgX
uE8K7fZC7qwi1y0KfKOy
=M94q
-----END PGP SIGNATURE-----

--nextPart1882884.h2nHaK9o0M--


--===============6048718895277632911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============6048718895277632911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6048718895277632911==--

