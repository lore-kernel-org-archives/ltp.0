Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UVyIG-0001rY-TY
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:07:33 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UVyIG-0002yJ-5m
	for ltp-list@lists.sourceforge.net; Sat, 27 Apr 2013 06:07:32 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sat, 27 Apr 2013 02:07:31 -0400
References: <517A31DE.2050003@cn.fujitsu.com> <517A3282.2050809@cn.fujitsu.com>
In-Reply-To: <517A3282.2050809@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201304270207.32914.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/2] syscalls/mount/mount02.c: modify array
	"exp_enos"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5173541055121750746=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============5173541055121750746==
Content-Type: multipart/signed; boundary="nextPart3989077.FBLQmvpZeE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3989077.FBLQmvpZeE
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 26 April 2013 03:53:38 DAN LI wrote:
> Expected errno setted in array "exp_enos" do not match
> echo test item rightly, leading to two problems:

what is "echo test item" ?
-mike

--nextPart3989077.FBLQmvpZeE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRe2skAAoJEEFjO5/oN/WBiLAQAJBUH/8ucudnGIb6R7hE5cEc
OorSQcGKzm4aR57PESWle1c20/HEBN4tdgUaEibFq47Az+MSj7vHifna40MvU38V
4h1sLUorz+ZVUWA3g7C3T4+73fMCEGWNsDVYu9z4BGexpYFf9vcHKuE40ru5tGPn
NKDf3S1YHTuWoVcEg17p+QDqU4puc304PKhbSfXTPC3aqkzbpY5QwH0kMZHfa/dD
3u/FnVpgvhYahNr7v1CT1SasuUE6+QEgVeI7yMwPMQxYOnD+1yofS/qbLVWG9xh4
JPMhSPU1FYJMIKjGbUPm1WYgShzehWh25JIqNtdduJ4UH6Dx+Squ34bCvsubw/+2
AdYKiFvEbPefqzKqbLhtgooOhH3z2IYf+3HECRlW+ntgktXBpK0Y5erFG2lSjnPF
+02+fnU8prVyty7/HkJ7todClu2diB0xaHaxSWRhdPvSvb9T62yFTZNok21eapMA
A0Rl0wzCopbyVaB+JICNrngviHJzf1rSWFvOhM/V3/7IHuh5ZPN7d53lLv8o8ffZ
x+RXkQO1kG/WLiXClv5t6S50jIwMxZGoauYwy2Pv1itjxLtKrchgjjqQPKXYnQrq
+T3eGrer89BBEBZSkhKCgxLahism7PMPrKfjtW8RGPje/1LD5VaPEACIgs+9uMp7
zoilwLhP0IBm5s8e0ReB
=JoqJ
-----END PGP SIGNATURE-----

--nextPart3989077.FBLQmvpZeE--


--===============5173541055121750746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
--===============5173541055121750746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5173541055121750746==--

