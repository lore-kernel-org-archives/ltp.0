Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VjYtz-0006C4-GW
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 18:22:55 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VjYty-00005n-P6
	for ltp-list@lists.sourceforge.net; Thu, 21 Nov 2013 18:22:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 21 Nov 2013 13:22:50 -0500
References: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1384353022-9088-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1384353022-9088-2-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Message-Id: <201311211322.51456.vapier@gentoo.org>
Subject: Re: [LTP] [RFC PATCH 1/2] autoconf check for utimensat(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6335630999956726964=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

--===============6335630999956726964==
Content-Type: multipart/signed; boundary="nextPart5808143.4PZKYKPMc5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart5808143.4PZKYKPMc5
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 13 November 2013 09:30:21 Stanislav Kholmanskikh wrote:
> +if test "x$has_utimensat" == "xyes"; then

just 1 =
-mike

--nextPart5808143.4PZKYKPMc5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSjk97AAoJEEFjO5/oN/WBdigP/1QRE+i9W37mld433CtX9Per
FWUQYTZunLRGi0J4DftuArfMqd+VDz12u2lMM3MSbnKPB9m84ecD9L4aohnnYEBV
KZlr/st60uzTaYH7fEA4dcVoDbyrI5UcWRTx2kcoGibjD5o8fuD/oJeLt6jRwI3Y
IUHxMSZneytEK63B4llrQUxd9FYse3b6btu84EPEO1Beb23bX/JGQ4KJuaUROWpQ
P2UCdf9KZgtgnfg1CAwyzrZptaJMKf6f8jQyuHaH9iEKvZ6CkvkWFYwdZGf1Z+LC
ciQr7RhEx2QCSdHwvWiXk+fpAOah7JylRehLNNRDvQSQBVE8NtwvGe4NTcfiWqwm
Zog8jUBpPVKLBQXSzlJY1EVuTxy1+2Kny7lOa7Cv2mBrBrWIlZgVY0BSrNHamyIF
WXGoiQd0JLdPMbV/wHe8Rqy9MxTPuraghViihhatpVzPaddSVcAib6pDAF00pUYr
D0qJWa+aslLHhFkx7xLyGTSm9i5NY+UdnZKx/d5fB8GtprI1vWc9bwq/PZfC/YTR
k8fB69aDiHSvHiGIVABqm3azJwjUOutywXxlJpduG9k43V/wmvPwdXDz7NML7HdC
92vx3Aqrn+2mQo4vZx2wBKmHsbc3uwV38q6pjpUM4Z4gB8miYFdaQQIz8zMJ2qx5
LkaJbNiHeWPVkJz5J2LD
=9sNm
-----END PGP SIGNATURE-----

--nextPart5808143.4PZKYKPMc5--


--===============6335630999956726964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
--===============6335630999956726964==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6335630999956726964==--

