Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1OUMtc-0005AX-Lb
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 16:45:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUMtb-0006TT-Id
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 16:45:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 1 Jul 2010 12:44:34 -0400
References: <20100701153446.16085.3341.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100701153446.16085.3341.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <201007011244.37145.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] Remove files which does not have a dmesg entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8074444188103049107=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP List Members <ltp-list@lists.sf.net>

--===============8074444188103049107==
Content-Type: multipart/signed; boundary="nextPart5398334.RVWiYSMidD";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5398334.RVWiYSMidD
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday, July 01, 2010 11:34:47 Subrata Modak wrote:
> +		PREVIOUS_TO_DMESG_DIR=`pwd`
> +		cd $DMESG_DIR
> +		if [ $? -eq 0 ] ; then
> +			find . -size 0 -exec rm {} +
> +		else
> +			echo "cd to $DMESG_DIR failed: $?"
> +		fi
> +		cd $PREVIOUS_TO_DMESG_DIR

		if find "$DMESG_DIR" -size 0 -exec rm {} + ; then
			echo "cd to $DMESG_DIR failed: $?"
		fi
-mike

--nextPart5398334.RVWiYSMidD
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMLMX1AAoJEEFjO5/oN/WBXE4P/280JQj4DtwP1ALBdc2OLdbC
hy/pwkoECauyD4aum73PSdKdt7sJsdLe+2IK8wR+z081eA62BeaIuojhOfnJ0kvV
rSvcYzVty5ua5m9s/a2OxzzFghYxlZQFyCF0Ya6LUDCwdJAWpXfY7KLHzgD11s1q
UXAV2Qyaj3xfoggrpBfrXxNa2+CBjMMDvZpb26RvrguRTFus62IQcpVKeQHdBJj4
tmIWvhV6jp60qms9Jyz1tTFPKEQ6aF+p7iG45wt2qdslHM/NZbjGkW1ow63NB8jw
1RsaexwwML9Fpwt+32vteu8IkEdxka2VkaUkVM1hEpYdJaFqzc0Hi7xZpUPDc/4L
0t51shq1Pc0AMHStHtK80NvMnUy8xdINgUPIKdEZWWjJZeg2hdC+hA+sND0mf5Mp
NkTe9YbfDasBQPz+Pq06CjQdL/RraNkUg80rlmSce5xzciH1J28ABtRwxaWam+tm
3Cn5Hb8IPG32JYAyyFI8UCDYhetJI8ZchueljILVkQRLzcugZc9tipKtWsJRLnES
cQB0Qrm9tTAzJ51F8AIMtMFWRxVxC2bs+0ZWdxISZU8tuDJlSr4Ey9EHunJ9dACU
qBhqtQkOIHwmYvWynF6r12UjyMA/lsQs7xVtaRbRo1Irg4DcctzVTNaH8apVwW5D
CH9m0SeRRO/k7Ku36reG
=WnIN
-----END PGP SIGNATURE-----

--nextPart5398334.RVWiYSMidD--


--===============8074444188103049107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============8074444188103049107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8074444188103049107==--

