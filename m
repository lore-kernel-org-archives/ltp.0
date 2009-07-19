Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapier@gentoo.org>) id 1MSOvM-0001pK-Tb
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:27:00 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MSOvB-0002Lo-KU
	for ltp-list@lists.sourceforge.net; Sun, 19 Jul 2009 05:26:55 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 19 Jul 2009 01:26:45 -0400
References: <1247741996.3886.5.camel@dyn9002018117.watson.ibm.com>
	<364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
In-Reply-To: <364299f40907182215q56ff7c3au5971afb877d4aa15@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200907190126.47767.vapier@gentoo.org>
Subject: Re: [LTP] ltp: IMA cross platform fixes
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7669046438104226339=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: waqar afridi <afridi.waqar@gmail.com>, Shaz <shazalive@gmail.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, ltp-list <ltp-list@lists.sf.net>

--===============7669046438104226339==
Content-Type: multipart/signed; boundary="nextPart3014835.gYeSJ4bEk7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3014835.gYeSJ4bEk7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 19 July 2009 01:15:04 Garrett Cooper wrote:
>     /bin/sh should remain the standard, but a number of changes need
> to happen to the .sh scripts to make them POSIX compatible, e.g.
> backticks execution should become $(), etc. Let's not make things
> bash-only...

umm, `cmd` is in POSIX
-mike

--nextPart3014835.gYeSJ4bEk7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iQIcBAABAgAGBQJKYq6XAAoJEEFjO5/oN/WBmx4P/2lOKUx31U1qjm7KxkCHUE9V
33AUhd24kBAbJo94R3wiB1NYkptiyqFH+fq/tD/kPZJsp09A1SeIlwz9zXYpGmnS
5Z/O5tIBR9AUuJ8mHdy676/if4RYOta+8qqs+pKpsuXEUPLb0UnThZkXqtvSmNfn
CtqjZdJdl2Tc1tSk+HVmjDrv+8XukTmIV4lj+UsFPSonPiKEhbQP7Cxq3OY4h8WV
HXv0gSZYDq6enPEIbdCrNBQesRWRJA95iiIn8qoHzjRqbU89LGyKBGERVNmvteGB
DrwXAXUrDGc1+9B+GJthS6QBa/u2VToG9+Qowx8qH1P68rqH4W1f3Ny7JnEwhUAM
XqAwOU+AltYwaIUbVtrN40OuePeBnYoaPPp2UKCKGbcfWJFQv8ww5lk5y3FcvhkG
9JzdnjI2ek5AtzPbXWvkdpnDizoO4BV6jnA+MO0lIrpLEEgs2x76XmQPi2UY+Num
uEkGkjzrjcoM1BgJlglgDiIaE16J2yE9SFXs/BwmYdZ0v1dnQuNP6kGMd8Qomnjb
CbL6VoXG4NkwFo/DKlj5f7Ud2MGJ2Nr18/py6u+RQRSiuuVUfjkaC4rJJ8UaFvqI
NhNv4DITG2IcvbKUQRGw5jhUfKjqyTc9YEvUY8137H2WTIv20tlUkJyhr28t2x7j
8CkcmHTjpBmCpm+zF/bF
=TcEK
-----END PGP SIGNATURE-----

--nextPart3014835.gYeSJ4bEk7--


--===============7669046438104226339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--===============7669046438104226339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7669046438104226339==--

