Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UYIRy-0001RK-5L
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 16:03:10 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UYIRw-0005Tb-Km
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 16:03:09 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 3 May 2013 12:02:51 -0400
References: <1367588717-18162-3-git-send-email-riku.voipio@linaro.org>
In-Reply-To: <1367588717-18162-3-git-send-email-riku.voipio@linaro.org>
MIME-Version: 1.0
Message-Id: <201305031202.52664.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/3] Set invalid syscall as -1 instead of 0
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0368463075401304391=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: riku.voipio@linaro.org

--===============0368463075401304391==
Content-Type: multipart/signed; boundary="nextPart1747855.7j11QBv4Tn";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1747855.7j11QBv4Tn
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Friday 03 May 2013 09:45:16 riku.voipio@linaro.org wrote:
> System call number 0 might be in use in selected syscalls.

this patch is against an old git repo.  you need to rebase.
-mike

--nextPart1747855.7j11QBv4Tn
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRg9+sAAoJEEFjO5/oN/WBp6QP/1r2y8qQrQRjzConGhGTi60T
qETGQMiF3t7sdt6mJfI4CjogUqm9T2cPVz7mwZEEDgos2NwuUTN8QiCa+QU9Won0
Vo9irNGt6Qk8StBLx1zcmMAGoFvyGFnXuJ+mrRBDxH5Ov6C4ARjhqwxN6nT++MJj
T5+69cyGcjCfUzmU3LUZ9sOClCAWh0jKEz/08Jfd3gojJDZ1rxyHIOI5tt21yaVm
1+brsEOBbMDa7QGDCE2v7w+T7ozBW2UZ8BblQBqPg3+pDoEFiJCBkF+T37epReCk
h0egRxBRaSYtP+uF2RA7RA++QOOo2tX4fuw00Ma+KuBaVufhWECHIF25GKhJXt9D
/sF/pKeZ66UpJfYiSDY7UAZgnwl0J3L43exiJDqxMW3bHfJiK4N0Vfknllf2W50Y
IGh4Am9x3vSga9N7nTXL1iqaVK0/we5aOBdwYYD9S0IReTZGymfLpi5J3zLxgFcC
4MxEkZVqcjY9bCjyHKVi1KNDB4BSktYyexq3jHbzxNHUA6p9cJqHyTVAcOR2DiWE
i7zfw0Mj8i3c9k5t5yI/NdAWVCGpng2PRPbem8wbQl2ymE6Km2+ENh2JLpKiecEo
aRcLDH8ZkKgIpI9Be2Fmk44KtoycvXbz+sql5S9Qv3OjdAmZH7UfVRtvAJIYn1uN
8V/CQI+wmdrShbOyanUT
=oSuC
-----END PGP SIGNATURE-----

--nextPart1747855.7j11QBv4Tn--


--===============0368463075401304391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
--===============0368463075401304391==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0368463075401304391==--

