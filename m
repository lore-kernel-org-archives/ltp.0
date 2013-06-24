Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1Ur8n3-0002ZO-AG
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:34:49 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ur8n2-0001H3-LN
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:34:49 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Mon, 24 Jun 2013 11:34:31 -0400
References: <1372086727-27722-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1372086727-27722-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Message-Id: <201306241134.32158.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] dup2/dup205: close all fds before tst_rmdir()
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4932181862195067515=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============4932181862195067515==
Content-Type: multipart/signed; boundary="nextPart6989834.JU244HVl2x";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6989834.JU244HVl2x
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Monday 24 June 2013 11:12:07 Eryu Guan wrote:
> Close all open fds before calling tst_rmdir() to avoid TWARN caused by
> NFS silly rename when removing temp dir caused by NFS silly rename.

"NFS silly rename" duplicated by accident ?

code looks fine to me
-mike

--nextPart6989834.JU244HVl2x
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRyGcIAAoJEEFjO5/oN/WBdKsQAMZS/LWdJoGnsAH10CtfHimb
0s63ij82T3oF55HrSCXq0cRVOImYEhCUY3s9MU3fOeVuTd9vIaYj37CmsA6J6yeZ
6aaXcLcmhThoTIpcKfDP5PDkPCx135bJNvNirPt21QeqMV7zzwAfT73KsB37pNFB
FWsgeSEeURflZjsz/67RM9OkdedCp9JrS+kEfHEBbMYlihzyOWeAqaXK9om3HoEp
q8xftwIGFloGAiovJEAQxq3gW1QjWcgRzt740lao5S5Hn+Kev7R4LnUpLg9UvO13
RaUmOOG1O6Z/Ghb8z3jVqa0mIu3ljbDf+t/h5trU6cqht5MhrYPQJ7ALCYFQygCE
KWekR8Iaaoo/NvEbpOVoJmcifRHaDRnbe7PYASk4Y6wFBt7q/fZMuCypvX+o5XmG
fmIh+cTVS9FKRGlB0agauN/swg4ER6ZIChmfoNKq99jIyjjhECoqa+nTLzr/eajw
ovGKf1tmGhGzWKGsbPcPmXsk9JHJUWaleBABxJBu58Wuk00+zgUxLrvpGmRKVyRu
1jey0HYxNKccTJ5Gj+WDgaRtXJa6IpMzJevQ5qgdGbyAg4irULvllgbW7nCTTvC8
P61GNncQ2r/LinewTV/v2XhqIO7M3PpfvXHb8bGewEaJizCqfgD9XVlQ/tdavDV/
EWyagpxDRu1pbfPbQXKV
=XSrn
-----END PGP SIGNATURE-----

--nextPart6989834.JU244HVl2x--


--===============4932181862195067515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============4932181862195067515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4932181862195067515==--

