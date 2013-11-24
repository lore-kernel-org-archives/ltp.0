Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VkdHk-000215-38
	for ltp-list@lists.sourceforge.net; Sun, 24 Nov 2013 17:15:52 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VkdHj-0008Vk-6C
	for ltp-list@lists.sourceforge.net; Sun, 24 Nov 2013 17:15:52 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Sun, 24 Nov 2013 12:15:46 -0500
References: <1385290561-24404-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1385290561-24404-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201311241215.47426.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] runltp: suppress the out message when creating
	loop device
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0544391111858217598=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0544391111858217598==
Content-Type: multipart/signed; boundary="nextPart4467304.19XsQiEa4L";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4467304.19XsQiEa4L
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Sunday 24 November 2013 05:56:01 Wanlong Gao wrote:
> +    dd if=/dev/zero of=${TMP}/test.img bs=1kB count=20480 &>/dev/null

that's a bashism.  you have to use:
	... >/dev/null 2>&1
-mike

--nextPart4467304.19XsQiEa4L
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSkjRDAAoJEEFjO5/oN/WBsbQP/R9CQc+a4UFJtS76uypyp0EX
vaUlIw89ukDaORok24h5i74zxlWgR/T82DnD/5E4gc62msNEFOhz0M/jwGgAjT2H
RvQAULjD4C5tG2nzTdX69cpHwlmo6ESX8TDEF8SDN/PAClMxszvDSRN4oPjuVfoZ
Tn2ythB0x8Cjkbl8e/3TVOZm1pqf5/JdSvegWVMyFU7hk7CXuyI8lwSmi6IXZRa6
d9Y42QMgQ0T/HDMxCH3DVSSoTYeFloY8K+SHdgTSgWgqZW28Z1zvdA8sdcqNHnY4
zfVjpQwlHjnuxbEqlKCfVlg9m8p8jXl/YsM1TRbrnTSlc4o0pz2/M+opFmSywpNi
ZImlEWggphExEXVkcAY9jSh4BG43cmS5VxDsTgwD8mG71SERMiaNZ9OJnt1GRxee
sMFhVNMgkv6MDQOVRSmBC7Vv1RPTT2l8ytNwtXY7FtpGHjIiGokVgf2jORwHfjmF
Up1RTQ+sXFoy55RUXJCS4QAzcY/9OWHTms+ui56s4HMk7EAd3Mv/CaAmc0pyKww5
2BzB4xCNB8dAw0RaKLO0ukx2vvo2nn2KkEt/c7c+Lx2bxuJAXv7r2fu2pa8ki9MH
kZ8VAVfO21a1+qoqOvJRA3oObjbW1owqQl6jyV13AUMcrf5P/0bdUI63NqaELag5
PpBtHAHR7ITcv+Kr3qlZ
=h2gc
-----END PGP SIGNATURE-----

--nextPart4467304.19XsQiEa4L--


--===============0544391111858217598==
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
--===============0544391111858217598==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0544391111858217598==--

