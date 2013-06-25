Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1UrW7q-0007ZT-U8
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 16:29:50 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UrW7p-0006N5-Ux
	for ltp-list@lists.sourceforge.net; Tue, 25 Jun 2013 16:29:50 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Tue, 25 Jun 2013 12:29:45 -0400
References: <CA+icZUXjY1QAWk80FqnENt=S1H+x+MaREjoHMuOmoq-QMnT3+A@mail.gmail.com>
In-Reply-To: <CA+icZUXjY1QAWk80FqnENt=S1H+x+MaREjoHMuOmoq-QMnT3+A@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201306251229.46574.vapier@gentoo.org>
Subject: Re: [LTP] [ltp-full-20130503] runltp and dash-bug
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1510889724132742406=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net, sedat.dilek@gmail.com

--===============1510889724132742406==
Content-Type: multipart/signed; boundary="nextPart4422925.lqpn6v0Gju";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4422925.lqpn6v0Gju
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Tuesday 25 June 2013 10:18:09 Sedat Dilek wrote:
> https://github.com/linux-test-project/ltp/commit/b88fa5b6ec5a29834a0e52df7
> b22b9bb47fe0379

if the output really should be silenced, it should be changed to:
	>/dev/null 2>&1
rather than just deleting it
-mike

--nextPart4422925.lqpn6v0Gju
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRycV6AAoJEEFjO5/oN/WB9W0P/RXQdJMmRDREODm5znPPGO3k
kfdm1IPP1r6DeTkGcm5LmiUW/hIMqUFMp652nIivEQS6Zv5IqkiEi3E+oDQxujIP
PPyCBxZyWz63boAaEnAozkC4V942+Qn4ViCGp5712xJVkghq8Vk8QnLmw/ximrDC
PnF+Qx3NFp5dCSkyAZ1XeT3dPwiUYbP5y+xGxlezYX7AJlcmgb344Ng0md+sH/Xk
67ywToM/xc31W2rofXWcxGRB37ueEkEGtyL6kZfV9ZdYpnfWtO94yKuwJI7fEPLL
Kt52AOxnX/9ggLcvQqL9gsMirW7fqH4NeMXFKulcUmw+TfAhYv7HhbZ6sU2M+KoJ
Jgi5vNMXzsBBAp8aw94pZEVg2LQTcY5yxCQ1pL/agIEMMGdZcpK15EoBBIOm5rXK
2nEzhllESbpaZCvlUcIpjaDBFiF7JFcN+QjW7g1PYcjJpUgmfKHLT/msqVZn7x++
XeYJHATpoYhPIYuC8JGu+owdG/2NyZn06p/Kk/yllXHNuJOL/2bIxFKUhsUYSolo
YCY499u089S4Dh1rTDnnApSyDmjDxmN0ghWpkg4mDH9PbzetP9N5gRzKk9RMNHEy
uzQ1q/T4VS7pQQKlvnmeF1KzmiZ+hEsoe2V2bOX6SNa+pZvDasRBbRfq2m41onhH
sh0h5LQb6XHpHuV+dSDv
=rBZW
-----END PGP SIGNATURE-----

--nextPart4422925.lqpn6v0Gju--


--===============1510889724132742406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============1510889724132742406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1510889724132742406==--

