Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RlZvN-0002P2-9X
	for ltp-list@lists.sourceforge.net; Fri, 13 Jan 2012 05:43:37 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RlZvM-0002fm-DC
	for ltp-list@lists.sourceforge.net; Fri, 13 Jan 2012 05:43:37 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Fri, 13 Jan 2012 00:43:40 -0500
References: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1326166692-18276-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Message-Id: <201201130043.41529.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] syscalls/getrusage03: flush stdout to avoid
	duplicated output
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0946485021136599913=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0946485021136599913==
Content-Type: multipart/signed; boundary="nextPart2909815.3EnxPSdUEV";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2909815.3EnxPSdUEV
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 09 January 2012 22:38:12 Caspar Zhang wrote:
> when executing with `$BIN/runltp` command, getrusage03 puts out
> duplicated information due to buffered stdout. Using fflush(stdout) to
> solve this issue.

NAK to this version.  it's a general issue with LTP and forking and should =
be=20
solved as such.
=2Dmike

--nextPart2909815.3EnxPSdUEV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPD8SNAAoJEEFjO5/oN/WBoLMP/1RspGHEwBqm27JUp7QJ4s1y
bwKtrUTvu+tClApz8zNKtXa5cFETxMsHLMUIA/+0sw/BrpuskL8aBIuvZ7IfL4ri
72eSPIeobP3qIVUgMBN00SKunugvdnNNSYlcx6mF8yG95Uq1sM90uZo5dtvvJaGb
2rJBGWWa/lVoKYqdSDZl2BKEGl50lzZtUo5ThDs/oXG+1eTM3KDVG5nwtALzBL65
Nwbh+8gjmnOtItyXhmxE2TYfvFwp1a0LgscmbD48Rufdo6116daUS4ES1UVZ0pOz
GBN1fBe1LMmMdkLljBo/vz9Csk3T2AqFRTXu1HcHb9713nShjF44MovNC8yilaRB
GTcVdK0IfZTdDc2atQUoV0bZkHF33PTpRwo/CWH/RkMVkZ91F2NqFbOVe/Uf8ijk
VVTugyPsBpmzUuADZ+SoRQcyopmdEf+4wLCEzCl7z2Nj1npGT/KUDWHUwIu0OTcq
6I8JhBZ4Nfk84oDzD0/ijb0CYddsm5lXWW/jhIH9el+B95ntw/5laclcZEHe9H7J
mgjLPSeRjEjKP0nywSFo7vlk7UHlHnbU9noE6VZN6a40Ht63yH+UUUEWYQC94nHy
xu5VrEBBZ1HGnGTfE9GCOUG7TvupgMRPpfGGfiXX8zBqXCru2eRqWD+LAm9yJh1H
c5lsNnJoVEUQKe+G4rFr
=DC1/
-----END PGP SIGNATURE-----

--nextPart2909815.3EnxPSdUEV--


--===============0946485021136599913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
RSA(R) Conference 2012
Mar 27 - Feb 2
Save $400 by Jan. 27
Register now!
http://p.sf.net/sfu/rsa-sfdev2dev2
--===============0946485021136599913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0946485021136599913==--

