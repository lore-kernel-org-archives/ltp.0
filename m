Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiDsM-0007CL-4e
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 23:34:38 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiDsL-0007N9-E5
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 23:34:38 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 18:34:44 -0500
References: <4F02DBAF.5040202@imgtec.com>
	<201201031557.08072.vapier@gentoo.org>
	<CAGH67wSrnkWdC8vYubfur6p2-Vs03F6LKvnZumtb-ZW-dWLy8g@mail.gmail.com>
In-Reply-To: <CAGH67wSrnkWdC8vYubfur6p2-Vs03F6LKvnZumtb-ZW-dWLy8g@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201201031834.45745.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 05/21] syscalls: Cast st_nlink variables to proper
	integers
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5313719057798519657=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Markos Chandras <Markos.Chandras@imgtec.com>

--===============5313719057798519657==
Content-Type: multipart/signed; boundary="nextPart2723299.BpfVIv1BCM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2723299.BpfVIv1BCM
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 03 January 2012 17:19:25 Garrett Cooper wrote:
> The 'solution' for the issues with
> format strings and long integers is generally cast to [u]intmax_t,
> then use %zd or %zu.

eek, almost ;)

ssize_t -> %zd
size_t -> %zu
intmax_t -> %jd
uintmax_t -> %ju
-mike

--nextPart2723299.BpfVIv1BCM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA5CVAAoJEEFjO5/oN/WBelMQAMFHlZeiq6VLg+oxdxtsSwHi
mds3xRywxAsf2rAYHC4ISL6FmuO3YDoK+PNSrs0CKPpIqLtZ2NAN2onmUi3nOnJI
8eQZ0rikDCymRNiYU+tuQl9Wtfarq6q+isB5xarLctZM5LOy7voRzr8MoIpxtp73
jSKSZebx1PMnkS8FXlwgxKEyTQVK7MMKDV0/RKQeW36e8zUNOn4kJ12pq4dCzpD5
6dn2mxhca96+vv9sxSlkQqRQIdwVIOH39LmA4DQmTcYSGmpS0b6SUPE71f2Klw3z
x8r2jLLYaLbCOcr7QmVa1GGWkT+y+jzQO+Mr7eifavBWPr5wH5p09wUPQcXktlrO
t2hj62u6ZLyA0JbNejJ5WQQ7hb7kacQ0Hdp09ngiACyghpgkJhhqEKGKGOVJKpNg
lpDXdYCLDMtaZxgd2rA5ROwgLK+FNfgRFY87LYIJ/XTUg2utMTlDtntXQ/yjCUtt
q8VSdKWnOM6BILpcsGUG2dH3PAjCWOy/1RlUVDsVOnPELnBDiBOBUHtoo1hZdnrh
pxGx2lXYLkBZ6zo5J+Py1zJ3yo5L+Zh+bUs6Nu+KBFhgHNHmOTbczP1g23jm1ag5
6jBXEGXb/z2Hg7+2VdWuK0jPzJVaPUyjGAAEqui0VCfmgys1Zj7ZCRfSF2Dl3+Ez
Mr7KTqDHM5+68Jz4/zhq
=P9AR
-----END PGP SIGNATURE-----

--nextPart2723299.BpfVIv1BCM--


--===============5313719057798519657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--===============5313719057798519657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5313719057798519657==--

