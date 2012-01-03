Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1RiB1Z-0002AH-Sw
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:31:57 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiB1Z-0000RP-5i
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 20:31:57 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 3 Jan 2012 15:32:04 -0500
References: <4F0300EC.7040201@imgtec.com>
In-Reply-To: <4F0300EC.7040201@imgtec.com>
MIME-Version: 1.0
Message-Id: <201201031532.04811.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 16/21] kernel/vma: Add missing return statement
	for non-void functions
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1341387315579688845=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: Markos Chandras <Markos.Chandras@imgtec.com>

--===============1341387315579688845==
Content-Type: multipart/signed; boundary="nextPart2056488.I6szMbSVL7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2056488.I6szMbSVL7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tuesday 03 January 2012 08:21:48 Markos Chandras wrote:
> Hi, please review the attached patch

two of these hunks are fallout of your tst_brkm() no attribute change.  tho=
se=20
don't actually return, so there shouldn't be a need to add explicit returns.

the 3rd hunk (adding a return after tst_exit) is wrong -- that is marked=20
noreturn and isn't changing.
=2Dmike

--nextPart2056488.I6szMbSVL7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPA2XEAAoJEEFjO5/oN/WBwK4QAL4Wj0VmzTa+BTZsgvUkkEG5
5Ckw6OvhEAcXOXolnQ1Gc906uadyFJklTfHs204pUgJfbEpc69pmtePEKb2PKpnP
gTrH3oQi+8w2aO75kguNnnzKAec8YI4gmh/3qR4HV3T1JZtpxDzoAGSob8DO5ifX
Q2jZWOiLrcKs0POLq9HjPHDOewlX4CG+/bRlHY27+9cnuJDakhycHKj/PZzOlMNb
zzrU9ZUPy2ef9kDRypi7YzLVjayG4065wBpUighNuSFxYuyjX6jF0z6LQfBYcssa
uv/c++nLGmRF6SgB1X96O7Z6YTCMz/lGInSqaW2dn06Jb90vZDQni3NQyCOrLIRh
NZYzHLdDWK3kXOb328D5oMQjvGVYNgMSfLPD8RDVRGspgS3i3BnVFcmfQFND49Pt
GQVJK2/vhf6aR6bh4Qkyp+OI3W2WMLeBRYRKWqsZKT5SSYnB2wiasCb3FXie8C6t
K8HhmrQ2PO8TsoWD2jktPjCh09qsxXdebL/FimjyBucPDxjkyPSIq+D6LIZcC2FC
tyLp6kIMDPZW175/X14rd5TXDM3CGa5rWwBtwyDcmcA2DYhApl1woSR1/ooYarxc
CBugx34q9ersKxZm1iU0umfdX03lhwx+jzniH08vRv+8BPMmoC/uFOR5ZzZHHjIX
qZNFUrx45/d3/7OsWkgA
=DF7i
-----END PGP SIGNATURE-----

--nextPart2056488.I6szMbSVL7--


--===============1341387315579688845==
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
--===============1341387315579688845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1341387315579688845==--

