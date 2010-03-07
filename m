Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1NoKyT-0002x0-OP
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 18:13:09 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NoKyR-0005Dm-C5
	for ltp-list@lists.sourceforge.net; Sun, 07 Mar 2010 18:13:09 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 7 Mar 2010 13:12:54 -0500
References: <20100227075348.GA3077@linux.vnet.ibm.com>
	<201003061633.16026.vapier@gentoo.org>
	<4B93EBBC.5070004@petalogix.com>
In-Reply-To: <4B93EBBC.5070004@petalogix.com>
MIME-Version: 1.0
Message-Id: <201003071312.58906.vapier@gentoo.org>
Subject: Re: [LTP] A note from Maintainer
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2817630143813513489=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net, jburke@redhat.com, ambar.seksena@calsoftinc.com, kamaleshb@in.ibm.com, doug.chapman@hp.com, risrajak@in.ibm.com, Cai Qian <qcai@redhat.com>, Khem Raj <kraj@mvista.com>, aneesh.kumar@linux.vnet.ibm.com, carmelo.amoroso@st.com, Nadia Derbey <Nadia.Derbey@bull.net>, Balbir Singh <balbir@linux.vnet.ibm.com>

--===============2817630143813513489==
Content-Type: multipart/signed; boundary="nextPart2387595.DphCggAlqI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2387595.DphCggAlqI
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Sunday 07 March 2010 13:09:00 Michal Simek wrote:
> Anyway don't you have another script which will check commit message and
> if is there Signed-off-by line then change author name?
> There are a lot of commits with that line and will be good to fix this too.
> Adding some new lines to commit messages (At least before Sign-off-by
> line) make sense too.

i dont have any such script, and i'm not sure it's a good idea ...
-mike

--nextPart2387595.DphCggAlqI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLk+yqAAoJEEFjO5/oN/WBSkAQALpNKBuI8HR19l1dBq17qI3m
XnUOLyYgrudd5e27nl8hKQvm7loxX/YS4kCqBnd5sLhi6LOpWO4HJYeaVFBXonMo
ZHjuRNoSa2niPDseGTfMLdvo8X1FK95A2Xa1MkiNbBIsaa7R2P1JLMso0wHkhqwT
4qzpGjAm7H9T4OitwsDBJOsR+m2BSngjCAz5yxQwbl2n3NAiIVX9NOFgi6sU11gv
9KoksVcXWwM77mLgxXK/czdB3oDuHfeTKmSXYCLOphIEkWF2v6LDcxce9O35qN/x
oIeDGpjLrqMQtXHgt9h0k35S1mHozegCPFKOXNM4nYdyALJIJInE19VecbtDDAhJ
1As3LeWmGWvD+Hq/3ZfWyArHKXdTze9w1BUGUYyJda78VGQUO+56/+CL6mQPNiYI
v6lpGOrImt9CG4Th2NZlluhjdu9YdFNJ80k8SV2am0mOu6QgYztTCw0ZKoVDFaHA
1uwGJ+BHaX02AZWLXMtyqxK637CwVhhH1Zkv1HHBqMfHEW7nHpl33h2cZYBQ0wfd
k6LIgLyAZI1e/mGzIdmD1Le5ROc3PsIKM36tUlga//duxFokBIGW6DIo4y6r569z
UpO4Mi3ZlyYM/f6AZz7sAFUdsxSF7Xin9Et4gqeiUcXlsYdTANWK4b0DyOgiyOIk
2cJy2HUacwlw+v+I0V2x
=+R+R
-----END PGP SIGNATURE-----

--nextPart2387595.DphCggAlqI--


--===============2817630143813513489==
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
--===============2817630143813513489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2817630143813513489==--

