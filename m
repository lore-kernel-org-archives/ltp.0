Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1OUNAR-000826-Gf
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:03:15 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OUNAQ-00029W-LS
	for ltp-list@lists.sourceforge.net; Thu, 01 Jul 2010 17:03:15 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 1 Jul 2010 13:01:57 -0400
References: <20100701165206.23119.26070.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100701165206.23119.26070.sendpatchset@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-Id: <201007011301.59073.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v3] Remove files which does not have a dmesg entry
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4072583600711659889=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP List Members <ltp-list@lists.sf.net>

--===============4072583600711659889==
Content-Type: multipart/signed; boundary="nextPart6000554.4BgMHRO2n0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6000554.4BgMHRO2n0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday, July 01, 2010 12:52:07 Subrata Modak wrote:
> +		if find "$DMESG_DIR" -size 0 -exec rm {} + ; then
> +			echo "cd to $DMESG_DIR failed: $?"
> +		fi

err, sorry, you probably want "! find"
-mike

--nextPart6000554.4BgMHRO2n0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iQIcBAABAgAGBQJMLMoHAAoJEEFjO5/oN/WBQ/wP/0m3+B3E/jvjwo1qZeS+6lUF
JB6dOZ7NXYGvfu/qywjephc1DzzG/c+dKExsEAI2l7qPcxP40fHdcl5A1IEn7VhC
7gRnsIM02j44ljMrNbmft2tYwxrdjR5awocRRXgWkXJWvvsFJRXG10GcqShI8ZWQ
VojO2RNr3M4I944/66xRQvsvIZo5fG3rDfxb/tleKKp64ZhMl3DopdlWEucNzClz
0jzUtDa8oSTac9vpZK4sjOpAqIuVDsa9EAn1PreXRkavYovyRlB4RNEErZOhZCTA
/oGvJ3jDA42wmwjBQdJpAKI1LwSIbB+rVFpSIALUZ6vOQ/QryYzdbo7jeiGCn0Dt
rR0UDJBI78kcc/1DZ8uIvpL4RbBrbd4+2D9qNz/O3uoAo3awtxAPmhSzHdspnIJ1
bavRTnJKTKbI81sPG/SMXUhfMFZKmB/zBC8bq5xQA/bLpD5QB+yXvXUCartohY0U
8DcV/2Ns6z2SIMF+TF4alWM4IpX7kkyJTt3HQ/JDTaJnjpfS+zbVENa7SHQ+KCQP
gABzU+5CUr03yoN6fEuivXAOH0rMaqjO3SaPJQ+N4Xm00k725BBrtJvvClAF2oqo
tW+Fi+9zTK0iH4wuMSRJ2FtAi11A75wdq69Ge+sr9DWFfwgw1mfMyZ4HbG3eHJmi
mC5DCJWhih3uedtJkqS7
=FIwT
-----END PGP SIGNATURE-----

--nextPart6000554.4BgMHRO2n0--


--===============4072583600711659889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
--===============4072583600711659889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4072583600711659889==--

