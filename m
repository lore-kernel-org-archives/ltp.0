Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vapier@gentoo.org>) id 1VoRRS-00088G-B2
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 05:25:38 +0000
Received: from smtp.gentoo.org ([140.211.166.183])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VoRRQ-0006VA-Eo
	for ltp-list@lists.sourceforge.net; Thu, 05 Dec 2013 05:25:38 +0000
From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 5 Dec 2013 00:25:35 -0500
References: <529FF7DF.9000006@cn.fujitsu.com>
In-Reply-To: <529FF7DF.9000006@cn.fujitsu.com>
MIME-Version: 1.0
Message-Id: <201312050025.36619.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH 2/3] fcntl/fcntl30.c: add F_SETPIPE_SZ,
	F_GETPIPE_SZ test for fcntl(2)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2904255452903711714=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2904255452903711714==
Content-Type: multipart/signed; boundary="nextPart3478935.CmueDeLlkJ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3478935.CmueDeLlkJ
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

On Wednesday 04 December 2013 22:49:51 Xiaoguang Wang wrote:
> +#if defined(F_SETPIPE_SZ) && defined(F_GETPIPE_SZ)
> ...
> +#else
> +
> +int main(int ac, char **av)
> +{
> +	tst_brkm(TCONF, NULL, "This test can only run on kernels"
> +		 "that are 2.6.35 and higher");
> +}
> +
> +#endif


same comment as your 1/3 patch
-mike

--nextPart3478935.CmueDeLlkJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSoA5QAAoJEEFjO5/oN/WBBP0P/2cVJIRSvZF2J5fIAa+qU64f
Ewixb2ABBt9aSeZ2E8sflfqPjaBKNVGD7wpn9XOVhPzyWcH85/Ag60kWlCRNUO61
Ke+WPjcZifP+ImQC+0DK8i5eZYfbAQbMUieo+CWRPJABeloHVJ/LBvQ2PxAxwuT0
d8TqHhW/r03NJS9C5FV5qidMS01lTvmOwY/SL87BqUXrtHEEaF1r8WIS0d3E0XbT
Qh0A58D+cTXrTN8XywYrnm2WzHOrb2MrkA6PSe4ufDtSqKzpTA6Vu1zqyWgcZY7T
xWg/Q0Mml2rk4zr1LMaH6Py+EcbAHM2JGiDYBH6ohJGL5j23kjg3Knqvw0LMI8B/
nIJthJbQefeZ6TRKlAhuJWA8Wpycx3Uxiss1XSMSzSxav6KVuosMs2nEVHbYxt6t
jp5+r9xW/yzdPekUgDu0IoiV+mf9v1dl1yubyyf2MB8utur6tFlAlmmFjwNDpsO6
QnGWNujsRiPPxDosL+7kGCZMn2eIKK3q275aAYc4lsZPdmBypE0VJdVA8WDPAeEx
qJk377jUCJMeziTq/GwKO7dbdtZbv9lHJoceoH2+P2tfFl16du1e0EOxJ0orLLFL
ZzyNy8iU8/tY5RomNH+mEZoTMLgEyZ58Rc/0jk07ct2Fu3kTiN5tZ1hOrc0/Yiut
DxR7CAczF/WgJQGoqIyA
=KNZH
-----END PGP SIGNATURE-----

--nextPart3478935.CmueDeLlkJ--


--===============2904255452903711714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
--===============2904255452903711714==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2904255452903711714==--

